Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVCODb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVCODb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVCODb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:31:58 -0500
Received: from main.gmane.org ([80.91.229.2]:30164 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262220AbVCODbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:31:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Question about initramfs
Date: Tue, 15 Mar 2005 08:31:43 +0500
Message-ID: <d15ksi$n22$1@sea.gmane.org>
References: <4235C0A1.3050508@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsa.physics.usu.ru
User-Agent: KNode/0.8.2
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gifford wrote:

> Question: Initramfs is going to replace initrd, but I haven't seen
> anyone explain how to copy modules that are built during the build
> process moved into the initramfs archive. Has somebody done, this or is
> this still a work in progress?

Easy.

1) Unpack a vanilla kernel and build and install it as you usually do for a
system that doesn't need initramfs.

make menuconfig
make
make modules_install
cp arch/i386/boot/bzimage /boot/linux-2.6

2) Make a temporary directory (say, "initramfs") and put all files that you
want to go to your initramfs there. Don't forget the "/init" file, it is
used as a starting point for initramfs.

3) Make the initramfs image:

cd initramfs
find . | cpio -o -H newc | gzip -9 >/boot/initramfs-2.6.cpio.gz

4) Add /boot/linux-2.6 and /boot/initramfs-2.6.cpio.gz to your LILO or GRUB
as you would normally do with a kernel image and the initrd:

image=/boot/linux-2.6
        label="Linux"
        initrd=/boot/initramfs-2.6.cpio.gz
        root=/dev/hda1  # if your initramfs "/init" script understands this
        read-only       # if your initramfs "/init" script understands this

5) Upon reboot, the kernel will automatically determine that the image is
really an initramfs, not an initrd.

-- 
Alexander E. Patrakov


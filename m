Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVHXPJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVHXPJP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVHXPJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:09:15 -0400
Received: from alerce1.iplannetworks.net ([200.69.193.89]:6118 "EHLO
	alerce1.iplannetworks.net") by vger.kernel.org with ESMTP
	id S1751034AbVHXPJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:09:15 -0400
Message-ID: <430C8CB5.1050501@latinsourcetech.com>
Date: Wed, 24 Aug 2005 12:05:25 -0300
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with kernel image in a Prep Boot on PowerPC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-iplan-Al-Info: iplan networks - Proteccion contra spam y virus en e-mail
X-iplan-Al-MRId: f3ead2d0458f5edfceb5504618f1d8ad
X-iplan-Al-From: moliveira@latinsourcetech.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi There!

   I have a IBM Power server and I want to put the /boot partition onto 
softwrae RAID1 array, but I'm having some problems...

   Aparently yaboot boot loader doesn't support /boot partition on a 
linux software RAID 1, so i'm trying to put the kernel image 
(zImage.initrd) directly on the Prep Boot partition. But when the system 
boots, the kernel can't locate the initrd or the root partition ("Kernel 
Panic" no init found message).

   I think the kernel is pointing to the wrong root partiotion. In a x86 
box, I can change the kernel root partition in the boot loader (root= 
parameter) or using the "rdev" command. In my case, the IBM Power 
doesn't have a boot loader (yaboot was replaced by the kernel image) and 
the powerpc64 system doesn't have the rdev command (from util-linux 
package, the same package on x86 systems have the rdev command!).

   Is there a way to change the default root partition in my ppc64 
kernel image?

   I followed this steps to made the configuration of the kernel image:

# cd /usr/src/linux-2.4
# cp /boot/config-2.4.21-4.EL swinitrd.config
Edit the file Makefile to change the EXTRAVERSION variable to match the 
running kernel: EXTRAVERSION= -4.EL
# cp /boot/initrd-2.4.21-4.EL.img 
/usr/src/linux-2.4/arch/ppc64/boot/ramdisk.image.gz
# cd /usr/src/linux-2.4
# make distclean
# cp swinitrd.config .config
# make oldconfig
# make dep
# make zImage.initrd
# cp /usr/src/linux-2.4/arch/ppc64/boot/zImage.initrd 
/boot/zImage.initrd-2.4.21-4.EL
# cp /usr/src/linux-2.4/swinitrd.config /boot/config.initrd-2.4.21-4.EL
# dd if=/boot/zImage.initrd-2.4.21-4.EL of=/dev/sdb1 bs=512

   This is my partition scheme:

Disk 1:
/dev/sda1   = Prep Boot Partition (10MB)
/dev/sda2   = RAID 1 - "/boot" partition (100MB)
/dev/sda3   = swap (300MB)
/dev/sda4   = Extendend
/dev/sda5   = RAID 1 - "/" root partition (34GB)

Disk 2:
/dev/sdb1   = Prep Boot Partition (10MB)
/dev/sdb2   = RAID 1 - "/boot" partition (100MB)
/dev/sdb3   = swap (300MB)
/dev/sdb4   = Extendend
/dev/sdb5   = RAID 1 - "/" root partition (34GB)

   Any ideia about this issue?

Thanks a lot!

Márcio.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270815AbUJUT5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270815AbUJUT5o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270865AbUJUTr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:47:28 -0400
Received: from zamok.crans.org ([138.231.136.6]:29372 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S270816AbUJUToQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:44:16 -0400
To: root@chaos.analogic.com
Cc: Paulo Marques <pmarques@grupopie.com>,
       Mildred Frisco <mildred.frisco@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: making a linux kernel with no root filesystem
References: <e7b30b2404102102466dc71118@mail.gmail.com>
	<e7b30b24041021030535925d1d@mail.gmail.com>
	<417792F0.20008@grupopie.com>
	<Pine.LNX.4.61.0410210757040.10239@chaos.analogic.com>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Thu, 21 Oct 2004 21:44:15 +0200
In-Reply-To: <Pine.LNX.4.61.0410210757040.10239@chaos.analogic.com> (Richard
	B. Johnson's message of "Thu, 21 Oct 2004 08:10:14 -0400 (EDT)")
Message-ID: <87d5zbc0vk.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> disait dernièrement que :

> On Thu, 21 Oct 2004, Paulo Marques wrote:
>
> Let me add the basics that the kernel expects to execute
> /sbin/init. This means that there must be a root file-system
> to contain it. However, it can be a RAM-disk. That's how
> initrd works. /sbin/init can be a program that you write
> that does everything you need yout system to do. It can
> fork off multiple tasks, etc. Just don't accidentally call
> exit() or return from main()!

but initrd needs a FS code linked in :)
the only way to have no fs linked in the kernel, is to use initramfs,
i.e. rootfs as the real root.
The solution to the problem is to provide the basics of a system in
the newc cpio format (see in Documentation/early-userspace/) which
will require no FS code linked in (huh, I guess RAMFS is needed ;)),
tweak usr/Makefile to get it use the in-place initramfs_data.cpio.gz and
put the cpio archive in usr. (I do this way because the initramfs_list
"mechanics" never succeeded in getting me a working kernel :)) 

-- 
"I know how hard it is for you to put food on your family."

George W. Bush
January 27, 2000
During a campaign speech in Nashua, New Hampshire.


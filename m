Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281002AbRKLJNG>; Mon, 12 Nov 2001 04:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280679AbRKLJMx>; Mon, 12 Nov 2001 04:12:53 -0500
Received: from [212.3.242.3] ([212.3.242.3]:4874 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S280000AbRKLJMh>;
	Mon, 12 Nov 2001 04:12:37 -0500
Message-Id: <5.1.0.14.2.20011112101039.00a8b348@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 12 Nov 2001 10:11:41 +0100
To: johann.pfefferl.jp@germany.agfa.com
From: DevilKin <devilkin@gmx.net>
Subject: Re: loop Device doesn't work in kernel 2.4.14
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OFC9FBD042.EA509C88-ON41256B02.002FCAEC@bayer-ag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:57 12/11/2001 +0100, you wrote:
>Hello,
>
>I have detected that the loop device mechanism can't be
>used any longer in kernel version 2.4.14. I have compiled
>the kernel with minimum features (ext2, initrd, ramdisk) compiled
>into the kernel. The rest is all modules.
>
># cat /proc/version
>Linux version 2.4.14 (root@pcls03) (gcc version 2.95.3 20010315 (SuSE)) #2 
>Wed Nov 7 11:34:01 CET 2001
>
># mount -o loop /tmp/DISK /mnt -v
>mount: Could not find any loop device, and, according to /proc/devices,
>        this kernel does not know about the loop device.
>        (If so, then recompile or `insmod loop.o'.)
>
># modprobe -v loop
>/sbin/insmod /lib/modules/2.4.14/kernel/drivers/block/loop.o
>Using /lib/modules/2.4.14/kernel/drivers/block/loop.o
>Symbol version prefix ''
>/lib/modules/2.4.14/kernel/drivers/block/loop.o: unresolved symbol 
>deactivate_page
>/lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod 
>/lib/modules/2.4.14/kernel/drivers/block/loop.o failed
>/lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod loop failed
>
># find /usr/src/linux-2.4.14 -type f -name '*.[ch]' |xargs grep 
>deactivate_page
>/usr/src/linux-2.4.14/drivers/block/loop.c:             deactivate_page(page);
>/usr/src/linux-2.4.14/drivers/block/loop.c:     deactivate_page(page);
>
># depmod -ae
>depmod: *** Unresolved symbols in 
>/lib/modules/2.4.14/kernel/drivers/block/loop.o
>depmod:         deactivate_page
>depmod: *** Unresolved symbols in 
>/lib/modules/2.4.14/kernel/drivers/net/wan/comx.o
>depmod:         proc_get_inode
>depmod: *** Unresolved symbols in 
>/lib/modules/2.4.14/kernel/drivers/telephony/ixj_pcmcia.o
>depmod:         register_pccard_driver
>depmod:         unregister_pccard_driver
>depmod:         CardServices
>
>There seems to be a problem with the routine deactivate_page, which is no 
>longer present
>in the 2.4.14 kernel but is used somehow in the loop device code.
>
>Hans

This is a known problem, and is fixed starting 2.4.15-pre1. Otherwise you 
can also manually remove the deactivate_page calls from loop.c and compile 
again.

DK


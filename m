Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281365AbRKLI6l>; Mon, 12 Nov 2001 03:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281366AbRKLI6b>; Mon, 12 Nov 2001 03:58:31 -0500
Received: from bayer2.bayer-ag.de ([194.120.191.2]:52135 "HELO
	bayer2.bayer-ag.de") by vger.kernel.org with SMTP
	id <S281365AbRKLI6W>; Mon, 12 Nov 2001 03:58:22 -0500
Subject: loop Device doesn't work in kernel 2.4.14
To: linux-kernel@vger.kernel.org
From: johann.pfefferl.jp@germany.agfa.com
Date: Mon, 12 Nov 2001 09:57:38 +0100
Message-Id: <OFC9FBD042.EA509C88-ON41256B02.002FCAEC@bayer-ag.com>
X-Mimetrack: Serialize by Router on BY-INET1/Central/LEV/DE/BAYER(Release 5.0.8 |June 18, 2001) at
 11/12/2001 09:58:18 AM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have detected that the loop device mechanism can't be
used any longer in kernel version 2.4.14. I have compiled
the kernel with minimum features (ext2, initrd, ramdisk) compiled
into the kernel. The rest is all modules.

# cat /proc/version
Linux version 2.4.14 (root@pcls03) (gcc version 2.95.3 20010315 (SuSE)) #2 Wed Nov 7 11:34:01 CET 2001

# mount -o loop /tmp/DISK /mnt -v
mount: Could not find any loop device, and, according to /proc/devices,
       this kernel does not know about the loop device.
       (If so, then recompile or `insmod loop.o'.)

# modprobe -v loop
/sbin/insmod /lib/modules/2.4.14/kernel/drivers/block/loop.o
Using /lib/modules/2.4.14/kernel/drivers/block/loop.o
Symbol version prefix ''
/lib/modules/2.4.14/kernel/drivers/block/loop.o: unresolved symbol deactivate_page
/lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod /lib/modules/2.4.14/kernel/drivers/block/loop.o failed
/lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod loop failed

# find /usr/src/linux-2.4.14 -type f -name '*.[ch]' |xargs grep deactivate_page
/usr/src/linux-2.4.14/drivers/block/loop.c:             deactivate_page(page);
/usr/src/linux-2.4.14/drivers/block/loop.c:     deactivate_page(page);

# depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.14/kernel/drivers/block/loop.o
depmod:         deactivate_page
depmod: *** Unresolved symbols in /lib/modules/2.4.14/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode
depmod: *** Unresolved symbols in /lib/modules/2.4.14/kernel/drivers/telephony/ixj_pcmcia.o
depmod:         register_pccard_driver
depmod:         unregister_pccard_driver
depmod:         CardServices

There seems to be a problem with the routine deactivate_page, which is no longer present
in the 2.4.14 kernel but is used somehow in the loop device code.

Hans
--
Dr.-Ing. Johann Pfefferl       mailto:johann.pfefferl.jp@germany.agfa.com
Agfa-Gevaert AG                                    Tel.: +49 89 6207-3524
GF Laborgeraete, Entwicklung Software (LG-ESW)     Sek.: +49 89 6207-3362
Tegernseer Landstr. 161,  D-81539 Muenchen         Fax : +49 89 6207-7279
                      __
                     / /    __  _  _  _  _ __  __
                    / /__  / / / \// //_// \ \/ /           -o)
                   /____/ /_/ /_/\/ /___/  /_/\_\           /\\
                    ...for IQs GREATER than 98...          _\_v-



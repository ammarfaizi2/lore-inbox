Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSI0XwO>; Fri, 27 Sep 2002 19:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbSI0XwO>; Fri, 27 Sep 2002 19:52:14 -0400
Received: from members.cotse.com ([216.112.42.58]:42122 "EHLO cotse.com")
	by vger.kernel.org with ESMTP id <S262648AbSI0XwN>;
	Fri, 27 Sep 2002 19:52:13 -0400
From: alan@cotse.net
Message-ID: <YWxhbg==.2ba5f69c113071e878e765f8a0b9b65e@1033171691.cotse.net>
Date: Fri, 27 Sep 2002 20:08:11 -0400 (EDT)
X-Abuse-To: abuse@cotse.com
X-AntiForge: http://packetderm.cotse.com/antiforge.php
Subject: Nonfatal error in 2.5.39 + preempt
To: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  In 2.5.39, with preempt configured, I get the following err message
in the middle of the ide setup:

ide: Assuming 66MHz system bus speed for PIO modes
ICH: IDE controller at PCI slot 00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 2B020H1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Lite-On LTN486 48x Max, ATAPI CD/DVD-ROM drive
Sleeping function called from illegal context at slab.c:1374
c12bdec4 c01125b4 c02d4160 c02d84f0 0000055e 000001d0 c012c260 c02d84f0
       0000055e c03f17c8 c026c0e4 04000000 c03f17c8 c01085ac 00000018
       000001d0       c03f17c8 c03f17b8 cfd3e380 04000000 c0265b67 0000000f c026c0e4
       04000000Call Trace:
 [<c01125b4>]__might_sleep+0x54/0x60
 [<c012c260>]kmalloc+0x4c/0x130
 [<c026c0e4>]ide_intr+0x0/0x17c
 [<c01085ac>]request_irq+0x50/0xa8
 [<c0265b67>]init_irq+0x1e7/0x338
 [<c026c0e4>]ide_intr+0x0/0x17c
 [<c0265ff6>]hwif_init+0x112/0x258
 [<c026586c>]probe_hwif_init+0x1c/0x6c
 [<c0275a11>]ide_setup_pci_device+0x61/0x68
 [<c0105086>]init+0x2e/0x188
 [<c0105058>]init+0x0/0x188
 [<c01054c9>]kernel_thread_helper+0x5/0xc

ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)

   I have gotten an error in slab.c that looked like this in 2.5.38,
2.5.38-mm2 and 2.5.38-mm3 with preempt enabled, and I did not get it without
preempt enabled. I've just been too lazy to use ksymoops.  This never kept
me from using my system, but it would 'feel' almost too fast sometimes,
and a bit sluggish otherwise.  My normal usage pattern during the day often
involves building various small pieces of software, and the occasional
kernel.  My system would also lock up completely with preempt enabled,
without the ability to use even the sysrq key for anything.

   As I am writing this on 2.5.39 + preempt, I also get this err:

Sleeping function called from illegal context at slab.c:1374
ce819f6c c01125b4 c02d4160 c02d84f0 0000055e 000001d0 c012c260 c02d84f0
       0000055e 00000000 00000400 bffffbc4 ceba9620 c010abb2 00000080
       000001d0       ce818000 40015b6c bffffbc4 bffffacc 00000000 c0106fff 00000000
       00000400Call Trace:
 [<c01125b4>]__might_sleep+0x54/0x60
 [<c012c260>]kmalloc+0x4c/0x130
 [<c010abb2>]sys_ioperm+0x82/0x11c
 [<c0106fff>]syscall_call+0x7/0xb

   System is fairly smooth and responsive at the moment though.
   kksymoops makes error reporting so much easier.
   Thank you very much.

-alan




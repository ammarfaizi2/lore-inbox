Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265233AbUF1Vk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUF1Vk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUF1Vk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:40:57 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:23221 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265233AbUF1Vkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:40:53 -0400
Date: Mon, 28 Jun 2004 17:34:41 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: __setup()'s not processed in bk-current
Message-ID: <Pine.GSO.4.33.0406281523340.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bootdata ok (command line is ro console=ttyS0,115200 debug numa=off md=d0,0,2,0,
/dev/sda,/dev/sdb,/dev/sdc,/dev/sdd root=/dev/hdd1)
...
Built 1 zonelists
Kernel command line: ro console=ttyS0,115200 debug numa=off md=d0,0,2,0,/dev/sda
,/dev/sdb,/dev/sdc,/dev/sdd root=/dev/hdd1
Parsing ARGS: ro console=ttyS0,115200 debug numa=off md=d0,0,2,0,/dev/sda,/dev/s
db,/dev/sdc,/dev/sdd root=/dev/hdd1
parse_one(): params[0]: 8250.share_irqs
parse_one(): params[1]: 8250.probe_rsa
parse_one(): params[2]: scsi_mod.scsi_logging_level
parse_one(): params[3]: scsi_mod.max_luns
parse_one(): params[4]: scsi_mod.max_report_luns
parse_one(): params[5]: scsi_mod.inq_timeout
parse_one(): params[6]: scsi_mod.dev_flags
parse_one(): params[7]: scsi_mod.default_dev_flags
parse_one(): params[8]: usbcore.blinkenlights
parse_one(): params[9]: usbcore.usbfs_snoop
parse_one(): params[10]: ehci_hcd.log2_irq_thresh
parse_one(): params[11]: ohci_hcd.power_switching
parse_one(): params[12]: mousedev.xres
parse_one(): params[13]: mousedev.yres
parse_one(): params[14]: atkbd.set
parse_one(): params[15]: atkbd.reset
parse_one(): params[16]: atkbd.softrepeat
parse_one(): params[17]: atkbd.scroll
parse_one(): params[18]: atkbd.extra
parse_one(): params[19]: psmouse.proto
parse_one(): params[20]: psmouse.resolution
parse_one(): params[21]: psmouse.rate
parse_one(): params[22]: psmouse.smartscroll
parse_one(): params[23]: psmouse.resetafter
parse_one(): params[24]: i8042.noaux
parse_one(): params[25]: i8042.nomux
parse_one(): params[26]: i8042.unlock
parse_one(): params[27]: i8042.reset
parse_one(): params[28]: i8042.direct
parse_one(): params[29]: i8042.dumbkbd
Unknown argument: calling ffffffff805713c0
obsolete_checksetup(): line: console=ttyS0,115200
obsolete_checksetup(): checking: nosmp(5)
obsolete_checksetup(): checking: <NULL>(1)
obsolete_checksetup(): checking: <NULL>(1)
obsolete_checksetup(): checking: H<83><EC>^XH<89>|H<8D>t$^TH<8D>|<E8>HQ<CD><FF>
<85><C0>t$HcD$^TH<C7><C7>+^N;<80><C7>^EN<D6><FA><FF>^A(47)
obsolete_checksetup(): checking: debug(5)
obsolete_checksetup(): checking: <NULL>(1)
obsolete_checksetup(): checking: <NULL>(1)
obsolete_checksetup(): checking: H<89>=<91>k<F9><FF><BA>^A(9)
obsolete_checksetup(): checking: initcall_debug(14)
obsolete_checksetup(): checking: <NULL>(1)
obsolete_checksetup(): checking: <NULL>(0)
obsolete_checksetup(): checking: H<83><ECH<C7><C6>^E<B6>:<80>H<85><FF>H^OE<F7>1
<C0>H<C7><C7>!<B6>:<80><E8><B0><D8>^B(31)
obsolete_checksetup(): checking: load_ramdisk=(13)
obsolete_checksetup(): checking: <NULL>(1)
obsolete_checksetup(): checking: <NULL>(1)
obsolete_checksetup(): checking: <80>?(2)
obsolete_checksetup(): checking: root=(5)
obsolete_checksetup(): checking: <NULL>(1)
obsolete_checksetup(): checking: <NULL>(1)
obsolete_checksetup(): checking: <B8>^A(2)
...
obsolete_checksetup(): checking: log_buf_len=(12)
...

Odd that it sees "log_buf_len=", but not the "console=" that's defined right
ahead of it:
(kernel/printk.o)
Contents of section .init.data:
 0000 636f6e73 6f6c653d 006c6f67 5f627566  console=.log_buf
 0010 5f6c656e 3d00                        _len=.

init/main.o:
Contents of section .init.data:
 0000 6e6f736d 70006d61 78637075 733d0070  nosmp.maxcpus=.p
 0010 726f6669 6c653d00 64656275 67007175  rofile=.debug.qu
 0020 69657400 696e6974 3d000000 00000000  iet.init=.......
 0030 00000000 00000000 00000000 00000000  ................
...
 0140 696e6974 63616c6c 5f646562 75670074  initcall_debug.t
 0150 65737473 65747570 00746573 74736574  estsetup.testset
 0160 75705f6c 6f6e6700 00000000           up_long.....

The linked kernel *looks* correct (x86_64 here):
Contents of section .init.data:
 ffffffff8058d000 6e6f736d 70006d61 78637075 733d0070  nosmp.maxcpus=.p

Contents of section .init.setup:
 ffffffff80593510 00d05880 ffffffff 60125780 ffffffff  ..X.....`.W.....
 ffffffff80593520 00000000 00000000 00000000 00000000  ................
 ffffffff80593530 06d05880 ffffffff 70125780 ffffffff  ..X.....p.W.....
 ffffffff80593540 00000000 00000000 00000000 00000000  ................

Do I smell some bad pointer math?  Yeap:
DEBUG: sizeof(obs_kernel_param): 24 (0x18)

obsolete_checksetup(): line: ro
obsolete_checksetup(): checking: nosmp(5) @ ffffffff80593510
obsolete_checksetup(): checking: <NULL>(1) @ ffffffff80593528

p++ moved the pointer sizeof(obs_kernel_param) ahead, but that's 8 bytes
short.

--Ricky



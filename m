Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTFJOMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTFJOMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:12:42 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:12552 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262884AbTFJOMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:12:38 -0400
Date: Tue, 10 Jun 2003 11:27:51 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IDE OOPS in latest BK
Message-ID: <20030610142750.GC31067@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[root@oops root]# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8375 [KM266] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 01)
00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master
IDE (rev 06)
00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem]
(rev 80)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Radeon 9000] (rev 01)
[root@oops root]#

Jun 10 01:09:07 oops kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun 10 01:09:07 oops kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 10 01:09:07 oops kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Jun 10 01:09:07 oops kernel: PCI: Hardcoded IRQ 14 for device 00:11.1
Jun 10 01:09:07 oops kernel: VP_IDE: chipset revision 6
Jun 10 01:09:07 oops kernel: VP_IDE: not 100%% native mode: will probe irqs later
Jun 10 01:09:07 oops kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 10 01:09:07 oops kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller
on pci00:11.1
Jun 10 01:09:07 oops kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
Jun 10 01:09:07 oops kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:DMA
Jun 10 01:09:07 oops kernel: hda: ST380021A, ATA DISK drive
Jun 10 01:09:07 oops kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 10 01:09:07 oops kernel: hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
Jun 10 01:09:07 oops kernel: hdd: HL-DT-ST GCE-8160B, ATAPI CD/DVD-ROM drive
Jun 10 01:09:07 oops kernel: hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
Jun 10 01:09:07 oops kernel: hdc: set_drive_speed_status: error=0x04
Jun 10 01:09:07 oops kernel: ide1: Drive 0 didn't accept speed setting. Oh, well.
Jun 10 01:09:07 oops kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 10 01:09:07 oops kernel: hda: max request size: 128KiB
Jun 10 01:09:07 oops kernel: hda: host protected area => 1
Jun 10 01:09:07 oops kernel: hda: 156301488 sectors (80026 MB) w/2048KiB Cache,
CHS=155061/16/63
Jun 10 01:09:07 oops kernel:  hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >


Unable to handle kernel paging request at virtual address 6b6b6b7f
 printing eip:
c021f5a5
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[task_mulout_intr+309/608]    Not tainted
EFLAGS: 00010202
EIP is at task_mulout_intr+0x135/0x260
eax: 000001f0   ebx: 6b6b6b6b   ecx: 00000000   edx: 6b6b6b6b
esi: 00000008   edi: eb24e524   ebp: ef3bbc2c   esp: ef3bbc08
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 265, threadinfo=ef3ba000 task=ef556140)
Stack: c038bccc cf85b000 00000400 00000000 6b6b6b6b 00000008 c038bccc c038bccc 
       ef3bbc94 ef3bbc50 c021f748 c038bccc c038bccc 00000008 000000a1 00000032 
       c01deaf4 c038bc20 ef3bbc80 c021e4d6 c038bccc eb24e524 000001f7 00000000 
Call Trace:
 [pre_task_mulout_intr+120/128] pre_task_mulout_intr+0x78/0x80
 [__delay+20/32] __delay+0x14/0x20
 [do_rw_taskfile+326/720] do_rw_taskfile+0x146/0x2d0
 [lba_28_rw_disk+164/176] lba_28_rw_disk+0xa4/0xb0
 [pre_task_mulout_intr+0/128] pre_task_mulout_intr+0x0/0x80
 [task_mulout_intr+0/608] task_mulout_intr+0x0/0x260
 [SELECT_DRIVE+51/80] SELECT_DRIVE+0x33/0x50
 [start_request+236/320] start_request+0xec/0x140
 [ide_do_request+601/1264] ide_do_request+0x259/0x4f0
 [do_ide_request+31/48] do_ide_request+0x1f/0x30
 [generic_unplug_device+359/448] generic_unplug_device+0x167/0x1c0
 [check_poison_obj+56/400] check_poison_obj+0x38/0x190
 [blk_run_queues+318/832] blk_run_queues+0x13e/0x340
 [generic_make_request+311/464] generic_make_request+0x137/0x1d0
 [__wait_on_buffer+179/192] __wait_on_buffer+0xb3/0xc0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [sync_dirty_buffer+75/192] sync_dirty_buffer+0x4b/0xc0
 [journal_commit_transaction+2499/6950] journal_commit_transaction+0x9c3/0x1b26
 [start_request+236/320] start_request+0xec/0x140
 [kjournald+377/864] kjournald+0x179/0x360
 [commit_timeout+0/16] commit_timeout+0x0/0x10
 [kjournald+0/864] kjournald+0x0/0x360
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

Code: 0f b7 42 14 8b 5a 24 66 2b 47 24 0f b7 c0 8d 04 40 c1 e0 02 

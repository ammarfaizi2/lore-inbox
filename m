Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUBVAVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 19:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUBVAVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 19:21:09 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18599 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261631AbUBVAVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 19:21:03 -0500
Date: Sun, 22 Feb 2004 00:12:46 +0000
From: Andrew Gray <agray@alumni.uwaterloo.ca>
Subject: kernel BUG at drivers/ide/ide-iops.c:1005!
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Message-id: <20040222001246.GA9787@chalco.vc.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linux 2.6.3 vanilla, i586, compiled with gcc 3.2.3.

Four ide drives:
hda: WD hard drive
hdb: Mitsumi CR-4802TE IDE CDR (slave)
hdc: quantim hard drive
hdd: toshiba CDROM.

I'm passing hdb=cdrom on the boot cmdline.  With 2.4 I could burn CDs with
ide-scsi. With 2.6 I cannot mount a CD in /dev/hdb. The mount process
hangs in D state. Then I get the following oops (transcribed by hand,
so there may be some type-os):

kernel BUG at drivers/ide/ide-iops.c:1005!
invalid operand: 0000[#1]
CPU: 0
EIP: 0060:[<c01de848>] Not tainted
EFLAGS: 00010086
EIP is at ide_execute_command +0x38/0xb0
eax: c01e4b00 ebx: c02da000 ecx: c01e45b0 edx: c5f1c680
esi: c030bcec edi: 00c04e20 ebp: c02dbe50 esp: c02dbe38
stack:
c0306c40 00000292 ca000000 c0306cec c0306c40 c5eb7e28 c02dbe7c c01e4edc
c0306cec 000000c9 c01e45b0 00004e20 c01e4b00 0030bc40 00000000 c030bc40
000001f6 c02dbeb8 c01e79dc c0306cec c02dbeac c01de0ac 000001f7 00000000

call trace:
[<c01e4edc>] __ide_dma_write     +0x8c/0xa0
[<c01e45b0>] ide_dma_intr        +0x0/0x90
[<c01e4b00>] dma_timer_expiry    +0x0/0x90
[<c01e79dc>] __ide_do_rw_disk    +0x33c/0x610
[<c01de0ac>] ide_wait_stat       +0xcc/0x120
[<c01dcc9f>] start_req           +0x13f/0x220
[<c01dcf8e>] ide_do_req          +0x1de/0x370
[<c010ab81>] enable_irq          +0x81/0xb0
[<c01dd2f6>] ide_timer_expiry    +0xe6/0x220
[<c68f0f30>] cdrom_read_intr     +0x00/0x3a0 [ide_cd]
[<c01dd210>] ide_timer_expiry    +0x00/0x220
[<c01218c1>] run_timer_softirq   +0xd1/0x1b0
[<c021d8e3>] do_softirq          +0x93/0xb0
[<c020ace5>] do_IRQ              +0x135/0x170
[<c02d5000>] rest_init           +0x00/0x60
[<c02d9398>] common_interrupt    +0x18/0x20
[<c02d6f40>] default_idle        +0x00/0x30
[<c02d5000>] rest_init           +0x00/0x60
[<c02d6f68>] default_idle        +0x28/0x30
[<c02d6fde>] cpu_idle            +0x2e/0x40
[<c02dc6ba>] start_kernel        +0x14a/0x160

code: 0f 0b ed 03 59 21 26 c0 89 0a 89 82 dc 00 00 00 a1 a0 b7 27

Part of .config:
#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

(ide-scsi module not loaded).

Please cc: me if I can provide more information, as I am not on the list.

-- 
Andrew Gray 

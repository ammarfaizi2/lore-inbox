Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUBOHlx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUBOHlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:41:51 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:44203 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264291AbUBOHlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:41:45 -0500
Date: Sun, 15 Feb 2004 02:41:41 -0500
From: Marc Heckmann <mh@nadir.org>
To: akpm@osdl.org, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: oops w/ 2.6.2-mm1 on ppc32
Message-ID: <20040215074140.GA3840@nadir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It happened while the machine was waking up from sleep. There were no
UDF or ISO filesystems mounted at the time, in fact, there wasn't even
a cd in the drive. The "autorun" process was running though (polls the
cdrom drive, to see if a disc has been inserted...). There were some
request timeouts on the cdrom drive (hdc) just before, it went to
sleep (system was idle at the time, I wasn't even at home).

Here is the kernel output before and after the machine went to sleep. The Oops
is at the bottom.

ide-cd: cmd 0x3 timed out
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: DMA disabled
hdc: ATAPI reset timed-out, status=0x80
ide1: reset timed-out, status=0x80
hdc: status timeout: status=0x80 { Busy }
hdc: status timeout: error=0x80LastFailedSense 0x08
hdc: drive not ready for command
hdc: ATAPI reset timed-out, status=0x80
ide1: reset timed-out, status=0x80
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
mediabay0: powering down
ohci_hcd 0000:00:0e.0: USB continue from host wakeup
mediabay0: powering down
mediabay0: powering up                       <--------- wakeup starts here.
mediabay0: enabling (kind:3)
mediabay0: waiting reset (kind:3)
mediabay0: waiting IDE reset (kind:3)
mediabay0: waiting IDE ready (kind:3)
media-bay 0 is ide1
mediabay 0 IDE ready
mesh: performing initial bus reset...
phy registers:
 3500 7869 2000 5c10 01e1 0021 0004 2001
 0000 0000 0000 0000 0000 0000 0000 0000
 0a23 0000 0000 0000 0000 0000 0020 0000
 0000 0000 0109 0100 0006 0f00 0000 0000
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: MDMA, cycleTime: 120, accessTime: 75, recTime: 45
hda: Set MDMA timing for mode 2, reg: 0x00211526
hda: Enabling MultiWord DMA 2
hda: completing PM request, resume
adb: starting probe task...
adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
ADB mouse at 3, handler set to 4 (trackpad)
adb: finished probe task...
UDF-fs DEBUG fs/udf/super.c:502:udf_set_blocksize: Bad block size (2048)
udf: bad block size (2048)
kernel BUG in grow_buffers at fs/buffer.c:1195!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C0055B30 LR: C0055AF0 SP: C862FCF0 REGS: c862fc40 TRAP: 0700    Not tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cf1e1b60[3743] 'mount' Last syscall: 21
GPR00: 0000FBFF C862FCF0 CF1E1B60 00000000 00000000 00000000 00000000 C02CE75C
GPR08: 0000001C 00000000 00000000 0000FC00 22004422 100289FC 00000000 7FFFF978
GPR16: 7FFFF82C 00000000 00000000 100EDD08 00000000 00000000 00000000 00000000
GPR24: 00000000 00000064 00000000 00000000 00008000 D7FF4AC0 00000010 00000000
Call trace:
 [c00560a0] __getblk+0x54/0x5c
 [c0056100] __bread+0x10/0x40
 [c00b40fc] isofs_fill_super+0x590/0x6fc
 [c005acc4] get_sb_bdev+0x128/0x180
 [c00b4dac] isofs_get_sb+0x18/0x28
 [c005afe8] do_kern_mount+0xb4/0x1dc
 [c0071ad8] do_add_mount+0x8c/0x1b8
 [c0071e94] do_mount+0x184/0x1bc
 [c0072318] sys_mount+0xd4/0x11c
 [c000781c] ret_from_syscall+0x0/0x44

-m

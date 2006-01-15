Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWAPHPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWAPHPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 02:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWAPHPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 02:15:25 -0500
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:11190 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932213AbWAPHPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 02:15:25 -0500
Subject: 2.6.15 on powerbook 15" still oopsing on resume with cd/dvd in
	drive
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@KERNEL.CRASHING.ORG>
Content-Type: text/plain
Date: Sun, 15 Jan 2006 10:46:38 +0100
Message-Id: <1137318398.24666.25.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

happens this time w/o preemption:

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set


relevant dmesg part:

radeonfb (0000:00:10.0): suspending to state: 2...
uninorth-agp: disabling AGP on device 0000:00:10.0
uninorth-agp: disabling AGP on bridge 0000:00:0b.0
radeonfb (0000:00:10.0): switching to D2 state...
radeonfb (0000:00:10.0): resuming from state: 2...
radeonfb (0000:00:10.0): switching to D0 state...
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
eth0: resuming
PHY ID: 2060e1, addr: 0
hda: Enabling Ultra DMA 4
BUG: soft lockup detected on CPU#0!
NIP: C00068EC LR: C0285CA8 SP: ED37BC30 REGS: ed37bb80 TRAP: 0901    Not tainted
MSR: 0200b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
TASK = ed377390[4714] 'pbbuttonsd' THREAD: ed37a000
Last syscall: 54 
GPR00: 00487AB0 ED37BC30 ED377390 000513B5 000088B8 00000000 00000000 C05445F0 
GPR08: 00000000 C04B0000 00000000 00400000 00000000 
NIP [c00068ec] __delay+0xc/0x14
LR [c0285ca8] ide_wait_not_busy+0x34/0x90
Call trace:
 [c02845e4] ide_do_request+0x464/0x8c8
 [c0284b20] ide_do_drive_cmd+0xd8/0x12c
 [c028169c] generic_ide_resume+0x80/0x94
 [c0269c44] resume_device+0xa8/0xec
 [c0269dd8] dpm_resume+0xa0/0x120
 [c0269e94] device_resume+0x3c/0x70
 [c027c5e0] pmac_wakeup_devices+0xac/0xcc
 [c027dc10] pmu_ioctl+0x718/0x8ec
 [c0086d58] do_ioctl+0x70/0x88
 [c0087100] vfs_ioctl+0x390/0x3cc
 [c00871a4] sys_ioctl+0x68/0x98
 [c00046dc] ret_from_syscall+0x0/0x44
hdc: Enabling MultiWord DMA 2
VFS: busy inodes on changed media.
adb: starting probe task...
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
ADB mouse at 3, handler set to 4 (trackpad)
adb: finished probe task...
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
[drm] Loading R200 Microcode
orinoco 0.15rc3 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
airport 0.15rc3 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
airport: Physical address 80030000
eth1: Hardware identity 0005:0001:0001:0002
eth1: Station identity  001f:0001:0008:0046
eth1: Firmware determined as Lucent/Agere 8.70
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:30:65:28:DD:B1
eth1: Station name "HERMES I"
eth1: ready
airport: Card registered for interface eth1
hdc: irq timeout: status=0xc0 { Busy }
ide: failed opcode was: unknown
hdc: DMA disabled
hdc: ATAPI reset complete
ADDRCONF(NETDEV_UP): eth1: link is not ready

Note, the system is in a completely usable state afterwards... but still
it is a bit annoying...

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.


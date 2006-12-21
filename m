Return-Path: <linux-kernel-owner+w=401wt.eu-S1423121AbWLUXFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423121AbWLUXFd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423127AbWLUXFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:05:33 -0500
Received: from [195.171.73.133] ([195.171.73.133]:56679 "EHLO
	pelagius.h-e-r-e-s-y.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1423108AbWLUXFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:05:31 -0500
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 18:05:31 EST
Subject: Sparc64 kernel oops (caused by bad scsi disk?)
From: Andrew Walrond <andrew@walrond.org>
To: sparclinux <sparclinux@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 22:40:27 +0000
Message-Id: <1166740827.5009.64.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Installing a bad disk in a Sun D1000 (JBOD 12 disk scsi 2 array)
attached to a Sun E4500 (8proc, 8Gb ram) running a 64bit sparc64
2.6.18.3 SMP kernel causes this or similar oops when accessing the bad
disk:

sda: Current: sense key: Recovered Error
    Additional sense: Address mark not found for data field
Info fld=0xa8d
sda: Current: sense key: Recovered Error
    Additional sense: Write error - recovered with auto reallocation
Info fld=0xa98
sda: Current: sense key: Recovered Error
    Additional sense: Address mark not found for data field
Info fld=0xad6
sda: Current: sense key: Recovered Error
    Additional sense: Recovered data with retries
Info fld=0xaff
sda: Current: sense key: Recovered Error
    Additional sense: Recovered data with retries
Info fld=0xb0f
eth5: Auto-Negotiation unsuccessful, trying force link mode
sda: Current: sense key: Recovered Error
    Additional sense: Recovered data with negative head offset
Info fld=0xb2b
sda: Current: sense key: Recovered Error
    Additional sense: Recovered data with retries
Info fld=0xb52
sda: Current: sense key: Recovered Error
    Additional sense: Recovered data with retries
Info fld=0xb68
sda: Current: sense key: Recovered Error
    Additional sense: Recovered data with retries
Info fld=0xbba
eth5: Link down, cable problem?
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000000000005a4
tsk->{mm,active_mm}->pgd = fffff80113976000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
TSTATE: 0000000080f09607 TPC: 000000000052b51c TNPC: 000000000052b520 Y: 00000000    Not tainted
TPC: <memcpy+0x1224/0x13c0>
g0: fffff80003d03660 g1: 0000000011010080 g2: 0000000000000000 g3: fffff801feaf0000
g4: 000000000072d280 g5: fffff8000350c000 g6: 0000000000729280 g7: 0000000000000050
o0: 00000000000000c0 o1: fffff801feaf1d60 o2: 0000000000000000 o3: 000007fe0150e360
o4: 00000000000000c0 o5: f0000300000bcf28 sp: 000000000072c3d1 ret_pc: 00000000005d7e24
RPC: <qpti_intr+0x128/0x294>
l0: fffff801feaf1d40 l1: 0000000000000076 l2: 0000000000000000 l3: 0000000000000076
l4: 0000000000000000 l5: 0000000000000000 l6: fffff80004a74140 l7: 0000000000000001
i0: 0000000000000000 i1: fffff80004faa4c0 i2: 000000000072cf90 i3: 0000000000000000
i4: 0000000000000000 i5: fffff80003d6b660 i6: 000000000072c491 i7: 000000000046d20c
I7: <handle_IRQ_event+0x38/0x78>
Caller[000000000046d20c]: handle_IRQ_event+0x38/0x78
Caller[000000000046d308]: __do_IRQ+0xbc/0x13c
Caller[000000000041bec8]: handler_irq+0x7c/0x94
Caller[00000000004108b4]: tl0_irq5+0x1c/0x20
Caller[00000000004180e4]: cpu_idle+0x2c/0xa4
Caller[00000000007ce6c0]: start_kernel+0x28c/0x294
Caller[00000000004045d8]: setup_trap_table+0x0/0x100
Caller[0000000000000000]: 0x8
Instruction DUMP: da5a6000  c25a6008  8ea1e010 <da72400b> 92026008  c272400b  186ffffa  92026008  808aa008
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Press Stop-A (L1-A) to return to the boot prom


Let me know if I can do anything to help chase this down.

Andrew Walrond


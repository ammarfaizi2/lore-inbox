Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUL1F0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUL1F0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 00:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUL1FZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 00:25:51 -0500
Received: from b.mail.sonic.net ([64.142.19.5]:7051 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S262079AbUL1FYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:24:44 -0500
Date: Mon, 27 Dec 2004 21:29:15 -0800
From: Jim McCloskey <mcclosk@ucsc.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 solves mtrr problem
Message-ID: <20041228052915.GA9330@lapdog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux/2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Probably well known already to the knowledgeable, but I just wanted to
report that 2.6.10 fixes a problem that I have been puzzled by since
about 2.6.7.

The problem was that mtrr ranges were not set appropriately for
the graphics card on my laptop, which is a:

----------------------------------------------------------------------
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Mitac: Unknown device 8170
	Flags: bus master, stepping, 66MHz, medium devsel, latency 64, IRQ 11
	Memory at 90000000 (32-bit, prefetchable) [size=128M]
	I/O ports at c000 [size=256]
	Memory at e0000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2
----------------------------------------------------------------------

The problem was indicated in kern.log for 2.6.9:

----------------------------------------------------------------------
Dec 14 10:31:19 lapdog kernel: mtrr: 0x90000000,0x1000000 overlaps existing 0x90000000,0x200000
----------------------------------------------------------------------

which resulted in turn in the following, when the X server was started:

----------------------------------------------------------------------
(--) RADEON(0): Linear framebuffer at 0x90000000
(--) RADEON(0): VideoRAM: 16384 kByte (64 bit DDR SDRAM)
(II) RADEON(0): AGP card detected

        .....

(WW) RADEON(0): Failed to set up write-combining range (0x90000000,0x1000000)
----------------------------------------------------------------------

This problem has disappeared in 2.6.10. /proc/mtrr:

----------------------------------------------------------------------
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x90000000 (2304MB), size=  16MB: write-combining, count=3
reg02: base=0xa0000000 (2560MB), size=  64MB: write-combining, count=1
----------------------------------------------------------------------

For previous 2.6 kernels, I had to run a hand-written script to
achieve this result.

Thank you,

Jim

----------------------------------------------------------------------
cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping	: 4
cpu MHz		: 1600.489
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3153.92
======================================================================

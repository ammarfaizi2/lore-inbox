Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbULMJwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbULMJwP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 04:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbULMJwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 04:52:14 -0500
Received: from h01.hostsharing.net ([212.42.230.152]:10190 "EHLO
	pima.hostsharing.net") by vger.kernel.org with ESMTP
	id S261170AbULMJwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 04:52:00 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <A14736FC-4CEC-11D9-8ECF-000A95AAEC58@despammed.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Dirk Dittert <dittert@despammed.com>
Subject: Problems with forcedeth network driver
Date: Mon, 13 Dec 2004 10:51:58 +0100
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting the following error messages in syslog:

Dec 12 04:53:00 [kernel] eth0: received irq with unknown events 0x92. 
Please report
Dec 12 04:53:07 [kernel] eth0: received irq with unknown events 0x82. 
Please report
...
Dec 12 15:56:05 [kernel] eth0: received irq with unknown events 0x83. 
Please report
Dec 12 15:56:08 [kernel] eth0: received irq with unknown events 0x82. 
Please report
...
Dec 12 15:58:17 [kernel] eth0: received irq with unknown events 0xa0. 
Please report
Dec 12 15:59:53 [kernel] eth0: received irq with unknown events 0x92. 
Please report

drivers/net/forcedeth.c did not contain any contact e-mail addresses. I 
am hoping that somebody on this list would be able to add the 
appropriate fixes in function
static irqreturn_t nv_nic_irq(int foo, void *data, struct pt_regs *regs)
of the interrupt handling code. Networking more or less comes to a 
complete standstill (some traffic still passes through, but speed is 
very low) if this happens. I can trigger the problem by copying about 
300MB data to a netatalk share.

Hardware: Shuttle SN45GV3, chipset NVIDIA nForce2 400 with onboard LAN

Best,

Dirk Dittert


--- System information follows ---

Kernel is:
Linux version 2.6.9-gentoo-r9 (root@proxy-wue) (gcc-Version 3.3.4 
20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #4 Sun Dec 12 
16:10:58 CET 2004

CPU:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : Unknown CPU Typ
stepping        : 0
cpu MHz         : 1987.832
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3932.16

Modules:
usbcore 99684 1 - Live 0xd0c9f000

/proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
0376-0376 : ide1
03c0-03df : vga+
   03c0-03df : vesafb
0970-0977 : 0000:00:0b.0
09f0-09f7 : 0000:00:0b.0
0b70-0b73 : 0000:00:0b.0
0bf0-0bf3 : 0000:00:0b.0
0cf8-0cff : PCI conf1
4000-407f : motherboard
   4000-4003 : PM1a_EVT_BLK
   4004-4005 : PM1a_CNT_BLK
   4008-400b : PM_TMR
   4020-4027 : GPE0_BLK
4080-40ff : motherboard
4200-427f : motherboard
4280-42ff : motherboard
4400-447f : motherboard
4480-44ff : motherboard
   44a0-44af : GPE1_BLK
5000-503f : motherboard
5100-513f : motherboard
d000-dfff : PCI Bus #01
   d000-d07f : 0000:01:04.0
   d100-d13f : 0000:01:06.0
     d100-d13f : eepro100
e000-e007 : 0000:00:04.0
e100-e1ff : 0000:00:06.0
e200-e27f : 0000:00:06.0
e500-e51f : 0000:00:01.1
ea00-ea0f : 0000:00:0b.0
eb00-eb7f : 0000:00:0b.0
f000-f00f : 0000:00:09.0
   f000-f007 : ide0
   f008-f00f : ide1

/proc/iomem

Linux proxy-wue 2.6.9-gentoo-r9 #4 Sun Dec 12 16:10:58 CET 2004 i686 
Unknown CPU Typ AuthenticAMD GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.1.1
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.25
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         usbcore

-- 
Always Use Source Code Control
Source code control is a time machine for your work -- you _can_ go 
back.
     The Pragmatic Programmer


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbUKXVUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbUKXVUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUKXVUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:20:38 -0500
Received: from zeus.kernel.org ([204.152.189.113]:55962 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262854AbUKXVUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:20:19 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20041123175823.GA8803@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1101324238.29045.62.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Nov 2004 11:23:58 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 09:58, Ingo Molnar wrote:
> i have released the -V0.7.30-9 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes-only release.

Using PREEMPT_DESKTOP I see a irq related problem with my network
interface:

cat /proc/interrupts
           CPU0       
  0:     134209    IO-APIC-edge  timer  0/34148
  1:        221    IO-APIC-edge  i8042  0/221
  8:          1    IO-APIC-edge  rtc  0/1
  9:          0   IO-APIC-level  acpi  0/0
 11:          0    IO-APIC-edge  radeon@PCI:1:0:0  0/0
 12:       2215    IO-APIC-edge  i8042  0/2215
 14:        650    IO-APIC-edge  ide0  2/648
 16:     100000   IO-APIC-level  eth0  0/0
 17:         59   IO-APIC-level  libata, libata  0/59
 18:          0   IO-APIC-level  ICE1712  0/0
 20:      15160   IO-APIC-level  libata  0/15160
 21:          0   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd,
uhci_hcd  0/0
NMI:          0 
LOC:     134034 
ERR:          0
MIS:          0

relevant portion of dmesg:
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 304 bytes per
conntrack
r8169 Gigabit Ethernet driver 1.6LK loaded
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 16
divert: allocating divert_blk for eth0
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xf88b6f00, 00:0c:76:b3:c2:43, IRQ 16
IRQ#16 thread RT prio: 40.
hm: ioapic cache empty for irq 16 (e:00000000/d:00010000) 0001a9c1
r8169: eth0: link up
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.5
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
IRQ#4 thread RT prio: 39.
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03d7e80(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present
[drm] Initialized radeon 1.11.0 20020828 on minor 0: 
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
IRQ#11 thread RT prio: 38.
irq 16: nobody cared!
 [<c0104173>] dump_stack+0x23/0x30 (20)
 [<c0147970>] __report_bad_irq+0x30/0xa0 (24)
 [<c0147a80>] note_interrupt+0x70/0xb0 (32)
 [<c01477dc>] do_hardirq+0x13c/0x150 (40)
 [<c0147889>] do_irqd+0x99/0xd0 (32)
 [<c0139fda>] kthread+0xaa/0xb0 (48)
 [<c0101335>] kernel_thread_helper+0x5/0x10 (153083924)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c014777a>] .... do_hardirq+0xda/0x150
.....[<c0147889>] ..   ( <= do_irqd+0x99/0xd0)
.. [<c013c98d>] .... print_traces+0x1d/0x60
.....[<c0104173>] ..   ( <= dump_stack+0x23/0x30)

handlers:
[<f892ce60>] (rtl8169_interrupt+0x0/0x140 [r8169])
Disabling IRQ #16
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 18
IRQ#18 thread RT prio: 37.
hm: ioapic cache empty for irq 18 (e:00000000/d:00010000) 0001a9c9


output of lspci -v for the card:
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
Gigabit Ethernet (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 702c
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
	I/O ports at d000 [size=cffa0000]
	Memory at cfffef00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [dc] Power Management version 2

-- Fernando



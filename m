Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269524AbUJWAxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269524AbUJWAxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbUJWAud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:50:33 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:39070 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S269524AbUJWAmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:42:38 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
In-Reply-To: <32871.192.168.1.5.1098491242.squirrel@192.168.1.5>
References: <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
	 <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu>
	 <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
	 <32871.192.168.1.5.1098491242.squirrel@192.168.1.5>
Content-Type: text/plain
Organization: 
Message-Id: <1098492115.13398.602.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Oct 2004 17:41:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 17:27, Rui Nuno Capela wrote:
> Ingo Molnar wrote:
> >> i have released the -U10.2 Real-Time Preemption patch, which can be
> > downloaded from:
> >
> >   http://redhat.com/~mingo/realtime-preempt/
>
> Regarding the jackd -R issue, I was trying to capture some debug data via
> netconsole on my laptop (P4/UP) running RT-U10.2

Just starting to test U10.3. So far no freezes but I do see problems
with Jack kicking out Hydrogen from the graph and some xruns. 

I see this on boot (athlon64 system):

ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19] 
MMIO=[cfffe000-cfffe7ff]  Max Packet=[2048]
ohci1394 0000:00:0e.0: Device was removed without properly calling
pci_disable_device(). This may need fixing.
r8169 Gigabit Ethernet driver 1.6LK loaded
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 16
divert: allocating divert_blk for eth0
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xf88c8f00, 00:0c:76:b3:c2:43, IRQ 16
BUG: atomic counter underflow at:
 [<c02b99a1>] qdisc_destroy+0x91/0xa0 (8)
 [<c02b9b6f>] dev_shutdown+0x2f/0x90 (12)
 [<c030dfc7>] cond_resched+0x17/0x70 (8)
 [<c02acea5>] unregister_netdevice+0x125/0x250 (16)
 [<c030e6b2>] down_write+0xa2/0x1e0 (12)
 [<c01cd87a>] __up_write+0x11a/0x200 (4)
 [<c02476cf>] unregister_netdev+0xf/0x20 (16)
 [<f8b0163d>] rtl8169_remove_one+0x1d/0x50 [r8169] (8)
 [<c01d6c08>] pci_device_remove+0x68/0x70 (16)
 [<c0235cb6>] device_release_driver+0x56/0x60 (20)
 [<c0235cd8>] driver_detach+0x18/0x30 (12)
 [<c02360d9>] bus_remove_driver+0x29/0x50 (12)
 [<c02364eb>] driver_unregister+0xb/0x20 (8)
 [<c01d6e3b>] pci_unregister_driver+0xb/0x20 (8)
 [<c0137795>] sys_delete_module+0x105/0x130 (8)
 [<c0106019>] sysenter_past_esp+0x52/0x71 (80)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0xd/0x40 [<00000000>] / (0x0 [<00000000>])

divert: freeing divert_blk for eth0
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 300 bytes per
conntrack
r8169 Gigabit Ethernet driver 1.6LK loaded
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 16
divert: allocating divert_blk for eth0
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xf8af4f00, 00:0c:76:b3:c2:43, IRQ 16
IRQ#16 thread RT prio: 49.
r8169: eth0: link up

-- Fernando



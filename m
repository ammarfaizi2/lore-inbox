Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945918AbWJSAIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945918AbWJSAIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 20:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945914AbWJSAIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 20:08:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:32170 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1945918AbWJSAIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 20:08:12 -0400
Subject: Re: 2.6.19-rc2-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20061018162507.efa7b91a.akpm@osdl.org>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	 <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
	 <45364CE9.7050002@yahoo.com.au>
	 <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
	 <45366515.4050308@yahoo.com.au>
	 <1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
	 <20061018154402.ef49874a.akpm@osdl.org>
	 <1161212465.18117.35.camel@dyn9047017100.beaverton.ibm.com>
	 <20061018162507.efa7b91a.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 17:07:59 -0700
Message-Id: <1161216479.18117.45.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 16:25 -0700, Andrew Morton wrote:
> On Wed, 18 Oct 2006 16:01:05 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
> > > Is the NMI watchdog ticking over?
> > 
> > I think so.
> > 
> > # dmesg | grep NMI
> > ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> > ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> > ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> > ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> > testing NMI watchdog ... OK.
> 
> 
> What does it say in /proc/interrupts?
> 
> The x86_64 nmi watchdog handling looks rather complex.
> 
> <checks a couple of x86-64 machines>
> 
> The /proc/interrutps NMI count seems to be going up by about
> one-per-minute.  How odd.   Maybe you just need to wait longer.


While the soft lock up messages are getting printed..
(waited for 5 min for these messages)..

# while :; do grep NMI /proc/interrupts; sleep 30; done
NMI:        265         73         41         47
NMI:        265         81         62         47
NMI:        265         81         71         69
NMI:        265         81         93         77
NMI:        265         81        101         99
NMI:        288         82        101        107
NMI:        296         82        131        129
NMI:        296         82        153        137
NMI:        296         82        161        160
NMI:        296        105        161        167
NMI:        296        112        184        167

Looking at the messages, I don't think trace all cpus
is working ..


BUG: soft lockup detected on CPU#1!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#3!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#3!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#3!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#3!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]


BUG: soft lockup detected on CPU#0!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#0!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]


BUG: soft lockup detected on CPU#0!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#3!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#3!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#3!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#3!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#3!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#1!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#1!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]





Thanks,
Badari




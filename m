Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWHXOiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWHXOiW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWHXOiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:38:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20640 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751588AbWHXOiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:38:21 -0400
Date: Thu, 24 Aug 2006 07:38:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: mm snapshot broken-out-2006-08-24-00-22.tar.gz uploaded
Message-Id: <20060824073817.2f50f6e0.akpm@osdl.org>
In-Reply-To: <6bffcb0e0608240452w6c17586djaab20855d9356139@mail.gmail.com>
References: <200608240723.k7O7NsBB025642@shell0.pdx.osdl.net>
	<6bffcb0e0608240452w6c17586djaab20855d9356139@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006 13:52:28 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> Hi,
> 
> On 24/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > The mm snapshot broken-out-2006-08-24-00-22.tar.gz has been uploaded to
> >
> >    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-24-00-22.tar.gz
> >
> > It contains the following patches against 2.6.18-rc4:
> 
> I haven't seen this on 2.6.18-rc4-mm2. Any idea which patch is causing
> this soft lockup?
> 
> BUG: soft lockup detected on CPU#0!
> [<c01041b5>] dump_trace+0x64/0x1b2
> [<c0104315>] show_trace_log_lvl+0x12/0x25
> [<c0104985>] show_trace+0xd/0x10
> [<c0104a4d>] dump_stack+0x19/0x1b
> [<c014f40d>] softlockup_tick+0xc5/0xd9
> [<c012a0c7>] run_local_timers+0x12/0x14
> [<c012a329>] update_process_times+0x40/0x65
> [<c0113cc7>] smp_apic_timer_interrupt+0x6e/0x77
> [<c0103ce2>] apic_timer_interrupt+0x2a/0x30
> DWARF2 unwinder stuck at apic_timer_interrupt+0x2a/0x30
> Leftover inexact backtrace:

Sigh, useless.

> [<c0104315>] show_trace_log_lvl+0x12/0x25
> [<c0104985>] show_trace+0xd/0x10
> [<c0104a4d>] dump_stack+0x19/0x1b
> [<c014f40d>] softlockup_tick+0xc5/0xd9
> [<c012a0c7>] run_local_timers+0x12/0x14
> [<c012a329>] update_process_times+0x40/0x65
> [<c0113cc7>] smp_apic_timer_interrupt+0x6e/0x77
> [<c0103ce2>] apic_timer_interrupt+0x2a/0x30
> [<c01f3010>] __delay+0x9/0xb
> [<c01ffc47>] _raw_spin_lock+0xca/0x11d
> [<c02f86a8>] _spin_lock+0x2a/0x32
> [<c013cc4e>] do_futex+0xee/0xd9a
> [<c013d9d4>] sys_futex+0xda/0xf0
> [<c01031b5>] sysenter_past_esp+0x56/0x8d


There are a couple of recent futex changes, but they're fairly
innocent-looking.  What is the workload?


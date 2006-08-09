Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWHIBoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWHIBoB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWHIBoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:44:01 -0400
Received: from colin.muc.de ([193.149.48.1]:5903 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030414AbWHIBoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:44:00 -0400
Date: 9 Aug 2006 03:43:59 +0200
Date: Wed, 9 Aug 2006 03:43:59 +0200
From: Andi Kleen <ak@muc.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Message-ID: <20060809014359.GB59180@muc.de>
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net> <6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com> <20060808140511.def9b13c.akpm@osdl.org> <6bffcb0e0608081419p4430b5cei7b4aa990cd0d4422@mail.gmail.com> <20060808143751.42f8d87c.akpm@osdl.org> <6bffcb0e0608081511x17508f89j60705bf74e09e820@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0608081511x17508f89j60705bf74e09e820@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 12:11:38AM +0200, Michal Piotrowski wrote:
> On 08/08/06, Andrew Morton <akpm@osdl.org> wrote:
> >On Tue, 8 Aug 2006 23:19:09 +0200
> >"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> >
> >> >  You
> >> > can look these things up in gdb or using addr2line, provided you have
> >> > CONFIG_DEBUG_INFO=y.
> >> >
> >> >
> >>
> >> (gdb) list *0xc047d609
> >> 0xc047d609 is in start_kernel (/usr/src/linux-work1/init/main.c:577).
> >> 572             cpuset_init_early();
> >> 573             mem_init();
> >> 574             kmem_cache_init();
> >> 575             setup_per_cpu_pageset();
> >> 576             numa_policy_init();
> >> 577             if (late_time_init)
> >> 578                     late_time_init();
> >> 579             calibrate_delay();
> >> 580             pidmap_init();
> >> 581             pgtable_cache_init();
> >
> >hm.
> >
> >- Try to get the full oops record,
> 
> BUG: unable to handle kernel paging request at virtual address 01020304
> printing eip:
> c041b95c
> *pde= 00000000
> Oops: 0000 [#1]
> 4K_STACK PREEMPT SMP
> last sysfs file:
> Modules linked in:
> CPU 0
> EIP: 0060: [<c041b95c>] Not tainted VLI
> EFLAGS: 00010202
> EIP is at kmem_cache_init+0x389/0x3f0

Well it didn't crash in the unwinder.
> [..]

And that [..] isn't a unwinder problem, but a human operator error.
Michal, you removed the valuable part of the backtrace.

-AndI

> Call Trace:
> [<c0104063>] show_stack_log_lvl+0x8c/0x97
> [<c010422b>] show_registers+0x181/0x215
> [<c0104481>] die+0x1c2/0x2dd
> [<c0117419>] do_page_fault+0x410/0x4f3
> [<c02f40a1>] error_code+0x39/0x40
> [<c040b604>] start_kernel+0x21f/0x39d
> [<c0100210>] 0xc0100210

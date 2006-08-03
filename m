Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWHCVSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWHCVSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWHCVSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:18:10 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:5787
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932281AbWHCVSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:18:08 -0400
Date: Thu, 3 Aug 2006 14:18:00 -0700
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Robert Crocombe <rcrocomb@gmail.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: Problems with 2.6.17-rt8
Message-ID: <20060803211800.GA11251@gnuppy.monkey.org>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com> <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com> <1154541079.25723.8.camel@localhost.localdomain> <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com> <1154615261.32264.6.camel@localhost.localdomain> <20060803202211.GA10720@gnuppy.monkey.org> <1154638445.4655.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154638445.4655.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:54:05PM -0400, Steven Rostedt wrote:
> On Thu, 2006-08-03 at 13:22 -0700, Bill Huey wrote:
> > free_pages_bulk is definitely being called inside of an atomic.
> > I force this stack trace when the in_atomic() test is true at the
> > beginning of the function.
> > 
> > 
> > [   29.362863] Call Trace:
> > [   29.367107]        <ffffffff802a82ac>{free_pages_bulk+86}
> > [   29.373122]        <ffffffff80261726>{_raw_spin_unlock_irqrestore+44}
> > [   29.380233]        <ffffffff802a8778>{__free_pages_ok+428}
> > [   29.386336]        <ffffffff8024f101>{free_hot_page+25}
> > [   29.392165]        <ffffffff8022e298>{__free_pages+41}
> > [   29.397898]        <ffffffff806b604d>{__free_pages_bootmem+174}
> > [   29.404457]        <ffffffff806b5266>{free_all_bootmem_core+253}
> > [   29.411112]        <ffffffff806b5340>{free_all_bootmem_node+9}
> > [   29.417574]        <ffffffff806b254e>{numa_free_all_bootmem+61}
> > [   29.424122]        <ffffffff8046e96e>{_etext+0}
> > [   29.429224]        <ffffffff806b1392>{mem_init+128}
> > [   29.434691]        <ffffffff806a17ab>{start_kernel+377}
> > [   29.440520]        <ffffffff806a129b>{_sinittext+667}
> > [   29.446669] ---------------------------
> > [   29.450963] | preempt count: 00000001 ]
> > [   29.455257] | 1-level deep critical section nesting:
> > [   29.460732] ----------------------------------------
> > [   29.466212] .. [<ffffffff806a169a>] .... start_kernel+0x68/0x221
> > [   29.472815] .....[<ffffffff806a129b>] ..   ( <= _sinittext+0x29b/0x2a2)
> > [   29.480056]
> 
> Perhaps you could put in that in_atomic check at the start of each of
> these functions and point to where it is a problem.  Perhaps a spinlock
> is taken that was real and not a mutex.

Yeah, that's my thought as well. I'm going to do what you suggest now.

bill


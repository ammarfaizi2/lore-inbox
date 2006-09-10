Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWIJQdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWIJQdd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 12:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWIJQdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 12:33:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932299AbWIJQdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 12:33:32 -0400
Date: Sun, 10 Sep 2006 09:33:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Message-Id: <20060910093307.a011b16f.akpm@osdl.org>
In-Reply-To: <20060910132614.GA29423@elte.hu>
References: <20060908011317.6cb0495a.akpm@osdl.org>
	<200609101032.17429.ak@suse.de>
	<20060910115722.GA15356@elte.hu>
	<200609101334.34867.ak@suse.de>
	<20060910132614.GA29423@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Sep 2006 15:26:14 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> * Andi Kleen <ak@suse.de> wrote:
> 
> > > Basically, non-atomic setup of basic architecture state _is_ going to be
> > > a nightmare, lockdep or not, especially if it uses common infrastructure
> > > like 'current', spin_lock() or even something as simple as C functions.
> > > (for example the stack-footprint tracer was once hit by this weakness of
> > > the x86_64 code)
> > 
> > I disagree with that.  The nightmare is putting stuff that needs so 
> > much infrastructure into the most basic operations.
> 
> ugh, "having a working current" is "so much infrastructure" ?? Lockdep 
> uses a very low amount of infrastructure, considering its complexity: it 
> has its own allocator, uses raw spinlocks, raw irq flags ops, it 
> basically implements its own infrastructure for everything. Being able 
> to access a per-task data area (current) is a quite fundamental thing 
> for kernel code.

I must say that having an unreliable early-current is going to be quite a
pita for evermore.  Things like mcount-based tricks and
basic-block-profiling-based tricks, for example.

Is it really going to be too messy to fake up some statically-defined gdt
which points at init_task, install that before we call any C at all?

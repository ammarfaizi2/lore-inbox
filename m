Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVBNWfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVBNWfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVBNWfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:35:25 -0500
Received: from fmr18.intel.com ([134.134.136.17]:57243 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261217AbVBNWfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 17:35:17 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Date: Mon, 14 Feb 2005 14:29:11 -0800
User-Agent: KMail/1.5.4
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200502141240.14355.mgross@linux.intel.com> <1108416249.8413.54.camel@localhost.localdomain>
In-Reply-To: <1108416249.8413.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502141429.11587.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 February 2005 13:24, Steven Rostedt wrote:
> On Mon, 2005-02-14 at 12:40 -0800, Mark Gross wrote:
> > I'm working on a tweak to the preepmtive soft IRQ implementation using
> > work queues and I'm having problems with a BUG assert when trying to
> > queue_work.
> >
> > Souldn't I be able to call queue_work form ISR context?
>
> Yes, but not with interrupts disabled.
>

Hmm.  It seems to me that one should be able to call queue_work from wherever 
you can call raise_softirq.  This constraint adds a bit of asymetry in the 
deffered processing API's


> > --mgross
> >
> > ---------------------------
> >
> > | preempt count: 00000001 ]
> > | 1-level deep critical section nesting:
> >
> > ----------------------------------------
> > .. [<c0140f5d>] .... print_traces+0x1d/0x60
> > .....[<c01042a3>] ..   ( <= dump_stack+0x23/0x30)
> >
> > BUG: sleeping function called from invalid context IRQ 20(2039) at
> > kernel/rt.c in_atomic():0 [00000000], irqs_disabled():1
>
> Here you have interrupts disabled. Since you are tweaking the softirq I
> don't know your code, but the kernel should not schedule after turning
> off interrupts, and the spinlocks under the PREEMPT kernel, may now
> sleep (unless they are raw_spin_locks).  Here we also see that
> queue_work calls spin_lock_irqsave.  I'm suspecting that you turned off
> interrupts somewhere.
>
> -- Steve

I'll post my code soon, I hope.  I now need to work around this API problem :(

thanks, 

--mgross


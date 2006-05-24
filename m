Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932726AbWEXPwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbWEXPwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbWEXPwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 11:52:40 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:16601 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932726AbWEXPwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 11:52:39 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven-Thorsten Dietrich <sven@mvista.com>
Cc: tglx@linutronix.de, Yann.LEPROVOST@wavecom.fr,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1148484729.14683.5.camel@localhost.localdomain>
References: <OFD8B7556E.13DD6F3A-ONC1257178.002C2D9A-C1257178.002D1FC5@wavecom.fr>
	 <1148475334.24623.45.camel@localhost.localdomain>
	 <1148476383.5239.54.camel@localhost.localdomain>
	 <1148484729.14683.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 May 2006 11:52:23 -0400
Message-Id: <1148485943.24623.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 08:32 -0700, Sven-Thorsten Dietrich wrote:
> On Wed, 2006-05-24 at 15:13 +0200, Thomas Gleixner wrote:
> > On Wed, 2006-05-24 at 08:55 -0400, Steven Rostedt wrote:
> > > Thomas or Ingo,
> > > 
> > > Maybe the handling of IRQs needs to handle the case that shared irq can
> > > have both a NODELAY and a thread.  The irq descriptor could have a
> > > NODELAY set if any of the actions are NODELAY, but before calling the
> > > interrupt handler (in interrupt context), check if the action is NODELAY
> > > or not, and if not, wake up the thread if not done so already.
> > 
> > As I said yesterday. You need a demultiplexer for such cases.
> > 
> 
> Would IRQs stay masked until the thread has finished running?

I would say yes.  But the system is basically broken if you have the
same interrupt line that needs both to be threaded and NODELAY.

Basically, the best I can think to have for such a case, is all
interrupt threads that have a shared NODELAY run at MAX_PRIO (99).  So
that they act like a NODELAY interrupt, in that they run over everything
else, but they can still schedule.

-- Steve



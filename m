Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262225AbSJFWSG>; Sun, 6 Oct 2002 18:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262226AbSJFWSG>; Sun, 6 Oct 2002 18:18:06 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:21516
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262225AbSJFWSF>; Sun, 6 Oct 2002 18:18:05 -0400
Subject: Re: 2.5.40-mm2
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Ingo Molnar <mingo@redhat.com>
In-Reply-To: <3DA0B422.C23B23D4@digeo.com>
References: <3DA0854E.CF9080D7@digeo.com> <3DA0A144.8070301@us.ibm.com>
	<3DA0B151.6EF8C8D9@digeo.com>  <3DA0B422.C23B23D4@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 18:23:40 -0400
Message-Id: <1033943021.27093.29.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 18:07, Andrew Morton wrote:

> > -                       while (base->running_timer == timer) {
> > +                       while (base->running_timer == timer)
> >                                 cpu_relax();
> > -                               preempt_disable();
> > -                               preempt_enable();

I am confused as to why Ingo would put these here.  He knows very well
what he is doing... surely he had a reason.

If he intended to force a preemption point here, then the lines needs to
be reversed.  This assumes, of course, preemption is disabled here.  But
I do not think it is.

If he just wanted to check for preemption, we have a
preempt_check_resched() which does just that (I even think he wrote
it).  Note as long as interrupts are enabled this probably does not
achieve much anyhow.

So I do not know.  I find it odd the solution is to completely remove
it...

Btw, I think the solution to the crash is to add a check to
cpu_online().

	Robert Love


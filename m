Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWELJQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWELJQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 05:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWELJQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 05:16:17 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50639 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751095AbWELJQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 05:16:17 -0400
Date: Fri, 12 May 2006 11:16:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Hounschell <markh@compro.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt20 patch question
Message-ID: <20060512091602.GB18145@elte.hu>
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com> <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> On Fri, 12 May 2006, Ingo Molnar wrote:
> 
> >
> > > So I guess we have a case that we can schedule, but while atomic and
> > > BUG when it's really not bad.  Should we add something like this:
> >
> > that's not good enough, we must not schedule with the preempt_count()
> > set.
> 
> It gets even worse, with your new fix, the softirq will schedule with 
> interrutps disabled, which would definitely BUG.

i dont think so. Calling __do_softirq() with hardirqs disabled is not a 
problem, it does an explicit local_irq_enable().

	Ingo

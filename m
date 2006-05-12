Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWELIpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWELIpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 04:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWELIpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 04:45:41 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:40163 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751089AbWELIpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 04:45:40 -0400
Date: Fri, 12 May 2006 04:45:24 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Mark Hounschell <markh@compro.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt20 patch question
In-Reply-To: <20060512081628.GA26736@elte.hu>
Message-ID: <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
 <20060512081628.GA26736@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, Ingo Molnar wrote:

>
> > So I guess we have a case that we can schedule, but while atomic and
> > BUG when it's really not bad.  Should we add something like this:
>
> that's not good enough, we must not schedule with the preempt_count()
> set.

It gets even worse, with your new fix, the softirq will schedule with
interrutps disabled, which would definitely BUG.

>
> one solution would be to forbid disable_irq() from softirq contexts, and
> to convert the vortex timeout function to a workqueue and use the
> *_delayed_work() APIs to drive it - and cross fingers there's not many
> places to fix.

I prefer the above. Maybe even add a WARN_ON(in_softirq()) in disable_irq.

But I must admit, I wouldn't know how to make that change without spending
more time on it then I have for this.

>
> another solution would be to make softirqs preemptible if they are
> threaded. I'm a bit uneasy about that though. In that case we'd also
> have to make HARDIRQ threading dependent on softirq threading, in the
> Kconfig.

scary.

-- Steve


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVASRXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVASRXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVASRV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:21:56 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:57581 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261785AbVASRTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:19:46 -0500
Date: Wed, 19 Jan 2005 09:17:31 -0800
From: Tony Lindgren <tony@atomide.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119171731.GC14545@atomide.com>
References: <20050119000556.GB14749@atomide.com> <1106108467.4500.169.camel@gaston> <20050119050701.GA19542@atomide.com> <1106112525.4534.175.camel@gaston> <20050119141115.GI10437@ns.snowman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119141115.GI10437@ns.snowman.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Frost <sfrost@snowman.net> [050119 06:11]:
> * Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> > Hrm... reading more of the patch & Martin's previous work, I'm not sure
> > I like the idea too much in the end... The main problem is that you are
> > just "replaying" the ticks afterward, which I see as a problem for
> > things like sched_clock() which returns the real current time, no ?
> > 
> > I'll toy a bit with my own implementation directly using Martin's work
> > and see what kind of improvement I really get on ppc laptops.
> 
> I don't know if this is the same thing, or the same issue, but I've
> noticed on my Windows machines that the longer my laptop sleeps the
> longer it takes for it to wake back up- my guess is that it's doing
> exactly this (replaying ticks).  It *really* sucks though because it can
> take quite a while for it to come back if it's been asleep for a while.

That sounds like suspend related thing, while this is an idle loop
issue. On my machine with PIT timer doing the interrupts, the skip is
only 54 ticks, so catching up is very fast :) But if the machine was
able to idle for seconds at time inbetween ticks, it would be noticable.

Regards,

Tony


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVANCY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVANCY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVANCY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:24:29 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:34984 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261751AbVANCYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:24:22 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: utz lehmann <lkml@s2y4n2c.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjanv@redhat.com>,
       "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       LKML <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1105668319.15692.16.camel@segv.aura.of.mankind>
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	 <200501112251.j0BMp9iZ006964@localhost.localdomain>
	 <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us>
	 <20050112074906.GB5735@devserv.devel.redhat.com>
	 <87oefuma3c.fsf@sulphur.joq.us>
	 <20050113072802.GB13195@devserv.devel.redhat.com>
	 <878y6x9h2d.fsf@sulphur.joq.us>
	 <20050113210750.GA22208@devserv.devel.redhat.com>
	 <1105651508.3457.31.camel@krustophenia.net>
	 <1105668319.15692.16.camel@segv.aura.of.mankind>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 13:24:11 +1100
Message-Id: <1105669451.5402.38.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 03:05 +0100, utz lehmann wrote:
> On Thu, 2005-01-13 at 16:25 -0500, Lee Revell wrote:

> > This all seems to imply that introducing an rlimit for MAX_RT_PRIO is an
> > excellent solution.  The RT watchdog thread could run as root, and the
> > rlimit would be used to ensure than even nonroot users in the RT group
> > could never preempt the watchdog thread.
> 
> Just an idea. What about throttling runaway RT tasks?
> If the system spend more than 98% in RT tasks for 5s consider this as a
> _fatal error_. Print an error message and throttle RT tasks by inserting
> ticks where only SCHED_OTHER tasks allowed. For a limit of 98% this
> means one SCHED_OTHER only tick all 50 ticks.
> 
> The limit and timeout should be configurable and of course it can be
> disabled.
> 

This is just a hack. Realtime scheduling is pretty rigidly specified,
and we satisfy that. Thus it is useful for systems that need to make
use of it. The way SCHED_FIFO and SCHED_RR scheduling is specified is
inherently insecure/incompatible with a multi user machine; I don't
understand why people are getting heated with this debate. You literally
can't run more than one realtime system on the same CPU(s) if they don't
have a knowledge of one another.

SCHED_FIFO and SCHED_RR are definitely privileged operations and you
can't really change them without making them useless to legitimate
users, I think.




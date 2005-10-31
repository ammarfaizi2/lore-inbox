Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVJaVu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVJaVu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVJaVu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:50:28 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:17859 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932544AbVJaVu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:50:27 -0500
Date: Mon, 31 Oct 2005 22:50:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       tytso@us.ibm.com, sripathi@in.ibm.com, dipankar@in.ibm.com,
       oleg@tv-sign.ru
Subject: Re: [RFC,PATCH] RCUify single-thread case of clock_gettime()
Message-ID: <20051031215044.GA20926@elte.hu>
References: <20051031174416.GA2762@us.ibm.com> <Pine.LNX.4.61.0510311802550.9631@goblin.wat.veritas.com> <20051031195425.GA14806@elte.hu> <Pine.LNX.4.61.0510312004460.10705@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510312004460.10705@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hugh Dickins <hugh@veritas.com> wrote:

> On Mon, 31 Oct 2005, Ingo Molnar wrote:
> > * Hugh Dickins <hugh@veritas.com> wrote:
> > > 
> > > Not my area at all, but this looks really dodgy to me, Paul:
> > > could you explain it further?
> > 
> > the patch below (included in the -rt tree) is the prerequisite. That's 
> > what Paul's "requires RCU on task_struct" comment refers to.
> 
> Thanks, Ingo: Sorry, Paul: I missed that it was an -rt patch: Ignore 
> me.

btw., since the RCU-task-struct thing is beneficial to upstream SMP 
kernels (even without any preempt option enabled), it should be 
considered for upstream too. The tasklist_lock is one of our last 
remaining monolithic and globally-bouncing locks. The patch i attached 
to the previous mail is against the upstream kernel and implements the 
RCU-task-struct logic, without any PREEMPT_RT dependency. (the -rt tree 
is a collection of various preemption related patches, not just 
PREEMPT_RT)

	Ingo

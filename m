Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267610AbUHEMTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267610AbUHEMTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267657AbUHEMTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:19:25 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:54469 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267610AbUHEMTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:19:23 -0400
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
From: Albert Cahalan <albert@users.sf.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>,
       nickpiggin@yahoo.com.au
In-Reply-To: <20040805065708.GA10124@elte.hu>
References: <1091638227.1232.1750.camel@cube>
	 <20040805065708.GA10124@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1091699297.1232.1809.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Aug 2004 05:48:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 02:57, Ingo Molnar wrote:
> * Albert Cahalan <albert@users.sf.net> wrote:
> 
> > Are these going to be numbered consecutively, or might they better be
> > done like the task state? [...]
> 
> this is quite unnecessary at the moment since p->prio < MAX_RT_PRIO is a
> good enough check - but whenever the way p->prio works is changed it
> will be easy to introduce a PF_REALTIME flag that is set/cleared in
> setscheduler(). (instead of playing around with p->policy.)

That was one example. I'm guessing that one might want to
test for other policy groupings, like these:

SCHED_RR | SCHED_ISO
SCHED_BATCH | SCHED_NORMAL
SCHED_SPORADIC | SCHED_NORMAL
SCHED_EDF | SCHED_FIFO

If that's certainly not going to be useful, even in the future,
then of course there's no reason to allocate the values as bits.

In any case, it's a user ABI issue, and I'd like to see what
the allocations are going to be. Perhaps I should send in a
patch that just allocates a few of these...?



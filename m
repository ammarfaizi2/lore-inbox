Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTHSUlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTHSTPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:15:50 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51217 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261263AbTHSTKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:10:12 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
Date: 19 Aug 2003 19:01:58 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bhts76$8bm$1@gatekeeper.tmr.com>
References: <1061261666.2094.15.camel@orbiter> <3F419449.4070104@cyberone.com.au> <1061266033.2900.43.camel@orbiter> <3F41B43D.6000706@cyberone.com.au>
X-Trace: gatekeeper.tmr.com 1061319718 8566 192.168.12.62 (19 Aug 2003 19:01:58 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F41B43D.6000706@cyberone.com.au>,
Nick Piggin  <piggin@cyberone.com.au> wrote:
| Eric St-Laurent wrote:

| >
| >Anyway i always tought linux default timeslice of 100 ms is way too long
| >for desktop uses. Starting with this in mind, i think that a 10 ms
| >timeslice should bring back good interactive feel, and by using longer
| >timeslices for (lower prio) cpu-bound processes, we can save some costly
| >context switches.
| >
| 
| I agree completely.
| 
| >
| >Unfortunatly i'm unable to test those ideas right now but i share them,
| >maybe it can help other's work.
| >
| >- (previously mentionned) higher prio tasks should use small timeslices
| >and lower prio tasks, longer ones. i think, maybe falsely, that this can
| >lower context switch rate for cpu-bound tasks. by using up to 200 ms
| >slices instead of 10 ms...
| >
| >- (previously mentionned) use dynamic priority to calculate timeslice
| >length.
| >
| >- maybe adjust the max timeslice length depending on how many tasks are
| >running/ready.
| >
| 
| I agree with your previous two points. Not this one. I think it is very
| easy to get bad feedback loops and difficult to ensure it doesn't break
| down under load when doing stuff like this. I might be wrong though.

I have to agree with Eric that sizing the max timeslices to fit the
hardware seems like a reasonable thing to do. I have little salvaged
systems running (well strolling would be more accurate) Linux on old
Pentium Classic 90-166MHz machines. I also have 3+ GHz SMP machines. I
have a gut feeling that the timeslices need to be longer on the slow
machines to allow them to get something done, that the SMP machines
will perform best with a different timeslice than UP of the same speed,
etc.

I think you also want a user tunable for throughput vs. interactive, so
you know what you're trying to do best.

Perhaps some counting of wait time between dispatches would be useful,
and drop the timeslices to keep that limited. Sort of a "deadline CPU
scheduler" with limiting bounds. That might at least give some hope of
compensating for CPU speed changes after boot.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263346AbUDBHhC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 02:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbUDBHhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 02:37:02 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3830 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263346AbUDBHg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 02:36:58 -0500
Message-Id: <200404020735.i327Zk604510@owlet.beaverton.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ingo Molnar <mingo@redhat.com>, John Hawkes <hawkes@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler balancing statistics 
In-reply-to: Your message of "Fri, 02 Apr 2004 17:18:44 +1000."
             <406D13D4.8040607@yahoo.com.au> 
Date: Thu, 01 Apr 2004 23:35:46 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The important thing, as always, is that collecting the stats not impact
the action being taken.  If you stick with incrementing counters and
not taking additional locks, then you've probably done what you can to
minimize any impact.

>From an analysis standpoint it would be nice to know which of the major
features are being activated for a particular load.  So imbalance-driven
moves, power-driven moves, and the number of times each domain tried
to balance and failed would all be useful.  I think your output covered
those.

Another useful stat might be how many times the self-adjusting fields
(min, max) adjusted themselves.  That might yield some insights on
whether that's working well (or correctly).

When I started thinking about these stats, I started thinking about how to
identify the domains.  "domain0" and "domain1" do uniquely identify some
data structures, but especially as they get hierarchical, can we easily
tie them to the cpus they manage?  Perhaps the stats should include a
bitmap of what cpus are covered by the domain too.

Looks very useful for those times when some workload causes the scheduler
to burp -- between scheduler stats and domain stats we may find it much
easier to track down issues.

Would you say these would be in addition to the schedstats or would
these replace them?

Rick

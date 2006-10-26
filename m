Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423647AbWJZSSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423647AbWJZSSG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423649AbWJZSSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 14:18:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41433 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423647AbWJZSSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 14:18:03 -0400
Date: Thu, 26 Oct 2006 11:17:08 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH 3/5] Use next_balance instead of last_balance
In-Reply-To: <4540ECCD.7050700@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610261113180.18037@schroedinger.engr.sgi.com>
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
 <20061024183119.4530.64973.sendpatchset@schroedinger.engr.sgi.com>
 <4540A676.1070802@yahoo.com.au> <4540AACE.3010804@yahoo.com.au>
 <Pine.LNX.4.64.0610260924440.16978@schroedinger.engr.sgi.com>
 <4540ECCD.7050700@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, Nick Piggin wrote:

> > Hmmmm... We change the point at which we calculate the interval relative to
> > load balancing. So move it after the load balance. This also avoids having
> > to do the calculation if the sched_domain has not expired.
> 
> That still doesn't take into account if the CPU goes idle/busy during
> the interval.

How does the current version take that into account? As far as I can tell 
we take the busy / idle stuation at the point in time when 
rebalance_tick() is called. We do not track whever the cpu gues idle/busy 
in the interval.

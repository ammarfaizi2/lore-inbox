Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423601AbWJZQZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423601AbWJZQZE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161421AbWJZQZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:25:03 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10191 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161431AbWJZQZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:25:00 -0400
Date: Thu, 26 Oct 2006 09:24:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH 5/5] Only call rebalance_domains when needed from
 scheduler_tick
In-Reply-To: <4540A986.2070200@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610260922400.16978@schroedinger.engr.sgi.com>
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
 <20061024183130.4530.83162.sendpatchset@schroedinger.engr.sgi.com>
 <4540A986.2070200@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006, Nick Piggin wrote:

> > Call rebalance_domains from a tasklet with interrupt enabled.
> > Only call it when one of the sched domains is to be rebalanced.
> > The jiffies when the next balancing action is to take place is
> > kept in a per cpu variable next_balance.
> 
> sched-domains was supposed to be able to build a whacky topology
> so you didn't have to take the occasional big latency hit when
> scanning 512 CPUs...

How is that supposed to work? The load calculations will be off
in that case and also the load balancing algorithm wont work anymore. 
This is going to be a pretty significant rework of how the scheduler 
works but given the problems with pinned tasks... maybe that is 
necessary?
duler?


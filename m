Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423493AbWJZSOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423493AbWJZSOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 14:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423610AbWJZSOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 14:14:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38355 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1423493AbWJZSOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 14:14:36 -0400
Date: Thu, 26 Oct 2006 11:13:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH 5/5] Only call rebalance_domains when needed from
 scheduler_tick
In-Reply-To: <4540EC84.8070302@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610261110030.18037@schroedinger.engr.sgi.com>
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
 <20061024183130.4530.83162.sendpatchset@schroedinger.engr.sgi.com>
 <4540A986.2070200@yahoo.com.au> <Pine.LNX.4.64.0610260922400.16978@schroedinger.engr.sgi.com>
 <4540EC84.8070302@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, Nick Piggin wrote:

> > > sched-domains was supposed to be able to build a whacky topology
> > > so you didn't have to take the occasional big latency hit when
> > > scanning 512 CPUs...
> > 
> > 
> > How is that supposed to work? The load calculations will be off
> > in that case and also the load balancing algorithm wont work anymore. This
> > is going to be a pretty significant rework of how the scheduler works but
> > given the problems with pinned tasks... maybe that is necessary?
> > duler?
> 
> What will the problem be? Sure it may pull tasks fom one group to
> another when both could actually be pulling from a third, but it
> the load balancing algorithm should work fine and not require any
> rework.

Hmmm....
I think we already have what you want if we would disable the allnodes 
domain. The next sched domain layer contains 16 surrounding nodes 
from which it can pull processes. If there would be severe overload on one 
node  then processes would be gradually migrated away from it but it would 
require multiple migration steps.

Nevertheless, I still think we need this patchset because of the general 
interrupt hold off issue. The livelock is extreme case but it general we 
do no want long interrupt holdoffs but keep the period in which we would 
be executing with interrupts off minimal.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUCSAFk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUCSAFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:05:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:15831 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263365AbUCSACi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:02:38 -0500
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com
In-Reply-To: <8090000.1079652747@flay>
References: <1079651064.8149.158.camel@arrakis>
	 <200403181523.10670.jbarnes@sgi.com>  <8090000.1079652747@flay>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1079654513.8149.249.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 16:01:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 15:32, Martin J. Bligh wrote:
> > On Thursday 18 March 2004 3:04 pm, Matthew Dobson wrote:
> >> do most anything you'd want to do with a nodemask.  This stops us from
> >> open-coding nodemask operations, allows non-consecutive node numbering
> >> (ie: nodes don't have to be numbered 0...numnodes-1), gets rid of
> >> numnodes entirely (replaced with num_online_nodes()), and will
> >> facilitate the hotplugging of whole nodes.
> > 
> > My hero! :)  I think this has been needed for awhile, but now that I
> > think about it, it begs the question of what a node is.  Is it a set
> > of CPUs and blocks of memory (that seems to be the most commonly used
> > definition in the code), just memory, just CPUs, or what?  On sn2
> > hardware, we have the concept of a node without CPUs.  And due to our
> > wacky I/O layout, we also have nodes without CPUs *or* memory!  (The
> > I/O guys call these "ionodes".)  And then of course, there are CPUs
> > that aren't particularly close to any memory (i.e. they have none of
> > their own, and have to go several hops and/or through other CPUs to
> > get at memory at all).
> 
> I think the closest answer we have is that it's a grouping of cpus and
> memory, where either may be NULL. 
> 
> I/O isn't directly associated with a node, though it should fit into the 
> topo infrastructure, to give distances from io buses to nodes (for which 
> I think we currently use cpumasks, which is probably wrong in retrospect, 
> but then life is tough and flawed ;-))
> 
> M.

Yeah... We used cpumasks because that seemed like a good idea at the
time.  Nodemasks may be a better choice now...  We can write a quicky
inline function nodemask_to_cpumask() as well, to keep the current users
happy.

-Matt


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbUCSABl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbUCSABT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:01:19 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45447 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263334AbUCRX7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:59:15 -0500
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
In-Reply-To: <200403181523.10670.jbarnes@sgi.com>
References: <1079651064.8149.158.camel@arrakis>
	 <200403181523.10670.jbarnes@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1079654311.8149.240.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 15:58:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 15:23, Jesse Barnes wrote:
> On Thursday 18 March 2004 3:04 pm, Matthew Dobson wrote:
> > do most anything you'd want to do with a nodemask.  This stops us from
> > open-coding nodemask operations, allows non-consecutive node numbering
> > (ie: nodes don't have to be numbered 0...numnodes-1), gets rid of
> > numnodes entirely (replaced with num_online_nodes()), and will
> > facilitate the hotplugging of whole nodes.
> 
> My hero! :)  I think this has been needed for awhile, but now that I

Anything for a damsel in distress! ;)

> think about it, it begs the question of what a node is.  Is it a set
> of CPUs and blocks of memory (that seems to be the most commonly used
> definition in the code), just memory, just CPUs, or what?

There have been arguments about exactly what a node is since there has
been a concept of a node at all.  In the kernel, it isn't defined.  A
node doesn't *have* to have CPUs on it (see nr_cpus_node()), doesn't
*have* to have memory, doesn't *have* to have I/O.  It's supposed to be
just a container for those 3 things, but the containers can be empty. 
This code doesn't get into what a node is, just makes sure they're used
properly... ;)

> On sn2
> hardware, we have the concept of a node without CPUs.  And due to our
> wacky I/O layout, we also have nodes without CPUs *or* memory!  (The
> I/O guys call these "ionodes".)

Yep...  I saw both numnodes and numionodes perusing the ia64 code.  You
should be able to put these CPU/memless nodes in the node_online_map
now...  If there's code that's assuming a node contains either CPUs or
memory, I'd like to find it! :)

> And then of course, there are CPUs
> that aren't particularly close to any memory (i.e. they have none of
> their own, and have to go several hops and/or through other CPUs to
> get at memory at all).

node_distance(from, to)

> I'll take a look at the ia64 bits when I get them (I've only received
> two of the seven patches thus far).
> 
> Jesse

Super.  I'd really like feedback on the ia64 code (well, actually all
the non-i386 code).  I did what I thought was right, but eyes more
familiar with the code are extremely welcome.

Cheers!

-Matt


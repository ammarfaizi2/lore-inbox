Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbUCSAWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbUCRXxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:53:48 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:37840 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263332AbUCRXdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:33:14 -0500
Date: Thu, 18 Mar 2004 15:32:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com
cc: akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <8090000.1079652747@flay>
In-Reply-To: <200403181523.10670.jbarnes@sgi.com>
References: <1079651064.8149.158.camel@arrakis> <200403181523.10670.jbarnes@sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday 18 March 2004 3:04 pm, Matthew Dobson wrote:
>> do most anything you'd want to do with a nodemask.  This stops us from
>> open-coding nodemask operations, allows non-consecutive node numbering
>> (ie: nodes don't have to be numbered 0...numnodes-1), gets rid of
>> numnodes entirely (replaced with num_online_nodes()), and will
>> facilitate the hotplugging of whole nodes.
> 
> My hero! :)  I think this has been needed for awhile, but now that I
> think about it, it begs the question of what a node is.  Is it a set
> of CPUs and blocks of memory (that seems to be the most commonly used
> definition in the code), just memory, just CPUs, or what?  On sn2
> hardware, we have the concept of a node without CPUs.  And due to our
> wacky I/O layout, we also have nodes without CPUs *or* memory!  (The
> I/O guys call these "ionodes".)  And then of course, there are CPUs
> that aren't particularly close to any memory (i.e. they have none of
> their own, and have to go several hops and/or through other CPUs to
> get at memory at all).

I think the closest answer we have is that it's a grouping of cpus and
memory, where either may be NULL. 

I/O isn't directly associated with a node, though it should fit into the 
topo infrastructure, to give distances from io buses to nodes (for which 
I think we currently use cpumasks, which is probably wrong in retrospect, 
but then life is tough and flawed ;-))

M.


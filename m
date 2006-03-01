Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWCAWUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWCAWUU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWCAWUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:20:19 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4584 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750761AbWCAWUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:20:18 -0500
Date: Wed, 1 Mar 2006 14:20:01 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
In-Reply-To: <200603012221.37271.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0603011411190.31997@schroedinger.engr.sgi.com>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
 <200603012159.42273.ak@suse.de> <20060301131910.beb949be.pj@sgi.com>
 <200603012221.37271.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2006, Andi Kleen wrote:

> I think it's the best default for smaller systems too. I've had people
> complaining about node inbalances that were caused by one or two
> being filled up with d/icache. And the small latencies of accessing
> them don't matter very much.

But these are special situations. Placing memory on a distance node
is not beneficial in the standard case of a single threaded process 
churning along opening and closing files etc.

Interleave is only beneficial for special applications that use a common 
pool of data and that implement no other means of locality control. At 
that point we sacrifice the performance benefit that comes with node locality
in order not to overload a single node. 

Kernels before 2.6.16 suffer from special overload situations that are due 
to not having the ability to reclaim the pagecache and the slab cache. 
This is going to change in SLES10.

> > If you think it would be better to change this default, now that the
> > mechanism is in place to do support spreading these slabs, then I could
> > certainly go along with that.
> 
> Yes that would make me happy.

It seems that we are trying to sacrifice the performance of many in 
order to accomodate a few special situations. Cpusets are ideal for those 
situations since they allow the localization of the interleaving to a 
slice of the machine. Processes on the rest of the box can still get node 
local memory and run at optimal performance.
  
> I would be in favour of it

Please run performance tests with single threaded processes if you 
do not believe me before doing any of this.

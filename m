Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWBFSnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWBFSnm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWBFSnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:43:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:2276 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932279AbWBFSnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:43:41 -0500
Date: Mon, 6 Feb 2006 10:43:25 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, mingo@elte.hu, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <200602061936.27322.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602061039420.16829@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com>
 <200602061936.27322.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andi Kleen wrote:

> > AFAIK you can reach these low latency factors only if multiple nodes are 
> > on the same motherboard. Likely Opteron specific?
> 
> Should be true for most CPUs with integrated memory controller.

Even the best memory controller cannot violate the laws of physics 
(electrons can at maximum travel with the speed of light). Therefore
cable lengths have a major influence on the latency of signals.

> > I dont understand you here. What would be the benefit of selecting more 
> > distant memory over local? I can only imagine that this would be 
> > beneficial if we know that the data would be used later by other 
> > processes.
> 
> The benefit would be to not fill up the local node as quickly when
> you do something IO (or dcache intensive).  And on contrary when you
> do something local memory intensive on that node then you won't need
> to throw away all the IO caches if they are already spread out.

An efficient local reclaim should deal with that situation. zone_reclaim 
will free up portions of memory in order to stay on node.

> The kernel uses of these cached objects are not really _that_ latency 
> sensitive and not that frequent so it makes sense to spread it out a 
> bit to nearby nodes.

The impact of spreading cached object will depend on the application and 
the NUMA latencies in the system.

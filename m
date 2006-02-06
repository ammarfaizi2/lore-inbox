Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWBFSgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWBFSgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWBFSgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:36:54 -0500
Received: from mx1.suse.de ([195.135.220.2]:64193 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932251AbWBFSgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:36:53 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Mon, 6 Feb 2006 19:36:26 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, mingo@elte.hu, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061936.27322.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 19:21, Christoph Lameter wrote:
> On Mon, 6 Feb 2006, Andi Kleen wrote:
> 
> > I still don't quite agree. As long as the latency penalty of going
> > off node is not too bad (let's say < factor 2) i think it's better
> > to spread out the caches than to always locate them locally.
> 
> AFAIK you can reach these low latency factors only if multiple nodes are 
> on the same motherboard. Likely Opteron specific?

Should be true for most CPUs with integrated memory controller.

Anyways, the 2 was just an example, true number would probably
need to be found with benchmarks.

> 
> > If you have a much worse worst case NUMA factor it might be different,
> > but even there it would be a good idea to at least spread it out
> > to nearby nodes.
> 
> I dont understand you here. What would be the benefit of selecting more 
> distant memory over local? I can only imagine that this would be 
> beneficial if we know that the data would be used later by other 
> processes.

The benefit would be to not fill up the local node as quickly when
you do something IO (or dcache intensive).  And on contrary when you
do something local memory intensive on that node then you won't need
to throw away all the IO caches if they are already spread out.

The kernel uses of these cached objects are not really _that_ latency 
sensitive and not that frequent so it makes sense to spread it out a 
bit to nearby nodes.

-Andi

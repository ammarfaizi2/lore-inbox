Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWITRHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWITRHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWITRHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:07:37 -0400
Received: from ns.suse.de ([195.135.220.2]:31704 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751887AbWITRHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:07:36 -0400
Date: Wed, 20 Sep 2006 19:07:35 +0200
From: Nick Piggin <npiggin@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Rohit Seth <rohitseth@google.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       pj@sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
Message-ID: <20060920170735.GB22913@wotan.suse.de>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com> <20060920164404.GA22913@wotan.suse.de> <Pine.LNX.4.64.0609200944420.30793@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609200944420.30793@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 09:48:13AM -0700, Christoph Lameter wrote:
> On Wed, 20 Sep 2006, Nick Piggin wrote:
> 
> > > Right thats what cpusets do and it has been working fine for years. Maybe 
> > > Paul can help you if you find anything missing in the existing means to 
> > > control resources.
> > 
> > What I like about Rohit's patches is the page tracking stuff which 
> > seems quite simple but capable.
> > 
> > I suspect cpusets don't quite provide enough features for non-exclusive 
> > use of memory (eg. page tracking for directed reclaim).
> 
> Look at the VM statistics please. We have detailed page statistics per 
> zone these days. If there is anything missing then this would best be put 
> into general functionality. When I looked at it, I saw page statistics 
> that were replicating things that we already track per zone. All these 
> would become available if a container is realized via a node and we would 
> be using proven VM code.

Look at what the patches do. These are not only for hard partitioning
of memory per container but also those that share memory (eg. you might
want each to share 100MB of memory, up to a max of 80MB for an individual
container).

The nodes+cpusets stuff doesn't seem to help with that because you
with that because you fundamentally need to track pages on a per
container basis otherwise you don't know who's got what.

Now if, in practice, it turns out that nobody really needed these
features then of course I would prefer the cpuset+nodes approach. My
point is that I am not in a position to know who wants what, so I
hope people will come out and discuss some of these issues.

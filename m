Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbWBVCfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWBVCfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWBVCfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:35:19 -0500
Received: from ns1.siteground.net ([207.218.208.2]:27267 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750725AbWBVCfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:35:18 -0500
Date: Tue, 21 Feb 2006 18:35:48 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
Message-ID: <20060222023548.GB3635@localhost.localdomain>
References: <20060220233242.GC3594@localhost.localdomain> <43FA8938.70006@yahoo.com.au> <Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com> <43FBB2E8.2020300@yahoo.com.au> <20060221180845.79a44449.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221180845.79a44449.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 06:08:45PM -0800, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > Christoph Lameter wrote:
> > > On Tue, 21 Feb 2006, Nick Piggin wrote:
> > > 
> > > 
> > >>Ravikiran G Thirumalai wrote:
> > >>
> > >>>Following change places each element of the futex_queues hashtable on a
> > >>>different cacheline.  Spinlocks of adjacent hash buckets lie on the same
> > >>>cacheline otherwise.
> > >>>
> > >>
> > >>It does not make sense to add swaths of unused memory into a hashtable for
> > >>this purpose, does it?
> > > 
> > > 
> > > It does if you essentially have a 4k cacheline (because you are doing NUMA 
> > > in software with multiple PCs....) and transferring control of that 
> > > cacheline is comparatively expensive.
> > > 
> > 
> > Instead of 1MB hash with 256 entries in it covering 256 cachelines, you
> > have a 1MB hash with 65536(ish) entries covering 256 cachelines.
> > 
> 
> Good (if accidental point).  Kiran, if you're going to gobble a megabyte,
> you might as well use all of it and make the hashtable larger, rather than
> just leaving 99% of that memory unused...

Yes, good (intentional :) ) point. I am rerunning my tests with a larger hash slot.
(As large as the padding takes away).  If we get the same or better results, we 
can just increase the hash slots.

Thanks,
Kiran

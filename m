Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWBVUQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWBVUQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWBVUQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:16:45 -0500
Received: from ns1.siteground.net ([207.218.208.2]:65423 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751419AbWBVUQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:16:44 -0500
Date: Wed, 22 Feb 2006 12:17:13 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
Message-ID: <20060222201713.GA3663@localhost.localdomain>
References: <20060220233242.GC3594@localhost.localdomain> <43FA8938.70006@yahoo.com.au> <Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com> <43FBB2E8.2020300@yahoo.com.au> <20060221180845.79a44449.akpm@osdl.org> <43FBCE56.9020001@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FBCE56.9020001@yahoo.com.au>
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

On Wed, Feb 22, 2006 at 01:37:10PM +1100, Nick Piggin wrote:
> Andrew Morton wrote:
> >Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> >>Instead of 1MB hash with 256 entries in it covering 256 cachelines, you
> >>have a 1MB hash with 65536(ish) entries covering 256 cachelines.
> >>
> >
> >
> >Good (if accidental point).  Kiran, if you're going to gobble a megabyte,
> >you might as well use all of it and make the hashtable larger, rather than
> >just leaving 99% of that memory unused...
> >
> 
> We chould probably also convert the list_head over to an hlist_head,
> for a modest saving in size (although that's more important from a
> cache footprint POV rather than improving cacheline bouncing).
> 
> Although speaking of cacheline footprint: making the hash table so
> large will increase the "real" CPU cacheline footprint on your VSMP
> systems, so perhaps it is not always such an easy decision.

We re-ran the threaded benchmark with FUTEX_HASHBITS set to 15 (32k hash
slots) and got the same performance as the padding approach.  So increasing
the hash helps.  We also tried 256, 512, and 1024 hash slots, but we
did not get good results with those. 
We also collected hash collision statistics for 1024 slots.  We found that
50% of the slots did not take any hit!!  So maybe we should revisit the
hashing function before settling on the optimal number of hash slots. 

Thanks,
Kiran

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161264AbWBUBiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbWBUBiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 20:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161267AbWBUBiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 20:38:51 -0500
Received: from ns1.siteground.net ([207.218.208.2]:36744 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1161264AbWBUBiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 20:38:50 -0500
Date: Mon, 20 Feb 2006 17:39:15 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
Message-ID: <20060221013915.GF3594@localhost.localdomain>
References: <20060220233242.GC3594@localhost.localdomain> <20060220153320.793b6a7d.akpm@osdl.org> <20060220153419.5ea8dd89.akpm@osdl.org> <20060221000924.GD3594@localhost.localdomain> <20060220162317.5c7b9778.akpm@osdl.org> <20060221010430.GE3594@localhost.localdomain> <20060220170940.1496e1d5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220170940.1496e1d5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 05:09:40PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > 
> > Yes, only on vSMPowered systems.  Well, we have a large 
> > internode cacheline, but these machines have lots of memory too.  I 
> > thought a  simpler padding solution might be acceptable as futex_queues 
> > would be large only on our boxes.
> 
> Well it's your architecture...  As long as you're finding this to be a
> sufficiently large problem in testing to justify consuming a meg of memory
> then fine, let's do it.
> 
> But your initial changelog was rather benchmark-free?  It's always nice to
> see numbers accompanying a purported optimisation patch.

We saw 30% better elapsed time with a threaded benchmark on our systems, with 
this patch.  That said, we would like to avoid this bloat on our systems too, 
and some work needs to be done to improve futex hashing on NUMA.  But for now, 
this patch should be good enough.

Thanks,
Kiran

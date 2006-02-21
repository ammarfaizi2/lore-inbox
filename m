Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161215AbWBUAIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbWBUAIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161214AbWBUAIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:08:53 -0500
Received: from ns1.siteground.net ([207.218.208.2]:36039 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1161215AbWBUAIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:08:52 -0500
Date: Mon, 20 Feb 2006 16:09:24 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
Message-ID: <20060221000924.GD3594@localhost.localdomain>
References: <20060220233242.GC3594@localhost.localdomain> <20060220153320.793b6a7d.akpm@osdl.org> <20060220153419.5ea8dd89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220153419.5ea8dd89.akpm@osdl.org>
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

On Mon, Feb 20, 2006 at 03:34:19PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > > @@ -100,9 +100,10 @@ struct futex_q {
> > >  struct futex_hash_bucket {
> > >         spinlock_t              lock;
> > >         struct list_head       chain;
> > > -};
> > > +} ____cacheline_internodealigned_in_smp;
> > >  
> > > -static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
> > > +static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS] 
> > > +				__cacheline_aligned_in_smp;
> > >  
> > 
> > How much memory does that thing end up consuming?
> 
> I think a megabyte?

On most machines it would be 256 * 128 = 32k. or 16k on arches with 64B 
cachelines.  This looked like a simpler solution for spinlocks falling on
the same cacheline.  So is 16/32k unreasonable?

Thanks,
Kiran

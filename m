Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWBWTQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWBWTQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWBWTQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:16:37 -0500
Received: from ns1.siteground.net ([207.218.208.2]:3506 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750716AbWBWTQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:16:37 -0500
Date: Thu, 23 Feb 2006 11:17:06 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       Alok Kataria <alok.kataria@calsoftinc.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: slab: Remove SLAB_NO_REAP option
Message-ID: <20060223191706.GB3708@localhost.localdomain>
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain> <20060223020957.478d4cc1.akpm@osdl.org> <Pine.LNX.4.58.0602231331530.15716@sbz-30.cs.Helsinki.FI> <Pine.LNX.4.64.0602230917540.1796@schroedinger.engr.sgi.com> <1140719812.11455.1.camel@localhost> <Pine.LNX.4.64.0602231044210.13228@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602231044210.13228@schroedinger.engr.sgi.com>
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

On Thu, Feb 23, 2006 at 10:47:53AM -0800, Christoph Lameter wrote:
> On Thu, 23 Feb 2006, Pekka Enberg wrote:
> 
> > Look at the loop, it is redundant work (like acquiring/releasing a
> > spinlock). The cache_cache is practically static, which is why it makes
> > sense to leave it alone.
> 
> There is a loop but its broken by
> 
> 			p = l3->slabs_free.next;
>                         if (p == &(l3->slabs_free))
>                                 break;
> 
> One cache_reap() may scan the free list but once its free the code is 
> skipped.

I think Pekka is referring to draining of alien cache, array caches and the
shared caches before the loop is is broken by above.

> 
> There are potentially large amounts of other caches around that are also 
> basically static and which also would need any bypass that we may 
> implement.

I agree. That's where SLAB_NO_REAP can be used? or rather, change the
name/documentation to mean something better.

OR, introduce smartness in cache_reap to break the loop earlier if we can
somehow dynamically recognise the cache is static. 

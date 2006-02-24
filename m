Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWBXQTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWBXQTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBXQTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:19:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40128 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932335AbWBXQTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:19:33 -0500
Date: Fri, 24 Feb 2006 08:19:15 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Andrew Morton <akpm@osdl.org>, Alok Kataria <alok.kataria@calsoftinc.com>,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: slab: Remove SLAB_NO_REAP option
In-Reply-To: <84144f020602232336l480f6a4el9f7f708f9c3a61e1@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0602240817110.20760@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain> 
 <20060223020957.478d4cc1.akpm@osdl.org>  <Pine.LNX.4.58.0602231331530.15716@sbz-30.cs.Helsinki.FI>
  <Pine.LNX.4.64.0602230917540.1796@schroedinger.engr.sgi.com> 
 <1140719812.11455.1.camel@localhost>  <Pine.LNX.4.64.0602231044210.13228@schroedinger.engr.sgi.com>
 <84144f020602232336l480f6a4el9f7f708f9c3a61e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Pekka Enberg wrote:

> > One cache_reap() may scan the free list but once its free the code is
> > skipped.
> 
> Which is _totally_ redundant for cache_cache.

Correct. So you are going to add a check to the loop that is useless for 
all other caches? The many have to sacrfice for the one?

> I don't think its worth it. It doesn't make much sense to create a
> separate object cache if you're not using it, we're better off
> converting those to kmalloc(). cache_cache is there to make
> bootstrapping easier, it is very unlikely that you ever have more than
> one page allocated for that cache which is why scanning the freelist
> _at all_ is silly. I think SLAB_NO_REAP should go away but we also
> must ensure we don't introduce a performance regression while doing
> that.

Got some way to get rid of cache_cache? Or remove it after boot?



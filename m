Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWD0WXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWD0WXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbWD0WXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:23:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21212 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751719AbWD0WXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:23:07 -0400
Date: Thu, 27 Apr 2006 15:22:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Or Gerlitz <ogerlitz@voltaire.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, open-iscsi@googlegroups.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: possible bug in kmem_cache related code
In-Reply-To: <84144f020604270419s10696877he2ec27ae6d52e486@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0604271510240.27370@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0604271138370.16357-101000@zuben>
 <84144f020604270419s10696877he2ec27ae6d52e486@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006, Pekka Enberg wrote:

> On 4/27/06, Or Gerlitz <ogerlitz@voltaire.com> wrote:
> > With 2.6.17-rc3 I'm running into something which seems as a bug related
> > to kmem_cache. Doing some allocations/deallocations from a kmem_cache and
> > later attempting to destroy it yields the following message and trace
> 
> Tested on 2.6.16.7 and works ok. Christoph, could this be related to
> the cache draining patches that went in 2.6.17-rc1?

What happened to that part of the slab allocator? Looks completely  
changed to when I saw it the last time?

This directly fails in kmem_cache_destroy?

So it tries to free all the slab entries from the free list and then 
returns 1 or 2 if there are entries left on the partial and full 
list? So the bug happens if cache entries are left.

Guess the reason for this failure is then that not all cache entries have 
been freed before calling kmem_cache_destroy()?



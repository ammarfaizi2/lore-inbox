Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbWD1GDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWD1GDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWD1GDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:03:50 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:63378 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965138AbWD1GDu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:03:50 -0400
Date: Fri, 28 Apr 2006 09:03:44 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: Or Gerlitz <ogerlitz@voltaire.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, open-iscsi@googlegroups.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: possible bug in kmem_cache related code
In-Reply-To: <Pine.LNX.4.64.0604271510240.27370@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0604280902240.6181@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.44.0604271138370.16357-101000@zuben>
 <84144f020604270419s10696877he2ec27ae6d52e486@mail.gmail.com>
 <Pine.LNX.4.64.0604271510240.27370@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/06, Or Gerlitz <ogerlitz@voltaire.com> wrote:
> > > With 2.6.17-rc3 I'm running into something which seems as a bug related
> > > to kmem_cache. Doing some allocations/deallocations from a kmem_cache and
> > > later attempting to destroy it yields the following message and trace

On Thu, 27 Apr 2006, Pekka Enberg wrote:
> > Tested on 2.6.16.7 and works ok. Christoph, could this be related to
> > the cache draining patches that went in 2.6.17-rc1?

On Thu, 27 Apr 2006, Christoph Lameter wrote:
> What happened to that part of the slab allocator? Looks completely  
> changed to when I saw it the last time?
> 
> This directly fails in kmem_cache_destroy?
> 
> So it tries to free all the slab entries from the free list and then 
> returns 1 or 2 if there are entries left on the partial and full 
> list? So the bug happens if cache entries are left.
> 
> Guess the reason for this failure is then that not all cache entries have 
> been freed before calling kmem_cache_destroy()?

Yes, but if you look at Or's test case, there's no obvious reason why 
that's happening. I'll see if I can reproduce the problem with 2.6.17-rc3.

					Pekka

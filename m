Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262989AbREWEjx>; Wed, 23 May 2001 00:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262990AbREWEjn>; Wed, 23 May 2001 00:39:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47501 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262989AbREWEj3>;
	Wed, 23 May 2001 00:39:29 -0400
Date: Wed, 23 May 2001 00:39:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (part 2) fs/super.c cleanups
In-Reply-To: <3B0B3BAC.8B48E985@uow.edu.au>
Message-ID: <Pine.GSO.4.21.0105230032300.17373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001, Andrew Morton wrote:

> Alexander Viro wrote:
> > 
> >         Locking rules: both require mount_sem and dcache_lock being
> > held by callers.
> >
> 
> It would help a lot if locking rules were commented in 
> the source, rather than on linux-kernel.

They will change in the next chunks. In particular, we'll need
rwlock for these two instead of mount_sem.

Current locking rules for fs/super.c are mess. It used to be completely
under BKL and nobody cared much about races there, so lots of things
are sloppy. As usual - there is no such thing as SMP-only race...

New variant makes much more sense, but I'm feeding it in small chunks and
one of the obvious requirements is that at every stage situation should
be better or same as on the previous step. It's -STABLE, damnit.


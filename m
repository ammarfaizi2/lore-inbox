Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSHaVUf>; Sat, 31 Aug 2002 17:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSHaVUf>; Sat, 31 Aug 2002 17:20:35 -0400
Received: from dsl-213-023-043-117.arcor-ip.net ([213.23.43.117]:49386 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318017AbSHaVUe>;
	Sat, 31 Aug 2002 17:20:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC] [PATCH] Include LRU in page count
Date: Sat, 31 Aug 2002 23:05:02 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
References: <3D644C70.6D100EA5@zip.com.au> <E17lEDR-0004Qq-00@starship> <3D712682.66E2D3B2@zip.com.au>
In-Reply-To: <3D712682.66E2D3B2@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lFQV-0004RO-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 August 2002 22:26, Andrew Morton wrote:
> Daniel Phillips wrote:
> > Manfred suggested an approach to de-racing this race using
> > atomic_dec_and_lock, which needs to be compared to the current approach.
> 
> Could simplify things, but not all architectures have an optimised
> version.  So ia64, mips, parisc and s390 would end up taking
> the lru lock on every page_cache_release.

As far as implementing it goes, some instances of page_cache_release are
already under the lru lock and would need an alternative, non-locking
version.

The current patch seems satisfactory performance-wise and if it's
also raceless as it's supposed to be, it gives us something that works,
and we can evaluate alternatives at our leisure.  Right now I'm afraid
we have something that just works most of the time.

I think we're getting to the point where this needs to get some heavy
beating up, to see what happens.

-- 
Daniel

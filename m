Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314321AbSEXLmt>; Fri, 24 May 2002 07:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314327AbSEXLms>; Fri, 24 May 2002 07:42:48 -0400
Received: from holomorphy.com ([66.224.33.161]:54684 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314321AbSEXLmr>;
	Fri, 24 May 2002 07:42:47 -0400
Date: Fri, 24 May 2002 04:42:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] using page aging to shrink caches (pre8-ac5)
Message-ID: <20020524114234.GJ14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <200205180010.51382.tomlins@cam.org> <20020521144759.B1153@redhat.com> <200205240728.45558.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 07:28:45AM -0400, Ed Tomlinson wrote:
> This moves things towards having the vm do the work of freeing the
> pages. I do wonder if it worth the effort in that slab pages are a
> bit different from other pages and get treated a little differently.
> For instance, we sometimes free slab pages in refill_inactive.
> Without this the caches can grow and grow without any possibility of
> shrinking when under low loads.  By allowing freeing we avoid getting
> into a situation where slab pages cause an artificial shortage.
> Finding a good method of handling the dcache/icache and dquota caches
> has been fun...  What I do now is factor the pruning and shrinking
> into different calls.  The puning, in effect, ages entries in the
> above caches. The rate I prune is simply the rate I see entries for
> these slabs in refill_inactive_zone. This is seems fair and, in my
> testing, works better than anything else I have tried (I have have
> experimented quite a bit).  It also avoid using any magic numbers 
> and is self tuning.

This kind of cache reclamation logic is so sorely needed it's
unimaginable. I'm quite grateful for your efforts in this direction,
and hope to be able to provide some assistance in testing soon.

Cheers,
Bill

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSHGUwg>; Wed, 7 Aug 2002 16:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSHGUwe>; Wed, 7 Aug 2002 16:52:34 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:10250 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315536AbSHGUvX>; Wed, 7 Aug 2002 16:51:23 -0400
Date: Wed, 7 Aug 2002 17:54:50 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <wli@holomorphy.com>
Subject: Re: [PATCH] Rmap speedup
In-Reply-To: <E17cXlz-0004y0-00@starship>
Message-ID: <Pine.LNX.4.44L.0208071753190.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Daniel Phillips wrote:

> > It may be a net loss for high sharing levels.  Dunno.
>
> High sharing levels are exactly where the swap-in problem is going to
> rear its ugly head.

If the swap-in problem exists.

I can see it being triggered artificially because we still
unmap too many pages in the pageout path, but if we fix
shrink_cache() to not unmap the whole inactive list when
we're under continuous memory pressure but only the end of
the list where we're actually reclaiming pages, maybe then
many of the minor page faults we're seeing under such
loads will just disappear.

Not to mention the superfluous IO being scheduled today.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319025AbSH1Wh5>; Wed, 28 Aug 2002 18:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319039AbSH1Wh5>; Wed, 28 Aug 2002 18:37:57 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:9477 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319025AbSH1WhW>; Wed, 28 Aug 2002 18:37:22 -0400
Message-ID: <3D6D5128.9EE6DFDD@zip.com.au>
Date: Wed, 28 Aug 2002 15:39:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au> <E17k9dO-0002tR-00@starship> <3D6D3AA4.31A4AD3A@zip.com.au> <E17kAvf-0002tx-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> So there's no question that the race is lurking in 2.4.  I noticed several
> more paths besides the one above that look suspicious as well.  The bottom
> line is, 2.4 needs a fix along the lines of my suggestion or Christian's,
> something that can actually be proved.
> 
> It's a wonder that this problem manifests so rarely in practice.

I sort-of glanced through the 2.4 paths and it appears that in all of the
places where it could do a page_cache_get/release, that would never happen
because of other parts of the page state.

Like: it can't be in pagecache, so we won't run writepage, and
it can't have buffers, so we won't run try_to_release_page().

Of course, I might have missed a path.  And, well, generally: ugh.

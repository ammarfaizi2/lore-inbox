Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319345AbSH2VmI>; Thu, 29 Aug 2002 17:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319352AbSH2VmI>; Thu, 29 Aug 2002 17:42:08 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:8324 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319345AbSH2VmH>; Thu, 29 Aug 2002 17:42:07 -0400
Date: Thu, 29 Aug 2002 18:46:15 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [PATCH] low-latency zap_page_range()
In-Reply-To: <3D6E9084.820B2608@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208291845060.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Andrew Morton wrote:

> > So we know it is held forever and a day... but is there contention?
>
> I'm sure there is, but nobody has measured the right workload.
>
> Two CLONE_MM threads, one running mmap()/munmap(), the other trying
> to fault in some pages.  I'm sure someone has some vital application
> which does exactly this.  They always do :(

Can't fix this one.  The mmap()/munmap() needs to have the
mmap_sem for writing as long as its setting up or tearing
down a VMA while the pagefault path takes the mmap_sem for
reading.

It might be fixable in some dirty way, but I doubt that'll
ever be worth it.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSG2A4q>; Sun, 28 Jul 2002 20:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318109AbSG2A4q>; Sun, 28 Jul 2002 20:56:46 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:31502 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318107AbSG2A4p>; Sun, 28 Jul 2002 20:56:45 -0400
Date: Sun, 28 Jul 2002 21:59:45 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <3D449388.7CE9A47A@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0207282158530.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002, Andrew Morton wrote:

> And we took the lru_cache_del() out of truncate_complete_page()
> because, err, I forget.  There was a situation in which the page
> could still be mapped into process pagetables, and the lru_cache_del()
> would have left it unswappable until process exit.
>
> Rik, can you remember the exact scenario?

Truncate vs. the page fault path.  It would be possible for
pages to be removed from the lru list by truncate and turning
into anonymous process memory.

This becomes a leak when only pages on the lru list can be
paged out.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131392AbRCWX7h>; Fri, 23 Mar 2001 18:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131393AbRCWX7a>; Fri, 23 Mar 2001 18:59:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:44806 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131392AbRCWX6m>; Fri, 23 Mar 2001 18:58:42 -0500
Date: Fri, 23 Mar 2001 08:21:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Richard Jerrell <jerrell@missioncriticallinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory.c, 2.4.1 : memory leak with swap cache (updated)
In-Reply-To: <Pine.LNX.4.21.0103231042380.20061-200000@jerrell.lowell.mclinux.com>
Message-ID: <Pine.LNX.4.21.0103230820430.1863-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Richard Jerrell wrote:
> > Your idea is nice, but the patch lacks a few things:
> > 
> > - SMP locking, what if some other process faults in this page
> >   between the atomic_read of the page count and the test later?
> 
> It can't happen.  free_pte is called with the page_table_lock held in 
> addition to having the mmap_sem downed.

The page_table_lock and the mmap_sem only protect the *current*
task. Think about something like an apache with 500 children who
COW share the same page...

> > - testing if our process is the _only_ user of this swap page,
> >   for eg. apache you'll have lots of COW-shared pages .. it would
> >   be good to keep the page in memory for our siblings
> 
> This is already done in free_page_and_swap_cache.

Ok ...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


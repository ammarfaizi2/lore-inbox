Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131603AbRC0VTh>; Tue, 27 Mar 2001 16:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131600AbRC0VTS>; Tue, 27 Mar 2001 16:19:18 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:22545 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131590AbRC0VTC>; Tue, 27 Mar 2001 16:19:02 -0500
Date: Tue, 27 Mar 2001 18:18:11 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Richard Jerrell <jerrell@missioncriticallinux.com>
Cc: Stephen Tweedie <sct@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memory.c, 2.4.1 : memory leak with swap cache (updated)
In-Reply-To: <Pine.LNX.4.21.0103271624520.1989-200000@jerrell.lowell.mclinux.com>
Message-ID: <Pine.LNX.4.33.0103271815370.26154-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Richard Jerrell wrote:

> Instead of removing the swap cache page at process exit and possibly
> expending time doing disk IO as you have pointed out, we check during
> refill_inactive_scan and page_launder for a page that is

Three comments:

1. we take an extra reference on the page, how does that
   affect the test for if the page is shared or not ?
2. we call delete_from_swap_cache with the pagemap_lru_lock
   held, since this tries to grab the pagecache_lock we can
   easily deadlock with the rest of the kernel (where the
   locking order is opposite)
3. there are no comments in the code explaining what this
   suspicious-looking piece of code does ;)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



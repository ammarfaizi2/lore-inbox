Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273911AbRIRUyV>; Tue, 18 Sep 2001 16:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273914AbRIRUyL>; Tue, 18 Sep 2001 16:54:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:18698 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273911AbRIRUx4>; Tue, 18 Sep 2001 16:53:56 -0400
Date: Tue, 18 Sep 2001 16:29:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au
Subject: Re: 2.4.10pre11 vm rewrite fixes for mainline inclusion and testing
In-Reply-To: <20010918224317.E720@athlon.random>
Message-ID: <Pine.LNX.4.21.0109181627340.7836-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

(testing now)

> Linus, can you merge this patch in the next pre-patch? Marcelo and
> Andrew, can you test if this fixes your problems properly or if we need
> further work on it for the oom problem?
> 
> Only in 2.4.10pre11aa1: 00_vm-aa-2
> 
> 	description of the patch:
> 
> 	-       fixed a race condition in rw_swap_page path: if we need
> 	        to wait synchronously on the page we must hold a reference
> 	        on the page or it could be freed by the VM under us
> 	        after it's been unlocked at I/O completion time (see
> 	        the page_io.c changes)
> 	-       don't hide anything (see the new parameter "this_max_scan" to
> 	        shrink_cache)
> 	-       don't skip work on the ptes but just don't stop until we
> 	        unmapped the "interesting" pages from the right classzone

I really think we should reintroduce the idea of "enough" inactive/free
pages, Andrea.

This way we avoid starving the page reclaiming work on only one zone when
we have a small zone under extreme pressure, while at the same time we
avoid breaking writeout clustering and the "fairness" of pte scanning.

Do you remember the "zone_inactive_plenty()/zone_free_plenty()" stuff
which we had back into pre10 ?


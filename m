Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132801AbRDWQye>; Mon, 23 Apr 2001 12:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133105AbRDWQyX>; Mon, 23 Apr 2001 12:54:23 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:17405 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S132801AbRDWQyP>; Mon, 23 Apr 2001 12:54:15 -0400
Message-Id: <l03130301b70a0e4c4676@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.21.0104231218000.1685-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.30.0104231039050.3540-200000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 23 Apr 2001 17:53:18 +0100
To: Rik van Riel <riel@conectiva.com.br>, Ingo Molnar <mingo@elte.hu>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [patch] swap-speedup-2.4.3-A1, massive swapping speedup
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Szabolcs Szakacsits <szaka@f-secure.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There seems to be one more reason, take a look at the function
>read_swap_cache_async() in swap_state.c, around line 240:
>
>        /*
>         * Add it to the swap cache and read its contents.
>         */
>        lock_page(new_page);
>        add_to_swap_cache(new_page, entry);
>        rw_swap_page(READ, new_page, wait);
>        return new_page;
>
>Here we add an "empty" page to the swap cache and use the
>page lock to protect people from reading this non-up-to-date
>page.

How about reversing the order of the calls - ie. add the page to the cache
only when it's been filled?  That would fix the race.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----



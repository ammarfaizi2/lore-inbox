Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130661AbRAaEGm>; Tue, 30 Jan 2001 23:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130763AbRAaEGd>; Tue, 30 Jan 2001 23:06:33 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:5380 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130661AbRAaEGY>; Tue, 30 Jan 2001 23:06:24 -0500
Date: Wed, 31 Jan 2001 00:16:43 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.1 find_page_nolock fixes
In-Reply-To: <Pine.LNX.4.21.0101301728520.1321-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101310015290.16164-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Jan 2001, Rik van Riel wrote:

> Hi Linus,
> 
> the patch below contains 3 small changes to mm/filemap.c:
> 
> 1. replace the aging in __find_page_nolock() with setting
>    PageReferenced(), otherwise a large number of small
>    reads from (or writes to) a page can drive up the page
>    age unfairly
> 
> 2. remove the wakeup of kswapd from __find_page_nolock(),
>    the wakeup condition is complex and leaving out the
>    wakeup has no influence on any workload I tested in
>    the last few weeks
> 
> 3. add a __find_page_simple(), which is like __find_page_nolock()
>    but only needs 2 arguments and doesn't touch the page ... this
>    can be used by IO clustering and other things that really don't
>    want to influence page aging, removing the 3rd argument also
>    keeps things simple

The swapin readahead still makes the page referenced bit set, and it
should not as we discussed previously.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136032AbRAGU7v>; Sun, 7 Jan 2001 15:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135968AbRAGU7k>; Sun, 7 Jan 2001 15:59:40 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:26632 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S135762AbRAGU73>; Sun, 7 Jan 2001 15:59:29 -0500
Date: Sun, 7 Jan 2001 17:07:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] mm-cleanup-1 (2.4.0)
In-Reply-To: <87snmv9k13.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.21.0101071701250.4416-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 7 Jan 2001, Zlatko Calusic wrote:

> The following patch cleans up some obsolete structures from the mm &
> proc code.
> 
> Beside that it also fixes what I think is a bug:
> 
>         if ((rw == WRITE) && atomic_read(&nr_async_pages) >
>                        pager_daemon.swap_cluster * (1 << page_cluster))
> 
> In that (swapout logic) it effectively says swap out 512KB at once (at
> least on my memory configuration). I think that is a little too much.
> I modified it to be a little bit more conservative and send only
> (1 << page_cluster) to the swap at a time. Same applies to the
> swapin_readahead() function. Comments welcome.

512kb is the maximum limit for in-flight swap pages, not the cluster size 
for IO. 

swapin_readahead actually sends requests of (1 << page_cluster) to disk
at each run.
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

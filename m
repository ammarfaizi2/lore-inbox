Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRAGVRX>; Sun, 7 Jan 2001 16:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRAGVRM>; Sun, 7 Jan 2001 16:17:12 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:51956 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130144AbRAGVRC>; Sun, 7 Jan 2001 16:17:02 -0500
Date: Sun, 7 Jan 2001 19:16:47 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] mm-cleanup-1 (2.4.0)
In-Reply-To: <87snmv9k13.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.21.0101071912570.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2001, Zlatko Calusic wrote:

> The following patch cleans up some obsolete structures from the
> mm & proc code.
> 
> Beside that it also fixes what I think is a bug:
> 
>         if ((rw == WRITE) && atomic_read(&nr_async_pages) >
>                        pager_daemon.swap_cluster * (1 << page_cluster))
> 
> In that (swapout logic) it effectively says swap out 512KB at
> once (at least on my memory configuration). I think that is a
> little too much.

Since we submit a whole cluster of (1 << page_cluster)
size at once, your change would mean that the VM can
only do one IO at a time...

Have you actually measured your changes or is it just
a gut feeling that the current default is too much?

(I can agree with 1/2 MB being a bit much, but doing
just one IO at a time is probably wrong too...)


The cleanup part of your patch is nice. I think that
one should be submitted as soon as the 2.4 bugfix
period is over ...

(and yes, I'm not submitting any of my own trivial
patches either unless they're REALLY needed, lets make
sure Linus has enough time to focus on the real bugfixes)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

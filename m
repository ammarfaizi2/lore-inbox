Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131327AbRBJMhC>; Sat, 10 Feb 2001 07:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbRBJMgw>; Sat, 10 Feb 2001 07:36:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:29169 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131368AbRBJMgf>; Sat, 10 Feb 2001 07:36:35 -0500
Date: Sat, 10 Feb 2001 10:36:05 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.LNX.4.21.0102100727350.27389-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0102101030000.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001, Marcelo Tosatti wrote:
> On Sat, 10 Feb 2001, Mike Galbraith wrote:
> 
> > This change makes my box swap madly under load.
> 
> Swapped out pages were not being counted in the flushing limitation.
> 
> Could you try the following patch? 

Marcelo's patch should do the trick wrt. to making page_launder()
well-behaved again.  It should fix the problems some people have
seen with bursty swap behaviour.

> --- linux.orig/mm/vmscan.c      Sat Feb 10 08:26:17 2001
> +++ linux/mm/vmscan.c   Sat Feb 10 09:34:20 2001
> @@ -515,6 +515,7 @@
> 
>                         writepage(page);
>                         flushed_pages++;
> +                       max_launder--;
>                         page_cache_release(page);
> 
>                         /* And re-start the thing.. */



Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276278AbRI1UPB>; Fri, 28 Sep 2001 16:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276288AbRI1UOw>; Fri, 28 Sep 2001 16:14:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14091 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276278AbRI1UOo>; Fri, 28 Sep 2001 16:14:44 -0400
Date: Fri, 28 Sep 2001 17:14:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 does not set accessed bit for readahead pages
In-Reply-To: <Pine.LNX.4.21.0109281506430.3230-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0109281708550.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001, Marcelo Tosatti wrote:

> NOTE: I'm saying that it is _bad_ to throw away readahead pages
> easily because I've seen it in practice. I'll try to test this
> in real practice again soon (not this week) to make sure.
>
> Comments ?

Setting the referenced bit on not (yet) used readahead
pages could have the damaging side effect of swapping
out pages from the working set in preference to the
readahead pages.

OTOH, without some special trick for linear access the
VM will prefer to swap out the pages we're about to use
(the readahead pages) instead of the pages we just used
-- the absolute worst thing for sequential IO.

One simple solution which achieves both the effect of
dropping the right pages in a sequential IO stream and
making sure that not-used readahead pages aren't pushing
out the working set would be drop-behind.

I know drop-behind isn't the prettiest thing, but it's
simple and it works.

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266957AbRGHSaT>; Sun, 8 Jul 2001 14:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbRGHSaJ>; Sun, 8 Jul 2001 14:30:09 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:51716 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S266957AbRGHS3w>;
	Sun, 8 Jul 2001 14:29:52 -0400
Date: Sun, 8 Jul 2001 15:29:49 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107081002490.7044-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0107081527110.4598-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001, Linus Torvalds wrote:


>  (a) _had_ the page been on any of the aging lists, it would have been
>      aged down every time we passed it, and
>  (b) it's obviously been aged up every time we passed it in the VM so far
>      (because it hadn't been added to the swap cache earlier).

>  - an anonymous page, by the time we add it to the swap cache, would have
>    been aged down and up roughly the same number of times.

Hmmm, indeed.  I guess this also means page aging in its
current form cannot even work well with exponential down
aging since the down aging on the pageout list always
cancels out the up aging in swap_out() ...

I guess it's time we found some volunteers to experiment
with linear down aging (page->age--;) since that one will
be able to withstand pages being referenced only in the
page tables.

(now, off to a project 4000 km from home for the next 2
weeks ... bbl)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


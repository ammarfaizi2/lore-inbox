Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266954AbRGHSYa>; Sun, 8 Jul 2001 14:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbRGHSYT>; Sun, 8 Jul 2001 14:24:19 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:37380 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S266954AbRGHSYH>;
	Sun, 8 Jul 2001 14:24:07 -0400
Date: Sun, 8 Jul 2001 15:23:53 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107081039420.7044-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0107081521510.4598-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001, Linus Torvalds wrote:
> On Sun, 8 Jul 2001, Rik van Riel wrote:
> >
> > ... Bingo.  You hit the infamous __wait_on_buffer / ___wait_on_page
> > bug. I've seen this for quite a while now on our quad xeon test
> > machine, with some kernel versions it can be reproduced in minutes,
> > with others it won't trigger at all.
>
> Hmm.. That would explain why the "tar" gets stuck, but why does the whole
> machine grind to a halt with all other processes being marked runnable?

If __wait_on_buffer and ___wait_on_page get stuck, this could
mean a page doesn't get unlocked.  When this is happening, we
may well be running into a dozens of pages which aren't getting
properly unlocked on IO completion.

This in turn would get the rest of the system stuck in the
pageout code path, eating CPU like crazy.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


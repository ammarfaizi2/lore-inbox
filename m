Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261943AbREMXFY>; Sun, 13 May 2001 19:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbREMXFO>; Sun, 13 May 2001 19:05:14 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:6413 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261943AbREMXFD>;
	Sun, 13 May 2001 19:05:03 -0400
Date: Sun, 13 May 2001 20:04:41 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: "David S. Miller" <davem@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Another VM race? (was: page_launder() bug)
In-Reply-To: <Pine.LNX.3.96.1010513224406.18268B-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0105132003580.5468-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2001, Mikulas Patocka wrote:

> CPU 0				CPU 1
> is executing the code marked	is executing try_to_free_buffers on
> above with ^^^^^^^:		the same page (it can be, because CPU 0
> 				did not lock the page)
> 
> (page->buffers &&
> 
> 				page->buffers = NULL
> 
> MAJOR(page->buffers->b_dev) == 
> 	RAMDISK_MAJOR)) ===> Oops, NULL pointer dereference!
> 
> 
> 
> Maybe compiler CSE optimization will eliminate the double load of
> page->buffers, but we must not rely on it. If the compiler doesn't
> optimize it, it can produce random oopses.

You're right, this should be fixed. Do you happen to have a
patch ? ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262235AbREZA0d>; Fri, 25 May 2001 20:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262265AbREZA0X>; Fri, 25 May 2001 20:26:23 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30224 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262235AbREZA0M>; Fri, 25 May 2001 20:26:12 -0400
Date: Fri, 25 May 2001 21:26:02 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.31.0105251720110.1086-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0105252124470.10469-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Linus Torvalds wrote:

> Oh, also: the logic behind the change of the kmem_cache_reap() - instead
> of making it conditional on the _reverse_ test of what it has historically
> been, why isn't it just completely unconditional? You've basically
> dismissed the only valid reason for it to have been (illogically)
> conditional, so I'd have expected that just _removing_ the test is better
> than reversing it like your patch does..
>
> No?

The function do_try_to_free_pages() also gets called when we're
only short on inactive pages, but we still have TONS of free
memory. In that case, I don't think we'd actually want to steal
free memory from anyone.

Moving it into the same if() conditional the other memory
freeers are in would make sense, though ...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


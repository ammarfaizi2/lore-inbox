Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286227AbRLJLLX>; Mon, 10 Dec 2001 06:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286228AbRLJLLO>; Mon, 10 Dec 2001 06:11:14 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:39441 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286227AbRLJLLF>; Mon, 10 Dec 2001 06:11:05 -0500
Date: Mon, 10 Dec 2001 09:10:42 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Ken Brownfield <brownfld@irridia.com>
Cc: Mike Galbraith <mikeg@wen-online.de>, Leigh Orf <orf@mailbag.com>,
        "M.H.VanLeeuwen" <vanl@megsinet.net>,
        Mark Hahn <hahn@physics.mcmaster.ca>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 memory badness (fixed?)
In-Reply-To: <20011210012408.B11697@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.33L.0112100909250.4755-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Ken Brownfield wrote:

> What about moving the calls to shrink_[di]cache_memory() after the
> nr_pages check after the call to kmem_cache_reap?  Or perhaps keep it at
> the beginning, but only call it after priority has gone a number of
> notches down from DEF_PRIORITY?
>
> Something like that seems like the only obvious way to balance how soon
> these caches are flushed without over- or under-kill.

So obvious that it's been re-introduced 3 times now even though
it broke each time. ;)

The only way to get stuff balanced somewhat is to call the
shrink functions unconditionally. It's not optimally balanced,
but at least the cache will stay reasonably small while still
being able to grow under load.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/


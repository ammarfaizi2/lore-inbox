Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286291AbRLJPvy>; Mon, 10 Dec 2001 10:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286292AbRLJPvo>; Mon, 10 Dec 2001 10:51:44 -0500
Received: from nc-ashvl-66-169-84-151.charternc.net ([66.169.84.151]:3457 "EHLO
	orp.orf.cx") by vger.kernel.org with ESMTP id <S286291AbRLJPvb>;
	Mon, 10 Dec 2001 10:51:31 -0500
Message-Id: <200112101549.fBAFnOq08395@orp.orf.cx>
To: Rik van Riel <riel@conectiva.com.br>
From: Leigh Orf <orf@mailbag.com>
cc: Ken Brownfield <brownfld@irridia.com>,
        Mike Galbraith <mikeg@wen-online.de>,
        "M.H.VanLeeuwen" <vanl@megsinet.net>,
        Mark Hahn <hahn@physics.mcmaster.ca>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcDb+Y'p'sCMJ
Subject: Re: 2.4.16 memory badness (fixed?) 
In-Reply-To: Your message of "Mon, 10 Dec 2001 09:10:42 -0200."
             <Pine.LNX.4.33L.0112100909250.4755-100000@duckman.distro.conectiva> 
Date: Mon, 10 Dec 2001 10:49:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel wrote:

|   On Mon, 10 Dec 2001, Ken Brownfield wrote:
|
|   > What about moving the calls to shrink_[di]cache_memory()
|   > after the nr_pages check after the call to kmem_cache_reap?
|   > Or perhaps keep it at the beginning, but only call it
|   > after priority has gone a number of notches down from
|   > DEF_PRIORITY?
|   >
|   > Something like that seems like the only obvious way to
|   > balance how soon these caches are flushed without over- or
|   > under-kill.
|
|   So obvious that it's been re-introduced 3 times now even
|   though it broke each time. ;)

And in fact, after furthur playing around with the "fixed" version
(moving shrink_[id]cache_memory to the top of vmscan.c::shrink_caches)
I find that I still will get ENOMEM after updatedb occasionally. Less
often than before, but it still happens.

|   The only way to get stuff balanced somewhat is to call
|   the shrink functions unconditionally. It's not optimally
|   balanced, but at least the cache will stay reasonably small
|   while still being able to grow under load.

I just can't understand why the kernel wouldn't tag application memory
as being more important tan buff/cache and free up some of that stuff
when an application calls for it. I mean, it won't even use the gobs of
swap I have. That just seems to be a plain ol' bug to me.

Leigh Orf

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319671AbSIMVY2>; Fri, 13 Sep 2002 17:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319794AbSIMVY2>; Fri, 13 Sep 2002 17:24:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:45329 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S319671AbSIMVY1>; Fri, 13 Sep 2002 17:24:27 -0400
Date: Fri, 13 Sep 2002 23:29:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
Message-ID: <20020913212921.GA17627@atrey.karlin.mff.cuni.cz>
References: <20020913210042.GA25464@elf.ucw.cz> <Pine.LNX.4.44L.0209131808240.1857-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209131808240.1857-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > /*
> >  * Try to free as much memory as possible, but do not OOM-kill anyone
> >  *
> >  * Notice: all userland should be stopped at this point, or livelock
> > is possible.
> >  */
> >
> > This worked before -rmap came in, but it does not free anything
> > now. What needs to be done to fix it?
> 
> Actually, it still worked when -rmap came in, but it stopped working
> when the LRU lists were made to be per-zone...
> 
> > static void free_some_memory(void)
> > {
> >         printk("Freeing memory: ");
> >         while
> > (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
> >                 printk(".");
> >         printk("|\n");
> > }
> 
> Why don't you just allocate memory ?
> 
> To prevent the OOM kill you can just check for a variable
> in the OOM slow path.  No need to rely on any particular
> behaviour of the VM.

Allocating memory is pain because I have to free it afterwards. Yep I
have such code, but it is ugly. try_to_free_pages() really seems like
cleaner solution to me... if you only tell me how to fix it :-).

If it is not easy to fix, I can reintroduce memory eating code; but
I'd hate to special-case SWSUSP in VM. Otoh GFP_FAIL or something like
that might help me, right?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319814AbSINKA4>; Sat, 14 Sep 2002 06:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319827AbSINKA4>; Sat, 14 Sep 2002 06:00:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:10248 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S319814AbSINKAz>; Sat, 14 Sep 2002 06:00:55 -0400
Date: Sat, 14 Sep 2002 12:05:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
Message-ID: <20020914100549.GB816@atrey.karlin.mff.cuni.cz>
References: <20020913212921.GA17627@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44L.0209131830560.1857-100000@imladris.surriel.com> <3D825E43.FDB41C7F@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D825E43.FDB41C7F@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Allocating memory is pain because I have to free it afterwards. Yep I
> > > have such code, but it is ugly. try_to_free_pages() really seems like
> > > cleaner solution to me... if you only tell me how to fix it :-).
> > 
> > "Fixing" the VM just so it behaves the way swsuspend wants is
> > out. If swsuspend relies on all other subsystems playing nicely,
> > I think it should be removed from the kernel.
> > 
> 
> Yup.  Martin Bligh is cooking up a multi-page allocation API, so when that's
> in place, swsusp need only do:
> 
> 	LIST_HEAD(foo);
> 	alloc_many_pages(&foo, nr_pages, __GFP_HIGHMEM|__GFP_WAIT);
> 	free_many_pages(&foo);
> 
> So I suggest you do something local for the while, plan to use that later.
> 
> (Actually, the implementation would probably have a heart attack if you
> asked for 100,000 pages so you may need to sit in a loop there;
> we'll see).

If nr_pages is > than number of pages really freable will it return
NULL or stall the calling process forever?

If it will return NULL I'm happy to use that... Otherwise its not too
usable because I do not want to OOM the machine.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.

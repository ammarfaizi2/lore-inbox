Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136033AbRD0NZ4>; Fri, 27 Apr 2001 09:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136024AbRD0NZq>; Fri, 27 Apr 2001 09:25:46 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14343 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136025AbRD0NZh>; Fri, 27 Apr 2001 09:25:37 -0400
Date: Fri, 27 Apr 2001 08:45:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Ingo Molnar <mingo@elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104271500300.243-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0104270844560.2863-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Apr 2001, Mike Galbraith wrote:

> On Thu, 26 Apr 2001, Rik van Riel wrote:
> 
> > On Thu, 26 Apr 2001, Mike Galbraith wrote:
> >
> > > > > > No.  It livelocked on me with almost all active pages exausted.
> > > > > Misspoke.. I didn't try the two mixed.  Rik's patch livelocked me.
> > > >
> > > > Interesting. The semantics of my patch are practically the same as
> > > > those of the stock kernel ... can you get the stock kernel to
> > > > livelock on you, too ?
> > >
> > > Generally no.  Let kswapd continue to run?  Yes, but not always.
> >
> > OK, then I guess we should find out WHY the thing livelocked...
> 
> Hi Rik,
> 
> I decided to take a break from pondering input and see why the thing
> ran itself into the ground.  Methinks I was sent the wrooong patch :)

Mike,

Please apply this patch on top of Rik's v2 patch otherwise you'll get the
livelock easily:

--- linux.orig/mm/vmscan.c      Fri Apr 27 04:32:52 2001
+++ linux/mm/vmscan.c   Fri Apr 27 04:32:34 2001
@@ -644,6 +644,7 @@
        struct page * page;
        int maxscan = nr_active_pages >> priority;
        int page_active = 0;
+       int start_count = count;

        /*
         * If no count was specified, we do background page aging.
@@ -725,7 +726,7 @@
        }
        spin_unlock(&pagemap_lru_lock);

-       return count;
+       return (start_count - count);
 }

 /*





Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVCKStv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVCKStv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVCKSnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:43:40 -0500
Received: from mailfe10.swip.net ([212.247.155.33]:11737 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261246AbVCKSXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:23:45 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: Strange memory leak in 2.6.x
From: Alexander Nyberg <alexn@dsv.su.se>
To: Tobias Hennerich <Tobias@Hennerich.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050311183207.A22397@bart.hennerich.de>
References: <20050308133735.A13586@bart.hennerich.de>
	 <20050308173811.0cd767c3.akpm@osdl.org>
	 <20050309102740.D3382@bart.hennerich.de>
	 <20050311183207.A22397@bart.hennerich.de>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 19:23:40 +0100
Message-Id: <1110565420.2501.12.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Please grab 2.6.11, apply the below patch, set CONFIG_PAGE_OWNER and follow
> > > the below instructions.
> > 
> > thank you for you mails. We installed the patch from Alex on a test-system
> > last night and will switch it to the production machine this evening. The
> > problem will start after 48-72 hours, so we hope to send feedback
> > on friday.
> 
> Ok, we had another crash this morning after an uptime of only 36
> hours 8-(.
> 
> No oom-killer this time, but we got a very high load (>40) in the
> end. Our cron-job which starts the page_owner-sort every 10 minutes
> didn't return the last 4 times.
> 
> The new 2.6.11-kernel changed the graphs a little bit - values for
> 'MemTree' are much higher, but values for 'Cached' and 'Buffered' are
> still very low.
> 
> Here the graph for the last week:
> 
>   http://download.hennerich.de/memory-leak2.png
> 
> (the left part is the same like our first graph last week
> http://download.hennerich.de/memory-leak.png, the weekend is well visible)
> 
> Detailed view of the last 40 hours:
> 
>   http://download.hennerich.de/memory-leak3.png
> 
> Some output of the page_owner-sort:
> 
>
>   http://download.hennerich.de/page_owner_sorted_20050311_0820.bz2

Yikes something isn't right with these backtraces that page_owner is
showing. Even without frame pointers it shouldn't be this noisy.

I'm afraid I'm going to need to ask for more help, could you please
select CONFIG_FRAME_POINTER under 
Kernel hacking => "Compile the kernel with frame pointers"

And when that kernel is booted, could you directly send me the output
of /proc/page_owner (sort or unsorted) so that I can see if something is
wrong with the data it's producing (just to be sure).

If it works better with CONFIG_FRAME_POINTER, i'm also going to have to
ask you to do another one of these runs that you just did.

Thanks
Alexander


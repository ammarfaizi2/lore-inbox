Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130313AbRBMGSm>; Tue, 13 Feb 2001 01:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130437AbRBMGSd>; Tue, 13 Feb 2001 01:18:33 -0500
Received: from www.wen-online.de ([212.223.88.39]:32778 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130313AbRBMGSY>;
	Tue, 13 Feb 2001 01:18:24 -0500
Date: Tue, 13 Feb 2001 07:17:53 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.LNX.4.21.0102121852530.29727-100000@freak.distro.conectiva>
Message-ID: <Pine.Linu.4.10.10102130649110.324-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Marcelo Tosatti wrote:

> On Sun, 11 Feb 2001, Mike Galbraith wrote:
> 
> > On Sun, 11 Feb 2001, Rik van Riel wrote:
> > 
> > > On Sun, 11 Feb 2001, Mike Galbraith wrote:
> > > > On Sun, 11 Feb 2001, Mike Galbraith wrote:
> > > > 
> > > > > Something else I see while watching it run:  MUCH more swapout than
> > > > > swapin.  Does that mean we're sending pages to swap only to find out
> > > > > that we never need them again?
> > > > 
> > > > (numbers might be more descriptive)
> > > > 
> > > > user  :       0:07:21.70  54.3%  page in :   142613
> > > > nice  :       0:00:00.00   0.0%  page out:   155454
> > > > system:       0:03:40.63  27.1%  swap in :    56334
> > > > idle  :       0:02:30.50  18.5%  swap out:   149872
> > > > uptime:       0:13:32.83         context :   519726
> > > 
> > > Indeed, in this case we send a lot more pages to swap
> > > than we read back in from swap, this means that the
> > > data is still sitting in swap space and was never needed
> > > again.
> > 
> > But it looks and feels (box is I/O hyper-saturated) like
> > it wrote it all to disk.
> > 
> > (btw, ac5 does more disk read.. ie the reduced cache size
> > of earlier kernels under heavy pressure does have it's price
> > with this workload.. quite visible in agregates.  looks to
> > be much cheaper than swap though.. for this workload)
> 
> Mike,
> 
> Could you please try the attached patch on top of latest Rik's patch?

Sure thing.. (few minutes later) no change.

	-Mike

P.S.

(said I'd try other loads...)

I tried a different workload yesterday (only one because it took
the entire day to finish).  Glimpseindexing my webserver test area
played well.  As it was running, all of it's growth was pushed to
swap (very slow trickle for some hours).  I figured it would get
beaten up when it started actually using the dataset it was building,
but the way it used it, sending it to swap was perfect.  When it
started using, it paged in a small burst and then used this data
combined with a truckload of I/O (actual database building bit).
Since there were hours between dataset generation and subsequent
use, I had free use of about ~30 mb of pages for those hours.

Doing other things (like letting lynx webcrawl over my other box's
server area while it was running) were not even visible.. ie caused
no additional paging, so huge cache/buffers space (~100mb of 128mb)
was not plugging up the mana supply in any way.  What was in cache
_looked_ to be old cruft, and the system released these resources
just fine.  (so why won't it give up cache to gcc?  either the vm
doesn't like gcc, or I flat don't understand page aging yet. nod;)

Very boring test session.  I hope the results mean more to you than
they do to me ;-)


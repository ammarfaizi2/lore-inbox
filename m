Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284002AbRLAIOv>; Sat, 1 Dec 2001 03:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284001AbRLAIOl>; Sat, 1 Dec 2001 03:14:41 -0500
Received: from www.wen-online.de ([212.223.88.39]:9484 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S284002AbRLAIOe>;
	Sat, 1 Dec 2001 03:14:34 -0500
Date: Sat, 1 Dec 2001 09:15:39 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Andrew Morton <akpm@zip.com.au>
cc: war <war@starband.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Is it normal for freezing while...
In-Reply-To: <3C0875DA.A54BC89E@zip.com.au>
Message-ID: <Pine.LNX.4.33.0112010908180.313-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Andrew Morton wrote:

> war wrote:
> >
> > Wow, responsiveness is wonderful with these patches.
>
> yup.  Thanks for testing...
>
> > Will they make it into 2.4.17, (ie: I've seen the -pre2 changelog, did
> > you incorporate them into -pre2)?
> > Even throughout the entire dd, it remained responsive
> > (mouse/cursor/network/etc).
>
> Well, this is a stable kernel, and the patch does adversely
> affect overall throughput.
>
> There are two changes to the elevator in that patch.  One
> is a modest speedup for all workloads which, frankly, I'm
> inclined to drop.   The other is the part which gives the
> improved responsiveness.
>
> Being a cautious chap, I think I'll submit that patch, with
> the default setting to "off", so there is no change to default
> kernel behaviour.   Then people can run `elvtune -b' to enable it.

I confirmed that this works just fine for my test load.

2.5.1-pre1+vm-fixes+elevator+mini-ll+elvtune -b ~random
real    7m48.999s
user    6m41.020s
sys     0m30.130s

user  :       0:06:47.59  73.0%  page in :   669883
nice  :       0:00:00.00   0.0%  page out:   636094
system:       0:00:48.41   8.7%  swap in :   143339
idle  :       0:01:42.63  18.4%  swap out:   154398

-----------------previous-results------------------
2.5.1-pre1
real    7m54.873s
user    6m41.070s
sys     0m30.170s

user  :       0:06:47.35  72.6%  page in :   661891
nice  :       0:00:00.00   0.0%  page out:   708836
system:       0:00:47.42   8.5%  swap in :   140234
idle  :       0:01:46.26  18.9%  swap out:   172775

2.5.1-pre1+vm-fixes
real    7m48.438s
user    6m41.070s
sys     0m29.570s

user  :       0:06:47.89  74.9%  page in :   666952
nice  :       0:00:00.00   0.0%  page out:   621296
system:       0:00:47.70   8.8%  swap in :   142391
idle  :       0:01:28.94  16.3%  swap out:   150721


2.5.1-pre1+vm-fixes+elevator
real    8m13.386s
user    6m38.330s
sys     0m31.680s

user  :       0:06:45.24  70.3%  page in :   596724
nice  :       0:00:00.00   0.0%  page out:   574456
system:       0:00:47.79   8.3%  swap in :   123507
idle  :       0:02:03.64  21.4%  swap out:   138675

2.5.1-pre1+vm-fixes+elevator+mini-ll
real    8m12.437s
user    6m38.860s
sys     0m31.680s

user  :       0:06:45.90  71.0%  page in :   604385
nice  :       0:00:00.00   0.0%  page out:   572588
system:       0:00:47.50   8.3%  swap in :   126731
idle  :       0:01:58.05  20.7%  swap out:   138055



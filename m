Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267778AbTBGKQv>; Fri, 7 Feb 2003 05:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267780AbTBGKQv>; Fri, 7 Feb 2003 05:16:51 -0500
Received: from mail009.syd.optusnet.com.au ([210.49.20.137]:14021 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S267778AbTBGKQs>; Fri, 7 Feb 2003 05:16:48 -0500
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.59-mm8 with contest
Date: Fri, 7 Feb 2003 21:26:20 +1100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200302052221.55663.conman@kolivas.net> <200302061908.32848.conman@kolivas.net> <20030207002202.5066e9c2.akpm@digeo.com>
In-Reply-To: <20030207002202.5066e9c2.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302072126.20826.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003 07:22 pm, Andrew Morton wrote:
> Con Kolivas <conman@kolivas.net> wrote:
> > On Thu, 6 Feb 2003 07:37 am, Andrew Morton wrote:
> > > Con Kolivas wrote:
> > > > ..
> > > >
> > > > This seems to be creeping up to the same as 2.5.59
> > > > ...
> > > > and this seems to be taking significantly longer
> > > > ...
> > > > And this load which normally changes little has significantly
> > > > different results.
> > >
> > > There were no I/O scheduler changes between -mm7 and -mm8.  I
> > > demand a recount!
> >
> > Repeated mm7 and mm8.
> > Recount-One for Martin, two for Martin. Same results; not the i/o
> > scheduler responsible for the changes, but I have a sneaking suspicion
> > another scheduler may be.
>
> Not sure.
>
> With contest 0.60, io_load, ext3, with the scheduler changes:
>
> Finished compiling kernel: elapsed: 161 user: 181 system: 16
> Finished io_load: elapsed: 162 user: 0 system: 17 loads: 9
> Finished compiling kernel: elapsed: 155 user: 179 system: 15
> Finished io_load: elapsed: 155 user: 0 system: 17 loads: 9
> Finished compiling kernel: elapsed: 166 user: 180 system: 15
> Finished io_load: elapsed: 166 user: 0 system: 18 loads: 10
>

average of 162/108 (io_load over no_load) prolongs it 50% for one process 
(disk writing) when eight processes are running (kernel compile)
on my uniprocessor results it's 92% prolongation for one v four

>
> With the CPU scheduler changes backed out:
>
> Finished compiling kernel: elapsed: 137 user: 181 system: 14
> Finished io_load: elapsed: 138 user: 0 system: 9 loads: 5
> Finished compiling kernel: elapsed: 142 user: 181 system: 14
> Finished io_load: elapsed: 142 user: 0 system: 9 loads: 5
> Finished compiling kernel: elapsed: 133 user: 181 system: 15
> Finished io_load: elapsed: 133 user: 0 system: 12 loads: 7
>
> So there's some diminution there, not a lot.

average of 133/108 prolongs it 27% for one process when eight processes are 
running.
on my results it's 44% prolongation

> With no_load:
>
> Finished compiling kernel: elapsed: 108 user: 179 system: 12
> Finished no_load: elapsed: 108 user: 7 system: 12 loads: 0
> Finished compiling kernel: elapsed: 107 user: 179 system: 13
> Finished no_load: elapsed: 107 user: 7 system: 12 loads: 0
> Finished compiling kernel: elapsed: 110 user: 178 system: 12
> Finished no_load: elapsed: 110 user: 8 system: 14 loads: 0
>
>
> It's very good either way.  Probably with the scheduler changes we're
> hitting a better balance.

I would have thought that the one disk write heavy process is getting more 
than the lion's share with the new scheduler changes, and the mm7 results 
were fairer?

Con

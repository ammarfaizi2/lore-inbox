Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267731AbTBGILr>; Fri, 7 Feb 2003 03:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbTBGILr>; Fri, 7 Feb 2003 03:11:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:49388 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267731AbTBGILp>;
	Fri, 7 Feb 2003 03:11:45 -0500
Date: Fri, 7 Feb 2003 00:22:02 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.59-mm8 with contest
Message-Id: <20030207002202.5066e9c2.akpm@digeo.com>
In-Reply-To: <200302061908.32848.conman@kolivas.net>
References: <200302052221.55663.conman@kolivas.net>
	<3E417624.2762A635@digeo.com>
	<200302061908.32848.conman@kolivas.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2003 08:21:17.0512 (UTC) FILETIME=[E30C1C80:01C2CE81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <conman@kolivas.net> wrote:
>
> On Thu, 6 Feb 2003 07:37 am, Andrew Morton wrote:
> > Con Kolivas wrote:
> > > ..
> > >
> > > This seems to be creeping up to the same as 2.5.59
> > > ...
> > > and this seems to be taking significantly longer
> > > ...
> > > And this load which normally changes little has significantly different
> > > results.
> >
> > There were no I/O scheduler changes between -mm7 and -mm8.  I
> > demand a recount!
> 
> Repeated mm7 and mm8. 
> Recount-One for Martin, two for Martin. Same results; not the i/o scheduler 
> responsible for the changes, but I have a sneaking suspicion another 
> scheduler may be.

Not sure. 

With contest 0.60, io_load, ext3, with the scheduler changes:

Finished compiling kernel: elapsed: 161 user: 181 system: 16
Finished io_load: elapsed: 162 user: 0 system: 17 loads: 9
Finished compiling kernel: elapsed: 155 user: 179 system: 15
Finished io_load: elapsed: 155 user: 0 system: 17 loads: 9
Finished compiling kernel: elapsed: 166 user: 180 system: 15
Finished io_load: elapsed: 166 user: 0 system: 18 loads: 10


With the CPU scheduler changes backed out:

Finished compiling kernel: elapsed: 137 user: 181 system: 14
Finished io_load: elapsed: 138 user: 0 system: 9 loads: 5
Finished compiling kernel: elapsed: 142 user: 181 system: 14
Finished io_load: elapsed: 142 user: 0 system: 9 loads: 5
Finished compiling kernel: elapsed: 133 user: 181 system: 15
Finished io_load: elapsed: 133 user: 0 system: 12 loads: 7

So there's some diminution there, not a lot.


With no_load:

Finished compiling kernel: elapsed: 108 user: 179 system: 12
Finished no_load: elapsed: 108 user: 7 system: 12 loads: 0
Finished compiling kernel: elapsed: 107 user: 179 system: 13
Finished no_load: elapsed: 107 user: 7 system: 12 loads: 0
Finished compiling kernel: elapsed: 110 user: 178 system: 12
Finished no_load: elapsed: 110 user: 8 system: 14 loads: 0


It's very good either way.  Probably with the scheduler changes we're
hitting a better balance.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSKINdj>; Sat, 9 Nov 2002 08:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbSKINdj>; Sat, 9 Nov 2002 08:33:39 -0500
Received: from [198.149.18.6] ([198.149.18.6]:53913 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265099AbSKINdi>;
	Sat, 9 Nov 2002 08:33:38 -0500
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
From: Stephen Lord <lord@sgi.com>
To: Con Kolivas <conman@kolivas.net>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <200211100009.55844.conman@kolivas.net>
References: <200211091300.32127.conman@kolivas.net>
	<200211091612.08718.conman@kolivas.net> <20021109112135.GB31134@suse.de> 
	<200211100009.55844.conman@kolivas.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Nov 2002 07:35:04 -0600
Message-Id: <1036848906.1061.17.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-09 at 07:09, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> >On Sat, Nov 09 2002, Con Kolivas wrote:
> >> >You're showing a big shift in behaviour between 2.4.19 and 2.4.20-rc1.
> >> >Maybe it doesn't translate to worsened interactivity.  Needs more
> >> >testing and anaysis.
> >>
> >> Sounds fair enough. My resources are exhausted though. Someone else have
> >> any thoughts?
> >
> >Try setting lower elevator passover values. Something ala
> >
> ># elvtune -r 64 /dev/hda
> >
> >(or whatever your drive is)
> 
> Heres some more data:
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
> 2420rc1r64 [3]          575.0   12      43      10      8.05
> 
> That's it then. Should I run a family of different values and if so over what 
> range?
> 


There is more going on than this, XFS suffered a major slowdown in some
metadata write only benchmarks - the file create/delete phase of 
bonnie++. Now thats a single app only doing writes. Slowdown on the
order of 500% to 600%. Since we did not follow the pre kernels in
2.4.20 we do not really know when it was introduced and there is
a possibility XFS itself has not followed some api change.

Steve




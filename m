Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbTBOLxL>; Sat, 15 Feb 2003 06:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbTBOLxL>; Sat, 15 Feb 2003 06:53:11 -0500
Received: from pop.gmx.net ([213.165.64.20]:56153 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261600AbTBOLxI>;
	Sat, 15 Feb 2003 06:53:08 -0500
Message-Id: <5.1.1.6.2.20030215130207.00ccc338@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sat, 15 Feb 2003 13:07:43 +0100
To: Rik van Riel <riel@imladris.surriel.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] CFQ scheduler, #2
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50L.0302150947570.20371-100000@imladris.surriel
 .com>
References: <5.1.1.6.2.20030215123533.00cd3e70@pop.gmx.net>
 <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net>
 <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net>
 <5.1.1.6.2.20030215123533.00cd3e70@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:49 AM 2/15/2003 -0200, Rik van Riel wrote:
>On Sat, 15 Feb 2003, Mike Galbraith wrote:
>
> > >Judging from your log, it ends up stalling kswapd and
> > >dramatically increases the number of times that normal
> > >processes need to go into the pageout code.
> > >
> > >If this provides an anti-thrashing benefit, something's
> > >wrong with the VM in 2.5 ;)
> >
> > Which number are you looking at?
>
>pgscan             2751953        5328260  <== ? hmm
>
>kswapd_steal        380282         522126
>pageoutrun            1107           1956
>allocstall            3472           1238
>
>- we scan far less pages
>- kswapd reclaims less pages
>- we go into the pageout code less often
>- allocations stall more often for a lack of free memory

I would interpret that differently.  I would say we scan less because we 
don't need to scan as much, kswapd reclaims less for the same reason, and 
ditto for pageout ;-)  The reduction in scans does seem _way_ high though...

wrt allocstall, I bet if I do a few runs, I'll see mucho variance there 
(could be wrong.. hunch)

         -Mke


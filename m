Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132514AbRDQMYP>; Tue, 17 Apr 2001 08:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132517AbRDQMYF>; Tue, 17 Apr 2001 08:24:05 -0400
Received: from iris.mc.com ([192.233.16.119]:42988 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S132514AbRDQMX5>;
	Tue, 17 Apr 2001 08:23:57 -0400
From: Mark Salisbury <mbs@mc.com>
To: george anzinger <george@mvista.com>, Mark Salisbury <gonar@mediaone.net>
Subject: Re: No 100 HZ timer!
Date: Tue, 17 Apr 2001 08:12:11 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Ben Greear <greearb@candelatech.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <001801c0c6d1$0528d340$6501a8c0@gonar.com> <3ADB9245.43054124@mvista.com>
In-Reply-To: <3ADB9245.43054124@mvista.com>
MIME-Version: 1.0
Message-Id: <01041708124126.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001, you wrote:
> Mark Salisbury wrote:
> > 
> > > Given a system speed, there is a repeating timer rate which will consume
> > > 100% of the system in handling the timer interrupts.  An attempt will
> > > be made to detect this rate and adjust the timer to prevent system
> > > lockup.  This adjustment will look like timer overruns to the user
> > > (i.e. we will take a percent of the interrupts and record the untaken
> > > interrupts as overruns)
> > 
> > just at first blush, there are some things in general but I need to read
> > this again and more closely....
> > 
> > but, with POSIX timers, there is a nifty little restriction/protection built
> > into the spec regarding the re-insertion of short interval repeating timers.
> > that is: a repeating timer will not be re-inserted until AFTER the
> > associated signal handler has been handled.
> 
> Actually what it says is: "Only a single signal shall be queued to the
> process for a given timer at any point in time.  When a timer for which
> a signal is still pending expires, no signal shall be queued, and a
> timer overrun shall occur."
> 
> It then goes on to talk about the overrun count and how it is to be
> managed.
> 
I guess I was confusing what the spec said with the way in which I chose to
comply with the spec.  I calculate overruns (I know when a timer went off, and
how many of its intervals have passed since it went off by by 
time_since_expire/interval) and don't reinsert until return from the signal
handler.  

this prevents a flood of high frequency interrupts inherently and allows
processing of the signal handlers to proceed cleanly.

-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/


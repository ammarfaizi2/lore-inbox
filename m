Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbTLaQeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 11:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbTLaQeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 11:34:09 -0500
Received: from mail.aei.ca ([206.123.6.14]:18133 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S265205AbTLaQeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 11:34:01 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches (BK consistency checks)
Date: Wed, 31 Dec 2003 11:33:58 -0500
User-Agent: KMail/1.5.93
Cc: Andy Isaacson <adi@hexapodia.org>
References: <20030906125136.A9266@infomag.infomag.iguana.be> <20031230195632.GB6992@bounceswoosh.org> <20031230141655.A30003@hexapodia.org>
In-Reply-To: <20031230141655.A30003@hexapodia.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312311133.58684.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 30, 2003 03:16 pm, Andy Isaacson wrote:
> On Tue, Dec 30, 2003 at 12:56:32PM -0700, Eric D. Mudama wrote:
> > On Tue, Dec 30 at 13:13, Andy Isaacson wrote:
> > >On Tue, Dec 30, 2003 at 08:36:15AM -0500, Ed Tomlinson wrote:
> > >The consistency check definitely should not take 15 minutes.  It should
> > >be (much) less than 30 seconds.  What is the hardware you're running on?
> > >
> > >I'm running on an Athlon 2 GHz (XP 2400+) with 512MB and a 7200RPM IDE
> > >disk, and I can do a complete clone (with full data copy and consistency
> > >check) of the 2.4 tree in 1:40.  That was with cold caches; with the
> > >sfile copies and "checkout:get", a half-gig isn't enough to cache
> > >everything.  The consistency check is about 19 seconds (bk -r check
> > > -acv).
> >
> > For what it is worth:
> >
> > AMD Duron 950MHz, 768MB RAM
> > 7200RPM 80GB Quantum Viper IDE drive, 26% full
> >
> > phat-penguin:~/src/linux-2.5> time bk -r check -acv
> > 100% |=================================================================|
> > OK 42.710u 5.770s 2:04.63 38.8%    0+0k 0+0io 74078pf+0w
> >
> > over 2 minutes of wall time, 42 seconds of "user" time... (if I'm reading
> > it right), without primed disk caches.
> >
> > The 2nd run, half a minute later:
> >
> > phat-penguin:~/src/linux-2.5> time bk -r check -acv
> > 100% |=================================================================|
> > OK 41.900u 3.080s 0:45.53 98.7%    0+0k 0+0io 74078pf+0w
> >
> >
> > ...would appear to show that BK's checksumming, on my system, is
> > constrained near 41 seconds of calculation time, and the difference
> > between the user and the wall-clock time is basically time spent
> > waiting for the disk to do all its reads.
> >
> >
> > I guess in that case, it'd be interesting to see what the user and
> > wall times were for the original poster who reported a 15+ minute
> > integrity check.
>
> That's basically right, except that if you don't have enough memory to
> keep bk's working set in memory, then you're paging and performance
> starts to suck.
>
> I didn't realize that the cpu-bound portion of the check would scale so
> closely with CPU speed, but it looks like the scaling is almost dead-on;
> 18.4/41.9 = .439
> 950/2000  = .475
>
> So I was wrong to say "less than 30 seconds".  "If you have a fast CPU
> and enough memory", I guess.  But the memory matters a lot more than the
> CPU.

Here are the numbers from my box:

oscar% cd /usr/src/linux
oscar% time bk -r check -acv
100% |=================================================================| OK
bk -r check -acv  80.63s user 16.18s system 21% cpu 7:32.06 total

oscar% time bk clone -ql linux yy
bk clone -ql linux yy  77.57s user 23.49s system 17% cpu 9:50.51 total

Ed


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273608AbRIUQbc>; Fri, 21 Sep 2001 12:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273613AbRIUQbV>; Fri, 21 Sep 2001 12:31:21 -0400
Received: from zapfhahn.bone.twc.de ([193.158.34.194]:25616 "EHLO
	zapfhahn.bone.twc.de") by vger.kernel.org with ESMTP
	id <S273608AbRIUQbI>; Fri, 21 Sep 2001 12:31:08 -0400
Message-ID: <20010921181800.36609@space.twc.de>
Date: Fri, 21 Sep 2001 18:18:00 +0200
From: Stefan Westerfeld <stefan@space.twc.de>
To: Roger Larsson <roger.larsson@norran.net>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <Pine.LNX.4.30.0109201756400.20823-100000@waste.org> <200109210047.f8L0lkv26045@maile.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <200109210047.f8L0lkv26045@maile.telia.com>; from Roger Larsson on Fri, Sep 21, 2001 at 02:42:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi!

On Fri, Sep 21, 2001 at 02:42:56AM +0200, Roger Larsson wrote:
> > You might try stracing artsd to see if it hangs at a particular syscall.
> > Use -tt or -r for timestamps and pipe the output through tee (to a file on
> > your ramfs).
> 
> I tried playing a mp3 with noatun via artsd. Starting dbench 32 I get the
> same kind of dropouts - and no indication with my latency profiling patch =>
> no process with higher prio is waiting to run!
> 
> One of noatun or artsd is waiting for something else! (That is why I included
> Stefan Westerfeld... artsd)
> 
> I noticed very nice improvement then reniceing (all) artsd and noatun.
> (I did also change the buffer size in artsd down to 40 ms)
> 
> (This part most for Stefan...
> So I thought - lets try to run artsd with RT prio - changed the option
> HOW can it get RT prio when it is not suid? I guess it can not...
> 
> So I manually added suid bit - but then noatun could not connect with
> artsd... bug?, backed out the suid change... but is behaves as it works,
> could be that it has so short bursts that prio never get a chance to drop)

If you want to run artsd with RT prio, add suid root to artswrapper if it is
not already there - it should by default, but some distributors/packagers
don't get this right. If you start artsd via kcminit, check the realtime
checkbox, if you do manually, run artswrapper instead of artsd, i.e.

stefan@voyager:~/src/kdelibs/arts$ artswrapper -F10 -S4096
>> running as realtime process now (priority 50)

Artsd itself will not acquire RT prio, only artswrapper will. Noatun doesn't
contain time critical code, so there it doesn't matter.

   Cu... Stefan
-- 
  -* Stefan Westerfeld, stefan@space.twc.de (PGP!), Hamburg/Germany
     KDE Developer, project infos at http://space.twc.de/~stefan/kde *-         

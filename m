Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273242AbRIWDVj>; Sat, 22 Sep 2001 23:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273246AbRIWDV2>; Sat, 22 Sep 2001 23:21:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26350 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S273240AbRIWDVW>; Sat, 22 Sep 2001 23:21:22 -0400
Message-ID: <3BAD53AA.F35DF6C9@mvista.com>
Date: Sat, 22 Sep 2001 20:14:50 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: safemode <safemode@speakeasy.net>,
        "Dieter =?iso-8859-1?Q?N=FCtzel?=" <Dieter.Nuetzel@hamburg.de>,
        Oliver Xymoron <oxymoron@waste.org>, Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org>
		<3BAB614E.8600D074@mvista.com>
		<20010922211919Z272247-760+15646@vger.kernel.org> 
		<200109222341.f8MNfnG25152@zero.tech9.net> <1001213460.872.10.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Sat, 2001-09-22 at 19:40, safemode wrote:
> > ok. The preemption patch helps realtime applications in linux be a little
> > more close to realtime.  I understand that.  But your mp3 player shouldn't
> > need root permission or renicing or realtime priority flags to play mp3s.
> 
> It doesn't, it needs them to play with a dbench 32 running in the
> background.  This isn't nessecarily acceptable, either, but it is a
> difference.
> 
> Note one thing the preemption patch does is really make `realtime' apps
> accel.  Without it, regardless of the priority of the application, the
> app can be starved due to something in kernel mode.  Now it can't, and
> since said application is high priority, it will get the CPU when it
> wants it.
> 
> This is not to say the preemption patch is no good if you don't run
> stuff at realtime --  I don't (who uses nice, anyhow? :>), and I notice
> a difference.
> 
> > To
> > test how well the latency patches are working you should be running things
> > all at the same priority.  The main issue people are having with skipping
> > mp3s is not in the decoding of the mp3 or in the retrieving of the file, it's
> > in the playing in the soundcard.  That's being affected by dbench flooding
> > the system with irq requests.  I'm inclined to believe it's irq requests
> > because the _only_ time i have problems with mp3s (and i dont change priority
> > levels) is when A. i do a cdparanoia -Z -B "1-"    or dbench 32.   I bet if
> > someone did these tests on scsi hardware with the latency patch, they'd find
> > much better results than us users of ide devices.
> 
> The skips are really big to be irq requests, although perhaps you are
> right in that the handling of the irq (we disable preemption during
> irq_off, of course, but also during bottom half execution) is the
> problem.
> 
> However, I am more inclined to believe it is something else.  All these
> long held locks can indeed be the problem.
> 
> I am on an all UW2 SCSI system, and I have no major blips playing during
> a `dbench 16' (never ran 32).  However, many other users (Dieter, I
> believe) are on a SCSI system too.

Dieter, could you post your .config file?  It might have a clue or two.

George

> 
> > even i dont get any skips when i run the player at nice -n -20.   That
> > doesn't tell you much about the preemption patch though.  And it doesn't tell
> > you about performance when you dont give linux the chance to do what it does,
> >  multitask.  That's where the latency patch is directed at improving, i
> > think.
> 
> Agreed.
> 
> --
> Robert M. Love
> rml at ufl.edu
> rml at tech9.net

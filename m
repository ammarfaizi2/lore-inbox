Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272912AbRIWEGs>; Sun, 23 Sep 2001 00:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273256AbRIWEGi>; Sun, 23 Sep 2001 00:06:38 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:5350 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S272912AbRIWEGc>; Sun, 23 Sep 2001 00:06:32 -0400
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: george anzinger <george@mvista.com>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Sun, 23 Sep 2001 06:06:49 +0200
X-Mailer: KMail [version 1.3.1]
Cc: safemode <safemode@speakeasy.net>, Oliver Xymoron <oxymoron@waste.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org> <1001213460.872.10.camel@phantasy> <3BAD53AA.F35DF6C9@mvista.com>
In-Reply-To: <3BAD53AA.F35DF6C9@mvista.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DRK33893BC5MIORJ0E1P"
Message-Id: <20010923040635Z272912-760+15693@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DRK33893BC5MIORJ0E1P
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Am Sonntag, 23. September 2001 05:14 schrieb george anzinger:
> Robert Love wrote:
> > On Sat, 2001-09-22 at 19:40, safemode wrote:
> > > ok. The preemption patch helps realtime applications in linux be a
> > > little more close to realtime.  I understand that.  But your mp3 player
> > > shouldn't need root permission or renicing or realtime priority flags
> > > to play mp3s.
> >
> > It doesn't, it needs them to play with a dbench 32 running in the
> > background.  This isn't nessecarily acceptable, either, but it is a
> > difference.
> >
> > Note one thing the preemption patch does is really make `realtime' apps
> > accel.  Without it, regardless of the priority of the application, the
> > app can be starved due to something in kernel mode.  Now it can't, and
> > since said application is high priority, it will get the CPU when it
> > wants it.
> >
> > This is not to say the preemption patch is no good if you don't run
> > stuff at realtime --  I don't (who uses nice, anyhow? :>), and I notice
> > a difference.
> >
> > > To
> > > test how well the latency patches are working you should be running
> > > things all at the same priority.  The main issue people are having with
> > > skipping mp3s is not in the decoding of the mp3 or in the retrieving of
> > > the file, it's in the playing in the soundcard.  That's being affected
> > > by dbench flooding the system with irq requests.  I'm inclined to
> > > believe it's irq requests because the _only_ time i have problems with
> > > mp3s (and i dont change priority levels) is when A. i do a cdparanoia
> > > -Z -B "1-"    or dbench 32.   I bet if someone did these tests on scsi
> > > hardware with the latency patch, they'd find much better results than
> > > us users of ide devices.
> >
> > The skips are really big to be irq requests, although perhaps you are
> > right in that the handling of the irq (we disable preemption during
> > irq_off, of course, but also during bottom half execution) is the
> > problem.
> >
> > However, I am more inclined to believe it is something else.  All these
> > long held locks can indeed be the problem.
> >
> > I am on an all UW2 SCSI system, and I have no major blips playing during
> > a `dbench 16' (never ran 32).  However, many other users (Dieter, I
> > believe) are on a SCSI system too.
>
> Dieter, could you post your .config file?  It might have a clue or two.

Here it comes.

Good night ;-)

-Dieter

BTW I have very good results (not the hiccup) for 2.4.10-pre14 + ReiserFS 
journal.c-2-patch from Chris
--------------Boundary-00=_DRK33893BC5MIORJ0E1P
Content-Type: application/x-bzip2;
  name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.bz2"

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

--------------Boundary-00=_DRK33893BC5MIORJ0E1P--

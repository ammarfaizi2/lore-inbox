Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282492AbRLSJRN>; Wed, 19 Dec 2001 04:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283771AbRLSJRD>; Wed, 19 Dec 2001 04:17:03 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:28167 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S282492AbRLSJQ5>; Wed, 19 Dec 2001 04:16:57 -0500
Message-ID: <3C205B9A.8F8BFEC7@loewe-komp.de>
Date: Wed, 19 Dec 2001 10:19:22 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112181216341.1237-100000@admin> <Pine.LNX.4.33.0112180922500.2867-100000@penguin.transmeta.com> <20011218105459.X855@lynx.no> <3C1F8A9E.3050409@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford schrieb:
> 
> Andreas Dilger wrote:
> 
> > On Dec 18, 2001  09:27 -0800, Linus Torvalds wrote:
> >
> >>Maybe the best thing to do is to educate the people who write the sound
> >>apps for Linux (somebody was complaining about "esd" triggering this, for
> >>example).
> >>
> >
> > Yes, esd is an interrupt hog, it seems.  When reading this thread, I
> > checked, and sure enough I was getting 190 interrupts/sec on the
> > sound card while not playing any sound.  I killed esd (which I don't
> > use anyways), and interrupts went to 0/sec when not playing sound.
> > Still at 190/sec when using mpg123 on my ymfpci (Yamaha YMF744B DS-1S)
> > sound card.
> 
> Weel, evidently esd and artsd both do this (well, I assume esd does now, it
> didn't do this in the past).  Basically, they both transmit silence over the
> sound chip when nothing else is going on.  So even though you don't hear
> anything, the same sound output DMA is taking place.  That avoids things
> like nasty pops when you start up the sound hardware for a beep and that
> sort of thing.  It also maintains state where as dropping output entirely
> could result in things like module auto unloading and then reloading on the
> next beep, etc.  Personally, the interrupt count and overhead annoyed me
> enough that when I started hacking on the i810 sound driver one of my
> primary goals was to get overhead and interrupt count down.  I think I
> suceeded quite well.  On my current workstation:
> 
> Context switches per second not playing any sound: 8300 - 8800
> Context switches per second playing an MP3: 9200 - 9900
> Interrupts per second from sound device: 86
> %CPU used when not playing MP3: 0 - 3% (magicdev is a CPU pig once every 2
> seconds)
> %CPU used when playing MP3s: 0 - 4%
> 
> In any case, it might be worth the original poster's time in figuring out
> just how much of his lost CPU is because of playing sound and how much is
> actually caused by the windowing system and all the associated bloat that
> comes with it now a days.
> 

Do you really think 8000 context switches are sane?

pippin:/var/log # vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0 100728   4424 121572  27800   0   1     6     6   61    77  98   2   0
 2  0  0 100728   5448 121572  27800   0   0     0    68  112   811  93   7   0
 2  0  0 100728   5448 121572  27800   0   0     0     0  101   776  95   5   0
 3  0  0 100728   4928 121572  27800   0   0     0     0  101   794  92   8   0

having a load ~2.1 (2 seti@home)

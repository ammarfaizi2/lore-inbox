Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281843AbRK1Bbl>; Tue, 27 Nov 2001 20:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRK1Bbf>; Tue, 27 Nov 2001 20:31:35 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:5322 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S281843AbRK1BbW>; Tue, 27 Nov 2001 20:31:22 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrew Morton <andrewm@uow.edu.au>
Subject: RE:  Unresponiveness of 2.4.16
Date: Wed, 28 Nov 2001 02:31:16 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011128013129Z281843-17408+21534@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jens Axboe wrote:
> >
> > I agree that the current i/o scheduler has really bad interactive
> > performance -- at first sight your changes looks mostly like add-on
> > hacks though.
>
> Good hacks, or bad ones?

As I can "see" not so good.
I've tried "dbench 32" and playing an MP3 with Noatun (KDE-2.2.2) and  "saw" 
my reported hiccup since 2.4.7-ac4, as always.

Noatun stops after 9-10 seconds of the "dbench 32" run and then every few 
seconds, again and again. The hiccup take place more often but for shorter 
times then without your patch.

System was:

2.4.16 +
preempt +
lock-break-rml-2.4.16-1.patch +
all ReiserFS patches for 2.4.16

1 GHz Athlon II
MSI MS-6167 Rev 1.0B (AMD Irongate C4, without bypass)
640 MB PC100-2-2-2 SDRAM
U160 IBM 18 GB disk
AHA-2940 UW

> It keeps things localised.  It works.  It's tunable.  It's the best
> IO scheduler presently available.

Throughput was a little lower ;-)

Don't forget to tune max-readahead.
I've used 127 and that gave me 4 MB (at the end) to 6 MB (at the beginning of 
the disk) more transferrate.
Write caching is off per default on all of my disks and it didn't offer much 
gain with dbench and bonnie++.

> > Arjan's priority based scheme is more promising.
>
> If the IO priority becomes an attribute of the calling process
> then an approach like that has value.  For writes, the priority
> should be driven by VM pressure and it's probably simpler just
> to stick the priority into struct buffer_head -> struct request.
> For reads, the priority could just be scooped out of *current.

Yes, please. I think, too that we need IO priority even for "little" IO 
consuming (weak) RT tasks (MP3, DVD, etc).

> If we're not going to push the IO priority all the way down from
> userspace then you may as well keep the logic inside the elevator
> and just say reads-go-here and writes-go-there.
>
> But this has potential to turn into a great designfest.  Are
> we going to leave 2.4 as-is?  Please say no.  

I'll second that.

Thank you for your work, Andrew!

-Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

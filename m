Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbTCGUYM>; Fri, 7 Mar 2003 15:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbTCGUYL>; Fri, 7 Mar 2003 15:24:11 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:25473 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S261764AbTCGUYI>;
	Fri, 7 Mar 2003 15:24:08 -0500
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303071541300.12493-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303071541300.12493-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047069277.752.45.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Mar 2003 21:34:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 15:43, Ingo Molnar wrote:
> On Fri, 7 Mar 2003, Mike Galbraith wrote:
> 
> > >Spiffy :)  /Me thinks desktop users will like this patch a bunch.
> > 
> > (I can even play asteroids [fly little rocket ship around, shoot at and
> > ram space rocks] with make -j25 bzImage and some swapping [sucks when
> > you hit heavy swap of course, but quite playable as long as swap is
> > light])
> 
> cool! Could you please also play a bit with various WAKER_BONUS_RATIO
> values? If the default '0' value is the best-performing variant then i'll
> nuke it from the patch altogether.

Hi,

I've tested 2.5.64 + sched-2.5.64-B2 on an UP pIII 700 with 704MB ram,
here's my results...

General impression is that interactivity is good but it seems there's a
few cases that gets worse, sometimes a lot worse.

First the things that got better...

Xmms doesn't skip when switching tabs in galeon anymore during general
desktopusage (more on that below)
Earlier I had to change some schedulersettings to get it to stop
skipping.

And it was possible to watch a movie using mplayer while running a make
-j10 on a kerneltree, the playback wasn't 100% perfect but I'd say it
was ~90% , the jerkyness I saw wasn't very irritating. I tried the
window wiggle-test while the compile and movie was playing and it was
smooth and only added a little more jerkyness to the playback.


Some negative things:

Xmms could skip during the compile/movie playback, most notably one
rather long skip right after a song-change but sometimes in the middle
of a song as well, those skips were quite long as well, 2-3 seconds.

Another xmms related problem is that even without any load on the
machine the mousepointer gets jerky for 0.1-0.5 seconds right after
having used the mouse to search forward or backwards in a song. It gets
jerky at the moment you release the mousebutton.
Basically no change in the jerkyness even with a make -j10 and movie
playing.
 
The biggest problem is the fact that my windowmanager gets unresponsive
for ~30 seconds when I perform something that works fine with vanilla
2.4 and 2.5. I have two keybindings that execute 'aumix -v+3' and 
'aumix -v-3'. And if I hold one of those buttons down for say 2 seconds
then at first it seems like nothing is happening but then the volume
starts to inc-/decrease sloowly and the windowmanager (sawfish) is
unresponsive for ~30 seconds. With 2.4 or vanilla 2.5 the change in
volume is instant and I've never noticed that sawfish got unresponsive.
Sure holding the button down for 2 seconds at a repeatrate of 30/s will
cause a lot of aumix's to be executed but 30 seconds for 60 aumix's is
quite a long time. A few times it has been enough to just press one of
those keys a few times to get the exact same effect. It's as if sawfish
goes into a weird loop. All this might be a bug in sawfish...
This behaviour is the same with or without the compile/movie running.

Another problem is that the composer-window in evolution gets
unresponsive for 1-2 seconds if you hold down a key, and when it gets
responsive again it gets all the keypresses...

I've tried changing WAKER_BONUS_RATIO but I didn't see any diffrence.
At least it didn't help with the Xmms mouse-jerkyness or the
sawfish_goes_out_for_coffee_and_a_cigarette problem.

There, that was my impressions of 2 hours usage of the patch.

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

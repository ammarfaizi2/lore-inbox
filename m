Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291762AbSBHTby>; Fri, 8 Feb 2002 14:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291766AbSBHTbr>; Fri, 8 Feb 2002 14:31:47 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:61936 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S291762AbSBHTbg>; Fri, 8 Feb 2002 14:31:36 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] get_request starvation fix
Date: Fri, 8 Feb 2002 20:31:23 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jens Axboe <axboe@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020208193142Z291762-13996+19336@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08 2002, Andrew Morton wrote:
> Here's a patch which addresses the get_request starvation problem.

[snip]

> Also, you noted the other day that a LILO run *never* terminated when
> there was a dbench running.  This is in fact not due to request
> starvation.  It's due to livelock in invalidate_bdev(), which is called
> via ioctl(BLKFLSBUF) by LILO.  invalidate_bdev() will never terminate
> as long as another task is generating locked buffers against the
> device.
[snip]

Could this below related?
I get system looks through lilo (bzlilo) from time to time with all latest 
kernels + O(1) + -aa + preempt

Thanks,
	Dieter

> Re: [patch] O(1) scheduler, -J9
> Datum: Wed, 30 Jan 2002 17:36:21 +0100
> Von: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
> An: Ingo Molnar <mingo@elte.hu>
> Kopie: Robert Love <rml@tech9.net>, Oleg Drokin <green@namesys.com>
>
> On Wednesday, 30. January 2002 17:26, Dieter Nützel wrote:
> > On Wednesday, 30. January 2002 15:40, Ingo Molnar wrote:
> > > On Wed, 30 Jan 2002, Dieter [iso-8859-15] Nützel wrote:
> > > > As always running "nice +19 make -j40" in my HUGE C++ VTK tree in the
> > > > background ;-)
> > > >
> > > > The mouse feels a little bit sluggish after KMail start so I reniced X
> > > > to -10. [...]
> > >
> > > does this make X smooth? nice -10 is a good choice, it's not too low and
> > > not too high, i'm using that value myself.
> >
> > Yes, mostly.
> > In "normal operation mode" X at 0 is good.
> >
> > I only get some very little but noticeable unsmoothness with several KDE
> > apps running. It could be KDE it self.
> >
> > Latency degradation since -J4 stays. But that could be missing of some
> > lock-breaks.
> >
> > Robert's latest BKL stuff halved the numbers for the two
> > latencytest0.42-png graphic benches on 2.4.18-pre7 + patches.

> Addition:

> I am most worried about the occasional kernel hangs during make 
> bzlilo/bzImage. It appears during lilo (???). The new kernel (vmlinux) is 
> still be built in /usr/src/linux but together with "latest" *.o and
> .*.flags files broken due to ReiserFS transaction replay after reboot
> (normal behavior with a journaling FS but without full data journaling.
>
> Maybe a RACE between lilo vs sync?

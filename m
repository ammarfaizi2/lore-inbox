Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291775AbSBHTxg>; Fri, 8 Feb 2002 14:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291778AbSBHTx0>; Fri, 8 Feb 2002 14:53:26 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:13814 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S291775AbSBHTxO>; Fri, 8 Feb 2002 14:53:14 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] get_request starvation fix
Date: Fri, 8 Feb 2002 20:53:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jens Axboe <axboe@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200202081932.GAA05943@mangalore.zipworld.com.au> <3C642A90.751BB750@zip.com.au>
In-Reply-To: <3C642A90.751BB750@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020208195322Z291775-13996+19340@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 8. February 2002 20:44, Andrew Morton wrote:
> Dieter Nützel wrote:
> > On Fri, Feb 08 2002, Andrew Morton wrote:
> > > Here's a patch which addresses the get_request starvation problem.
> >
> > [snip]
> >
> > > Also, you noted the other day that a LILO run *never* terminated when
> > > there was a dbench running.  This is in fact not due to request
> > > starvation.  It's due to livelock in invalidate_bdev(), which is called
> > > via ioctl(BLKFLSBUF) by LILO.  invalidate_bdev() will never terminate
> > > as long as another task is generating locked buffers against the
> > > device.
> >
> > [snip]
> >
> > Could this below related?
> > I get system looks through lilo (bzlilo) from time to time with all
> > latest kernels + O(1) + -aa + preempt
>
> Depends what you mean by "system locks".

Hard lock up :-(

Nothing in the log files.
No SYSRQ works. Only reset. --- But ReiserFS works. Some few corrupted 
*.o.flag files and most of the time a broken /usr/src/vmlinux or freshly 
/boot/vmlinuz file.

> The invalidate_bdev() problem won't lock the machine.

I see.

> In other words: if you run dbench, then lilo, lilo will not complete
> until after dbench terminates.

dbench wasn't run before
Only several "sync" commands (by hand) during kernel build helps.

> If you're seeing actual have-to-hit-reset lockups then that'll
> be due to something quite different.

Sadly, yes.

Thanks,
	Dieter

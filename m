Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269206AbRH0Vkx>; Mon, 27 Aug 2001 17:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269184AbRH0Vko>; Mon, 27 Aug 2001 17:40:44 -0400
Received: from 20dyn24.com21.casema.net ([213.17.90.24]:31762 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S269206AbRH0Vkd>; Mon, 27 Aug 2001 17:40:33 -0400
Message-Id: <200108272140.XAA20798@cave.bitwizard.nl>
Subject: Re: memcpy to videoram eats too much CPU on ATI cards (cache trashing?)
In-Reply-To: <E15bRy4-0004Va-00@the-village.bc.nu> from Alan Cox at "Aug 27,
 2001 08:22:40 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 27 Aug 2001 23:40:44 +0200 (MEST)
CC: Peter Surda <shurdeek@panorama.sth.ac.at>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > cause any CPU load (or more precisely, non-measurable load). However, with
> > mach64 and r128, it DOES. I did some more research.
> 
> Makes sense
> 
> > memcpy-ing 380kB at 25fps takes about 5ms per frame and causes X to eat 1% cpu
> > time (time measurements were done by tsc)

1%? at 5ms/f * 25 f/s = 125 ms/ second. = 12% of your CPU. 

However, as the X server manages to finish doing what it has to do
before the next timer tick, it will almost never get a timer tick
accounted to it.

> > memcpy-ing 760kB at 25fps takes about 11ms per frame, but instead of eating
> > 2% CPU time, it eats 35% (yes, that's 35 times more)

So at 2.2 times as much CPU time, I'd expect around 27% real
usage. But instead of managing to miss the timer tick almost every
time, it is now managing to hit slightly more than average on the
timer ticks. Or it's using a little bit more than you measured.

By doing stuff that takes on the order of a timer tick, and to trigger
them off a timer event, means that CPU time measurements can become
highly inaccurate. 

If you buy CPUtime on a large unix computer, and have a tight
mainloop, you can measure the number of iterations you can do inside
your mainloop in 9ms. Then schedule an "usleep (1)" every time you hit
that many iterations. Cheap computing... ;-)

			Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

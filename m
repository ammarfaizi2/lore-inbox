Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbRHMBBU>; Sun, 12 Aug 2001 21:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269633AbRHMBBA>; Sun, 12 Aug 2001 21:01:00 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:39950 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267883AbRHMBAy>; Sun, 12 Aug 2001 21:00:54 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sun, 12 Aug 2001 18:00:34 -0700
Message-Id: <200108130100.f7D10YH07664@penguin.transmeta.com>
To: pgallen@randomlogic.com
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Newsgroups: linux.dev.kernel
In-Reply-To: <3B772126.F23DB1D7@randomlogic.com>
In-Reply-To: <20010812155520.A935@ulthar.internal.mclure.org> <Pine.LNX.4.33.0108121557060.2102-100000@penguin.transmeta.com> <20010812161544.A947@ulthar.internal.mclure.org>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B772126.F23DB1D7@randomlogic.com> you write:
>Call me dumb, but what was wrong with the SB Live! code in the 2.4.7
>trees? Mine works fine and has since I first installed RH 7.1 on this
>system. The only problem I had was when I compiled it into the kernel
>(instead of compiling as a module), sound would not work and I could not
>configure it with sndconfig.

Well, the fact that it didn't work when compiled into the kernel means
(for me), that it doesn't work at all.

Also, if you followed the other thread on the Tyan Thunder lockup,
you'll have noticed that it locked up under heavy PCI loads. At least on
that machine it stopped with the 2.4.8 driver.

Does the new driver not work for you? There seems to be a bug at close()
time, in that the driver uses "tasklet_unlock_wait()" instead of
"tasklet_kill()" to kill the tasklets, and that wouldn't work reliably.

Anything else you can find?

		Linus

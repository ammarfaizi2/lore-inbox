Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266960AbRGQThC>; Tue, 17 Jul 2001 15:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbRGQTgw>; Tue, 17 Jul 2001 15:36:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14720 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266960AbRGQTgp>; Tue, 17 Jul 2001 15:36:45 -0400
Date: Tue, 17 Jul 2001 15:36:24 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6 possible problem
In-Reply-To: <9j23d7$1qs$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.95.1010717153319.6035A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2001, Linus Torvalds wrote:

> In article <Pine.LNX.3.95.1010717103652.1430A-100000@chaos.analogic.com>,
> Richard B. Johnson <root@chaos.analogic.com> wrote:
> >
> >    ticks = 1 * HZ;        /* For 1 second */
> >    while((ticks = interruptible_sleep_on_timeout(&wqhead, ticks)) > 0)
> >                  ;
> 
> Don't do this.
> 
> Imagine what happens if a signal comes in and wakes you up? The signal
> will continue to be pending, which will make your "sleep loop" be a busy
> loop as you can never go to sleep interruptibly with a pending signal.
> 
> In short: if you have to wait for a certain time or for a certain event,
> you MUST NOT USE a interruptible sleep.
> 
> If it is ok to return early due to signals or similar (which is nice -
> you can allow people to kill the process), then you use an interruptible
> sleep, but then you mustn't have the above kind of loop.
> 
> 		Linus

Okay, then ../linux/drivers/net/8139too.c (line 2239) should be fixed
because that's where it came from.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



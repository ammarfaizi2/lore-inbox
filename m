Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132462AbRDDVC0>; Wed, 4 Apr 2001 17:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132473AbRDDVCR>; Wed, 4 Apr 2001 17:02:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15489 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132462AbRDDVCM>; Wed, 4 Apr 2001 17:02:12 -0400
Date: Wed, 4 Apr 2001 17:00:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Fremlin <chief@bandits.org>
cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: how to let all others run
In-Reply-To: <m2lmpgifww.fsf@boreas.yi.org.>
Message-ID: <Pine.LNX.3.95.1010404165539.4737A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Apr 2001, John Fremlin wrote:

> 
> Hi Oliver!
> 
>  Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de> writes:
> 
> > is there a way to let all other runable tasks run until they block
> > or return to user space, before the task wishing to do so is run
> > again ?
> 
> Are you trying to do this in kernel or something? From userspace you
> can use nice(2) then sched_yield(2), though I don't know if the linux
> implementations will guarrantee anything.
> 

I recommend using usleep(0) instead of sched_yield(). Last time I
checked, sched_yield() seemed to spin and eat CPU cycles, usleep(0)
always gives up the CPU.

Try:
	for(;;) usleep();

and 
	for(;;) sched_yield();

.. you'll see a quiet behavior under `top` for usleep(0), and over 80%
with sched_yield().


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272258AbSISSeI>; Thu, 19 Sep 2002 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272320AbSISSeI>; Thu, 19 Sep 2002 14:34:08 -0400
Received: from auscon.arc.nasa.gov ([143.232.69.76]:26240 "EHLO
	rudi.arc.nasa.gov") by vger.kernel.org with ESMTP
	id <S272258AbSISSeG>; Thu, 19 Sep 2002 14:34:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dan Christian <dchristian@mail.arc.nasa.gov>
Reply-To: dchristian@mail.arc.nasa.gov
Organization: NASA Ames Research Center
To: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.18 serial drops characters with 16654
Date: Thu, 19 Sep 2002 11:38:48 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE> <1032457132.27721.45.camel@irongate.swansea.linux.org.uk> <20020919190107.C11763@flint.arm.linux.org.uk>
In-Reply-To: <20020919190107.C11763@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209191138.48009.dchristian@mail.arc.nasa.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 September 2002 11:01, Russell King wrote:
> Hmm, looking at the tty stuff, I'd say its a distinct possibility.
>  Even more so since the flip buffer handler is put on tq_timer, which
> is subject to ksoftirqd.
>
>
> However, at the point when we hand data to the tty layer, we should
> have 2048 bytes left in the flip buffer before we really start soft
> overrunning (vs hardware overrunning.)  I notice that we don't make
> any attempt to report such an event to user space, even when user
> space wants to know about overruns.
>
>
> Christian - what baud rate are you running these uarts at?

I've reproduced the drops at very low baud rates.  I didn't take notes, 
but I think that I was getting the same sort of behavior at about 
19.2Kb as 115Kb.

It really doesn't look like a speed thing.  The CPU is >1Ghz and the CPU 
usages is always below 10%.   Since it works with a 16550 (interrupting 
every 16? bytes) and not on a 16654 (interrupting every 64? bytes), it 
doesn't seem like something is too slow.

-Dan

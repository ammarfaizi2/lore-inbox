Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292841AbSCRUih>; Mon, 18 Mar 2002 15:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292842AbSCRUi2>; Mon, 18 Mar 2002 15:38:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:32896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292841AbSCRUiX>; Mon, 18 Mar 2002 15:38:23 -0500
Date: Mon, 18 Mar 2002 15:38:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jt@hpl.hp.com
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Killing tasklet from interrupt
In-Reply-To: <20020318115313.A26490@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.3.95.1020318153650.29558B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Jean Tourrilhes wrote:

> 	Hi,
> 
> 	I'm trying to use tasklets and I've come across one problem. I
> need to kill a tasklet from a timer, and I wonder if it's legal.
> 
> 	Code :
> 	-> User close IrDA TSAP and goes away
> 		-> LSAP not clean, more work to do
> 			-> Schedule timer in one second
> 	-> Timer
> 		-> If LSAP clean and nothing to do
> 			-> Kill tasklet
> 			-> Destroy LSAP
> 		-> Else re-shedule timer
> 
> 	The tasklet is used in the Rx path, so may be scheduled after
> the user close the TSAP. The TSAP may interface to the socket code, to
> the TTY code, to the Ethernet code or the PPP code, so we are not even
> guaranteed that the TSAP closure is done from a user context (fun,
> fun, fun).
> 	To be fair, the timer API is much more versatile in that
> respect. What I think I need is a tasklet_try_kill()...
> 
> 	Regards,
> 
> 	Jean

You have the tasklet kill itself the next time it executes. Set some
flag so it knows it should give up its timer-slot and expire. The
interrupt sets the flag. It doesn't do anything else.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


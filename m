Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312519AbSCUV4L>; Thu, 21 Mar 2002 16:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312521AbSCUV4A>; Thu, 21 Mar 2002 16:56:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60800 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312519AbSCUVzm>; Thu, 21 Mar 2002 16:55:42 -0500
Date: Thu, 21 Mar 2002 16:56:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ivan Gurdiev <ivangurdiev@yahoo.com>
cc: Andy Carlson <naclos@andyc.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine stalls - transmit errors
In-Reply-To: <20020321204951.35236.qmail@web10103.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020321161201.3488A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, Ivan Gurdiev wrote:

> if ((intr_status & ~( IntrLinkChange | IntrStatsMax |
>  IntrTxAborted ))) {
>    if (debug > 1)
>    	printk(KERN_ERR "%s: Something Wicked happened!
> %4.4x.\n",dev->name, intr_status);
>  /* Recovery for other fault sources not known. */
>   writew(CmdTxDemand | np->chip_cmd, dev->base_addr +
> ChipCmd);
>         }
> 
> What's classified as "Something Wicked" ?
> 
> Mar 20 21:52:00 cobra kernel: eth0: Something Wicked 
> happened! 0008. 
> 
> This is tx abort isn't it?
> 
> Mar 20 21:51:59 cobra kernel: eth0: Something Wicked 
> happened! 001a. 
> 
> ...and this should be : tx underrun, tx abort, tx done
> 
> are those supposed to be logged as "Wicked"?
> Those interrupts are handled earlier aren't they? 
>         if (intr_status & (underflow | IntrTxAbort))
> 	...
> 	if (intr_status & IntrTxUnderrun) {
> 	...
> 
> 
> I'm quite ignorant of all this, but I'm trying to
> learn. I apologize if this is a stupid question.
> 

If there was a link-mode change (100-to-10-base, 1/2 to full duplex) OR
if the chip status overflowed (tx packets, rx, packets, errors, etc) OR
if the transmitter aborted (unplug when active, etc.) THEN
   reset and reprogram the chip (after telling you something wicked
   happened IF verbose debug is enabled). 

You can turn OFF verbose debug (set debug to 1) and you won't have
the message.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


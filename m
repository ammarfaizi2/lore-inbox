Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSF2RCU>; Sat, 29 Jun 2002 13:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSF2RCT>; Sat, 29 Jun 2002 13:02:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2459 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313508AbSF2RCS>;
	Sat, 29 Jun 2002 13:02:18 -0400
Date: Sat, 29 Jun 2002 10:04:34 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: <hurwitz@lanl.gov>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: zero-copy networking & a performance drop
Message-ID: <Pine.LNX.4.33.0206291000060.23706-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On sending data, we have all the information trusted, because we
> > checked that already, as the user sets it. With sendfile, we have
> > even trusted and mapped data (because we just paged it in before).
> > 
> > If we take this into account, rx MUST be always slower, or tx
> > isn't really optimized yet.
> 
> Indeed, the above does make sense. But, what about when the receive side
> is trustable, too. This is obviously not the normal case; but with
> quadrics I think that it is. Since quadrics is a shared memory
> architecture, with all of the processing taken care of on the cards, we
> should be able to reliably trust the receive side as much as the send
> side. Unless I'm misunderstanding your use of trust?

Perhaps a little bit - the work the rx processing has to do
involves determining the validity of the packet as well as
demultiplexing at each protocol stage..You will always
have to at least test for a valid packet, parse options, find
the recipients, etc. If you're saying you have offloaded
the tcp/ip protocol stack on the cards, thats a whole different 
issue. 

 
> If I am right on this, how much of an overhaul would it be to implement, 
> for instance, a NETIF_RX_TRUSTED flag in the net_device struct to force a 
> receive side fast path? I don't expect this to bring the receive side even 
> with the transmit side, but right now we (and I have heard the same from 
> others) are running at ~70% of the transmit side on the receive side, 
> which seems to leave a good margin for improvement. 

I'm no maintainer, but I would at least say whoa! Not sure if we
have a problem, not sure where the problems are, and not sure
if there are problems in determining whether there is a problem :)..

fer'nstance:
	- if the rx code path is say 1000 lines and the tx
	  stack length is 700 lines of code, then I'd expect
	  the tx time to be 70% of rx time. A difference
	  in the stack length is not a problem by itself,
	  given that they have different functions to perform?

	- in reality, there is no such clean concept,
	  right? rx processing sends acks, interrupts happen,
	  and a whole bunch of profiling and lockmeter
	  data can end up pretty misleading.. Do you
	  have pure unidirectional data transfer? What 
	  applications are you running? How are you
	  measuring things, where are you measuring things,
	  and what are the skewing factors? 

	- and I'm not even a benchmarking or performance person,
	  wait till you get done talking to them :)	 	
	  
	 
> This seems like it could be useful not just for the special case of 
> quadrics (and other shared mamory architectures)- if, for instance, cards 
> begin to do more TCP processing in hardware (or we modify the firmware to 
> do this for us, ala AceNIC), it would be nice to bypass it in the kernel. 
> This is, of course, a quick idea that's just popped into my head, and 
> probably is inherently impossible or foolish :)

Thats a question of is the stack modified to take advantage
of what the hardware can do, and, as I said above, thats a rather bigger 
and different issue. 

> --Gus

thanks,
Nivedita


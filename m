Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263084AbREaQlS>; Thu, 31 May 2001 12:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263102AbREaQlI>; Thu, 31 May 2001 12:41:08 -0400
Received: from gateway.sequent.com ([192.148.1.10]:22492 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S263084AbREaQkx>; Thu, 31 May 2001 12:40:53 -0400
From: Nivedita Singhvi <nivedita@sequent.com>
Message-Id: <200105311640.JAA24611@eng4.sequent.com>
Subject: Re: Abysmal RECV network performance
To: jw2357@hotmail.com (John William)
Date: Thu, 31 May 2001 09:40:44 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F57chplw8IfbyyOxmQp000170f7@hotmail.com> from "John William" at May 30, 2001 01:55:06 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >the Netgear FA311/2 (tulip). Found that the link lost
> >connectivity because of card lockups and transmit timeout
> >failures - and some of these were silent. However, I moved
> >to the 3C905C (3c59x driver) which behaved like a champ, and

> I'm a little confused here - do you mean the FA310TX ("tulip" driver) or the 
> FA311/2 ("natsemi" driver)? I have not had any connection problems with 
> either the FA310 or the FA311 cards. I haven't noticed any speed problems 
> with the FA311 card, but I haven't benchmarked it, either. The FA310 is so 
> horribly slow, I couldn't help but notice. Unfortunately, the same is true 
> of the 3cSOHO.

Sorry, meant to describe both, (natsemi and tulip, but latter
on older DEC chip). 

> I looked at tcpdump to try and figure it out, and it appeared that the P-90 
> was taking a very long time to ACK some packets. I am not a TCP/IP guru by 
> any stretch, but my guess at the time was that the packets that were taking 
> forever to get ACK'ed were the ones causing a framing error on the P-90, but 
> again, I'm not an expert.

> The only unusual stat is the framing errors. There are a lot of them under 
> heavy receive load. The machine will go for weeks without a single framing 
> error, but if I blast some netperf action at it (or FTP send to it, etc.) 
> then I get about 1/3 of the incoming packets (to the P-90) with framing 
> errors. I see no other errors at all except a TX overrun error (maybe 1 in 
> 100000 packets).

Tried to reproduce this problem last night on my machines
at home (kernel 2.4.4, 500MHz K7/400Mhz K6). Just doing FTP
and netperf tests, didnt see any significant variation between
rcv and tx sides. Admittedly different machines, and between
3C905C and a FA310TX (tulip). However, if the problem
was purely kernel protocol under load, it should have showed. 

Also, am not seeing significant frame errors - 1 in 10K,
definitely not seeing anything remotely like 30%. If 1/3
of your packets are being dropped with frame errs, you'll see
lots of retransmissions, horrible performance, no question. But
I would expect frame errors to be due to things like the
speed not being negotiated correctly(?), or if the board
isnt sitting quite right (true - thats the only experience
I remember of recv code path being error prone compared
to tx), but that should affect all the kernel versions you
ran on that host..

Am pretty clueless about media level issues, but it would
help to identify whats causing the framing errors. 

Not much help, I know..

thanks,
Nivedita

---
Nivedita Singhvi                        (503) 578-4580
Linux Technology Center                 nivedita@us.ibm.com
IBM Beaverton, OR                       nivedita@sequent.com

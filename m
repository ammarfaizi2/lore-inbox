Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291129AbSAaQHE>; Thu, 31 Jan 2002 11:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291128AbSAaQGy>; Thu, 31 Jan 2002 11:06:54 -0500
Received: from elin.scali.no ([62.70.89.10]:5893 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S291124AbSAaQGn>;
	Thu, 31 Jan 2002 11:06:43 -0500
Subject: Re: TCP/IP Speed
From: Terje Eggestad <terje.eggestad@scali.com>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020131091155.26514A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020131091155.26514A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 31 Jan 2002 17:06:40 +0100
Message-Id: <1012493200.21290.133.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 2002-01-31 kl. 16:26 skrev Richard B. Johnson:
> On 31 Jan 2002, Terje Eggestad wrote:
> 
> > Hmmm, 
> > 
> > I tend to use the rdtsc register to do these kind of measurements, 
> > but I get ~110 uS round trip with or without TCP_NDELAY
> >
> 
> AMD-SC520 ( 'i486 ) don't have such an instruction. Therefore benchmarks,
> which have to run 'everywhere' need to be generic.
> 

too bad... 

> > I get ~100uS wehen pinging with raw ethernet frames.
> 
> > 
> > PS: Intel 82557 Ethernet Pro 100 NIC's
> > 
> 
> Ping doesn't count. ICMP is handled in the kernel a few procedures
> removed from actual frame acquisition. It looks like the kernel
> takes the data I'm waiting for, hides it away for awhile, scheduling
> other tasks, then finally decides to wake me up, having been sleeping
> in read() for a whole millisecond. This is entirely unacceptable.
> 

Actually, my "ping" is even less than icmp. I open the ethX with family
= AF_PACKET, and provide the full 802 frame.

> Since this 1000 data-buffers-per-second limitation is independent of
> CPU speed and/or RAM speed, it seems to be imposed artificially by
> the network implementation. It may have something to do with additions
> to stop DOS or whatever. I need to turn it OFF.
> 

Hmmm, guess I haven't tried abutally sending 1000 writes.
If you send my you test program, I could try it on my HW's tomorrow.

 
> I have done setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &x sizeof(x));
>                       ... SOL_TCP, TCP_NODELAY...
> with int x = 1;, everywhere a socket is created. It seems like a
> no-op.
> 
> My sun uses SunOS 5.5.1, with GNU 'C' runtime libraries, gcc 2.7.2, and
> it doesn't display this problem. The speed is lower because it has only
> a 10-base network connection, but the Tx/Rx time is running around
> 250 to 300 microseconds, not the awful 1 millisecond.
> 
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbRGHRfe>; Sun, 8 Jul 2001 13:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbRGHRf0>; Sun, 8 Jul 2001 13:35:26 -0400
Received: from eschelon.gamesquad.net ([216.115.239.45]:31754 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S266936AbRGHRfW>; Sun, 8 Jul 2001 13:35:22 -0400
From: "Vibol Hou" <vhou@khmer.cc>
To: "Chris Wedgwood" <cw@f00f.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Vibol Hou" <vhou@khmer.cc>, "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Machine check exception? (2.4.6+SMP+VIA)
Date: Sun, 8 Jul 2001 10:32:49 -0700
Message-ID: <NDBBKKONDOBLNCIOPCGHIEKOIKAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <20010708192805.C26213@weta.f00f.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm,

First off, thanks for the direction Alan, Peter, and Chris.

So I've flipped through the Intel docs, and read up on the MCA for P2/3
processors.  I've decoded the info from the MC0_STATUS register that was
given to me in the Bank 1: b200000000000115 line.  The 0115 MCA code
indicates a DCACHEL1_RD error, so it seems the L1 cache is bad, though this
does not seem to be heat-related since lm_sensors indicate similar
temperature readings for both CPUs (within .3 degress celcius of each other
~30 dC).

That probably explains why the system hardlocked quickly each time there was
heavy I/O and processing with SMP mode enabled with the full 1GB memory in
it.  Only after removing one of the memory sticks did the system begin
spitting out OOPs and MCEs.

I also wonder, however, if this could be due to the 2nd processor not
getting enough voltage.  I don't know the S-SPEC of the processor, but I
think it's the same as the 1st.  However, the voltage reading for CPU 2 is
.05v lower at 1.65v.  Any processor gurus here?

Thanks,
Vibol

-----Original Message-----
From: Chris Wedgwood [mailto:cw@f00f.org]
Sent: Sunday, July 08, 2001 12:28 AM
To: Alan Cox
Cc: Vibol Hou; Linux-Kernel
Subject: Re: Machine check exception? (2.4.6+SMP+VIA)


On Sat, Jul 07, 2001 at 10:41:23PM +0100, Alan Cox wrote:

    It means your processor flagged a fault. The b2....115 number
    decodes to info about the fault cause if you grab the PIII manual.

    Stupid things like overheating. wrong voltages can also trigger it

Is there any reason why, with proper MCE checking for both K7 and PIII
we can't automatically off-line processors when they start doing bad
things?

Sure, its a pretty lousy thing to do, but if you buys you a few
minutes and allows userland to initiate some kind of remedy
(pager("HELP"); system("shutdown"); sort of thing)...

Also, I'm pretty sure I was seeing overheating problems or something
on a K7 at one point, but never saw MCE; I take it this code only
exists fully in -ac kernels? I looked in Linus' tree and couldn't see
anything.




  --cw


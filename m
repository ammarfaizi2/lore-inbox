Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312922AbSCZBwn>; Mon, 25 Mar 2002 20:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312921AbSCZBwf>; Mon, 25 Mar 2002 20:52:35 -0500
Received: from web10104.mail.yahoo.com ([216.136.130.54]:8203 "HELO
	web10104.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312918AbSCZBwZ>; Mon, 25 Mar 2002 20:52:25 -0500
Message-ID: <20020326015223.69972.qmail@web10104.mail.yahoo.com>
Date: Mon, 25 Mar 2002 17:52:23 -0800 (PST)
From: Ivan Gurdiev <ivangurdiev@yahoo.com>
Subject: Re: Via-Rhine stalls - transmit errors
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That patch was an attempt to fix failed transmission
> and it contains all sorts of junk. It worked for  
> Andy, but not for one of the others with that
problem
> (and that motherboard, a Dragon+ with on-board eth
> chip).
>
> You probably shouldn't use that patch at all ...

Ok, I'll follow your advice and start from scratch...
or the kernel driver that is :) Interestingly,
however,
I was able to somehow get consistent stall-free
transfers for a while using your patch and some other
fixes of my own...but then I changed things and was
unable to reproduce the same situation... This is
happening again with the kernel driver. Sometimes my
card works great, sometimes it works ok, and sometimes
it doesn't. I am losing faith in all hardware...
now I don't trust my Netgear card on the other side
either. The thing is, this Via-rhine card works fine
under Win 98 (I have a dual-boot) or under light load
(ping or ping flood). It only breaks under heavy
transmit.


> VIA has drivers for VT86c100A, the VT6102 and the 
> VT6105, available here:
> http://www.viaarena.com/?PageID=71

tried that one...it seemed to fix transmit when
initiated from my desktop computer, but it freezes
everything when I initiate the transmit in the same
direction from the laptop. 

....just like the time I decided to divide by 0
in the kernel :)

> There is also the Donald Becker driver at 
> http://www.scyld.com/

This one won't compile. Lots of errors.
Entire include files are missing.



> There is an explanation of common "something wicked"
> errors on
> http://www.scyld.com/network/ethercard.html...

> So if you trust the explanations of the errors it 

I do, the erorrs are correct. However for some of
those errors you can't even get the "something wicked"
message the way that the code is written.
Other errors are handled elsewhere. The whole
thing is complicated and may cause redundancies 
and problems. Error handling needs improvement.

> There were ideas on changed meaning
> of an interrupt bit (0x0200) and the "fix" for that 
> is probably causing
>this.

Isn't this your patch?
It adds a mii/underflow inerrupt switch scheme.

By the way,

/* Enable interrupts by setting the interrupt mask. */
 writew(IntrRxDone | IntrRxErr | IntrRxEmpty|
IntrRxOverflow| IntrRxDropp
ed|IntrTxDone | IntrTxAbort | IntrTxUnderrun |
IntrPCIErr | IntrStatsMax | IntrLinkChange |
IntrMIIChange, ioaddr + IntrEnable);


Where's IntrRxEarly? IntrRxNoBuf? IntrRxWakeUp?
IntrTxAborted? .... I added those to my version.


__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/

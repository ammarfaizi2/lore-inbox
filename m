Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTK2JNN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 04:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTK2JNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 04:13:13 -0500
Received: from smtp801.mail.ukl.yahoo.com ([217.12.12.138]:42164 "HELO
	smtp801.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263728AbTK2JNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 04:13:09 -0500
Message-ID: <3FC86318.2050205@sbcglobal.net>
Date: Sat, 29 Nov 2003 03:12:56 -0600
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5) Gecko/20031008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Goerzen <jgoerzen@complete.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise IDE controller crashes 2.4.22
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org> <3FC7A3D9.3070500@sbcglobal.net> <20031129012319.GD2069@complete.org>
In-Reply-To: <20031129012319.GD2069@complete.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Goerzen wrote:

>On Fri, Nov 28, 2003 at 01:36:57PM -0600, Wes Janzen wrote:
>  
>
>>I'd suspect some sort of PCI problem, especially since you're running a 
>>    
>>
>
>Do you happen to have a URL where I can read up on PCI problems with
>K6s?
>
Well, I know of the assorted problems with the KT133 & newer from VIA 
and SoundBlaster Live sound cards.  I think changing the latency greatly 
reduced the problems but didn't eradicate it completely, IIRC.  You can 
search on Google for "via soundblaster live" to get some more information.

I know when I posted to the list due to problems with the onboard IDE on 
my board, several people responded that they had problems with their VIA 
boards randomly corrupting data during PCI busmaster transfers.  That 
problem doesn't seem to afflict my board.  Most of those were on newer 
boards (KT/KX133) but some involved the MVP3 which both of us are 
running.  I compared notes with someone with the same motherboard 
revision who didn't have the problems I have, so perhaps some silicon or 
boards were defective in a way that was never detected by VIA or the 
board manufacturer respectively. 

Anyway, if VIA had problems with the later chipset I wouldn't be at all 
surprised if an older version suffered from similar defects.

>  Are the problems unique to Linux? 
>
These problems are not unique to Linux.  Windows configures PCI devices 
differently though and that could have an effect.

> Note that it's a K6-3, so it's
>not really first generation PCI.
>  
>
Well, it was a first-generation chipset in many regards ;-)  Seriously 
though, especially back then VIA was several notches below Intel when it 
came to product quality.  The K6 in any form was a bargain chip and the 
chipsets for it were targetting that market; I doubt they went through 
any qualification program remotely resembling those of Intel.  In other 
words, it may not be first generation for VIA but it wasn't top quality 
either.

I'm not bashing VIA, that's just the reality of it.  My system was flaky 
until I replaced the onboard IDE with the Promise cards.  It became 
solid when I replaced the 3dfx Banshee with an ATI 9000 Pro.  Still I 
don't expect to get the kind of performance out of the cards as I would 
if they were in a comparable PII system.  For example, I seriously doubt 
the 3COM diagnostics complain about PCI bus performance on an Intel system.

> ...
>
>Can you translate UDMA-2 into something like UDMA/133?  I'm having
>trouble mapping the two in my head (I'm not terribly familiar with IDE
>internals)
>
>  
>
UDMA-2 = UDMA/33

It's not really important, I'm just pointing out that if the drive 
stopped responding due to a communication problem between the drive and 
card, the drive would be reset and the system would become responsive 
even if it paused for several seconds.

I should also clarify that the drive communicated fine with the VIA IDE 
in UDMA-2, just not with the Promise controllers.  I have to back the 
drive down to UDMA-1 before writing data or it will reset and fallback 
to PIO.

> ...
>
>The other thing is that the drives hooked to the on-board IDE channels
>work fine.  I don't know if that is important; but I figured I'd mention
>it.
>
>  
>
It may not stress the PCI bus as much, it was designed specifically for 
the chipset, and it's attached to the PCI bus in a significantly 
different manner.  It's just that the fact that using PIO transfers 
implies a large reduction in the PCI bandwidth utilized by the card.  
That and my experience with card to drive communication failure only 
leaves some other cause.  Depending on the type of transfer, it's likely 
that the PCI bus is being completely saturated when bursting write data 
to the drive's cache or even a sustained write.  So going from a high 
PCI load to a lower PCI load solves the problem.

It's possible that the driver is doing something wrong, but I'm using a 
similar hardware configuration and not experiencing the problem.  Many 
more people are using the driver and card with a different board, also 
apparently without problems.  So, add the history of VIA and PCI 
problems and a PCI communication failure looks like a prime candidate.  
You'd be wise to run an extensive memory test though to eliminate that 
cause.  Other possible suspects would be the power supply or a hot cpu.

>>You might try putting the card in another slot too.  My cards are 
>>    
>>
>
>Hmm, I could give that a try.
>  
>
Could be a BIOS setting causing the problem too, but I don't know enough 
about the PCI bus to know which settings you'd want to adjust ;-)  If it 
was me, I'd try the PCI settings first though since my machine is so 
full of cards and cables.

Perhaps someone else can speak up and let us know if another misbehaving 
PCI device could be causing this problem?  For example when the drive is 
hogging the bus during a DMA transfer maybe another card could interrupt 
it and lock up the PCI bus; is it possible and if so, likely?  Maybe 
it's not the bandwidth but a long transfer that's the problem...?  I'd 
rather not try to dig up the PCI specs to answer this question (mainly 
because I don't have the time).

Good luck,
Wes

>Thanks,
>John
>  
>


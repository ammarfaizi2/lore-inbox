Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTLMFNi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 00:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTLMFNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 00:13:35 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:51216 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S263846AbTLMFNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 00:13:32 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: cbradney@zip.com.au
Subject: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Sat, 13 Dec 2003 15:16:51 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com,
       Ian Kumlien <pomac@vapor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312131516.51777.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
>> The thing that strikes me funny is that you get no crashes with the 
> > updated BIOS and Disconnect on, but without the updated BIOS we have 
> > to turn disconnect off with athcool or the patch? This makes me think 
> > that there is some voodoo going on in the BIOS update that they aren't 
> > saying, surprise surprise, or something is just slowing down the time 
> > it takes for it to crash. I say this because I have gone 5+ days 
> > without any of the patches from these threads, acpi apic lapic 
> > enabled, and CPU disconnect on as stated by athcool. This was with 
> > much stress testing, idle time, etc. One day I just ran a grep that I 
> > have done probably 30 times and boom, hang. 
 
>> Good luck, hope the BIOS is the trick, now off to see how I can get 
> > ASUS to put the C1 Disconnect in the next revision. 
 



>Yes, thats how it was for me.. I was the only one here saying "no 
> problems, la la la", then at about 5.25 days.. boom. Then the next day 
> it crashed twice. Hopefully you make some progress with ASUS.. (for the 
> A7N8X Deluxe as well as you mobo please :) ). 
 


>Ive been playing with hardware in the past few days (new quieter Zalman 
> PSU, and Zalman 7000 Cu fan etc) so no uptime to speak of here now. I 
> did compile KDE 3.2 beta 2 last night though.. 6 hours of solid 
> compilation.. no hassles. I have never turned off Disconnect either. 
 


>Thanks to all you guys who are working on this one. Seems to be getting 
> somewhere. 
 


>Craig 

I wonder about the "voodoo" because my apic ack delay patch was developed
without knowledge of the C1 disconnect bit and reports I have received so far
are that the hard lockups go away when using it independent of the state of the 
disconnect bit. Apparently the bit was on in my test systems. 

Ian Kumlien pointed out the linkage with the northbridge timing signals 
to the CPU to do with the connect disconnect handshake so I now wonder just how
programmable the nforce2 northbridge is? Is it a bit fpga'ish in that they may be
using the bios boot to alter the handshake timing enough to accomplish what
the ack delay does but like it should be - transparent to the OS?

Of course they -the makers- have access to knowledge we don't so it could be 
something completely different that they are doing!

In short I agree with the suggestion that the new bios options do more behind
the scenes than what the athcool and disconnect patches do. 

I am pretty sure that I read somewhere that when the epox boards 
were first released the epox 8rda bios started out with it (the disconnect bit) off
then the 8rga+ came out with it on by default? So back then people were wanting
to turn it on in the 8rda to lower their CPU temperature - now some want it off
in search of stability? Back then under win.... some experienced lockups depending
on which IDE driver was used and which state the bit was in!

Out of interest has anyone seen new disconnect bit options in the Pheonix bios or
only in the award bios?

Finally I have done some more work and found that the ack delay patch on my
system is about 13 apic timer counts, about half that required to write a byte 
directly outb(0x00, 0x378) to the printer port at 28 apic timer counts. 
So the ack delay is about twice as quick as writing a single EOI to the 8259 in
XTPIC mode provided the 8259 accesses are not souped up under the hood.
In other words whilst it is a timing hit it is not much of one and it won't be
needed once this is all fixed by the respective manufacturers -lets hope they
can do it on the hardware we have already bought.

Regards
Ross Dickson




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVALXRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVALXRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVALXNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:13:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:3548 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261557AbVALXI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:08:59 -0500
Message-ID: <41E5AC72.1040301@osdl.org>
Date: Wed, 12 Jan 2005 15:02:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: ieee1394 errors on attempted insmod
References: <200501120000.15177.gene.heskett@verizon.net> <200501121519.17548.gene.heskett@verizon.net> <41E59783.3090408@osdl.org> <200501121758.38121.gene.heskett@verizon.net>
In-Reply-To: <200501121758.38121.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Wednesday 12 January 2005 16:32, Randy.Dunlap wrote:
> 
>>Gene Heskett wrote:
>>
>>>On Wednesday 12 January 2005 13:56, Randy.Dunlap wrote:
>>>
>>>>Gene Heskett wrote:
>>>>
>>>>>Greetings;
>>>>>
>>>>>I just bought a Sony HandyCam DCR-TRV460, which has both firewire
>>>>>and usb ports.
>>>>>
>>>>>But I couldn't seem to open a path to it using usb, so I plugged
>>>>>in an old firewire card that has the TI-Lynx chipset on it.  Its
>>>>>recognized (apparently) by both dmesg and kudzu, but although I'd
>>>>>turned on all the 1394 stuff as modules when I got ready to plug
>>>>>the card in and rebuilt my 2.6.10-ac8 kernel, kudzu didn't load
>>>>>any of them, and when I try to, I'm getting "-1 Unknown Symbol in
>>>>>module" errors.
>>>>>
>>>>>Probably an attack of dumbass, but I'd appreciate any help that
>>>>>can be tossed my way.  ATM I'm rebuilding again with the base
>>>>>module built in.
> 
> [...]
> 
>>>Here is a snip from an lspci -v:
>>>
>>>01:09.0 FireWire (IEEE 1394): Texas Instruments FireWire
>>>Controller (rev 01) (prog-if 10 [OHCI])
>>>        Subsystem: Texas Instruments: Unknown device 8010
>>>        Flags: bus master, medium devsel, latency 32, IRQ 19
>>>        Memory at db004000 (32-bit, non-prefetchable)
>>>        Memory at db000000 (32-bit, non-prefetchable) [size=16K]
>>>        Capabilities: [44] Power Management version 1
>>
>>That's not a PCILynx controller AFAIK, it seems that the
>>ohci1394 driver is handling it.
> 
> 
> Or miss-handling it as the case may be :-)
> 
>>>2 or 3 years ago when I was first playing with this card, it said
>>>it needed the pcilynx module, but I think the raw device is
>>>grabbing it first.  Is that kosher, and shouldn't I have a few
>>>more devices beside raw1394 in my devs directory?
>>
>>No idea on that one.  Are all of the modules loading OK now?
> 
> 
> It would appear so.  I think now the question is, do I need some 
> aliases setup in my modprobe.conf in order to force the correct 
> loading sequence?
> 
> 
>>>Do you know where I can find an rpm for gscanbus, I cannot make
>>>the tarball build here, possibly a compiler error coupled with
>>>what I'd call poorly formed src codes.  gcc is 3.3.3 here.
>>
>>I see some here:
>>http://rpmfind.net/linux/rpm2html/search.php?query=gscanbus&submit=S
>>earch+... The ones listed are all for MandrakeLinux.
> 
> 
> I saw those, never been able to use a mndrk rpm here.

No surprise there.

>>Or post the gscanbus build errors (to the
>>linux1394-devel@lists.sf.net mailing list).
> 
> Did that, rather quiet list.

Yes, it is.

 > I fixed it so it would make but its only
> working with the camera turned off!  If I turn it on, the shell that 
> launches it soon fills up with "resource temporarily unavailable" 
> messages.
> 
> Humm, my fix might need another.  Do long self allocating strings 
> still need a terminating \0 in C, inside the dbl quotes?  OTOH, I've 
> not seen either error string actually spit out (yet).  I've been 
> under the impression that most modern compilers handle that silently 
> and well.

C automatically terminates quoted strings with a nul char.

> With the camera turned off, I can get this out of gscanbus:
> ---------------
> SelfID Info
> -----------
> Physical ID: 0
> Link active: Yes
> Gap Count: 63
> PHY Speed: S400
> PHY Delay: <=144ns
> IRM Capable: Yes
> Power Class: -1W
> Port 0: Not connected
> Port 1: Not connected
> Port 2: Not connected
> Init. reset: Yes
> 
> CSR ROM Info
> ------------
> GUID: 0x0050625600001065
> Node Capabilities: 0x000083C0
> Vendor ID: 0x00005062
> Unit Spec ID: 0x0000005E
> Unit SW Version: 0x00000001
> Model ID: 0x00000000
> Nr. Textual Leafes: 1
> 
> Vendor:  KOUWELL ELECTRONICS CORP.  **
> Textual Leafes: 
> Linux - ohci1394
> 
> AV/C Subunits
> -------------
> N/A
> ----------------eof-----------------
> 
> With it turned on, I get the same report but it takes lots of time, 
> and its locked up, whereas with the camera off, the report above is 
> instant.
> 
> I going to shut down long enough to verify the chips on that card, 
> just to satisfy my own itch.  I only have one, and it actually came 
> in a Digital Research box several years ago, staples had a 20 dollar 
> bill on it and I figured what the hey...  I suppose I could drag out 
> the cd, but thats all winderz stuff, less than helpfull to an anti-M$ 
> like me.
> 
> One other item that might bear, the card claims S400 speed, but the 
> camera only claims S100, is the protocol not auto-negotiating?

I dunno, I still suggest asking on the linux1394 mailing list.

-- 
~Randy

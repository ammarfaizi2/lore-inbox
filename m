Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVALVnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVALVnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVALVjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:39:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:45500 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261460AbVALVhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:37:45 -0500
Message-ID: <41E59783.3090408@osdl.org>
Date: Wed, 12 Jan 2005 13:32:51 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: ieee1394 errors on attempted insmod
References: <200501120000.15177.gene.heskett@verizon.net> <41E572C0.2000909@osdl.org> <200501121519.17548.gene.heskett@verizon.net>
In-Reply-To: <200501121519.17548.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Wednesday 12 January 2005 13:56, Randy.Dunlap wrote:
> 
>>Gene Heskett wrote:
>>
>>>Greetings;
>>>
>>>I just bought a Sony HandyCam DCR-TRV460, which has both firewire
>>>and usb ports.
>>>
>>>But I couldn't seem to open a path to it using usb, so I plugged
>>>in an old firewire card that has the TI-Lynx chipset on it.  Its
>>>recognized (apparently) by both dmesg and kudzu, but although I'd
>>>turned on all the 1394 stuff as modules when I got ready to plug
>>>the card in and rebuilt my 2.6.10-ac8 kernel, kudzu didn't load
>>>any of them, and when I try to, I'm getting "-1 Unknown Symbol in
>>>module" errors.
>>>
>>>Probably an attack of dumbass, but I'd appreciate any help that
>>>can be tossed my way.  ATM I'm rebuilding again with the base
>>>module built in.
>>
>>Use modprobe instead of insmod, then there should be a logged
>>message about what symbol was missing/unknown.  Post that.
> 
> 
> Ok, that worked, provided I left the .ko off the end of the name.  So 
> now I have everything in 
> the /lib/modules/2.6.11-rc1/kernel/drivers/ieee1394 loaded, but I 
> suspect the ordering is not correct.  An lsmod now:
> Module                  Size  Used by
> pcilynx                19336  0
> sbp2                   24456  0
> amdtp                  12876  0
> cmp                     4352  1 amdtp
> dv1394                 21068  0
> video1394              18508  0
> raw1394                31852  0
> [... to revelant stuff]
> sg                     35360  0
> ohci1394               34948  3 amdtp,dv1394,video1394
> 
> Here is a snip from an lspci -v:
> 
> 01:09.0 FireWire (IEEE 1394): Texas Instruments FireWire Controller 
> (rev 01) (prog-if 10 [OHCI])
>         Subsystem: Texas Instruments: Unknown device 8010
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         Memory at db004000 (32-bit, non-prefetchable)
>         Memory at db000000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 1

That's not a PCILynx controller AFAIK, it seems that the
ohci1394 driver is handling it.

> 2 or 3 years ago when I was first playing with this card, it said it 
> needed the pcilynx module, but I think the raw device is grabbing it 
> first.  Is that kosher, and shouldn't I have a few more devices 
> beside raw1394 in my devs directory?

No idea on that one.  Are all of the modules loading OK now?

> Do you know where I can find an rpm for gscanbus, I cannot make the 
> tarball build here, possibly a compiler error coupled with what I'd 
> call poorly formed src codes.  gcc is 3.3.3 here.

I see some here:
http://rpmfind.net/linux/rpm2html/search.php?query=gscanbus&submit=Search+...
The ones listed are all for MandrakeLinux.

Or post the gscanbus build errors (to the linux1394-devel@lists.sf.net
mailing list).

-- 
~Randy

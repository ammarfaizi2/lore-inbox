Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVALUVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVALUVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVALUU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:20:56 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:1766 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261391AbVALUTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:19:19 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None, usuallly detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: ieee1394 errors on attempted insmod
Date: Wed, 12 Jan 2005 15:19:17 -0500
User-Agent: KMail/1.7
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
References: <200501120000.15177.gene.heskett@verizon.net> <41E572C0.2000909@osdl.org>
In-Reply-To: <41E572C0.2000909@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121519.17548.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.42.99] at Wed, 12 Jan 2005 14:19:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 January 2005 13:56, Randy.Dunlap wrote:
>Gene Heskett wrote:
>> Greetings;
>>
>> I just bought a Sony HandyCam DCR-TRV460, which has both firewire
>> and usb ports.
>>
>> But I couldn't seem to open a path to it using usb, so I plugged
>> in an old firewire card that has the TI-Lynx chipset on it.  Its
>> recognized (apparently) by both dmesg and kudzu, but although I'd
>> turned on all the 1394 stuff as modules when I got ready to plug
>> the card in and rebuilt my 2.6.10-ac8 kernel, kudzu didn't load
>> any of them, and when I try to, I'm getting "-1 Unknown Symbol in
>> module" errors.
>>
>> Probably an attack of dumbass, but I'd appreciate any help that
>> can be tossed my way.  ATM I'm rebuilding again with the base
>> module built in.
>
>Use modprobe instead of insmod, then there should be a logged
> message about what symbol was missing/unknown.  Post that.

Ok, that worked, provided I left the .ko off the end of the name.  So 
now I have everything in 
the /lib/modules/2.6.11-rc1/kernel/drivers/ieee1394 loaded, but I 
suspect the ordering is not correct.  An lsmod now:
Module                  Size  Used by
pcilynx                19336  0
sbp2                   24456  0
amdtp                  12876  0
cmp                     4352  1 amdtp
dv1394                 21068  0
video1394              18508  0
raw1394                31852  0
[... to revelant stuff]
sg                     35360  0
ohci1394               34948  3 amdtp,dv1394,video1394

Here is a snip from an lspci -v:

01:09.0 FireWire (IEEE 1394): Texas Instruments FireWire Controller 
(rev 01) (prog-if 10 [OHCI])
        Subsystem: Texas Instruments: Unknown device 8010
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at db004000 (32-bit, non-prefetchable)
        Memory at db000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 1

2 or 3 years ago when I was first playing with this card, it said it 
needed the pcilynx module, but I think the raw device is grabbing it 
first.  Is that kosher, and shouldn't I have a few more devices 
beside raw1394 in my devs directory?

Do you know where I can find an rpm for gscanbus, I cannot make the 
tarball build here, possibly a compiler error coupled with what I'd 
call poorly formed src codes.  gcc is 3.3.3 here.

Thanks Randy.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

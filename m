Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933351AbWKNJlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933351AbWKNJlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 04:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933352AbWKNJlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 04:41:51 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:8658 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S933353AbWKNJlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 04:41:47 -0500
Date: Tue, 14 Nov 2006 10:30:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
cc: Pavel Machek <pavel@ucw.cz>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>,
       John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com
Subject: Re: HD head unloads (was: Re: AHCI power saving)
In-Reply-To: <20061114034355.GB5810@khazad-dum.debian.net>
Message-ID: <Pine.LNX.4.61.0611141021040.29913@yvahk01.tjqt.qr>
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz>
 <45589008.1080001@garzik.org> <200611131637.56737.ak@suse.de>
 <455893E5.4010001@garzik.org> <4558B232.8080600@rtr.ca> <20061113220127.GA1704@elf.ucw.cz>
 <20061114034355.GB5810@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 14 2006 01:43, Henrique de Moraes Holschuh wrote:
>On Mon, 13 Nov 2006, Pavel Machek wrote:
>>On Mon 2006-11-13 12:58:10, Mark Lord wrote:
>>>Jeff Garzik wrote:
>>>>Andi Kleen wrote:
>>>>
>>>>>How does it shorten its life?
>>>>
>>>>Parks your hard drive heads many thousands of times more often than it 
>>>>does without the aggressive PM features.
>>> 
>>>Spinning-down would definitely shorten the drive lifespan.  Does 
>>>it do that?
>> 
>>Not on my machine.
>
>Heck, given just how much a ThinkPad T43 BIOS will attempt to do it for you,
>consider yourself lucky if the X60 behaves differently.  When I thought of
>monitoring the head unload counter through SMART on mine, my HD was already
>beyond 14k unloads... and the notebook had been powered up less than 100
>times :p

Let me jump in here. Short info: Toshiba MK2003GAH 1.8" 20GB 
PATA harddisk, in a Sony Vaio U3 (x86, gray-blue PhoenixBIOS).
If idle for more than 5 secs, unloads. Even when not inside any OS, 
which really sets me off.
    So I wrote a quick workaround hack for Linux, http://tinyurl.com/y3qs6g
It reads a predefined amount of bytes (just as much to not cause 
slowdown yet still cause it to not unload) from the disk at fixed 
intervals.

>The BIOS likes to set the drive APM mode to something other than "off", and
>in many drives (well, Hitachi ones at least), that means the drive will be
>happy to unload heads every chance it gets, so as to be able to power off
>the head assembly motion drive.
>
>> > Parking heads is more like just doing some extra (long) seeks.
>
>Long seeks don't lift the head assembly off the plates, head unloads do.
>And head unloads will also power down some stuff in laptop HDs, seeks don't
>do that either.

Parking heads is worse than a seek - it takes more time to reload it 
than to seek to the other side.

>And even old-style parking places the heads on a different surface than the
>data area.  That's a lot different from seeks no matter how one looks at it.
>
>> > Is this documented somewhere as being a life-shortening action?
>
>Yes, although not often with that many words.
>
>For example, a Hitachi Travelstar 5k100 is rated for 600k load/unload
>cycles, and 20k emergency load/unload cycles (each emergency unload counts
>as 30 normal unloads, but the tech docs say it is about 100 times more
>stressfull to the drive).  It is in the public drive datasheet, along with
>other important information, such as that the drive needs to spin down often
>(no less than once every 48h) or its lifespan will be shortened.
>
>A typical desktop HD can probably survive a lot less head load/unload
>cycles and spin up/down cycles than that.
>
>-- 
>  "One disk to rule them all, One disk to find them. One disk to bring
>  them all and in the darkness grind them. In the Land of Redmond
>  where the shadows lie." -- The Silicon Valley Tarot
>  Henrique Holschuh
>-

	-`J'
-- 

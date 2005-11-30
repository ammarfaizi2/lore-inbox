Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVK3BZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVK3BZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVK3BZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:25:27 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:54633 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750762AbVK3BZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:25:26 -0500
Message-ID: <438CFFAD.7070803@m1k.net>
Date: Tue, 29 Nov 2005 20:26:05 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirk Lapray <kirk.lapray@gmail.com>
CC: Gene Heskett <gene.heskett@verizon.net>, video4linux-list@redhat.com,
       CityK <CityK@rogers.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Perry Gilfillan <perrye@linuxmail.org>, Don Koch <aardvark@krl.com>
Subject: Re: Gene's pcHDTV 3000 analog problem
References: <200511282205.jASM5YUI018061@p-chan.krl.com>	 <200511291335.18431.gene.heskett@verizon.net>	 <438CA1E3.7010101@m1k.net>	 <200511291546.27365.gene.heskett@verizon.net> <438CC83E.50100@m1k.net>	 <c35b44d70511291435i5f07bc88g429276ef659c28c5@mail.gmail.com>	 <438CDDBC.1070704@m1k.net> <c35b44d70511291548lcb10361ifd3a4ea0f239662d@mail.gmail.com>
In-Reply-To: <c35b44d70511291548lcb10361ifd3a4ea0f239662d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirk Lapray wrote:

> There are some i2c commands sent in cx88-cards.c, but that should only 
> happen with the HDTV Wonder.
>
> The nxt200x should only be sending i2c commands if it detects a 
> NXT2002 or NXT2004 chip.  You can set the nxt200x module to load with 
> debug=1 to see if it is doing something that it shouldn't.  The only 
> thing that I can think of is that the auto detecting of NXT2002 and 
> NXT2004 is not working like it is supposed to.  If you do not have a 
> NXT2002 or NXT2004 based card the nxt200x module should not do 
> anything.  The only i2c command in the attach function is to read the 
> card id.
>
> From what I have seen the only device that is made visible is the 
> tuner.  This allows the tuner modules to connect to it.  It basically 
> turns on the tuner, and this should only happen on NXT2004 based cards.

Don Koch wrote:

>>If this fixes your problem, then we know that nxt200x is the cause.
>>    
>>
>No difference.
>
>Back to looking at the code...
>  
>
Okay, it looks like nxt200x is a red herring, sorry for the false 
alarm.  Even still, Kirk, it would be very helpful if you could confirm 
analog video functionality of your pcHDTV 3000 board, using either 
2.6.15-rc3, or v4l-dvb cvs on top of any kernel version.

...But before that, please first try it in your current configuration.

I do not have this board, and there *IS* a problem with it... Based on 
the tests done by Gene and Don, it looks like the regression is inside 
the v4l code, although this doesnt make any sense, as other cards with 
similar hardware are not affected.

I don't know any of the specifics about this board, besides the fact 
that is has OR51132 (irrelevant - the problem exists even without 
cx88-dvb loaded) Thomson DDT 7610, and a cx2388x chip.

I have two cx88 boards of my own - FusionHDTV5 Gold, everything works 
fine, both analog and digital.  FusionHDTV3 Gold-T, using Thomson DDT 
7611 (same as 7610) , and digital works, but the analog tuner is 
completely broken, regardless of what kernel version, regardless of 
whether I'm using Linux or windows, and it used to work a few months ago.

I think my hardware is fried, but since Gene is able to restore 
functionality by a cold boot into 2.6.14.2, it makes me think his 
problem is because of bad code, where my problem is due to bad hardware.

All I can think of doing next is to have Gene, Don or Perry do a 
bisection test on our cvs repo.... checking out different cvs revisions 
until we can narrow it down to the day the problem patch was applied.

::sigh::

Who wants to do it?  I'll give you detailed instructions if you're willing.

Regards,
Mike

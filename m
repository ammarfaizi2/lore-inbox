Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWDJXzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWDJXzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWDJXzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:55:08 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:23974 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932202AbWDJXzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:55:06 -0400
Message-ID: <443AF055.9030900@m1k.net>
Date: Mon, 10 Apr 2006 19:55:01 -0400
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Greg Stark <gsstark@mit.edu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pchdtv 3000 cx88 audio very very low level
References: <8764lmnlcx.fsf@stark.xeocode.com> <20060407092426.GA21330@rhlx01.fht-esslingen.de> <87d5ftmt5p.fsf@stark.xeocode.com> <20060410133831.GA22079@rhlx01.fht-esslingen.de>
In-Reply-To: <20060410133831.GA22079@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:

>Hi,
>
>On Fri, Apr 07, 2006 at 09:06:42AM -0400, Greg Stark wrote:
>  
>
>>Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:
>>
>>    
>>
>>>IOW, you need to examine the driver sources of cx88xx, cx8800, cx88_alsa,
>>>btcx_risc, tveeprom (?) for some multiplexer bit mask and tweak/twiddle that
>>>for your tuner until you manage to hear something properly.
>>>      
>>>
>>Hm. Except nobody else seems to have this problem with the pchdtv 3000 card.
>>And there are plenty of HOWTOs and FAQs online for it. Perhaps nobody else is
>>trying to use the NTSC tuner on it though.
>>    
>>
>
>A distant possibility might be that your card is a very specific rare revision
>of that thing and thus doesn't have a proper card type entry for it due to
>almost nobody else having that card.
>In the TV card area (just as in the WLAN card area) there are quite some cards
>sold under the *very same* name but wildly (or not so wildly but sufficiently)
>differing hardware (those manufacturer b****rds burn in hell please, thanks).
>
>  
>
>>I'm assuming that if cx88_alsa found any audio devices on the card then it
>>would create a card1 listed in /proc/asound/cards ? It isn't doing that
>>currently. Apparently not all cx88 cards provide a mixer interface.
>>    
>>
>
>I'm not that familiar with ALSA user-space interface specifics (rather than
>kernel-level), sorry.
>
We have recently discovered that the programming for the pcHDTV3000 card 
was based on a prototype that used the Thomson DTT7610 tuner, and that 
this particular version of the card has never gone into production.

The actual version of the card in circulation uses the Thomson DTT7612 
...  You do not need a patch to correct this on your machine, at least 
not for analog NTSC mode.  Just load your driver as follows:

modprobe cx88xx tuner=60   (it will use tuner 52 by default)
modprobe cx8800

Tuner #52 is the previous tuner defined for this card, DTT7610, and 
tuner #60 is configured for Thomson DTT 7611 7611A 7612 7613 7613A 7614 
7615 7615A

The configuration for this card has been fixed in the v4l-dvb mercurial 
tree as of this morning.  To update your v4l/dvb modules (so long as you 
are running kernel 2.6.12 or later) follow the directions here:

http://linuxtv.org/repo/

I hope this helps,

Michael Krufky

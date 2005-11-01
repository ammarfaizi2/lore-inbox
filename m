Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbVKBAQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbVKBAQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVKBAQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:16:39 -0500
Received: from [67.137.28.189] ([67.137.28.189]:60034 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1751473AbVKBAQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:16:38 -0500
Message-ID: <4367F226.4040302@utah-nac.org>
Date: Tue, 01 Nov 2005 15:54:30 -0700
From: "Jeff V. Merkey" <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Florian Weimer <fw@deneb.enyo.de>,
       Lawrence Walton <lawrence@the-penguin.otak.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3ware 9550SX problems - mke2fs incredibly slow writing last third
 of inode tables
References: <BEDEA151E8B1D6CEDD295442@[192.168.100.25]> 	<87oe54cza8.fsf@mid.deneb.enyo.de> 	<20051101170413.GA11640@the-penguin.otak.com> <87wtjs8f54.fsf@mid.deneb.enyo.de> <B4CA35A2CFBAF97FCE2856B0@[192.168.100.25]>
In-Reply-To: <B4CA35A2CFBAF97FCE2856B0@[192.168.100.25]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I see this problem if you have the array configured for RAID 5 and you 
have not pushed the F8 key during array config after setting up
the array. Try rebooting, setting the Raid 5 for INIT (Press F8) and it 
goes away, but the whole array will reinit itself. There seems to be
some sort of problem in their RAID 5 logic and you can setup a RAID 5 
stripe set, but init doesn't finish or gets in a wierd state during
reboot. It seems confined to 9500 series controllers, but I have also 
seen this behavior on the 8000 series drivers as well. I don't know
if you are using RAID 5 , but I have seen this problem on RAID 5 configs 
only.

Jeff

Alex Bligh - linux-kernel wrote:

>
>
> --On 01 November 2005 18:13 +0100 Florian Weimer <fw@deneb.enyo.de> 
> wrote:
>
>>>> In my experience, the 3ware SATA controllers which are not NCQ-capable
>>>> have very, very lousy write performance with some drives, unless you
>>>> enable the write cache (which is, of course, a bit dangerous without
>>>> UPS or battery backup on the controller).
>>>
>>
>>> Not to sound like the a 3ware chearleader, but this card does support
>>> NCQ.
>>
>>
>> Oh. I didn't know whether this particukar controller supported NCQ or
>> not.
>
>
> It even supports SATA-3, not much good that it does me.
>
> I managed to format it reiserfs in the end. dbench (yes I know it isn't a
> great benchmark) gives me a write speed of 7Mb/s compared to 700Mb/s 
> if one
> of the disks in the array is attached to the motherboard SATA controller.
>
> 7Mb/s is quite stunningly appalling. I realise the release notes warn of
> slow writes, but that's just daft! I have a few bits in my setup to check
> before I start pointing the finger comprehensively. It may (for instance)
> be a large partition problem (suggested on the ext2 list).
>
> I'm taking it that it works at least for some people (did you test write
> speed Lawrence?).
>
> -- 
> Alex Bligh
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTFDBK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 21:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTFDBK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 21:10:26 -0400
Received: from post-20.mail.nl.demon.net ([194.159.73.1]:49674 "EHLO
	post-20.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S262524AbTFDBKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 21:10:24 -0400
Message-ID: <3EDD49FA.2080407@maatwerk.net>
Date: Wed, 04 Jun 2003 03:23:06 +0200
From: Mauk van der Laan <mauk.lists@maatwerk.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: siimage slow on 2.4.21-rc6-ac2
References: <Pine.LNX.4.10.10306031746070.27756-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


He is right. I did several tests and it is the max_kb setting
that does it, not the fact that I programmed both disks.
Sorry to have put you in the wrong direction.

By the way, the autodma code doesnt seem to do anything?

Mauk


Andre Hedrick wrote:

>NO, it is not irrelevant.
>
>Seagate and Silicon Image are the only two player (well intel now) who did
>their own PHY.  They did not use the Marvel pairs.
>
>It is a function of possible ECC on the wire and the relation to the
>segments in the PIO or SG operations.  It is a FIFO issue based on 512byte
>boundaries being breached on corner cases.
>
>The data on the wire is in 8K units.
>
>It is a 7.5K + 0.5K corner case.
>
>max_kb_per_request:15 == 7.5K
>
>This prevents this corner case until I can code the proper special case SG
>table.
>
>drive->id->hwconfig |= 0x6000;
>
>Is needed to fake the driver for device side cable detect.
>There are several issues and I have not had time to keep up.
>
>I have to do other business ventures because being an independent
>developer/contract no longer can pay the bills.  More proof that free
>drivers and free software still has a cost to somebody.
>
>Cheers,
>
>On 3 Jun 2003, Alan Cox wrote:
>
>  
>
>>On Maw, 2003-06-03 at 23:48, Mauk van der Laan wrote:
>>    
>>
>>>He! I just did
>>>
>>># hdparm -d1 -X66 /dev/hdX
>>># echo "max_kb_per_request:15" > /proc/.ide/hdX/settings
>>>
>>>on BOTH sata drives and everything works fine!
>>>Is it possible that they influence each other?
>>>      
>>>
>>Not as I understand it, but this is rather useful information. The SI
>>does have some ties for PIO mode but not UDMA clocking. This is most
>>interesting information.
>>
>>The max_kb_per thing should be irrelevant btw.
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>Andre Hedrick
>LAD Storage Consulting Group
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>




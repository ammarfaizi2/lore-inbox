Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263284AbVFYCdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbVFYCdE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 22:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbVFYCdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 22:33:03 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:25317 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263284AbVFYCc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 22:32:57 -0400
Message-ID: <42BCC257.5060900@comcast.net>
Date: Fri, 24 Jun 2005 22:32:55 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: Pierre Ossman <drzeus-list@drzeus.cx>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx> <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx> <42BCBB60.7000508@comcast.net> <42BCBF01.206@comcast.net>
In-Reply-To: <42BCBF01.206@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, i'm retarded, i pasted the wrong changelog line.

<hch@lst.de>
	[8139TOO]: Use rtnl_lock_interruptible()
	
	The 8139too thread needs to use rtnl_lock_interruptible so it can avoid
	doing the actual work once it's been kill_proc()ed on module removal
	time.
	
	Based on debugging and an earlier patch that adds a driver-private
	semaphore from Herbert Xu.
	
	Signed-off-by: David S. Miller <davem@davemloft.net>

This seems to be the only patch that contains a change to the 8139too code between 
working and non-working code.

nothing in mm's patchset seems to have anything to cause these problems.




Ed Sweetman wrote:

> this is in the changefile to 2.6.11.   This seems to be the real 
> culprit.  I guarantee you if this patch is reverted, there will be no 
> problems.
>
> <romieu@fr.zoreil.com>
>     [PATCH] r8169: hint for Tx flow control
>     
>     return 1 in start_xmit() when the required descriptors are not 
> available
>     and wait for more room.
>     
>     Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
>
>
>
>
> Ed Sweetman wrote:
>
>> Pierre Ossman wrote:
>>
>>> Bjorn Helgaas wrote:
>>>
>>>  
>>>
>>>> Your 2.6.11 dmesg mentions the VIA IRQ fixup, but the 2.6.12 one
>>>> doesn't.  I bet something's broken there.
>>>>
>>>> Can you try the attached debugging patch?  And please collect the
>>>> output of lspci, too.
>>>>
>>>>
>>>>   
>>>
>>>
>>>
>>> I tried the attached patch and it had no effect. I also tried porting
>>> the 2.6.11 way of handling the VIA quirk but it didn't have any effect.
>>> I'll try a more complete port tomorrow (it was a bit of a hack this 
>>> time).
>>>
>>>  
>>>
>> 2.6.11-mm4 doesn't work. So i'm guessing 2.6.11 wont work either 
>> which may be why backporting it's via fixes didn't do anything.  I'm 
>> gonna try vanilla and if that by some crazy chance works, then it'll 
>> be fairly easy to see what change did it since mm has a nice Changelog.
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>


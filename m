Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVBGRc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVBGRc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVBGRcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:32:50 -0500
Received: from smtp-out.fr.clara.net ([212.43.194.59]:52132 "EHLO
	smtp-out.fr.clara.net") by vger.kernel.org with ESMTP
	id S261217AbVBGRcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:32:14 -0500
Message-ID: <4207A619.4080201@idtect.com>
Date: Mon, 07 Feb 2005 18:32:09 +0100
From: Charles-Edouard Ruault <ce@idtect.com>
Organization: Idtect SA
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: IO port conflict between timer & watchdog on PCISA-C800EV board
 ?
References: <420734DC.4020900@idtect.com> <420797DE.6030904@osdl.org>
In-Reply-To: <420797DE.6030904@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> Charles-Edouard Ruault wrote:
>
>> Hi All,
>>
>> i wrote a driver for the watchdog timer provided by a small form 
>> factor board from IEI ( the PCISA-C800EV : 
>> http://www.iei.com.tw/en/product_IPC.asp?model=PCISA-C800 ).
>> This board has a Via Apollo PLE133 ( VT8601A and VT82C686B ) chipset.
>> The watchdog uses two registers at addresses 0x43 and 0x443, 
>> therefore my driver tries to get bot addresses for its own use calling
>> request_region(0x43, 1, "watchdog" ) and request_region(0x443, 1, 
>> "watchdog").
>> The first call to request 0x43 fails because the address has already 
>> been allocated to the timer ( /proc/ioports shows 0040-005f : timer ).
>>
>> So my questions are :
>> - Why is the generic timer using this address ? isn't it reserving a 
>> too wide portion of IO ports ? Should it be modified for this board ?
>> -  If there's a good reason for the timer to request this address, 
>> is  there a clean way to share it with the timer ?
>
>
> Missing kernel version.... must be "not the current/latest",
> so early 2.6 or more likely 2.4 (just guessing)?
>
> /proc/ioports timer assignments have now been split up like this:
> 0040-0043 : timer0
> 0050-0053 : timer1
>
> However, port 0x43 is still assigned to timer0, so your request_region
> call will still fail.  What system board timer resource assignments
> should be used for that VIA chipset?  If the chipset timer only needs
> 0x40-0x42, e.g., leaving 0x43 available, then it would be possible
> to do some kind of workaround (maybe not real clean, but possible).
>
Hi Randy,
thanks for the reply.
My apologies for not including the kernel version ( that's what you get 
when you try to go too fast ;)
You were right, i'm running 2.4.29 !
I don't know about the resources assignments needed by this timer. I 
tried to get the spec sheets for the chipset from the via site but i was 
not able to find it ( i did not spend hours looking tough ).
I was wondering if someone had the info out there !
Right now i'm just not taking into account the failure of the 
request_region and everything works fine. But i wanted to make it clean 
so ... i'll have to dig deeper into this i guess !


-- 
Charles-Edouard Ruault
Idtect SA
115 rue Reaumur - 75002, Paris, France
Tel: +33-1-55-34-76-65
Fax: +33-1-55-34-76-75
Web: http://www.idtect.com


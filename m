Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVBGRd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVBGRd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVBGRd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:33:56 -0500
Received: from smtp-out.fr.clara.net ([212.43.194.59]:51329 "EHLO
	smtp-out.fr.clara.net") by vger.kernel.org with ESMTP
	id S261205AbVBGRdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:33:33 -0500
Message-ID: <4207A66A.9020602@idtect.com>
Date: Mon, 07 Feb 2005 18:33:30 +0100
From: Charles-Edouard Ruault <ce@idtect.com>
Organization: Idtect SA
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: IO port conflict between timer & watchdog on PCISA-C800EV board
 ?
References: <420734DC.4020900@idtect.com> <420797DE.6030904@osdl.org> <Pine.LNX.4.61.0502071157520.22576@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0502071157520.22576@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:

> On Mon, 7 Feb 2005, Randy.Dunlap wrote:
>
>> Charles-Edouard Ruault wrote:
>>
>>> Hi All,
>>>
>>> i wrote a driver for the watchdog timer provided by a small form 
>>> factor board from IEI ( the PCISA-C800EV : 
>>> http://www.iei.com.tw/en/product_IPC.asp?model=PCISA-C800 ).
>>> This board has a Via Apollo PLE133 ( VT8601A and VT82C686B ) chipset.
>>> The watchdog uses two registers at addresses 0x43 and 0x443, 
>>> therefore my driver tries to get bot addresses for its own use calling
>>> request_region(0x43, 1, "watchdog" ) and request_region(0x443, 1, 
>>> "watchdog").
>>> The first call to request 0x43 fails because the address has already 
>>> been allocated to the timer ( /proc/ioports shows 0040-005f : timer ).
>>>
>>> So my questions are :
>>> - Why is the generic timer using this address ? isn't it reserving a 
>>> too wide portion of IO ports ? Should it be modified for this board ?
>>> -  If there's a good reason for the timer to request this address, 
>>> is there a clean way to share it with the timer ?
>>
>>
>> Missing kernel version.... must be "not the current/latest",
>> so early 2.6 or more likely 2.4 (just guessing)?
>>
>> /proc/ioports timer assignments have now been split up like this:
>> 0040-0043 : timer0
>> 0050-0053 : timer1
>>
>> However, port 0x43 is still assigned to timer0, so your request_region
>> call will still fail.  What system board timer resource assignments
>> should be used for that VIA chipset?  If the chipset timer only needs
>> 0x40-0x42, e.g., leaving 0x43 available, then it would be possible
>> to do some kind of workaround (maybe not real clean, but possible).
>>
>> -- 
>> ~Randy
>
>
> The driver can still R/W registers that it hasn't allocated.
> There is no hardware trap preventing this. I suggest that,
> as a temporary work-around, just don't allocate the low
> port, but attempt to use it. I think the watchdog probably
> just looks for read at that address.

Hi Dick,
thanks for the reply. Right now i'm doing exactly what you suggest and 
it works fine ... but i'm not really happy about this "workaround" since 
it's not clean.
The driver reads only at 0x43 to disable the watchdog , i have not seen 
any side effect so far but ... one never knows !

>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.



-- 
Charles-Edouard Ruault
Idtect SA
115 rue Reaumur - 75002, Paris, France
Tel: +33-1-55-34-76-65
Fax: +33-1-55-34-76-75
Web: http://www.idtect.com


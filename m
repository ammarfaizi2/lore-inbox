Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVBGQtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVBGQtw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVBGQtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:49:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:32747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261187AbVBGQtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:49:50 -0500
Message-ID: <420797DE.6030904@osdl.org>
Date: Mon, 07 Feb 2005 08:31:26 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Charles-Edouard Ruault <ce@idtect.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: IO port conflict between timer & watchdog on PCISA-C800EV board
 ?
References: <420734DC.4020900@idtect.com>
In-Reply-To: <420734DC.4020900@idtect.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles-Edouard Ruault wrote:
> Hi All,
> 
> i wrote a driver for the watchdog timer provided by a small form factor 
> board from IEI ( the PCISA-C800EV : 
> http://www.iei.com.tw/en/product_IPC.asp?model=PCISA-C800 ).
> This board has a Via Apollo PLE133 ( VT8601A and VT82C686B ) chipset.
> The watchdog uses two registers at addresses 0x43 and 0x443, therefore 
> my driver tries to get bot addresses for its own use calling
> request_region(0x43, 1, "watchdog" ) and request_region(0x443, 1, 
> "watchdog").
> The first call to request 0x43 fails because the address has already 
> been allocated to the timer ( /proc/ioports shows 0040-005f : timer ).
> 
> So my questions are :
> - Why is the generic timer using this address ? isn't it reserving a too 
> wide portion of IO ports ? Should it be modified for this board ?
> -  If there's a good reason for the timer to request this address, is  
> there a clean way to share it with the timer ?

Missing kernel version.... must be "not the current/latest",
so early 2.6 or more likely 2.4 (just guessing)?

/proc/ioports timer assignments have now been split up like this:
0040-0043 : timer0
0050-0053 : timer1

However, port 0x43 is still assigned to timer0, so your request_region
call will still fail.  What system board timer resource assignments
should be used for that VIA chipset?  If the chipset timer only needs
0x40-0x42, e.g., leaving 0x43 available, then it would be possible
to do some kind of workaround (maybe not real clean, but possible).

-- 
~Randy

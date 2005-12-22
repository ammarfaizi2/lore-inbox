Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVLVVmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVLVVmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVLVVmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:42:19 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:42159 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1030298AbVLVVmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:42:19 -0500
Message-ID: <43AB1DB7.3080505@ru.mvista.com>
Date: Fri, 23 Dec 2005 00:42:15 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, spi-devel-general@sourceforge.net
Subject: Re: [PATCH 2.6-git] SPI: add set_clock() to bitbang
References: <20051222180449.4335a8e6.vwool@ru.mvista.com> <200512220840.34152.david-b@pacbell.net> <43AB1958.1070407@ru.mvista.com> <200512221337.39305.david-b@pacbell.net>
In-Reply-To: <200512221337.39305.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>>This is actually not needed.  Clocks are set through the setup() method
>>>      
>>>
>>...
>>
>>Where is it supposed to call setup? I guess it's anyway gonna be 
>>per-transfer, right?
>>Or am I missing something?
>>    
>>
>
>When the device is created, the core calls setup() to get things like
>chipselect polarity sorted out and put into the inactive state.   That
>matches the board-specific defaults associated with that device, which
>would be a function of voltage, routing, and more.
>
>And from then on, it'd be rare to ever call setup() again ... though
>drivers certainly could do that between spi_message interactions with
>a given device.
>  
>
No, suppose there're two devices behind the same SPI bus that have 
different clock constraints. As active SPI device change may well happen 
when each new message is processed, we'll need to set up clocks again 
for each message. Right?

Vitaly

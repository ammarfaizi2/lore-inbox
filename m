Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTDXQCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTDXQCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:02:55 -0400
Received: from watch.techsource.com ([209.208.48.130]:15066 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263396AbTDXQCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:02:53 -0400
Message-ID: <3EA8114A.4020309@techsource.com>
Date: Thu, 24 Apr 2003 12:31:06 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Chuck Ebbert <76306.1226@compuserve.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
References: <200304241128_MC3-1-35DA-F3DA@compuserve.com> <Pine.LNX.4.53.0304241147420.32073@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:

>On Thu, 24 Apr 2003, Chuck Ebbert wrote:
>
>  
>
>>Jens Axboe wrote:
>>
>>
>>    
>>
>>>>+	return((drive->id->cfs_enable_1 & 0x0400) ? 1 : 0);
>>>> }
>>>>        
>>>>
>>>Seconded, it causes a lot more confusion than it does good.
>>>      
>>>
>>  The return looks like a function call in that last line.
>>
>>  That's one of the few things I find really annoying -- extra parens
>>are fine when they make code clearer, but not there.
>>
>>
>>-------
>> Chuck [ C Style Police, badge #666 ]
>>    
>>
>
>return((drive->id->cfs_enable_1 & 0x0400) ? 1 : 0);
>                                  ^^^^^^|__________ wtf?
>These undefined numbers in the code are much more annoying to me...
>but I don't have a C Style Police Badge.
>
>Also, whatever that is, 0x400, I'll call it MASK, can have shorter
>code like:
>
>   return (drive->id->cfs_enable_1 && MASK); // TRUE/FALSE
>... for pedantics...
>   return (int) (drive->id->cfs_enable_1 && MASK);
>
>
>  
>

That wouldn't work, because && isn't a bitwise operator.  But I agree 
that the ( x ? 1 : 0 ) method may not be very efficient, because it may 
involve branches.

Two alternatives:

(a)     !!(x & 0x400)

(b)     (x & 0x400) >> 10




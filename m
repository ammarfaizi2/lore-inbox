Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVHKQXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVHKQXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVHKQXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:23:42 -0400
Received: from smtpout.mac.com ([17.250.248.84]:59095 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932299AbVHKQXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:23:41 -0400
In-Reply-To: <Pine.LNX.4.61.0508111058580.14789@chaos.analogic.com>
References: <20050811144457.2598.qmail@science.horizon.com> <Pine.LNX.4.61.0508111058580.14789@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <75F35484-8D34-4B1A-B158-92930EA704D6@mac.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: CCITT-CRC16 in kernel
Date: Thu, 11 Aug 2005 12:23:27 -0400
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 11, 2005, at 11:19:59, linux-os (Dick Johnson) wrote:
> On Thu, 11 Aug 2005 linux@horizon.com wrote:
>> You're wrong in two ways:
>> 1) You've got CRC-16 and CRC-CCITT mixed up, and
>> 2) You've got the bit ordering backwards.  Remember, I said very  
>> clearly,
>>   the lsbit is the first bit, and the first bit is the highest power
>>   of x.  You can reverse the convention and still have a CRC, but  
>> that's
>>   not the way it's usually done and it's more awkward in software.
>>
>> CRC-CCITT = X^16 + X^12 + X^5 + X^0 = 0x8408, and NOT 0x1021
>> CRC-16 =  X^16 + X^15 + X^2 + X^0 = 0xa001, and NOT 0x8005
>
> Thank you very much for your time, but what you say is completely
> different than anything else I have found on the net.
>
> Do the math:
>
>      2^ 16 = 65536
>      2^ 12 =  4096
>      2^  5 =    32
>      2^  0 =     1
> ----------------------
>                  69655 = 0x11021

No, it's like this: first, the 16 term is ignored, then:

     2^ ( 15 - 12 ) = 2^  3 =     8 = 0x0008
     2^ ( 15 -  5 ) = 2^ 10 =  1024 = 0x0400
     2^ ( 15 -  0 ) = 2^ 15 = 32768 = 0x8000
-----------------------------------------------
                                    = 0x8408

This has 2 things:
     1) The least-significant bit is the first bit
     2) The first bit is the _highest_ power of X.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E
W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+++) 5  
X R?
tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------



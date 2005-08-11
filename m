Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVHKRJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVHKRJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVHKRJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:09:19 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:22794 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751127AbVHKRJS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:09:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <75F35484-8D34-4B1A-B158-92930EA704D6@mac.com>
References: <20050811144457.2598.qmail@science.horizon.com> <Pine.LNX.4.61.0508111058580.14789@chaos.analogic.com> <75F35484-8D34-4B1A-B158-92930EA704D6@mac.com>
X-OriginalArrivalTime: 11 Aug 2005 17:09:10.0257 (UTC) FILETIME=[63DC7610:01C59E97]
Content-class: urn:content-classes:message
Subject: Re: CCITT-CRC16 in kernel
Date: Thu, 11 Aug 2005 13:08:56 -0400
Message-ID: <Pine.LNX.4.61.0508111256440.15112@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CCITT-CRC16 in kernel
Thread-Index: AcWel2Pjx8BUWnm/TYC6mspEmALkPw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Cc: <linux@horizon.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Aug 2005, Kyle Moffett wrote:

> On Aug 11, 2005, at 11:19:59, linux-os (Dick Johnson) wrote:
>> On Thu, 11 Aug 2005 linux@horizon.com wrote:
>>> You're wrong in two ways:
>>> 1) You've got CRC-16 and CRC-CCITT mixed up, and
>>> 2) You've got the bit ordering backwards.  Remember, I said very
>>> clearly,
>>>   the lsbit is the first bit, and the first bit is the highest power
>>>   of x.  You can reverse the convention and still have a CRC, but
>>> that's
>>>   not the way it's usually done and it's more awkward in software.
>>>
>>> CRC-CCITT = X^16 + X^12 + X^5 + X^0 = 0x8408, and NOT 0x1021
>>> CRC-16 =  X^16 + X^15 + X^2 + X^0 = 0xa001, and NOT 0x8005
>>
>> Thank you very much for your time, but what you say is completely
>> different than anything else I have found on the net.
>>
>> Do the math:
>>
>>      2^ 16 = 65536
>>      2^ 12 =  4096
>>      2^  5 =    32
>>      2^  0 =     1
>> ----------------------
>>                  69655 = 0x11021
>
> No, it's like this: first, the 16 term is ignored, then:
>
>     2^ ( 15 - 12 ) = 2^  3 =     8 = 0x0008
>     2^ ( 15 -  5 ) = 2^ 10 =  1024 = 0x0400
>     2^ ( 15 -  0 ) = 2^ 15 = 32768 = 0x8000
> -----------------------------------------------
>                                    = 0x8408
>
> This has 2 things:
>     1) The least-significant bit is the first bit
>     2) The first bit is the _highest_ power of X.
>
> Cheers,
> Kyle Moffett


Okay. Thanks. This means that hardware somehow swapped bits
before doing a CRC. I wasn't aware that this was even possible
as it would require additional storage, well I guess anything
is now possible in a FPGA.

The "Bible" has been:
 	http://www.joegeluso.com/software/articles/ccitt.htm

Note that on the very first page, reference, is made to
the 0x1021 poly. Then there is source-code that is entirely
incompatible with anything in the kernel, but is supposed to
work (it does work on my hardware).

I have spent over a week grabbing everything on the Web that
could help decipher the CCITT CRC and they all show this
same kind of code and same kind of organization. Nothing
I could find on the Web is like the linux kernel ccitt_crc.
Go figure.

Do you suppose it was bit-swapped to bypass a patent?


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

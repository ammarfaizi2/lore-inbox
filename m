Return-Path: <linux-kernel-owner+w=401wt.eu-S932779AbXAJMRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbXAJMRD (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 07:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbXAJMRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 07:17:01 -0500
Received: from spirit.analogic.com ([204.178.40.4]:2575 "EHLO
	spirit.analogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932779AbXAJMRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 07:17:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 10 Jan 2007 12:16:58.0867 (UTC) FILETIME=[39E76430:01C734B1]
Content-class: urn:content-classes:message
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
Date: Wed, 10 Jan 2007 07:16:55 -0500
Message-ID: <Pine.LNX.4.61.0701100715330.16104@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.64.0701100116420.10133@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: macros:  "do-while" versus "({ })" and a compile-time error
Thread-Index: Acc0sTnwDFIsNUZBT521uVqib8aPLw==
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain> <45A3D1DF.4020205@s5r6.in-berlin.de> <Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com> <Pine.LNX.4.64.0701100116420.10133@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jan 2007, Robert P. J. Day wrote:

> On Tue, 9 Jan 2007, linux-os (Dick Johnson) wrote:
>
>>
>> On Tue, 9 Jan 2007, Stefan Richter wrote:
>>
>>> Robert P. J. Day wrote:
>>>>   just to stir the pot a bit regarding the discussion of the two
>>>> different ways to define macros,
>>>
>>> You mean function-like macros, right?
>>>
>>>> i've just noticed that the "({ })"
>>>> notation is not universally acceptable.  i've seen examples where
>>>> using that notation causes gcc to produce:
>>>>
>>>>   error: braced-group within expression allowed only inside a function
>>>
>>> And function calls and macros which expand to "do { expr; } while (0)"
>>> won't work anywhere outside of functions either.
>>>
>>>> i wasn't aware that there were limits on this notation.  can someone
>>>> clarify this?  under what circumstances *can't* you use that notation?
>>>> thanks.
>>>
>>> The limitations are certainly highly compiler-specific.
>>
>> I don't think so. You certainly couldn't write working 'C' code like
>> this:
>>
>>  	do { a = 1; } while(0);
>>
>> This _needs_ to be inside a function. In fact any runtime operations
>> need to be inside functions. It's only in assembly that you could
>> 'roll your own' code like:
>>
>> main:
>>  	ret 0
>>
>>
>> Most of these errors come about as a result of changes where a macro
>> used to define a constant. Later on, it was no longer a constant in
>> code that didn't actually get compiled during the testing.
>
> just FYI, the reason i brought this up in the first place is that i
> noticed that the ALIGN() macro in kernel.h didn't verify that the
> alignment value was a power of 2, so i thought -- hmmm, i wonder if
> there are any invocations where that's not true, so i (temporarily)
> rewrote ALIGN to incorporate that check, and the build blew up
> including include/net/neighbour.h, which contains the out-of-function
> declaration:
>
> struct neighbour
> {
>        ...
>        unsigned char           ha[ALIGN(MAX_ADDR_LEN, sizeof(unsigned long))];
>        ...
>
> so it's not a big deal, it was just me goofing around and breaking
> things.
>
> rday


Hmmm, in that case you would be trying to put code inside a structure!
Neat --if you could do it!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

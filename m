Return-Path: <linux-kernel-owner+w=401wt.eu-S932085AbXAITXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbXAITXG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbXAITXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:23:05 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:2344 "EHLO
	odyssey.analogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbXAITXE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:23:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 09 Jan 2007 19:23:02.0212 (UTC) FILETIME=[946E8840:01C73423]
Content-class: urn:content-classes:message
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
Date: Tue, 9 Jan 2007 14:23:01 -0500
Message-ID: <Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com>
In-Reply-To: <45A3D1DF.4020205@s5r6.in-berlin.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: macros:  "do-while" versus "({ })" and a compile-time error
Thread-Index: Acc0I5SUJVZddknhTaa+cd5/NsLL0w==
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain> <45A3D1DF.4020205@s5r6.in-berlin.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2007, Stefan Richter wrote:

> Robert P. J. Day wrote:
>>   just to stir the pot a bit regarding the discussion of the two
>> different ways to define macros,
>
> You mean function-like macros, right?
>
>> i've just noticed that the "({ })"
>> notation is not universally acceptable.  i've seen examples where
>> using that notation causes gcc to produce:
>>
>>   error: braced-group within expression allowed only inside a function
>
> And function calls and macros which expand to "do { expr; } while (0)"
> won't work anywhere outside of functions either.
>
>> i wasn't aware that there were limits on this notation.  can someone
>> clarify this?  under what circumstances *can't* you use that notation?
>> thanks.
>
> The limitations are certainly highly compiler-specific.

I don't think so. You certainly couldn't write working 'C' code like
this:

 	do { a = 1; } while(0);

This _needs_ to be inside a function. In fact any runtime operations
need to be inside functions. It's only in assembly that you could
'roll your own' code like:

main:
 	ret 0


Most of these errors come about as a result of changes where a macro
used to define a constant. Later on, it was no longer a constant in
code that didn't actually get compiled during the testing.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

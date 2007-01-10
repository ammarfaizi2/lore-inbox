Return-Path: <linux-kernel-owner+w=401wt.eu-S964870AbXAJOHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbXAJOHi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 09:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbXAJOHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 09:07:38 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:2115 "EHLO
	odyssey.analogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964870AbXAJOHh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 09:07:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 10 Jan 2007 14:07:34.0764 (UTC) FILETIME=[AD34EAC0:01C734C0]
Content-class: urn:content-classes:message
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
Date: Wed, 10 Jan 2007 09:07:34 -0500
Message-ID: <Pine.LNX.4.61.0701100859260.16258@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.64.0701100841150.3216@CPE00045a9c397f-CM001225dbafb6>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: macros:  "do-while" versus "({ })" and a compile-time error
Thread-Index: Acc0wK1AkU5eLbRYQUuTJzl/WI23bA==
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain> <45A3D1DF.4020205@s5r6.in-berlin.de> <Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com> <Pine.LNX.4.64.0701100116420.10133@localhost.localdomain> <Pine.LNX.4.61.0701100715330.16104@chaos.analogic.com> <Pine.LNX.4.64.0701100841150.3216@CPE00045a9c397f-CM001225dbafb6>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jan 2007, Robert P. J. Day wrote:

> On Wed, 10 Jan 2007, linux-os (Dick Johnson) wrote:
>
>>
>> On Wed, 10 Jan 2007, Robert P. J. Day wrote:
>
>>> just FYI, the reason i brought this up in the first place is that
>>> i noticed that the ALIGN() macro in kernel.h didn't verify that
>>> the alignment value was a power of 2, so i thought -- hmmm, i
>>> wonder if there are any invocations where that's not true, so i
>>> (temporarily) rewrote ALIGN to incorporate that check, and the
>>> build blew up including include/net/neighbour.h, which contains
>>> the out-of-function declaration:
>>>
>>> struct neighbour
>>> {
>>>        ...
>>>        unsigned char           ha[ALIGN(MAX_ADDR_LEN, sizeof(unsigned long))];
>>>        ...
>>>
>>> so it's not a big deal, it was just me goofing around and breaking
>>> things.
>>>
>>> rday
>>
>>
>> Hmmm, in that case you would be trying to put code inside a
>> structure! Neat --if you could do it!
>
> well, yes, but it does raise a potential issue.  currently, that
> ALIGN() macro is being used to define one of the members of that
> structure.  since it's a "simple" macro, there's no problem.
>
> but there are *plenty* of macros in the source tree that incorporate
> either the "do-while" or "({ })" notation.  what the above implies is
> that the ALIGN() macro can *never* be extended in that way because of
> the way it's being used in the struct definition above, outside of a
> function.
>
> doesn't that place an unnecessarily limit on what might be done with
> ALIGN() in the future?  because of how it's being used in that single
> structure definition, it is forever restricted from being extended.
> isn't that perhaps a dangerous restriction for any macro?
>
> rday

Remember that a macro simply substitutes "text." If the new text doesn't make 
any sense, the compiler will barf. There are gnu extensions such as
__attribute__ that can be used to manipulate structure members in
non-default ways.

Also alignment only occurs when data-space in allocated either at runtime or at 
link time. This knowledge is useful when you are defining structures that will 
have elements accessed by pointers. You put the largest elements (a.k.a. 
sizeof()) at the beginning of the structure.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

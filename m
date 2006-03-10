Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWCJSdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWCJSdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWCJSdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:33:05 -0500
Received: from spirit.analogic.com ([204.178.40.4]:31251 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751308AbWCJSdE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:33:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <4411BF8E.4080306@kenati.com>
x-originalarrivaltime: 10 Mar 2006 18:33:02.0900 (UTC) FILETIME=[10B61740:01C64471]
Content-class: urn:content-classes:message
Subject: Re: How can I link the kernel with libgcc ?
Date: Fri, 10 Mar 2006 13:33:02 -0500
Message-ID: <Pine.LNX.4.61.0603101320510.5057@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How can I link the kernel with libgcc ?
Thread-Index: AcZEcRC/qXRBWo3aSseMP4WncBmuNg==
References: <4410D9F0.6010707@kenati.com> <1141961152.13319.118.camel@mindpipe> <4410F6CB.8070907@kenati.com> <200603101237.35687.vda@ilport.com.ua> <4411BF8E.4080306@kenati.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Carlos Munoz" <carlos@kenati.com>
Cc: "Denis Vlasenko" <vda@ilport.com.ua>, "Lee Revell" <rlrevell@joe-job.com>,
       <Valdis.Kletnieks@vt.edu>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       "alsa-devel" <alsa-devel@lists.sourceforge.net>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Mar 2006, Carlos Munoz wrote:

> Denis Vlasenko wrote:
>
>> On Friday 10 March 2006 05:47, Carlos Munoz wrote:
>>
>>
>>> Lee Revell wrote:
>>>
>>>
>>>
>>>> On Thu, 2006-03-09 at 19:25 -0800, Carlos Munoz wrote:
>>>>
>>>>
>>>>
>>>>
>>>>> I figured out how to get the driver to use floating point operations.
>>>>> I included source code (from an open source math library) for the
>>>>> log10 function in the driver. Then I added the following lines to the
>>>>> file arch/sh/kernel/sh_ksyms.c:
>>>>>
>>>>>
>>>>>
>>>>>
>>>> Where is the source code to your driver?
>>>>
>>>> Lee
>>>>
>>>>
>>>>
>>>>
>>>>
>>> Hi Lee,
>>>
>>> Be warned. This driver is in the early stages of development. There is
>>> still a lot of work that needs to be done (interrupt, dma, etc, etc).
>>>
>>>
>>
>> What? You are using log10 only twice!
>>
>>        if (!(siu_obj_status & ST_OPEN)) {
>> 		...
>>                /* = log2(over) */
>>                ydef[22] = (u_int32_t)(log10((double)(over & 0x0000003f)) /
>>                                       log10(2));
>> 		...
>>        }
>>        else {
>> 		...
>>                if (coef) {
>>                        ydef[16] = 0x03045000 | (over << 26) | (tap - 4);
>>                        ydef[17] = (tap * 2 + 1);
>>                        /* = log2(over) */
>>                        ydef[22] = (u_int32_t)
>>                                (log10((double)(over & 0x0000003f)) / log10(2));
>>                }
>>
>> Don't you think that log10((double)(over & 0x0000003f)) / log10(2)
>> can have only 64 different values depending on the result of (over & 0x3f)?
>>
>> Obtain them from precomputed uint32_t log10table[64].
>> --
>> vda
>>
>>
> Hi Denis,
>
> Yes, the driver code so far only uses log10 twice, but there will be
> more uses for it as I populate the rest of the tables. However, I think
> its use will be some what limited. I wasn't aware that the floating
> point registers are not saved. I'll investigate a way to create a table
> with pre-calculated log10 values.
>
> Thanks,
>
>
> Carlos

Since the log in base n is the log in any base times a constant,
you can probably use log base 2 (binary bit position) and multiply
the result by a constant, which may simply be shifts and adds.

I assume you are using 16-bit audio. If so, the dynamic range
is only 20 * log10(2^16) = 96.3 dB. That means that attenuation
from mininum to maximum, in 1 dB steps, requires only 94 values.

Your code shows something whacked off at 0x3f = 0->0x40 = 64
20 * log10(64) = 36 dB for only 36 values. Clearly, you don't
need floating point, just some thought ahead of time.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

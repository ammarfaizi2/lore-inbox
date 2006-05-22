Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWEVLs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWEVLs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWEVLs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:48:26 -0400
Received: from spirit.analogic.com ([204.178.40.4]:35597 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750764AbWEVLsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:48:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 22 May 2006 11:47:32.0502 (UTC) FILETIME=[82D1BB60:01C67D95]
Content-class: urn:content-classes:message
Subject: Re: [RFC PATCH (take #2)] i386: kill CONFIG_REGPARM completely
Date: Mon, 22 May 2006 07:47:31 -0400
Message-ID: <Pine.LNX.4.61.0605220739580.26623@chaos.analogic.com>
In-Reply-To: <305c16960605201500s6153e1doad87e4b85f15b53f@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH (take #2)] i386: kill CONFIG_REGPARM completely
Thread-Index: AcZ9lYLbfWcAv6qoSaScna4wWJ0l2g==
References: <20060520025353.GE9486@taniwha.stupidest.org> <20060520090614.GA9630@infradead.org> <20060520201357.GA32010@taniwha.stupidest.org> <20060520212049.GA11180@taniwha.stupidest.org> <305c16960605201500s6153e1doad87e4b85f15b53f@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Matheus Izvekov" <mizvekov@gmail.com>
Cc: "Chris Wedgwood" <cw@f00f.org>, "Christoph Hellwig" <hch@infradead.org>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 May 2006, Matheus Izvekov wrote:

> On 5/20/06, Chris Wedgwood <cw@f00f.org> wrote:
>> Take #2.
>>
>> Kill of CONFIG_REGPARM completely.
>>
>>
>> diff --git a/Documentation/stable_api_nonsense.txt b/Documentation/stable_api_nonsense.txt
>> index f39c9d7..ac11b81 100644
>> --- a/Documentation/stable_api_nonsense.txt
>> +++ b/Documentation/stable_api_nonsense.txt
>> @@ -62,9 +62,8 @@ consider the following facts about the L
>>        - different structures can contain different fields
>>        - Some functions may not be implemented at all, (i.e. some locks
>>         compile away to nothing for non-SMP builds.)
>> -      - Parameter passing of variables from function to function can be
>> -       done in different ways (the CONFIG_REGPARM option controls
>> -       this.)
>> +      - Parameter passing of variables from function to function can
>> +       be done in different ways.
>
> Why not kill those 2 lines too? Now that non-regparm is gone, it
> doesnt make sense to say there are different ways to pass parameters,
> there is only regparm now, right?
>

On ix86 there are not enough registers to pass a significant parameter
list all in registers! Like when you are printk()ing a dotted-quad IP
address, etc. Registers ESI, EDI, and EBX are precious, that leaves
EAX, ECX, EDX and possibly EBP for only 4 parameters. You need 5
for the dotted quad IP address. If the compiler were to use the
precious registers, the contents need to be saved on the stack.
That negates any advantage to passing parameters in registers.

This means that REGPARM will always remain a "hint" to the compiler,
not some absolute order.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

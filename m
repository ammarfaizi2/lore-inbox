Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVLPVfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVLPVfY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVLPVfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:35:24 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:24331 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932462AbVLPVfX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:35:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.62.0512161304120.5919@qynat.qvtvafvgr.pbz>
X-OriginalArrivalTime: 16 Dec 2005 21:35:20.0663 (UTC) FILETIME=[9D6D4670:01C60288]
Content-class: urn:content-classes:message
Subject: Re: [2.6 patch] i386: always use 4k stacks 
Date: Fri, 16 Dec 2005 16:35:09 -0500
Message-ID: <Pine.LNX.4.61.0512161620520.31619@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] i386: always use 4k stacks 
Thread-Index: AcYCiJ124O1jmau5TEqqK1+HFvITpg==
References: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl> <Pine.LNX.4.61.0512161407270.31274@chaos.analogic.com> <Pine.LNX.4.62.0512161304120.5919@qynat.qvtvafvgr.pbz>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "David Lang" <dlang@digitalinsight.com>
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <arjan@infradead.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Dec 2005, David Lang wrote:

> On Fri, 16 Dec 2005, linux-os (Dick Johnson) wrote:
>
>> On Fri, 16 Dec 2005, Horst von Brand wrote:
>>
>>> linux-os \(Dick Johnson\) <linux-os@analogic.com> wrote:
>>>
>>> [...]
>>>
>>>> Throughout the past two years of 4k stack-wars, I never heard why
>>>> such a small stack was needed (not wanted, needed). It seems that
>>>> everybody "knows" that smaller is better and most everybody thinks
>>>> that one page in ix86 land is "optimum". However I don't think
>>>> anybody ever even tried to analyze what was better from a technical
>>>> perspective. Instead it's been analyzed as religious dogma, i.e.,
>>>> keep the stack small, it will prevent idiots from doing bad things.
>>>
>>> OK, so here goes again...
>>>
>>> The kernel stack has to be contiguous in /physical/ memory. Keep the
>> stack
>>> /one/ page, that way you can always get a new stack when needed (==
>> each
>>> fork(2) or clone(2)). If the stack is 2 (or more) pages, you'll have
>> to
>>> find (or create) a multi-page free area, and (fragmentation being what
>> it
>>> is, and Linux routinely running for months at a time) you are in a
>> whole
>>> new world of pain.
>>
>> The interrupt stack needs to be non-paged. Are you sure the user-stacks
>> need to be 'physical', non-paged too? If so, that's probably the
>> problem. All addresses accessed by the CPUs in the kernel are virtual
>> which means one needs some mapping anyway.
>
> actually, the kernel always uses real addresses, userspace uses virtual
> addresses.
>

No. Hint: What is PAGE_OFFSET?
Everything the CPU executes/reads/writes is translated from physical (bus)
addresses to virtual addresses.

What you may have heard or read is that the address-space that the
kernel uses for its code and resident data has fixed translation tables
which means one doesn't have to scan a bunch of tables to locate the
bus address, given the virtual address.

physical_address = virtual_address  - PAGE_OFFSET;
virtual_address  = physical_address + PAGE_OFFSET;

This is totally an artifact of how the page-tables are set up.

> This came up recently with the page tables, Linus said that he was
> absolutly opposed to adding the complication and overhead of changine the
> kernel to user virtual addresses instead of real addresses for it's data
> structures. it would add an extra level of redirection to just about every
> memory access (which also means an additional load on the cache to store
> the mapping info to resolve this redirection). The performance hit for
> this would be considerable.
>
> David Lang
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

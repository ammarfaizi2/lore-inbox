Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWCBVcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWCBVcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWCBVcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:32:18 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:29196 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932245AbWCBVcR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:32:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <9738BCBE884FDB42801FAD8A7769C2651420C5@NAMAIL1.ad.lsil.com>
x-originalarrivaltime: 02 Mar 2006 21:32:14.0388 (UTC) FILETIME=[C5CAF740:01C63E40]
Content-class: urn:content-classes:message
Subject: RE: Question: how to map SCSI data DMA address to virtual address?
Date: Thu, 2 Mar 2006 16:32:09 -0500
Message-ID: <Pine.LNX.4.61.0603021628190.14946@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question: how to map SCSI data DMA address to virtual address?
Thread-Index: AcY+QMXSG1hMb6MOSsqdfLb1l0rxpA==
References: <9738BCBE884FDB42801FAD8A7769C2651420C5@NAMAIL1.ad.lsil.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: "Jens Axboe" <axboe@suse.de>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Mar 2006, Ju, Seokmann wrote:

> Hi,
>
> On Thursday, March 02, 2006 3:04 PM Dick Johnson wrote:
>> On Thu, 2 Mar 2006, Jens Axboe wrote:
>>
>>> On Thu, Mar 02 2006, linux-os (Dick Johnson) wrote:
>>>>
>>>> On Thu, 2 Mar 2006, Ju, Seokmann wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> In the 'scsi_cmnd' structure, there are two entries
>> holding address
>>>>> information for data to be transferred. One is
>> 'request_buffer' and the
>>>>> other one is 'buffer'.
>>>>> In case of 'use_sg' is non-zero, those entries indicates
>> the address of
>>>>> the scatter-gather table.
>>>>>
>>>>> Is there way to get virtual address (so that the data
>> could be accessed
>>>>> by the driver) of the actual data in the case of 'use_sg'
>> is non-zero?
>>>>>
>>>>> Any comments would be appreciated.
>>>>>
>>>>>
>>>>> Thank you,
>>>>>
>>>>> Seokmann
>>>>> -
>>>>
>>>> There is a macro for this purpose. However, for experiments, in
>>>> the kernel, you can add PAGE_OFFSET (0xC00000000) to get
>> the virtual
>>>> address. The macro is __va(a), its inverse is __pa(a).
>>>>
>>>> Careful. These things can change.
>>>
>>> Bzzt no, this wont work if an iommu is involved. It also
>> wont work if
>>> the page doesn't have a virtual address mapping (think highmem).
>>>
>>> --
>>
>>> Jens Axboe
>>>
>>
>> Are you going to get DMA-able pages out of high memory? The guy is
>> doing scatter-table DMA, i.e., linked DMA. I think you need to
>> build that table with pages from get_dma_page(). If you use
>> highmem, somebody can program the iommu right out from under
>> the DMA engine while a DMA is in progress because the CPU is
>> not involved and can be executing lots of code that can do lots
>> of bad things.

> Thank you for your valueable comment. One good thing is that the system
> does 2 GB memory so that highmem won't come into picture. I am implementing
> the feature with suggestions.
>
> Thank you again,
>
> Seokmann
>

You're welcome. Sometimes the simplest thing is the best thing, especially
for a debugging hack. Of course, Jens may be "more perfectly" correct,
but since you are just checking to see the correct data in your
DMA scatter list, and the memory is "DMA pages", the hack will work.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

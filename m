Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWCBUEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWCBUEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCBUEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:04:10 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:29448 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751283AbWCBUEI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:04:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060302184902.GW4329@suse.de>
x-originalarrivaltime: 02 Mar 2006 20:03:54.0701 (UTC) FILETIME=[6EEEE7D0:01C63E34]
Content-class: urn:content-classes:message
Subject: Re: Question: how to map SCSI data DMA address to virtual address?
Date: Thu, 2 Mar 2006 15:03:49 -0500
Message-ID: <Pine.LNX.4.61.0603021458060.14681@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question: how to map SCSI data DMA address to virtual address?
Thread-Index: AcY+NG74O2RlmuLlQfiZHI7NABNhpw==
References: <9738BCBE884FDB42801FAD8A7769C2651420C1@NAMAIL1.ad.lsil.com> <Pine.LNX.4.61.0603021203280.14257@chaos.analogic.com> <20060302184902.GW4329@suse.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Ju, Seokmann" <Seokmann.Ju@lsil.com>,
       "Ju, Seokmann" <Seokmann.Ju@engenio.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Mar 2006, Jens Axboe wrote:

> On Thu, Mar 02 2006, linux-os (Dick Johnson) wrote:
>>
>> On Thu, 2 Mar 2006, Ju, Seokmann wrote:
>>
>>> Hi,
>>>
>>> In the 'scsi_cmnd' structure, there are two entries holding address
>>> information for data to be transferred. One is 'request_buffer' and the
>>> other one is 'buffer'.
>>> In case of 'use_sg' is non-zero, those entries indicates the address of
>>> the scatter-gather table.
>>>
>>> Is there way to get virtual address (so that the data could be accessed
>>> by the driver) of the actual data in the case of 'use_sg' is non-zero?
>>>
>>> Any comments would be appreciated.
>>>
>>>
>>> Thank you,
>>>
>>> Seokmann
>>> -
>>
>> There is a macro for this purpose. However, for experiments, in
>> the kernel, you can add PAGE_OFFSET (0xC00000000) to get the virtual
>> address. The macro is __va(a), its inverse is __pa(a).
>>
>> Careful. These things can change.
>
> Bzzt no, this wont work if an iommu is involved. It also wont work if
> the page doesn't have a virtual address mapping (think highmem).
>
> --
> Jens Axboe
>

Are you going to get DMA-able pages out of high memory? The guy is
doing scatter-table DMA, i.e., linked DMA. I think you need to
build that table with pages from get_dma_page(). If you use
highmem, somebody can program the iommu right out from under
the DMA engine while a DMA is in progress because the CPU is
not involved and can be executing lots of code that can do lots
of bad things.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

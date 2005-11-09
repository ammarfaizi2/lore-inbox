Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVKIUqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVKIUqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVKIUqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:46:12 -0500
Received: from spirit.analogic.com ([204.178.40.4]:8208 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750779AbVKIUqK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:46:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <437258CD.8060206@esoterica.pt>
References: <437258CD.8060206@esoterica.pt>
X-OriginalArrivalTime: 09 Nov 2005 20:46:09.0853 (UTC) FILETIME=[9D52A6D0:01C5E56E]
Content-class: urn:content-classes:message
Subject: Re: Accessing file mapped data inside the kernel
Date: Wed, 9 Nov 2005 15:46:06 -0500
Message-ID: <Pine.LNX.4.61.0511091530510.12760@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Accessing file mapped data inside the kernel
Thread-Index: AcXlbp12VK5YW6SLT1Kw2hCN3FQYTg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Paulo da Silva" <psdasilva@esoterica.pt>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Nov 2005, Paulo da Silva wrote:

> Hi.
>
> I posted about this a few days ago but got no responses
> so far! I think this should be a trivial question for those
> involved in the kernel internals. May be I didn't develop
> the problem enough to be understood.
>
> So, here is the question reformulated.
>
> A given file system must supply a procedure for mmap.
>
> int <fsname>_file_mmap(struct file * file, struct vm_area_struct * vma)
> {
>   int addr;
>   addr=generic_file_mmap(file,vma);
>   <Code to access addr pointed bytes or vma->vm_start>
>   return addr;
> }
>

The mmap() code in the kernel in your module contains the physical
location of the memory-mapped data as the third parameter to
remap_pfn_range(a, b, c, d, e);
                       |____________ here.

Your code should have put the bus address of your memory
into that location as PAGES, which means you shifted it right
by PAGE_SHIFT. If you got your memory from get_dma_pages()
or similar, you needed to convert the virtual address using
virt_to_bus() so you already have the virtual address. If
not, you need to get the virtual address by taking this
page address and shifting it left by PAGE_SHIFT. Then you
convert that address to virtual using bus_to_virt().

[SNIPPED...]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274639AbRIYLPb>; Tue, 25 Sep 2001 07:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274641AbRIYLPU>; Tue, 25 Sep 2001 07:15:20 -0400
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:26040 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S274639AbRIYLPJ>; Tue, 25 Sep 2001 07:15:09 -0400
Message-ID: <012101c145b3$c43a1d50$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: =?ks_c_5601-1987?B?waTC+by6?= <csjung@dreamintek.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.ncuedqv.80oc2g@ifi.uio.no>
Subject: Re: Hi.... I guess linux-kernel..
Date: Tue, 25 Sep 2001 07:18:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to know, how use continuous memory over 128k at linux kernel...
> kmalloc is 128k limit...
> But, I want continous memory over 128k at linux kernel...

kmalloc() returns physically contiguous regions of memory. The 128KB limit
exists because it is difficult to find a free memory block that large in a
running system, due to fragmentation.

You have two options - if you can use a virtually (but not physically)
contiguous region of memory, use vmalloc(). This works fine for kernel data
structures. If you are using the memory as a DMA buffer however, you need to
be aware that the pages are not physically contiguous, so you have to DMA
each page individually (scatter/gather). Also for DMA to 32-bit PCI devices,
use vmalloc_32() instead of vmalloc() (which might give you high-memory
pages that are inaccessible to 32-bit devices).

The second option is to grab a large physically-contiguous region of memory
at boot time. There are a few kernel patches available that provide this
feature, although I haven't used them. For a really quick hack, you can use
the "mem=xxxM" boot-time option to tell the kernel to use less physical
memory than you actually have, and then claim the remaining memory for your
own use.

Regards,
Dan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUIXDMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUIXDMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUIXDML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:12:11 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:22858 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S267325AbUIXDIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 23:08:30 -0400
Date: Thu, 23 Sep 2004 21:07:59 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PCI Burst
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <003901c4a1e3$b2ae1de0$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.qb32f1i.oj0poe@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two things that I'd check, that the memory range shows up as prefetchable 
(i.e. in lspci) and also that the memory region is mapped with ioremap and 
not ioremap_nocache. Also, what's the region defined as in /proc/mtrr? I 
think it has to be mapped as write-back for burst reads to work. When the 
CPU reads in a cache line in that memory range from the bus, that should 
hopefully get passed through as a burst read on the PCI bus, but that may be 
chipset-dependent.

Getting PIO-mode PCI reads and writes like this to work efficiently seems a 
rather difficult thing to do..


----- Original Message ----- 
From: "Brian McGrew" <Brian@doubledimension.com>
Newsgroups: fa.linux.kernel
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, September 23, 2004 7:22 PM
Subject: PCI Burst


> Running RedHat 7.3 with the 2.4.20 kernel.
>
> How do I enable PCI burst mode for reading and writing on the PCI bus?  We 
> mmap 128MB per board that we install and now that we've added our 
> addressing to the /proc/mtrr file, we can burst on write but we're not 
> seeing any burst on the read.
>
> Any ideas?
>
> -brian
>
> Brian D. McGrew {brian@doubledimension.com || pacemakertaker@rock.com }
> ---
>> Failure is not an option; it is included with every Microsoft product.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 


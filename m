Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbVLOBWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVLOBWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbVLOBWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:22:46 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18152 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965099AbVLOBWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:22:45 -0500
Date: Wed, 14 Dec 2005 19:22:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Strange delay on PCI-DMA-transfer completion by
 wait_event_interruptible()
In-reply-to: <5jzIB-3pY-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43A0C55D.2070500@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
References: <5jzIB-3pY-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burkhard Schölpen wrote:
> I'm glad to meet somebody with dma experience, because I have
> some other difficulties concerning DMA buffers in RAM. The PCI-Board
> is to be applied in a large size copying machine, so it essentially
> has to transfer tons of data in 2 directions very fast without wasting
> cpu time (because the cpu has to run many image processing algorithms
> meanwhile on this data). So my approach is to allocate a quite large
> ringbuffer in kernel space (or more precisely one ringbuffer for each
> direction) which is capable of dma. Afterwards I would map this buffer
> to user space to avoid unnecessary memcopies/cpu usage. My problem is
> for now to get such a large DMA buffer. I tried out several things I
> read in O'Reilly's book, but they all failed so far. My current
> attempt is to take a high memory area with ioremap:

You can't ioremap normal memory like that. ioremap is only for MMIO 
address regions.

Better than trying to allocate lots of memory in the kernel (which you 
can't, really), would be to make the userspace application allocate the 
ringbuffer and do DMA from the device to userspace memory. To do this, 
you'll have to either make the device do a separate DMA for every 
contiguous chunk, or better yet make the device support scatter-gather 
DMA so that it can read/write from discontiguous physical blocks of 
memory. Have a look at Documentation/DMA-mapping.txt and 
Documentation/DMA-API.txt, also at the Linux Device Drivers 3rd ed. 
online book, these all have info on how this can be done.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


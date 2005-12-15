Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVLOTJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVLOTJA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVLOTI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:08:59 -0500
Received: from outmx017.isp.belgacom.be ([195.238.2.116]:10706 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750911AbVLOTI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:08:59 -0500
From: Laurent Pinchart <laurent.pinchart@skynet.be>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VM_RESERVED and PG_reserved : Allocating memory for video buffers
Date: Thu, 15 Dec 2005 20:09:33 +0100
User-Agent: KMail/1.9
X-Face: 4Mf^tnii7k\_EnR5aobBm6Di[DZ9@AX1wJ"okBdX-UoJ>:SRn]c6DDU"qUIwfs98vF>=?utf-8?q?Tnf=0A=09SacR=7B?=(0Du"N%_.#X]"TXx)A'gKB1i7SK$CTLuy{h})c=g:'w3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512152009.33758.laurent.pinchart@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I'm writing a Linux driver for a USB Video Class compliant USB device. I 
manage to understand pretty much everything on my own until the point where I 
have to allocate video buffers.

I read other drivers to understand how they proceed. Most of them used vmalloc 
with SetPageReserved and remap_pfn_range to map the memory to user space. I 
thought I understood that, when I noticed that vm_insert_page has been added 
in 2.6.15. I wasn't sure how to prevent pages from being swapped out, so I 
read the excellent "Understanding the Linux Virtual Memory Manager", but I'm 
still not sure to understand everything. This is where I ask for your help.

I need to allocate big buffers, so vmalloc is the way to go, as I don't need 
contiguous memory. I need to map those buffers to user space, and I 
understand that vm_insert_page will do the job nicely. My fears come from 
pages being swapped out. I suppose I need to prevent that, as a page fault in 
interrupt is a Bad Thing(TM). I'm not sure how PG_reserved and VM_RESERVED 
interract with eachother. Can kernel pages be swapped out if they are not 
mapped to user space ? Or does kswapd only walk VMAs when it tries to find 
pages that will be swapped out ? If the later is true, is it enough to set 
VM_RESERVED on the VMA in the mmap handler ?

Memory management is quite complex in the Linux kernel, and I definitely need 
some help to understand how all the magic is performed :-)

Best regards,

Laurent Pinchart

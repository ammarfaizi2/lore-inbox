Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWECVS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWECVS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWECVS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:18:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:35612 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751271AbWECVS5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:18:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t+vmOfMC4LbzB1UBlvvT/lU67kUfVzOamW8QQi1pYKYRDysUn1diYauSHxhfuMV0CF5iD8iOtqXMVS1swnec5EySoB3d2DD829PiaFnHai0Y3YT9HnxskQORenWGQ02EdY9NwpNs/FlgMKjOAc3D4FeVxdb28T/DPa00cXmVGcI=
Message-ID: <ae59f9ef0605031418o38b8c227le87e2906effb08c3@mail.gmail.com>
Date: Wed, 3 May 2006 14:18:56 -0700
From: "Ice Cold" <iscsiet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: DMA remap_pfn_range VM_IO pci_map_sg
In-Reply-To: <1146690339.515246.155630@u72g2000cwu.googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146690339.515246.155630@u72g2000cwu.googlegroups.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Group,


I have a few fundamental DMA questions which i need help with. These
are all relating to kernel 2.6+.


I have 40 megs of memory set aside for DMA. (This is an embedded device
so i can afford to do this). This memory is set aaside using the mem= option
on the boot line. I need to DMA data to parts of this memory. The DMA card
is a PCI based card with no addressing limitations. I want to make use of
the 2.6DMA API.


The reserved memory is given to anyone who requests it via the MMAP
call, internally it uses remap_pfn_range to fix up the page tables.


Call sequence.
1. Userspace mmaps a large chuck on this memory, and then breaks it up
intoa chunk, and wants to DMA data from the imaging device to this chunck.

2. It fires an IOCTL to my driver passing a start pointer to this chunk
and the len.


In the driver, i want to be able to
1. Create a scatter gather list for this chunk.
2. use pci_map_sg to map these pages.
3. use sg_address and sg_len to get the bus addresses.
4. using the bus address i want to populate the datastructures for this
card and start the DMA.


Questions.
1. To generate the scatter gather list, i need to get a list of pages
for the memory region passed to me? How do i do that? i know
get_user_pages cannot be called since it does not work on VM_IO
regions and remap_pfn_range marks the vma as VM_IO.
2. Is there any sample driver you know of which does similar stuff?


I'm open to suggestions and ideas.


rcn

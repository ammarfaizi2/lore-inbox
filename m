Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422882AbWHYXQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422882AbWHYXQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWHYXQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:16:14 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:42844 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932082AbWHYXQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:16:14 -0400
Date: Fri, 25 Aug 2006 17:16:12 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: FYI: 2.6.16-smp: DMA memory inbalance for NUMA?
In-reply-to: <fa.d2R7xkpalRzvzmCBKdBsGj9J31U@ifi.uio.no>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <44EF84BC.8030706@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.d2R7xkpalRzvzmCBKdBsGj9J31U@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:
> Hi,
> 
> my apologies if this is an issue already solved:
> I have no idea what these messages exactly say, but for reasons of symmetry I 
> think there's something wrong:
> For a Sun Fire X4100 with two Dual_Core Operon processors, the kernel (SLES10 
> kernel (x86_64, 2.6.16.21-0.15-smp)) says during boot:
> 
> <6>SRAT: PXM 0 -> APIC 0 -> Node 0
> <6>SRAT: PXM 0 -> APIC 1 -> Node 0
> <6>SRAT: PXM 1 -> APIC 2 -> Node 1
> <6>SRAT: PXM 1 -> APIC 3 -> Node 1
> <6>SRAT: Node 0 PXM 0 100000-f4000000
> <6>SRAT: Node 1 PXM 1 20c000000-40c000000
> <6>SRAT: Node 0 PXM 0 100000-20c000000
> <6>SRAT: Node 0 PXM 0 0-20c000000
> 
> [[ Note: "Node 0" is mentioned three times, but "Node 1" is only mentioned once. 
> If this is intended to be some address assignments, they look quite odd to me. 
> Does the following really mean that only one node can do DMA (the other has zero 
> DMA pages)? ]]

DMA is not done only to the DMA zones. The DMA zone is for devices that 
can only address 24-bit addresses (ISA/LPC devices). The DMA32 zone is 
for devices that can only address 4GB of memory.

I suppose you could say there is a bit of an imbalance between nodes but 
hopefully these are both (especially ZONE_DMA) rarely used in any sane 
setup so it wouldn't make much difference. Since these zones are based 
on bus-visible physical addresses I'm not sure if this could be fixed in 
any case.

> 
> <6>ACPI: SLIT table looks invalid. Not used.
> <7>NUMA: Using 26 for the hash shift.
> <6>Bootmem setup node 0 0000000000000000-000000020c000000
> <6>Bootmem setup node 1 000000020c000000-000000040c000000
> <7>On node 0 totalpages: 2066745
> <7>  DMA zone: 2993 pages, LIFO batch:0
> <7>  DMA32 zone: 981032 pages, LIFO batch:31
> <7>  Normal zone: 1082720 pages, LIFO batch:31
> <7>  HighMem zone: 0 pages, LIFO batch:0
> <7>On node 1 totalpages: 2068480
> <7>  DMA zone: 0 pages, LIFO batch:0
> <7>  DMA32 zone: 0 pages, LIFO batch:0
> <7>  Normal zone: 2068480 pages, LIFO batch:31
> <7>  HighMem zone: 0 pages, LIFO batch:0

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


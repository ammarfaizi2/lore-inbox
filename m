Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVLXXhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVLXXhV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 18:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVLXXhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 18:37:21 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44930 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750753AbVLXXhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 18:37:20 -0500
Date: Sat, 24 Dec 2005 17:37:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: pci-dma disables iommu on nforce4 motherboards?
In-reply-to: <5njvv-JD-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: safemode@comcast.net
Message-id: <43ADDBA3.9010701@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5njvv-JD-11@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> I have an asus A8N-E motherboard and recieve the following message on boot.
> PCI-DMA: Disabling IOMMU.
> 
> I have no issues with anything not functioning.  I guess i'm just 
> curious as to why this is done and if i'm missing out on any sort of 
> performance gain by not using the iommu.   I have less than 4GB of ram, 
> would that be why it's disabled (which is why i think it is)?  -

The IOMMU is not needed if your RAM all lies below 4GB (note that due to 
memory space used for PCI and PCI-E resources, even with only 4GB of 
memory, some may end up above 4GB). The purpose of the IOMMU is to allow 
32-bit devices which cannot access memory above 4GB to read from such 
memory. If the system does not have an IOMMU (i.e. the Intel CPUs with 
EM64T) then bounce buffers must be used when these devices want to 
perform DMA to memory above 4GB, which reduces performance.

On some platforms the IOMMU can be used to remap memory such that a 
discontigous memory region appears contiguous to the device, so that it 
can perform DMA transfers in larger chunks. I suspect the performance 
benefit of this is somewhat negated by the time to set up the IOMMU 
mapping, however.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


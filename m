Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbSL1SCT>; Sat, 28 Dec 2002 13:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266256AbSL1SCT>; Sat, 28 Dec 2002 13:02:19 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:39058 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S266250AbSL1SCS>; Sat, 28 Dec 2002 13:02:18 -0500
Date: Sat, 28 Dec 2002 10:16:38 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFT][PATCH] generic device DMA implementation
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E0DEA86.8050804@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212281618.gBSGI7Q02415@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> david-b@pacbell.net said:
> 
>>The indirection is getting from the USB device (or interface) to the
>>object representing the USB controller.  ...
> 
> This sounds like a mirror of the problem of finding the IOMMU on parisc (there 
> can be more than one).

Wouldn't it be straightforward to package that IOMMU solution using the
"call dev->whatsit->dma_op()" approach I mentioned?  Storing data in
the "whatsit" seems more practical than saying driver_data is no longer
available to the device's driver.  (I'll be agnostic on platform_data.)

This problem seems to me to be a common layering requirement.  All the
indirections are known when the device structure is being initted, so it
might as well be set up then.  True for PARISC (right?), as well as USB,
SCSI, and most other driver stacks.  I suspect it'd even allow complex
voodoo for multi-path I/O too...

- Dave


> The way parisc solves this is to look in dev->platform_data and if that's null 
> walk up the dev->parent until the IOMMU is found and then cache the IOMMU ops 
> in the current dev->platform_data.  Obviously, you can't use platform_data, 
> but you could use driver_data for this.  The IOMMU's actually lie on a parisc 
> specific bus, so the ability to walk up the device tree without having to know 
> the device types was crucial to implementing this.
> 
> James
> 
> 
> 




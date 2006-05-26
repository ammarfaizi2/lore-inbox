Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWEZCEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWEZCEj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 22:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWEZCEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 22:04:39 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24308 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030203AbWEZCEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 22:04:38 -0400
Date: Thu, 25 May 2006 20:03:14 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 3ware 7500 not working in 2.6.16.18, 2.6.17-rc5
In-reply-to: <6gn8D-4AV-13@gated-at.bofh.it>
To: Jan Kasprzak <kas@fi.muni.cz>, linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <447661E2.5020103@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6gn8D-4AV-13@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
> 	Hi all,
> 
> I have a 3ware 75xx P-ATA controller, which has been working in 2.6.15-rc2.
> Today I have tried to upgrade to 2.6.16.18, and it cannot boot - the
> controller cannot access the drives, with the attached messages.
> I have also tried 2.6.17-rc5 with the same results.

...

> 3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.
> nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
> sd 0:0:0:0: SCSI error: return code = 0x70000
> end_request: I/O error, dev sda, sector 0
> Buffer I/O error on device sda, logical block 0
> nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
> 3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.
> [... and so on, the same for all eight drives sda to sdh ...]

It looks like this controller only supports 32-bit DMA addresses. For 
some reason it's trying to feed in an SG list with addresses over 4GB, 
which fails. I'd think this configuration should work, but maybe not?

It looks like you have IOMMU turned off - I think you'll really want to 
turn that on with that much RAM (12GB). Even if this case did work as 
well as it could, without IOMMU the kernel would have to bounce-buffer 
the data below 4GB which will kill performance.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


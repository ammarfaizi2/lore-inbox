Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVA1TYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVA1TYd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVA1TRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:17:42 -0500
Received: from lists.us.dell.com ([143.166.224.162]:50575 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262776AbVA1TPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:15:09 -0500
Date: Fri, 28 Jan 2005 13:14:58 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Mark Haverkamp <markh@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: out of memory question
Message-ID: <20050128191458.GA21601@lists.us.dell.com>
References: <1106934186.27858.40.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106934186.27858.40.camel@markh1.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 09:43:06AM -0800, Mark Haverkamp wrote:
> 
> I have a situation where the out of memory killer kicked in and killed
> off a process.  From the information displayed, it looks like there was
> a lot of free memory available.  I need some help interpreting the
> output. I have included the console output from the oom killer.
> 
> It is running 2.6.11-rc2 and has a patch from Nick Piggin:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110665524811826&w=2
> The machine is running as an iscsi target with 4K luns configured.

What is eating all of your ZONE_DMA?  Of the 16MB available

> DMA: 55*4kB 4*8kB 2*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 348kB
> DMA free:348kB min:68kB low:84kB high:100kB active:4kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
> protections[]: 0 0 0

only 348kB is available, and something is requesting more...

> oom-killer: gfp_mask=0xd1  (__GFP_FS|__GFP_IO|__GFP_WAIT|__GFP_DMA)


This isn't a 64-bit architecture (you've got some ZONE_HIGHMEM), so
it's not like the x86_64/ia64 iommu.  Perhaps a
<32-bit DMA address mask PCI device?

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVA1T2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVA1T2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVA1TY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:24:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:9857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262769AbVA1TVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:21:47 -0500
Subject: Re: out of memory question
From: Mark Haverkamp <markh@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050128191458.GA21601@lists.us.dell.com>
References: <1106934186.27858.40.camel@markh1.pdx.osdl.net>
	 <20050128191458.GA21601@lists.us.dell.com>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 11:21:42 -0800
Message-Id: <1106940102.27858.41.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 13:14 -0600, Matt Domsch wrote:
> On Fri, Jan 28, 2005 at 09:43:06AM -0800, Mark Haverkamp wrote:
> > 
> > I have a situation where the out of memory killer kicked in and killed
> > off a process.  From the information displayed, it looks like there was
> > a lot of free memory available.  I need some help interpreting the
> > output. I have included the console output from the oom killer.
> > 
> > It is running 2.6.11-rc2 and has a patch from Nick Piggin:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=110665524811826&w=2
> > The machine is running as an iscsi target with 4K luns configured.
> 
> What is eating all of your ZONE_DMA?  Of the 16MB available
> 
> > DMA: 55*4kB 4*8kB 2*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 348kB
> > DMA free:348kB min:68kB low:84kB high:100kB active:4kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
> > protections[]: 0 0 0
> 
> only 348kB is available, and something is requesting more...
> 
> > oom-killer: gfp_mask=0xd1  (__GFP_FS|__GFP_IO|__GFP_WAIT|__GFP_DMA)
> 
> 
> This isn't a 64-bit architecture (you've got some ZONE_HIGHMEM), so
> it's not like the x86_64/ia64 iommu.  Perhaps a
> <32-bit DMA address mask PCI device?
> 

Thanks for the help.  I have somewhere to start looking now.

Mark.

> 
-- 
Mark Haverkamp <markh@osdl.org>


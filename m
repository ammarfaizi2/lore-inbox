Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266617AbUAWSML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266601AbUAWSMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:12:09 -0500
Received: from mailhub.hp.com ([192.151.27.10]:55742 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S266617AbUAWSLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:11:38 -0500
Subject: RE: pci_alloc_consistent()
From: Alex Williamson <alex.williamson@hp.com>
To: Leonid Grossman <leonid.grossman@s2io.com>
Cc: "'Jes Sorensen'" <jes@wildopensource.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'ravinandan arakali'" <ravinandan.arakali@s2io.com>, iod00d@hp.com
In-Reply-To: <000001c3e1be$79904640$0400a8c0@S2IOtech.com>
References: <000001c3e1be$79904640$0400a8c0@S2IOtech.com>
Content-Type: text/plain
Message-Id: <1074881493.26664.31.camel@wilson.home.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 11:11:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 07:37, Leonid Grossman wrote:
> Hi Jes,
> 
> > Leonid,
> > 
> > What type of Itanium box? It's possible what you're seeing is 
> > caused by a bug in the IOMMU code, but we would need to know 
> > which one (HP, SGI or someone else's).
> 
> The problem with pci_alloc_consistent()above 1MB happens on HP rx2600
> (this is 2U dual-Itanium 900MHz pci-x 133 box). I don't believe it
> happens on 64 bit Opterons. Today we are going to test Dell and SGI
> Itanium systems, as well as a bit newer rx 2600 with Itanium-2 1.5GHz -
> I'll let you know by the end of the day.

   The iommu code on zx1 boxes is currently limited to consistent
mappings of 64 * PAGE_SIZE.  We need to implement the consistent dma
mask interface so that 64bit devices can bypass the iommu and dma as
much as they'd like.  If you change your system page size to 64k, you
should be able to get up to 4MB mappings with the current code.  Sounds
like we need to do a BUG or something to make it more obvious how this
is failing.  It should be a pretty simple update to sba_iommu to make it
start looking at consistent_dma_mask in this path.  I'll try to get a
patch sent out for it on 2.6.  Thanks,

	Alex


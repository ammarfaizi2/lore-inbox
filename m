Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTGATor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTGATor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:44:47 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:29346 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S263542AbTGAToj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:44:39 -0400
Message-ID: <3F01E81E.813FCDAC@hp.com>
Date: Tue, 01 Jul 2003 13:59:26 -0600
From: Alex Williamson <alex_williamson@hp.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.21-rc8-aw-ob500 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>,
       ak@suse.de, davem@redhat.com, suparna@in.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn_helgaas@hp.com>
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
References: <1057077975.2135.54.camel@mulgrave> <20030701191941.GF14683@dsl2.external.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> 
> But I'm pretty sure james proposal will work for ia64 and parisc.
> 

   The thing that's got me concerned about this is that it allows
for sg lists that contains both entries that the block layer
expects will be mapped into the iommu and ones that it expects
to bypass.  I don't like the implications of parsing through
sg lists looking for bypass-able and non-bypass-able groupings.
This seems like a lot more overhead than we have now and the
complexity of merging partially bypass-able scatterlists seems
time consuming.

   The current ia64 sba_iommu does a quick and dirty sg bypass
check.  If the device can dma to any memory address, the entire
sg list is bypassed.  If not, the entire list is coalesced and
mapped by the iommu.  The idea being that true performance
devices will have 64bit dma masks and be able to quickly bypass.
Everything else will at least get the benefit of coalescing
entries to make more efficient dma.  The coalescing is a bit
simpler since it's the entire list as well.  With this proposal,
we'd have to add a lot of complexity to partially bypass sg
lists.  I don't necessarily see that as a benefit.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

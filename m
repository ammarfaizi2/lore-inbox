Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbTGCVJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 17:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbTGCVJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 17:09:52 -0400
Received: from ns.suse.de ([213.95.15.193]:35345 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265387AbTGCVJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 17:09:49 -0400
Date: Thu, 3 Jul 2003 23:24:15 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Grant Grundler <grundler@parisc-linux.org>,
       James Bottomley <James.Bottomley@SteelEye.com>, axboe@suse.de,
       davem@redhat.com, suparna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030703212415.GA30277@wotan.suse.de>
References: <1057077975.2135.54.camel@mulgrave> <20030702015701.6007ac26.ak@suse.de> <20030702165510.GC11739@dsl2.external.hp.com> <1057180598.20318.32.camel@dhcp22.swansea.linux.org.uk> <20030702235619.GA21567@wotan.suse.de> <1057263988.21508.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057263988.21508.18.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 09:26:29PM +0100, Alan Cox wrote:
> On Iau, 2003-07-03 at 00:56, Andi Kleen wrote:
> > > 1.	We allocate pages in reverse order so most merges cant occur
> > 
> > I added an printk and I get quite a lot of merges during bootup
> > with normal IDE.
> > 
> > (sometimes 12+ segments) 
> 
> Thats merging adjacent blocks with non adjacent page targets using the
> IOMMU right - I was doing mergign without an IOMMU which is a little

Yep. 

> different and turns out to be a waste of cpu

Understandable. Especially when memory fragments after some uptime.

But of course it doesn't help much in practice because all the interesting
block devices support DAC anyways and the IOMMU is disabled for that.

Also it's likely cheaper just submit more segments than to have the IOMMU
overhead
(at least for sane devices, if not it may be worth to artificially limit the
dma mask of the device to force IOMMU on IA64 and x86-64) 

-Andi

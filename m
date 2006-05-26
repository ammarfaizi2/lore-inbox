Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWEZJtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWEZJtn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWEZJtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:49:43 -0400
Received: from mail.axxeo.de ([82.100.226.146]:25807 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1751359AbWEZJtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:49:42 -0400
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] myri10ge - Driver core
Date: Fri, 26 May 2006 11:49:18 +0200
User-Agent: KMail/1.9.1
Cc: Anton Blanchard <anton@samba.org>, Brice Goglin <brice@myri.com>,
       netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org
References: <20060517220218.GA13411@myri.com> <20060523153928.GB5938@krispykreme> <1148543810.13249.265.camel@localhost.localdomain>
In-Reply-To: <1148543810.13249.265.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261149.18415.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Benjamin Herrenschmidt wrote:
> On Wed, 2006-05-24 at 01:39 +1000, Anton Blanchard wrote:
> 
> > > +#ifdef CONFIG_MTRR
> > > +	mgp->mtrr = mtrr_add(mgp->iomem_base, mgp->board_span,
> > > +			     MTRR_TYPE_WRCOMB, 1);
> > > +#endif
> > ...
> > > +	mgp->sram = ioremap(mgp->iomem_base, mgp->board_span);
> > 
> > Not sure how we are meant to specify write through in drivers. Any ideas Ben?
> 
> No proper interface exposed, he'll have to do an #ifdef powerpc here or
> such and use __ioremap with explicit page attributes. I have a hack to
> do that automatically for memory covered by prefetchable PCI BARs when
> mmap'ing from userland but not for kernel ioremap.

Stupid question: pci_iomap() is NOT what you are looking for, right?

Implementation is at the end of lib/iomap.c


Regards

Ingo Oeser

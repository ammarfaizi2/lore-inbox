Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWEYH5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWEYH5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWEYH5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:57:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:64673 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965063AbWEYH5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:57:19 -0400
Subject: Re: [PATCH 3/4] myri10ge - Driver core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Cc: Brice Goglin <brice@myri.com>, netdev@vger.kernel.org, gallatin@myri.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060523153928.GB5938@krispykreme>
References: <20060517220218.GA13411@myri.com>
	 <20060517220608.GD13411@myri.com>  <20060523153928.GB5938@krispykreme>
Content-Type: text/plain
Date: Thu, 25 May 2006 17:56:49 +1000
Message-Id: <1148543810.13249.265.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 01:39 +1000, Anton Blanchard wrote:

> > +#ifdef CONFIG_MTRR
> > +	mgp->mtrr = mtrr_add(mgp->iomem_base, mgp->board_span,
> > +			     MTRR_TYPE_WRCOMB, 1);
> > +#endif
> ...
> > +	mgp->sram = ioremap(mgp->iomem_base, mgp->board_span);
> 
> Not sure how we are meant to specify write through in drivers. Any ideas Ben?

No proper interface exposed, he'll have to do an #ifdef powerpc here or
such and use __ioremap with explicit page attributes. I have a hack to
do that automatically for memory covered by prefetchable PCI BARs when
mmap'ing from userland but not for kernel ioremap.

Ben.


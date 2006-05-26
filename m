Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWEZK40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWEZK40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWEZK40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:56:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:56756 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932195AbWEZK4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:56:25 -0400
Subject: Re: [PATCH 3/4] myri10ge - Driver core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Ingo Oeser <netdev@axxeo.de>, Anton Blanchard <anton@samba.org>,
       Brice Goglin <brice@myri.com>, netdev@vger.kernel.org,
       gallatin@myri.com, linux-kernel@vger.kernel.org
In-Reply-To: <4476D8E3.40101@garzik.org>
References: <20060517220218.GA13411@myri.com>
	 <20060523153928.GB5938@krispykreme>
	 <1148543810.13249.265.camel@localhost.localdomain>
	 <200605261149.18415.netdev@axxeo.de>
	 <1148637720.8089.145.camel@localhost.localdomain>
	 <4476D8E3.40101@garzik.org>
Content-Type: text/plain
Date: Fri, 26 May 2006 20:56:04 +1000
Message-Id: <1148640964.8089.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 06:30 -0400, Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
> >>> No proper interface exposed, he'll have to do an #ifdef powerpc here or
> >>> such and use __ioremap with explicit page attributes. I have a hack to
> >>> do that automatically for memory covered by prefetchable PCI BARs when
> >>> mmap'ing from userland but not for kernel ioremap.
> >> Stupid question: pci_iomap() is NOT what you are looking for, right?
> >>
> >> Implementation is at the end of lib/iomap.c
> > 
> > No, there is no difference there, pci_iomap won't help for passing in
> > platform specific page attributes for things like write combining.
> 
> Since we already have ioremap_nocache(), maybe adding ioremap_wcomb() is 
> appropriate?

Yes, but be careful there.. on ppc, not setting the page "guarded" bit
will enable write combining on various CPUs but will also enable
speculative reads, prefetch, etc... so it's not "just" WC, you have to
know for sure what you are doing with that memory (basically, enable
side-effects).

Ben.



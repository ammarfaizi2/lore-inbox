Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267941AbTB1POr>; Fri, 28 Feb 2003 10:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267947AbTB1POr>; Fri, 28 Feb 2003 10:14:47 -0500
Received: from havoc.daloft.com ([64.213.145.173]:59572 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267941AbTB1POq>;
	Fri, 28 Feb 2003 10:14:46 -0500
Date: Fri, 28 Feb 2003 10:25:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228152502.GA32449@gtf.org>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73heao7ph2.fsf@amdsimf.suse.de> <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk> <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk> <1046447737.16599.83.camel@irongate.swansea.linux.org.uk> <20030228145614.GA27798@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228145614.GA27798@wotan.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 03:56:15PM +0100, Andi Kleen wrote:
> On Fri, Feb 28, 2003 at 03:55:37PM +0000, Alan Cox wrote:
> > On Fri, 2003-02-28 at 14:34, Matthew Wilcox wrote:
> > > umm.  are you volunteering to convert drivers/net/macmace.c to the pci_*
> > > API then?  also, GFP_DMA is used on, eg, s390 to get memory below 2GB and
> > > on ia64 to get memory below 4GB.
> > 
> > The ia64 is a fine example of how broken it is. People have to hack around 
> > with GFP_DMA meaning different things on ia64 to everything else. It needs
> > to die. 
> 
> At least on x86-64 it is still needed when you need have some hardware
> with address limits < 4GB (e.g. an 24bit soundcard)
> 
> pci_* on K8 only allows address mask 0xffffffff or unlimited.

That's a bit broken...  I have an ALS4000 PCI soundcard that is a 24-bit
soundcard.  pci_set_dma_mask should support 24-bits accordingly,
otherwise it's a bug in your platform implementation...  Nobody will be
able to use certain properly-written drivers on your platform otherwise.

	Jeff




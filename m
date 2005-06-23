Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262943AbVFXBcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbVFXBcC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVFXBcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:32:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8929 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262943AbVFXBbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:31:41 -0400
Date: Thu, 23 Jun 2005 17:03:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrei Konovalov <akonovalov@ru.mvista.com>, akpm@osdl.org,
       trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
       yshpilevsky@ru.mvista.com, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: add Freescale MPC885ADS board support
Message-ID: <20050623200301.GA26802@logos.cnet>
References: <42BAD78E.1020801@ru.mvista.com> <20050623140522.GA25724@logos.cnet> <20050623194856.GA4588@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623194856.GA4588@gate.ebshome.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 12:48:56PM -0700, Eugene Surovegin wrote:
> On Thu, Jun 23, 2005 at 11:05:22AM -0300, Marcelo Tosatti wrote:
> > 
> > Hi Andrei,
> > 
> > On Thu, Jun 23, 2005 at 07:38:54PM +0400, Andrei Konovalov wrote:
> > <snip>
> > 
> > > diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
> > > --- a/arch/ppc/syslib/m8xx_setup.c
> > > +++ b/arch/ppc/syslib/m8xx_setup.c
> > > @@ -369,7 +369,7 @@ m8xx_map_io(void)
> > >  #if defined(CONFIG_HTDMSOUND) || defined(CONFIG_RPXTOUCH) || defined(CONFIG_FB_RPX)
> > >  	io_block_mapping(HIOX_CSR_ADDR, HIOX_CSR_ADDR, HIOX_CSR_SIZE, _PAGE_IO);
> > >  #endif
> > > -#ifdef CONFIG_FADS
> > > +#if defined(CONFIG_FADS) || defined(CONFIG_MPC885ADS)
> > >  	io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
> > >  #endif
> > >  #ifdef CONFIG_PCI
> > 
> > I suppose you also want to include CONFIG_MPC885ADS in the io_block_mapping(IO_BASE) 
> > here?
> 
> I think it'd be great if we _stop_ adding new io_block_mapping users, 
> there is ioremap() for stuff like this, let's use it instead.

(go back after reading previous discussion)

For that you need ioremap() to handle BATs and CAMs right?
What would be the difficulties with doing that?

For 8xx (which lacks BAT's and CAM's) we could try immediately I suppose.

Seems to be BenH's plan, along with making the virtual addresses
dynamic and not static. 

While at it, what are the possibilities of making BAT's and/or CAM's
available to userspace through hugetlbfs or some other mechanism?



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUGPFpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUGPFpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUGPFpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:45:53 -0400
Received: from colin2.muc.de ([193.149.48.15]:29701 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266487AbUGPFpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 01:45:51 -0400
Date: 16 Jul 2004 07:45:50 +0200
Date: Fri, 16 Jul 2004 07:45:50 +0200
From: Andi Kleen <ak@muc.de>
To: Martin Diehl <lists@mdiehl.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       irda-users@lists.sourceforge.net, jt@hpl.hp.com,
       the_nihilant@autistici.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop ISA dependencies from IRDA drivers
Message-ID: <20040716054550.GA21819@muc.de>
References: <20040715215552.GA46635@muc.de> <Pine.LNX.4.44.0407160027410.14037-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407160027410.14037-100000@notebook.home.mdiehl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 12:32:44AM +0200, Martin Diehl wrote:
> On 15 Jul 2004, Andi Kleen wrote:
> 
> > Remove wrong ISA dependencies for IRDA drivers.
> > 
> > 
> > diff -u linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig-o linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig
> > --- linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig-o	2004-07-12 06:09:05.000000000 +0200
> > +++ linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig	2004-07-15 18:33:48.000000000 +0200
> > @@ -310,7 +310,7 @@
> >  
> >  config NSC_FIR
> >  	tristate "NSC PC87108/PC87338"
> > -	depends on IRDA && ISA
> > +	depends on IRDA
> 
> 
> Admittedly I haven't tried either, but I'm pretty sure this patch will 
> break building those drivers because they are calling irda_setup_dma - 
> which is CONFIG_ISA. Maybe this can be dropped but I don't see what's 
> wrong with !64BIT instead.

Hmm, good point. 

!64BIT is not needed - apparently they are 64bit clean.

The reason I want to drop the CONFIG_ISA depency is that they *should*
be built on x86-64 too. 

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265660AbUFXXmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUFXXmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUFXXmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:42:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34025 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265660AbUFXXmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:42:00 -0400
Date: Fri, 25 Jun 2004 01:41:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>, zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add required dependencies to X86_NUMAQ
Message-ID: <20040624234145.GA18303@fs.tum.de>
References: <20040624231033.GF26669@fs.tum.de> <3450000.1088120038@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3450000.1088120038@flay>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 04:33:58PM -0700, Martin J. Bligh wrote:
> > If you select another option, you have to ensure that the dependencies 
> > of the selected options are met.
> > 
> > The following patch adds to X86_NUMAQ the required dependencies for the 
> > selected NUMA:
> > 
> > --- linux-2.6.7-mm2-full/arch/i386/Kconfig.old	2004-06-24 22:42:32.000000000 +0200
> > +++ linux-2.6.7-mm2-full/arch/i386/Kconfig	2004-06-24 22:44:53.000000000 +0200
> > @@ -65,6 +65,7 @@
> >  
> >  config X86_NUMAQ
> >  	bool "NUMAQ (IBM/Sequent)"
> > +	depends on SMP && HIGHMEM64G
> >  	select DISCONTIGMEM
> >  	select NUMA
> >  	help
> 
> Mmmm. As we already have this:
> 
> config NUMA
>         bool "Numa Memory Allocation and Scheduler Support"
>         depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SU
> MMIT && ACPI))
>         default n if X86_PC
>         default y if (X86_NUMAQ || X86_SUMMIT)
> 
> do we really need to cascade it back out like that into everything that
> selects NUMA? Perhaps we should make NUMA select SMP && HIGHMEM64G, rather
> than depend on it?

This would work for SMP, but according to my testing, select doesn't 
seem to work with options in choices like HIGHMEM64G.

> M.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


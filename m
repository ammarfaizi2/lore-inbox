Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422798AbWCXICE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbWCXICE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 03:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422796AbWCXICE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 03:02:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:30166 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422798AbWCXICC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 03:02:02 -0500
Subject: Re: [PATCH] powerpc: Kill machine numbers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Cc: Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060324062624.GA16815@pb15.lixom.net>
References: <1143178947.4257.78.camel@localhost.localdomain>
	 <20060324062624.GA16815@pb15.lixom.net>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 19:01:38 +1100
Message-Id: <1143187298.3710.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It would be very useful to print the ppc_md.name of the found machine
> here, even without debugging enabled.

Not sure ... without debugging enabled, it's likely that you won't see
anything that early anyway :)

> > -struct machdep_calls __initdata cell_md = {
> > +define_machine(cell) {
> >  	.probe			= cell_probe,
> >  	.setup_arch		= cell_setup_arch,
> >  	.init_early		= cell_init_early,
> 
> You forgot to add a .name value here.

Yup, thanks. I think this should become cpb instead of cell, other cell
based boards would then have different ppc_md's though they could share
various routines.

> > Index: linux-work/arch/powerpc/kernel/prom_init.c
> > ===================================================================
> > --- linux-work.orig/arch/powerpc/kernel/prom_init.c	2006-03-10 15:58:17.000000000 +1100
> > +++ linux-work/arch/powerpc/kernel/prom_init.c	2006-03-24 14:41:14.000000000 +1100
> [...]
> > +	/* If not a mac, try to figure out if it's an IBM pSeries. We assume
> > +	 * it is if :
> > +	 *  - /device_type is "chrp" (please, do NOT use that for future
> > +	 *    non-IBM designs !
> > +	 *  - it has /rtas
> > +	 */
> 
> It's really weird that IBM chose to use "chrp" to describe a
> PAPR-compliant platform. I guess it's for historical reasons, but it
> sure isn't CHRP any more.

Yup, I'm trying to get that changed in the architecture but even if I'm
successful, we'll have to deal with existing machines.

> Also, please change the wording. With power.org, there will likely be
> non-IBM PAPR-compliant platforms at some point. "non-PAPR-compliant
> designs" is a better term to use.

Ok.

> > Index: linux-work/Documentation/powerpc/booting-without-of.txt
> > ===================================================================
> > --- linux-work.orig/Documentation/powerpc/booting-without-of.txt	2006-03-24 11:42:13.000000000 +1100
> > +++ linux-work/Documentation/powerpc/booting-without-of.txt	2006-03-24 14:28:27.000000000 +1100
> > @@ -719,6 +719,10 @@ address which can extend beyond that lim
> >      - model : this is your board name/model
> >      - #address-cells : address representation for "root" devices
> >      - #size-cells: the size representation for "root" devices
> > +    - device_type : This property shouldn't be necessary. However, if
> > +      device to create a device_type for your root node, make sure it
> 
> if you device to create... ?

I was tired :) If you "decide" to create.. will fix, thanks.

> > +      is _not_ "chrp" as this will be matched by the kernel to be a
> > +      CHRP machine on 32 bits kernel or a pSeries on 64 bits kernels
> 
> ...or a PAPR-compliant machine on 64-bit kernels.
> 
> (Also, "xx-bit kernels", not "xx bits kernels").

yeah yeah :) Thanks for the review anyway !

Cheers,
Ben.



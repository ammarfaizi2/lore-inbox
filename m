Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVDRJRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVDRJRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 05:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVDRJOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 05:14:02 -0400
Received: from cantor.suse.de ([195.135.220.2]:60870 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262001AbVDRJLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 05:11:21 -0400
Date: Mon, 18 Apr 2005 11:11:13 +0200
From: Andi Kleen <ak@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jason@rightthere.net, ak@suse.de, jason.davis@unisys.com
Subject: Re: [patch 070/198] x86_64 genapic update
Message-ID: <20050418091113.GI8511@wotan.suse.de>
References: <200504121031.j3CAVln9005407@shell0.pdx.osdl.net> <20050417062726.GA8379@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050417062726.GA8379@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 11:27:26PM -0700, Chris Wedgwood wrote:
> On Tue, Apr 12, 2005 at 03:31:41AM -0700, akpm@osdl.org wrote:
> 
> > diff -puN arch/i386/kernel/acpi/boot.c~x86_64-genapic-update arch/i386/kernel/acpi/boot.c
> > --- 25/arch/i386/kernel/acpi/boot.c~x86_64-genapic-update	2005-04-12 03:21:20.212064200 -0700
> > +++ 25-akpm/arch/i386/kernel/acpi/boot.c	2005-04-12 03:21:20.217063440 -0700
> > @@ -608,6 +608,10 @@ static int __init acpi_parse_fadt(unsign
> >  	acpi_fadt.sci_int = fadt->sci_int;
> >  #endif
> >  
> > +	/* initialize rev and apic_phys_dest_mode for x86_64 genapic */
> > +	acpi_fadt.revision = fadt->revision;
> > +	acpi_fadt.force_apic_physical_destination_mode = fadt->force_apic_physical_destination_mode;
> > +
> 
> This breaks for me.  It seems acpi_fadt needs CONFIG_ACPI_BUS.  How
> does this look?

Looks good, thanks. Linus, can you please add it? Thanks.

-Andi

> 
> Signed-off-By: Chris Wedgwood <cw@f00f.org>
> 
> Index: cw-current/arch/i386/kernel/acpi/boot.c
> ===================================================================
> --- cw-current.orig/arch/i386/kernel/acpi/boot.c	2005-04-16 20:17:09.801272343 -0700
> +++ cw-current/arch/i386/kernel/acpi/boot.c	2005-04-16 23:24:59.014298068 -0700
> @@ -608,9 +608,11 @@
>  	acpi_fadt.sci_int = fadt->sci_int;
>  #endif
>  
> +#ifdef CONFIG_ACPI_BUS
>  	/* initialize rev and apic_phys_dest_mode for x86_64 genapic */
>  	acpi_fadt.revision = fadt->revision;
>  	acpi_fadt.force_apic_physical_destination_mode = fadt->force_apic_physical_destination_mode;
> +#endif
>  
>  #ifdef CONFIG_X86_PM_TIMER
>  	/* detect the location of the ACPI PM Timer */
> 
> 

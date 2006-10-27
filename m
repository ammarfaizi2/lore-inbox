Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946410AbWJ0LaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946410AbWJ0LaW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946412AbWJ0LaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:30:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2448 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946410AbWJ0LaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:30:21 -0400
Date: Fri, 27 Oct 2006 13:30:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS address space
Message-ID: <20061027113001.GB8095@elf.ucw.cz>
References: <1161920325.17807.29.camel@localhost.localdomain> <1161920535.17807.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161920535.17807.33.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> (Andrew had already taken that last one, I meant to send this)
> 
> Subject: Be careful about touching BIOS address space
> 
> BIOS ROM areas may not be mapped into the guest address space, so be careful
> when touching those addresses to make sure they appear to be mapped.
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> ===================================================================
> --- a/arch/i386/kernel/setup.c
> +++ b/arch/i386/kernel/setup.c
> @@ -270,7 +270,14 @@ static struct resource standard_io_resou
>  	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
>  } };
>  
> -#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
> +static inline int romsignature(const unsigned char *x)
> +{
> +     unsigned short sig;
> +     int ret = 0;
> +     if (__get_user(sig, (const unsigned short *)x) == 0)
> +	  ret = (sig == 0xaa55);

Indentation is b0rken here.

And... is get_user right primitive for accessing area that may not be
there?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

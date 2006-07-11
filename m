Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWGKX1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWGKX1z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWGKX1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:27:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36872 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932243AbWGKX1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:27:54 -0400
Date: Wed, 12 Jul 2006 01:27:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1: drivers/ide/pci/jmicron.c warning
Message-ID: <20060711232750.GH13938@stusta.de>
References: <20060709021106.9310d4d1.akpm@osdl.org> <20060711125258.GN13938@stusta.de> <20060711140257.GA6820@devserv.devel.redhat.com> <20060711221045.GC13938@stusta.de> <20060711231014.GA30186@devserv.devel.redhat.com> <20060711162328.6a771ce2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711162328.6a771ce2.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 04:23:28PM -0700, Andrew Morton wrote:
> Alan Cox <alan@redhat.com> wrote:
> >
> > I'd say that gcc warning in the case that all the enum values are enumerated
> > and have returns is a broken warning irrespective of that so I won't "fix" it
> > because it isn't broken. Its just like various other bogus gcc warnings
> > 
> 
> But we work around gcc problems all the time.
> 
> Warnings like this have a cost - they make the build noisy and that causes
> people to miss real bugs which the compiler is trying to tell them about.
> 
> So if we can implement a low-cost fix for this then we should do so.
> 
> 
> --- a/drivers/ide/pci/jmicron.c~a
> +++ a/drivers/ide/pci/jmicron.c
> @@ -94,8 +94,9 @@ static int __devinit ata66_jmicron(ide_h
>  			return 0;
>  		return 1;
>  	case PORT_SATA:
> -		return 1;
> +		break;

The part above isn't required to avoid the warning, and it does IMHO 
decrease readability.

>  	}
> +	return 1; /* Avoid bogus "control reaches end of non-void function" */
>...

This is what is required to fix the warning.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVDQTyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVDQTyh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVDQTyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:54:37 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62994 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261453AbVDQTyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:54:12 -0400
Date: Sun, 17 Apr 2005 21:54:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com, davem@davemloft.net, ak@suse.de,
       linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [RFC][PATCH 4/4] AES assembler implementation for x86_64
Message-ID: <20050417195406.GC3625@stusta.de>
References: <4262B6F5.4060907@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4262B6F5.4060907@domdv.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 09:20:21PM +0200, Andreas Steinmetz wrote:

> The attached patch contains the required changes for the crypto Kconfig
> to enable the usage of the x86_64 AES assembler implementation.


That is not specifically against this patch, but before we add another 
AES implementation, I'd like to find a better solution for the general 
AES selection.

My original thoughts on this issue are in [1], but this didn't attack 
the problem of CRYPTO_DEV_PADLOCK_AES where it might not be known at 
compile time whether the hardware will be present.


> Andreas Steinmetz

> diff -rNu linux-2.6.11.2.orig/crypto/Kconfig linux-2.6.11.2/crypto/Kconfig
> --- linux-2.6.11.2.orig/crypto/Kconfig	2005-03-09 09:12:53.000000000 +0100
> +++ linux-2.6.11.2/crypto/Kconfig	2005-04-17 13:10:51.000000000 +0200
>...
>  config CRYPTO_AES_586
>  	tristate "AES cipher algorithms (i586)"
> -	depends on CRYPTO && (X86 && !X86_64)
> +	depends on CRYPTO && X86 && !X86_64
>...

This doesn't make any difference.

I think the former version was better readable, but that's no strong 
opinion.

cu
Adrian

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0502.3/0518.html

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


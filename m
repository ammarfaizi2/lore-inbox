Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbRE3JNv>; Wed, 30 May 2001 05:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbRE3JNl>; Wed, 30 May 2001 05:13:41 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:62727 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S262660AbRE3JNa>;
	Wed, 30 May 2001 05:13:30 -0400
Message-ID: <3B14A61B.3DF7C1D7@yahoo.com>
Date: Wed, 30 May 2001 01:49:47 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #3
In-Reply-To: <200105300041.CAA04507@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
> 
> The following patch fixes some ISA PnP #ifdefs (enable modular,
> disable when non-available) for 3c509 and smc-ultra.

> -#ifdef CONFIG_ISAPNP
> +#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))

Hrrm.  AFAICT the token CONFIG_ISAPNP_MODULE will never be defined.  :-)

Regardless, we can just toss the #ifdefs altogether.  They aren't strictly
required as appropriate stubs exist in linux/isapnp.h and that is what 
they are there for. (I'd recommend this for 2.5, not 2.4 though.)

Granted, the CONFIG_ISAPNP buys you a slight reduction in driver
size (even over the stubs) which somewhat seemed worthwhile in the
past. But most of it is __init anyway, and for 2.5 I'd argue that the
readability and lack of ifdefs outweighs the slight size change.

Paul.



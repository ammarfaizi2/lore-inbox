Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbRE3KyJ>; Wed, 30 May 2001 06:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbRE3KyA>; Wed, 30 May 2001 06:54:00 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:60834 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262721AbRE3Kxr>; Wed, 30 May 2001 06:53:47 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200105301053.MAA02686@sunrise.pg.gda.pl>
Subject: Re: [PATCH] net #3
To: linux-kernel@vger.kernel.org (kernel-list)
Date: Wed, 30 May 2001 12:53:36 +0200 (MET DST)
Reply-To: p_gortmaker@yahoo.com, ankry@green.mif.pg.gda.pl
In-Reply-To: <3B14A61B.3DF7C1D7@yahoo.com> from "Paul Gortmaker" at May 30, 2001 01:49:47 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul Gortmaker wrote:"
> Andrzej Krzysztofowicz wrote:
> > 
> > The following patch fixes some ISA PnP #ifdefs (enable modular,
> > disable when non-available) for 3c509 and smc-ultra.
> 
> > -#ifdef CONFIG_ISAPNP
> > +#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
> 
> Hrrm.  AFAICT the token CONFIG_ISAPNP_MODULE will never be defined.  :-)

If IS defined by config subsystem when
  "$CONFIG_ISAPNP" = "m"

Just mark config option and test it.

$ grep ISAPNP include/linux/autoconf.h
#undef  CONFIG_ISAPNP
#define CONFIG_ISAPNP_MODULE 1
#undef  CONFIG_BLK_DEV_ISAPNP

;)

> Regardless, we can just toss the #ifdefs altogether.  They aren't strictly
> required as appropriate stubs exist in linux/isapnp.h and that is what 
> they are there for. (I'd recommend this for 2.5, not 2.4 though.)
> 
> Granted, the CONFIG_ISAPNP buys you a slight reduction in driver
> size (even over the stubs) which somewhat seemed worthwhile in the
> past. But most of it is __init anyway, and for 2.5 I'd argue that the
> readability and lack of ifdefs outweighs the slight size change.

When __init for modules will be implemented ?

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk


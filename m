Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTICOtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTICOtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:49:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35209 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263460AbTICOtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:49:50 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.6 patch] fix warning with modular ide.c
Date: Wed, 3 Sep 2003 16:50:25 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <20030903141901.GZ23729@fs.tum.de>
In-Reply-To: <20030903141901.GZ23729@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031650.25561.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 of September 2003 16:19, Adrian Bunk wrote:
> Hi Bartlomiej,
>
> I got the following compile warning when trying to compile ide.c modular
> in 2.6.0-tet4-mm5:

Modular ide is broken in 2.6.0-test4, somebody fixed it in -mm5? Don't.
It stays broken for purpose (I have patches fixing it) because I want to fix
other stuff first and it will change the way modular ide works (currently
its ugly and complicated) and not having to worry about breaking modular
ide all the time (it stays broken) simplifies things :-).

Anyway thanks for report.

--bartlomiej

> <--  snip  -->
>
> ...
>   CC [M]  drivers/ide/ide.o
> drivers/ide/ide.c: In function `ide_unregister_subdriver':
> drivers/ide/ide.c:2476: warning: implicit declaration of function
> `pnpide_init'
> ...
>
> <--  snip  -->
>
> I'd suggest the patch below (or something similar).
>
> cu
> Adrian
>
> --- linux-2.6.0-test4-mm5-modular-no-smp/drivers/ide/ide.c.old	2003-09-03
> 15:55:46.000000000 +0200 +++
> linux-2.6.0-test4-mm5-modular-no-smp/drivers/ide/ide.c	2003-09-03
> 15:59:46.000000000 +0200 @@ -214,6 +214,11 @@
>  extern ide_driver_t idedefault_driver;
>  static void setup_driver_defaults(ide_driver_t *driver);
>
> +#ifdef CONFIG_BLK_DEV_IDEPNP
> +extern void pnpide_init(int enable);
> +#endif
> +
> +
>  /*
>   * Do not even *think* about calling this!
>   */
> @@ -2288,7 +2293,6 @@
>  #endif /* CONFIG_BLK_DEV_BUDDHA */
>  #if defined(CONFIG_BLK_DEV_IDEPNP) && defined(CONFIG_PNP)
>  	{
> -		extern void pnpide_init(int enable);
>  		pnpide_init(1);
>  	}
>  #endif /* CONFIG_BLK_DEV_IDEPNP */


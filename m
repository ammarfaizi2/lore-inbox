Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130861AbRADTUc>; Thu, 4 Jan 2001 14:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130667AbRADTUM>; Thu, 4 Jan 2001 14:20:12 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:57101
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129765AbRADTUI>; Thu, 4 Jan 2001 14:20:08 -0500
Date: Thu, 4 Jan 2001 11:19:31 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
cc: "Andre M. Hedrick" <andre@suse.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide patch problem
In-Reply-To: <200101041219.NAA03487@green.mif.pg.gda.pl>
Message-ID: <Pine.LNX.4.10.10101041119120.745-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep know about that one...

Cheers,

On Thu, 4 Jan 2001, Andrzej Krzysztofowicz wrote:

> Hi,
>    Your ide.2.2.18.1221.patch does not compile on alpha:
> 
> cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8
> -mcpu=ev56 -Wa,-m21164a -DBWIO_ENABLED   -c -o ide-geometry.o ide-geometry.c
> In file included from ide-geometry.c:5:
> /usr/src/linux/include/linux/mc146818rtc.h:29: parse error before `rtc_lock'
> /usr/src/linux/include/linux/mc146818rtc.h:29: warning: type defaults to
> `int' in declaration of `rtc_lock'
> /usr/src/linux/include/linux/mc146818rtc.h:29: warning: data definition has
> no type or storage class
> make[3]: *** [ide-geometry.o] Error 1
> make[3]: Leaving directory /usr/src/linux/drivers/block'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory /usr/src/linux/drivers/block'
> make[1]: *** [_subdir_block] Error 2
> make[1]: Leaving directory /usr/src/linux/drivers'
> make: *** [_dir_drivers] Error 2
> 
> The following patch fixes the problem, but I'm not sure whether it is
> correct :
> 
> --- drivers/block/ide-geometry.c.old	Thu Jan  4 12:51:29 2001
> +++ drivers/block/ide-geometry.c	Thu Jan  4 13:18:02 2001
> @@ -2,6 +2,7 @@
>   * linux/drivers/ide/ide-geometry.c
>   */
>  #include <linux/config.h>
> +#include <linux/mm.h>
>  #include <linux/mc146818rtc.h>
>  #include <linux/ide.h>
>  #include <asm/io.h>
> 
> -- 
> =======================================================================
>   Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
>   phone (48)(58) 347 14 61
> Faculty of Applied Phys. & Math.,   Technical University of Gdansk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKUSWH>; Tue, 21 Nov 2000 13:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbQKUSV5>; Tue, 21 Nov 2000 13:21:57 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:9734 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129259AbQKUSVq>; Tue, 21 Nov 2000 13:21:46 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200011211740.SAA10738@green.mif.pg.gda.pl>
Subject: Re: [PATCH] Config.in fixes
To: Geert.Uytterhoeven@sonycom.com
Date: Tue, 21 Nov 2000 18:40:41 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <200011211742.SAA03627@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Nov 21, 2000 06:42:08 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Geert Uytterhoeven wrote:"
> --- linux-2.4.0-test11/drivers/video/Config.in	Tue Sep 19 00:15:22 2000
> +++ geert-2.4.0-test11/drivers/video/Config.in	Tue Nov 21 13:27:12 2000
> @@ -16,7 +16,7 @@
>        if [ "$CONFIG_AMIGA" = "y" -o "$CONFIG_PCI" = "y" ]; then
>  	 tristate '  Cirrus Logic support (EXPERIMENTAL)' CONFIG_FB_CLGEN
>  	 tristate '  Permedia2 support (EXPERIMENTAL)' CONFIG_FB_PM2
> -	 if [ "$CONFIG_FB_PM2" = "y" ]; then
> +	 if [ "$CONFIG_FB_PM2" != "n" ]; then
>  	    if [ "$CONFIG_PCI" = "y" ]; then
>  	       bool '    enable FIFO disconnect feature' CONFIG_FB_PM2_FIFO_DISCONNECT
>  	       bool '    generic Permedia2 PCI board support' CONFIG_FB_PM2_PCI

Please, be carefull with this type of fixes.
It is correct at the moment, but it would break xconfig if one changes

tristate '  Permedia2 support (EXPERIMENTAL)' CONFIG_FB_PM2

to

dep_tristate '  Permedia2 support (EXPERIMENTAL)' CONFIG_FB_PM2 $CONFIG_EXPERIMENTAL

It is safer to use  [ "$CONFIG_FB_PM2" = "y"  -o "$CONFIG_FB_PM2" = "m" ]
here.
   Andrzej

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

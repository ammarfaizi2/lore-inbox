Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130476AbRABKBc>; Tue, 2 Jan 2001 05:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130562AbRABKBX>; Tue, 2 Jan 2001 05:01:23 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:39632 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130476AbRABKBM>; Tue, 2 Jan 2001 05:01:12 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200101020930.KAA15067@sunrise.pg.gda.pl>
Subject: Re: IRNET depending on PPP
To: Oliver.Neukum@lrz.uni-muenchen.de (Oliver Neukum)
Date: Tue, 2 Jan 2001 10:30:40 +0100 (MET)
Cc: linux-kernel@vger.kernel.org, mec@shout.net
In-Reply-To: <01010115524900.10792@ghanima> from "Oliver Neukum" at Jan 01, 2001 03:32:47 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Oliver Neukum wrote:"
> 
> IRNET depends on PPP, but that is not reflected in the configuration files.
> A patch is attached.

An incorrect patch.
Note, that if CONFIG_NETDEVICES=n then CONFIG_PPP is undefined (instead of
being equal to "n") ...
 
> --- linux-vanilla/net/irda/irnet/Config.in	Mon Jan  1 14:34:02 2001
> +++ linux/net/irda/irnet/Config.in	Mon Jan  1 15:35:15 2001
> @@ -1 +1,3 @@
> -dep_tristate '  IrNET protocol' CONFIG_IRNET $CONFIG_IRDA

The following line
> +if [ "$CONFIG_PPP" != "n" ]; then

should be replaced by either
+if [ "$CONFIG_PPP" = "y" -o "$CONFIG_PPP" = "m" ]; then
or
+if [ "$CONFIG_NETDEVICES" = "y" -a "$CONFIG_PPP" != "n" ]; then

> +	dep_tristate '  IrNET protocol' CONFIG_IRNET $CONFIG_IRDA
> +fi
 
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

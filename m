Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267831AbRGUWJ1>; Sat, 21 Jul 2001 18:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267832AbRGUWJS>; Sat, 21 Jul 2001 18:09:18 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:41226 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S267831AbRGUWJJ>; Sat, 21 Jul 2001 18:09:09 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200107212139.XAA12131@kufel.dom>
Subject: Re: [PATCH] init/main.c
To: kufel!oph.rwth-aachen.de!stefan@green.mif.pg.gda.pl (Stefan Becker)
Date: Sat, 21 Jul 2001 23:39:40 +0200 (CEST)
Cc: kufel!lxorguk.ukuu.org.uk!alan@green.mif.pg.gda.pl (Alan Cox),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <Pine.LNX.4.21.0107211840250.27803-100000@die-macht> from "Stefan Becker" at lip 21, 2001 06:51:07 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,
   What do you aim at doing this changes ?

> The following patch against 2.4.6-ac5 does
[...]
> (b) wraps certain root_dev_names[] into #ifdefs.
>     I hope I found the correct CONFIG_BLK_* variables
[...]
>  #endif
> +#ifdef CONFIG_BLK_DEV_DAC960
>  	{ "rd/c0d0p",0x3000 },
>  	{ "rd/c0d1p",0x3008 },
>  	{ "rd/c0d2p",0x3010 },
> @@ -296,6 +298,8 @@
>  	{ "rd/c0d13p",0x3068 },
>  	{ "rd/c0d14p",0x3070 },
>  	{ "rd/c0d15p",0x3078 },
> +#endif
> +#ifdef CONFIG_BLK_CPQ_DA
... etc.

AFAIR, the above (and similar) #ifdefs were intentionally removed as they
break using root=... kernel parameters for apropriate drivers loaded as
module from initrd. In these cases there are 3 solutions:

1. Use numeric values (not convenient)
2. #if defined(CONFIG_FOO) || defined(CONFIG_FOO_MODULE)
   This is ugly (main kernel depends on too many module settings).
   Also, Linux (Alan too ?) hate too many unnecessary
3. Remove all #ifdefs here. (prefered as this is init code...)

Alan, please DON'T apply this patch.

Andrzej


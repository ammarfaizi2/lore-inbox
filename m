Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbTCaT52>; Mon, 31 Mar 2003 14:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbTCaT52>; Mon, 31 Mar 2003 14:57:28 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:18608 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S261819AbTCaT51>; Mon, 31 Mar 2003 14:57:27 -0500
Message-Id: <200303312005.h2VK5ZGi027341@locutus.cmf.nrl.navy.mil>
To: davem@redhat.com
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [patch] fix atm/iphase.c .text.exit error 
In-reply-to: Your message of "Thu, 27 Mar 2003 23:14:31 +0100."
             <20030327221431.GG24744@fs.tum.de> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 31 Mar 2003 15:05:35 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please apply this to 2.4 and 2.5.  thanks in advance.

In message <20030327221431.GG24744@fs.tum.de>,Adrian Bunk writes:
>The function ia_remove_one in drivers/atm/iphase.c is __devexit but the
>pointer to it doesn't use __devexit_p resulting in a .text.exit error if
>!CONFIG_HOTPLUG.
>
>The following patch is needed:
>
>
>--- linux-2.4.21-pre6-full-nohotplug/drivers/atm/iphase.c.old	2003-03-27 22:4
>5:31.000000000 +0100
>+++ linux-2.4.21-pre6-full-nohotplug/drivers/atm/iphase.c	2003-03-27 22:4
>6:28.000000000 +0100
>@@ -3322,7 +3322,7 @@
> 	.name =         DEV_LABEL,
> 	.id_table =     ia_pci_tbl,
> 	.probe =        ia_init_one,
>-	.remove =       ia_remove_one,
>+	.remove =       __devexit_p(ia_remove_one),
> };
> 
> static int __init ia_init_module(void)
>
>
>This patch applies against 2.4.21-pre6 and 2.5.66. I've tested the 
>compilation with 2.4.21-pre6.
>
>Please apply
>Adrian
>
>-- 
>
>       "Is there not promise of rain?" Ling Tan asked suddenly out
>        of the darkness. There had been need of rain for many days.
>       "Only a promise," Lao Er said.
>                                       Pearl S. Buck - Dragon Seed
>
>

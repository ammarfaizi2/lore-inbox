Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVKEIcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVKEIcK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 03:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbVKEIcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 03:32:10 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:42464 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751229AbVKEIcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 03:32:08 -0500
Message-ID: <436C6F02.90904@student.ltu.se>
Date: Sat, 05 Nov 2005 09:36:18 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ashutosh.lkml@gmail.com, netdev@vger.kernel.org, davej@suse.de,
       acme@conectiva.com.br, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH]dgrs - Fixes Warnings when CONFIG_ISA and CONFIG_PCI are
 not enabled
References: <81083a450511012314q4ec69927gfa60cb19ba8f437a@mail.gmail.com>	<4368878D.4040406@student.ltu.se>	<c216304e0511020516o5cfcd0b9u96a3220bf2694928@mail.gmail.com>	<436927CA.3090105@student.ltu.se>	<20051104182537.741be3d9.akpm@osdl.org> <20051104183043.27a2229c.akpm@osdl.org>
In-Reply-To: <20051104183043.27a2229c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>In fact we can de-ifdef things a bit.
>
>diff -puN drivers/net/dgrs.c~dgrs-fixes-warnings-when-config_isa-and-config_pci-are-not-enabled drivers/net/dgrs.c
>--- devel/drivers/net/dgrs.c~dgrs-fixes-warnings-when-config_isa-and-config_pci-are-not-enabled	2005-11-04 18:26:59.000000000 -0800
>+++ devel-akpm/drivers/net/dgrs.c	2005-11-04 18:29:24.000000000 -0800
>@@ -1549,7 +1549,7 @@ MODULE_PARM_DESC(nicmode, "Digi RightSwi
> static int __init dgrs_init_module (void)
> {
> 	int	i;
>-	int eisacount = 0, pcicount = 0;
>+	int	cardcount = 0;
> 
> 	/*
> 	 *	Command line variable overrides
>@@ -1591,15 +1591,13 @@ static int __init dgrs_init_module (void
> 	 *	Find and configure all the cards
> 	 */
> #ifdef CONFIG_EISA
>-	eisacount = eisa_driver_register(&dgrs_eisa_driver);
>-	if (eisacount < 0)
>-		return eisacount;
>-#endif
>-#ifdef CONFIG_PCI
>-	pcicount = pci_register_driver(&dgrs_pci_driver);
>-	if (pcicount)
>-		return pcicount;
>+	cardcount = eisa_driver_register(&dgrs_eisa_driver);
>+	if (cardcount < 0)
>+		return cardcount;
> #endif
>+	cardcount = pci_register_driver(&dgrs_pci_driver);
>+	if (cardcount)
>+		return cardcount;
> 	return 0;
> }
>  
>
I do not know what to think about this one:
* reduce one #ifdef: good
* check for something clearly stated not to: not so good

But as Ashutosh Naik said: Any one can be committed.

/Richard


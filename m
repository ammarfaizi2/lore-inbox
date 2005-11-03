Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030518AbVKCXJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030518AbVKCXJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVKCXJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:09:23 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:20725 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1030499AbVKCXJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:09:22 -0500
Message-ID: <436A9994.1000201@student.ltu.se>
Date: Fri, 04 Nov 2005 00:13:24 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ashutosh Naik <ashutosh.lkml@gmail.com>
CC: netdev@vger.kernel.org, davej@suse.de, acme@conectiva.com.br,
       linux-net@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       stable@kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] /drivers/net/dgrs.c - Fixes Warnings when CONFIG_EISA or
 CONFIG_PCI are not enabled
References: <81083a450511012314q4ec69927gfa60cb19ba8f437a@mail.gmail.com>	 <4368878D.4040406@student.ltu.se>	 <c216304e0511020516o5cfcd0b9u96a3220bf2694928@mail.gmail.com>	 <436927CA.3090105@student.ltu.se> <c216304e0511022139j70614ae3l3a96767c0a36358e@mail.gmail.com>
In-Reply-To: <c216304e0511022139j70614ae3l3a96767c0a36358e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>This patch fixes compiler warnings when CONFIG_ISA and CONFIG_PCI are
>>>>>not enabled in the dgrc network driver.
>>>>>
>>>>>Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>	
>>>>>
>>>>>--
>>>>>diff -Naurp linux-2.6.14/drivers/net/dgrs.c
>>>>>linux-2.6.14-git1/drivers/net/dgrs.c---
>>>>>linux-2.6.14/drivers/net/dgrs.c     2005-10-28 05:32:08.000000000
>>>>>+0530
>>>>>+++ linux-2.6.14-git1/drivers/net/dgrs.c        2005-11-01
>>>>>10:30:03.000000000 +0530
>>>>>@@ -1549,8 +1549,12 @@ MODULE_PARM_DESC(nicmode, "Digi RightSwi
>>>>>static int __init dgrs_init_module (void)  {
>>>>>      int     i;
>>>>>-       int eisacount = 0, pcicount = 0;
>>>>>-
>>>>>+#ifdef CONFIG_EISA
>>>>>+       int eisacount = 0;
>>>>>+#endif
>>>>>+#ifdef CONFIG_PCI
>>>>>+       int pcicount = 0;
>>>>>+#endif
>>>>>      /*
>>>>>       *      Command line variable overrides
>>>>>       *              debug=NNN
>>>>>          
>>>>>
>
>Both CONFIG_PCI and CONFIG_EISA cant be undefined at the same time,
>because the device has to be on either of the 2 busses. I think your
>patch is better in that case.
>
>Cheers
>Ashutosh
>  
>
OK, then I send in the patch again. Thanks for your help/opinion.

Till the next time...
/Richard

<--  snip  -->

This patch fixes compiler warnings when CONFIG_ISA or CONFIG_PCI are not enabled in the dgrc network driver.

Cleanly patched to 2.6.14-git6.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

diff -Nurp a/drivers/net/dgrs.c b/drivers/net/dgrs.c
--- a/drivers/net/dgrs.c	2005-10-28 02:02:08.000000000 +0200
+++ b/drivers/net/dgrs.c	2005-11-02 10:19:43.000000000 +0100
@@ -1549,7 +1549,7 @@ MODULE_PARM_DESC(nicmode, "Digi RightSwi
 static int __init dgrs_init_module (void)
 {
 	int	i;
-	int eisacount = 0, pcicount = 0;
+	int	count;
 
 	/*
 	 *	Command line variable overrides
@@ -1591,14 +1591,14 @@ static int __init dgrs_init_module (void
 	 *	Find and configure all the cards
 	 */
 #ifdef CONFIG_EISA
-	eisacount = eisa_driver_register(&dgrs_eisa_driver);
-	if (eisacount < 0)
-		return eisacount;
+	count = eisa_driver_register(&dgrs_eisa_driver);
+	if (count < 0)
+		return count;
 #endif
 #ifdef CONFIG_PCI
-	pcicount = pci_register_driver(&dgrs_pci_driver);
-	if (pcicount)
-		return pcicount;
+	count = pci_register_driver(&dgrs_pci_driver);
+	if (count)
+		return count;
 #endif
 	return 0;
 }



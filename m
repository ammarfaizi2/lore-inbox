Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVKEC0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVKEC0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 21:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVKEC0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 21:26:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750757AbVKEC0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 21:26:06 -0500
Date: Fri, 4 Nov 2005 18:25:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: ashutosh.lkml@gmail.com, netdev@vger.kernel.org, davej@suse.de,
       acme@conectiva.com.br, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH]dgrs - Fixes Warnings when CONFIG_ISA and CONFIG_PCI are
 not enabled
Message-Id: <20051104182537.741be3d9.akpm@osdl.org>
In-Reply-To: <436927CA.3090105@student.ltu.se>
References: <81083a450511012314q4ec69927gfa60cb19ba8f437a@mail.gmail.com>
	<4368878D.4040406@student.ltu.se>
	<c216304e0511020516o5cfcd0b9u96a3220bf2694928@mail.gmail.com>
	<436927CA.3090105@student.ltu.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson <ricknu-0@student.ltu.se> wrote:
>
> >
> >
> >>>This patch fixes compiler warnings when CONFIG_ISA and CONFIG_PCI are
> >>>not enabled in the dgrc network driver.
> >>>
> >>>Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>
> >>>
> >>>--
> >>>diff -Naurp linux-2.6.14/drivers/net/dgrs.c
> >>>linux-2.6.14-git1/drivers/net/dgrs.c---
> >>>linux-2.6.14/drivers/net/dgrs.c     2005-10-28 05:32:08.000000000
> >>>+0530
> >>>+++ linux-2.6.14-git1/drivers/net/dgrs.c        2005-11-01
> >>>10:30:03.000000000 +0530
> >>>@@ -1549,8 +1549,12 @@ MODULE_PARM_DESC(nicmode, "Digi RightSwi
> >>>static int __init dgrs_init_module (void)  {
> >>>       int     i;
> >>>-       int eisacount = 0, pcicount = 0;
> >>>-
> >>>+#ifdef CONFIG_EISA
> >>>+       int eisacount = 0;
> >>>+#endif
> >>>+#ifdef CONFIG_PCI
> >>>+       int pcicount = 0;
> >>>+#endif
> >>>       /*
> >>>        *      Command line variable overrides
> >>>        *              debug=NNN
> >>>-
> >>>      
> >>>
> 
> >>Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> >>
> >>---
> >>
> >>diff -uNr a/drivers/net/dgrs.c b/drivers/net/dgrs.c
> >>--- a/drivers/net/dgrs.c        2005-08-29 01:41:01.000000000 +0200
> >>+++ b/drivers/net/dgrs.c        2005-10-26 15:53:43.000000000 +0200
> >>@@ -1549,7 +1549,7 @@
> >> static int __init dgrs_init_module (void)
> >> {
> >>        int     i;
> >>-       int eisacount = 0, pcicount = 0;
> >>+       int     count;
> >>
> >>        /*
> >>         *      Command line variable overrides
> >>@@ -1591,14 +1591,14 @@
> >>         *      Find and configure all the cards
> >>         */
> >> #ifdef CONFIG_EISA
> >>-       eisacount = eisa_driver_register(&dgrs_eisa_driver);
> >>-       if (eisacount < 0)
> >>-               return eisacount;
> >>+       count = eisa_driver_register(&dgrs_eisa_driver);
> >>+       if (count < 0)
> >>+               return count;
> >> #endif
> >> #ifdef CONFIG_PCI
> >>-       pcicount = pci_register_driver(&dgrs_pci_driver);
> >>-       if (pcicount)
> >>-               return pcicount;
> >>+       count = pci_register_driver(&dgrs_pci_driver);
> >>+       if (count)
> >>+               return count;
> >> #endif
> >>        return 0;
> >> }
> >>    
> >>
> >
> >Well, both of them do the same stuff, but one of these patches needs
> >to be committed.
> >
> >Cheers
> >Ashutosh
> >  
> >
> Can both CONFIG_PCI and CONFIG_EISA be undefined at the same time? If 
> so

Not for this driver.   From drivers/net/dgrs.c:

config DGRS
	tristate "Digi Intl. RightSwitch SE-X support"
	depends on NET_PCI && (PCI || EISA)

> I think you patch is better.

Let's go with Ashutosh's patch then, thanks.


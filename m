Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131410AbRAWQmk>; Tue, 23 Jan 2001 11:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRAWQma>; Tue, 23 Jan 2001 11:42:30 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:40064 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S131410AbRAWQm1>; Tue, 23 Jan 2001 11:42:27 -0500
Date: Tue, 23 Jan 2001 17:42:23 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Karsten Keil <kkeil@suse.de>, linux-kernel@vger.kernel.org,
        Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
Subject: Re: BUG in modutils or drivers/isdn/hisax/
In-Reply-To: <20010123151302.J1173@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.10.10101231740360.2893-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Jan 2001, Ingo Oeser wrote:

> To quote drivers/isdn/hisax/config.c:1710-1713
> static struct pci_device_id hisax_pci_tbl[] __initdata = {
> #ifdef CONFIG_HISAX_FRTIZPCI
>         {PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_FRITZ,       PCI_ANY_ID, PCI_ANY_ID},
> #endif
> 
> To quote my .config:
> CONFIG_ISDN_DRV_HISAX=m
> CONFIG_HISAX_FRITZPCI=y
> 
> So the bug is indeed in the driver and is a speling mistake
> Patch is:
> 
> --- linux/drivers/isdn/hisax/config.c.orig	Fri Dec 29 23:07:22 2000
> +++ linux/drivers/isdn/hisax/config.c	Tue Jan 23 15:07:54 2001
> @@ -1708,8 +1708,8 @@
>  }
>  
>  static struct pci_device_id hisax_pci_tbl[] __initdata = {
> -#ifdef CONFIG_HISAX_FRTIZPCI
> -	{PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_FRITZ,        PCI_ANY_ID, PCI_ANY_ID},
> +#ifdef CONFIG_HISAX_FRITZPCI
> +	{PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_FRITZ,	PCI_ANY_ID, PCI_ANY_ID},
>  #endif
>  #ifdef CONFIG_HISAX_DIEHLDIVA
>  	{PCI_VENDOR_ID_EICON,    PCI_DEVICE_ID_EICON_DIVA20,     PCI_ANY_ID, PCI_ANY_ID},
> 

Close, but not quite. (Try compiling after your patch :)

Correct patch:

--- linux-2.4.0/drivers/isdn/hisax/config.c	Fri Dec 29 23:07:22 2000
+++ linux-2.4.1-pre10.work/drivers/isdn/hisax/config.c	Tue Jan 23 11:23:54 2001
@@ -1708,8 +1708,8 @@
 }
 
 static struct pci_device_id hisax_pci_tbl[] __initdata = {
-#ifdef CONFIG_HISAX_FRTIZPCI
-	{PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_FRITZ,        PCI_ANY_ID, PCI_ANY_ID},
+#ifdef CONFIG_HISAX_FRITZPCI
+	{PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_A1,          PCI_ANY_ID, PCI_ANY_ID},
 #endif
 #ifdef CONFIG_HISAX_DIEHLDIVA
 	{PCI_VENDOR_ID_EICON,    PCI_DEVICE_ID_EICON_DIVA20,     PCI_ANY_ID, PCI_ANY_ID},

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

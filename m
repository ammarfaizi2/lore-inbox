Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAWON0>; Tue, 23 Jan 2001 09:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129831AbRAWONR>; Tue, 23 Jan 2001 09:13:17 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:19591 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129485AbRAWONF>; Tue, 23 Jan 2001 09:13:05 -0500
Date: Tue, 23 Jan 2001 15:13:02 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Karsten Keil <kkeil@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in modutils or drivers/isdn/hisax/
Message-ID: <20010123151302.J1173@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010123013155.E1173@nightmaster.csn.tu-chemnitz.de> <20010123122849.A27379@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010123122849.A27379@gruyere.muc.suse.de>; from kkeil@suse.de on Tue, Jan 23, 2001 at 12:28:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karsten,

On Tue, Jan 23, 2001 at 12:28:49PM +0100, Karsten Keil wrote:
> > the current modutils (2.4.1) cannot read the
> > __module_pci_device_table of a kernel/drivers/isdn/hisax/hisax.o
> > module of linux 2.4.0 (vanilla).
> > 
> > What's wrong with it?
> 
> Nothing. Only the HFC-PCI part in hisax has such a table yet, all other
> card drivers in hisax don't have one at the moment.

To quote drivers/isdn/hisax/config.c:1710-1713
static struct pci_device_id hisax_pci_tbl[] __initdata = {
#ifdef CONFIG_HISAX_FRTIZPCI
        {PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_FRITZ,       PCI_ANY_ID, PCI_ANY_ID},
#endif

To quote my .config:
CONFIG_ISDN_DRV_HISAX=m
CONFIG_HISAX_FRITZPCI=y

So the bug is indeed in the driver and is a speling mistake
Patch is:

--- linux/drivers/isdn/hisax/config.c.orig	Fri Dec 29 23:07:22 2000
+++ linux/drivers/isdn/hisax/config.c	Tue Jan 23 15:07:54 2001
@@ -1708,8 +1708,8 @@
 }
 
 static struct pci_device_id hisax_pci_tbl[] __initdata = {
-#ifdef CONFIG_HISAX_FRTIZPCI
-	{PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_FRITZ,        PCI_ANY_ID, PCI_ANY_ID},
+#ifdef CONFIG_HISAX_FRITZPCI
+	{PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_FRITZ,	PCI_ANY_ID, PCI_ANY_ID},
 #endif
 #ifdef CONFIG_HISAX_DIEHLDIVA
 	{PCI_VENDOR_ID_EICON,    PCI_DEVICE_ID_EICON_DIVA20,     PCI_ANY_ID, PCI_ANY_ID},


Please apply.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

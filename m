Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbUJXLZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbUJXLZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 07:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUJXLRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 07:17:50 -0400
Received: from nl-ams-slo-l4-01-pip-7.chellonetwork.com ([213.46.243.25]:53596
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261448AbUJXLOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 07:14:51 -0400
Date: Sun, 24 Oct 2004 13:14:47 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Karsten Keil <kkeil@suse.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       isdn4linux@listserv.isdn4linux.de
Subject: [PATCH] Elsa ISDN: Kill warnings if !PCI
Message-ID: <Pine.LNX.4.61.0410241311120.27282@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Elsa ISDN: Kill warnings if !PCI

I'm not 100% sure this is correct, though. Can setup_elsa() be called multiple
times? If yes, dev_qs[13]000 have to be static.

--- linux-2.6.10-rc1/drivers/isdn/hisax/elsa.c.orig	2004-10-23 10:33:02.000000000 +0200
+++ linux-2.6.10-rc1/drivers/isdn/hisax/elsa.c	2004-10-24 12:54:59.000000000 +0200
@@ -834,9 +834,6 @@ probe_elsa(struct IsdnCardState *cs)
 	return (CARD_portlist[i]);
 }
 
-static 	struct pci_dev *dev_qs1000 __devinitdata = NULL;
-static 	struct pci_dev *dev_qs3000 __devinitdata = NULL;
-
 #ifdef __ISAPNP__
 static struct isapnp_device_id elsa_ids[] __initdata = {
 	{ ISAPNP_VENDOR('E', 'L', 'S'), ISAPNP_FUNCTION(0x0133),
@@ -1022,6 +1019,9 @@ setup_elsa(struct IsdnCard *card)
 		       cs->irq);
 	} else if (cs->typ == ISDN_CTYPE_ELSA_PCI) {
 #ifdef CONFIG_PCI
+		struct pci_dev *dev_qs1000 = NULL;
+		struct pci_dev *dev_qs3000 = NULL;
+
 		cs->subtyp = 0;
 		if ((dev_qs1000 = pci_find_device(PCI_VENDOR_ID_ELSA,
 			PCI_DEVICE_ID_ELSA_MICROLINK, dev_qs1000))) {
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

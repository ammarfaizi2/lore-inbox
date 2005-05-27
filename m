Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVE0K1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVE0K1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVE0K1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:27:12 -0400
Received: from mailfe10.swip.net ([212.247.155.33]:30117 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262418AbVE0K1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:27:07 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH] VIA IRQ quirk for 2.6.12-rc5
From: Alexander Nyberg <alexn@telia.com>
To: Len Brown <lenb@toshiba.hsd1.ma.comcast.net>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, bjorn.helgaas@hp.com
In-Reply-To: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
Content-Type: text/plain
Date: Fri, 27 May 2005 12:27:05 +0200
Message-Id: <1117189625.949.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus,
> Please apply this patch to 2.6.12-rc5.
> It fixes a 2.6.11 regression in the VIA IRQ quirk
> on machines with mixed vendor chip-sets.
> 
> thanks,
> Len
> 
> 
> Delete quirk_via_bridge(), restore quirk_via_irqpic() --
> but now improved to be invoked upon device ENABLE, and
> now only for VIA devices -- not all devices behind VIA bridges.

Please drop the __devinit on quirk_via_irqpic() or apply the patch I'm
putting at the bottom. Also there seems to be a completely unrelated
acpi chunk at the bottom of your patch...

quirk_via_irqpic can't be __devinit for swsuspend

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: linux-2.6/drivers/pci/quirks.c
===================================================================
--- linux-2.6.orig/drivers/pci/quirks.c	2005-05-27 12:15:17.000000000 +0200
+++ linux-2.6/drivers/pci/quirks.c	2005-05-27 12:17:10.000000000 +0200
@@ -492,7 +492,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
 
-static void __devinit quirk_via_irqpic(struct pci_dev *dev)
+static void quirk_via_irqpic(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
 



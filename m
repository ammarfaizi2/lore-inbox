Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288855AbSBILpU>; Sat, 9 Feb 2002 06:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288870AbSBILpK>; Sat, 9 Feb 2002 06:45:10 -0500
Received: from maild.telia.com ([194.22.190.101]:62169 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S288855AbSBILpB>;
	Sat, 9 Feb 2002 06:45:01 -0500
To: Patrick Mochel <mochel@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [bk patch] Make cardbus compile in -pre4
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org>
From: Peter Osterlund <petero2@telia.com>
Date: 09 Feb 2002 12:44:51 +0100
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org>
Message-ID: <m2vgd6hob0.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org> writes:

> I broke cardbus compile in -pre4 on accident. Sorry about that...

It compiles in -pre5 but doesn't work unless you also apply the patch
below. Without this patch, bus_id will be empty which makes
device_register fail.

--- linux/drivers/pcmcia/cardbus.c.old	Sat Feb  9 12:39:49 2002
+++ linux/drivers/pcmcia/cardbus.c	Sat Feb  9 12:14:36 2002
@@ -279,13 +279,13 @@
 		pci_readw(dev, PCI_DEVICE_ID, &dev->device);
 		dev->hdr_type = hdr & 0x7f;
 
+		pci_setup_device(dev);
+
 		dev->dev.parent = bus->dev;
 		strcpy(dev->dev.name, dev->name);
 		strcpy(dev->dev.bus_id, dev->slot_name);
 		device_register(&dev->dev);
 
-		pci_setup_device(dev);
-
 		/* FIXME: Do we need to enable the expansion ROM? */
 		for (r = 0; r < 7; r++) {
 			struct resource *res = dev->resource + r;

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

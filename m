Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288116AbSBICYy>; Fri, 8 Feb 2002 21:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291906AbSBICYo>; Fri, 8 Feb 2002 21:24:44 -0500
Received: from air-2.osdl.org ([65.201.151.6]:32696 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S291894AbSBICYh>;
	Fri, 8 Feb 2002 21:24:37 -0500
Date: Fri, 8 Feb 2002 18:25:17 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: <linux-kernel@vger.kernel.org>
Subject: [bk patch] Make cardbus compile in -pre4
Message-ID: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I broke cardbus compile in -pre4 on accident. Sorry about that...

(I don't have a public repository yet, so there's no place to pull form)

diffstat results: 
 drivers/pcmcia/cardbus.c |    3 +--
 1 files changed, 1 insertion, 2 deletions

ChangeSet
  1.231 02/02/08 18:22:27 mochel@segfault.osdlab.org +1 -0
  Doh! 
  struct device has no ->sysdata
  and ->device should be ->dev
   

  drivers/pcmcia/cardbus.c
    1.7 02/02/08 18:22:27 mochel@segfault.osdlab.org +1 -2
    Doh! 
    struct device has no ->sysdata
    and ->device should be ->dev
     


diff -Nru a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
--- a/drivers/pcmcia/cardbus.c	Fri Feb  8 18:23:08 2002
+++ b/drivers/pcmcia/cardbus.c	Fri Feb  8 18:23:08 2002
@@ -279,8 +279,7 @@
 		pci_readw(dev, PCI_DEVICE_ID, &dev->device);
 		dev->hdr_type = hdr & 0x7f;
 
-		dev->dev.parent = bus->device;
-		dev->dev.sysdata = bus->sysdata;
+		dev->dev.parent = bus->dev;
 		strcpy(dev->dev.name, dev->name);
 		strcpy(dev->dev.bus_id, dev->slot_name);
 		device_register(&dev->dev);


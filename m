Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316686AbSE0QwF>; Mon, 27 May 2002 12:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316690AbSE0QwE>; Mon, 27 May 2002 12:52:04 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:22020 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316686AbSE0QwE>; Mon, 27 May 2002 12:52:04 -0400
Date: Mon, 27 May 2002 20:51:54 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.18 pci/setup-bus.c: incorrect BUG() calls
Message-ID: <20020527205154.A1338@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously assigned resources are perfectly valid - just silently
ignore them.

Ivan.

--- 2.5.18/drivers/pci/setup-bus.c	Sat May 25 05:55:25 2002
+++ linux/drivers/pci/setup-bus.c	Mon May 27 16:06:39 2002
@@ -228,10 +228,8 @@ pbus_size_io(struct pci_bus *bus)
 			struct resource *r = &dev->resource[i];
 			unsigned long r_size;
 
-			if (!(r->flags & IORESOURCE_IO))
+			if (r->parent || !(r->flags & IORESOURCE_IO))
 				continue;
-			if (r->parent)
-				BUG();
 			r_size = r->end - r->start + 1;
 
 			if (r_size < 0x400)
@@ -283,10 +281,8 @@ pbus_size_mem(struct pci_bus *bus, unsig
 			struct resource *r = &dev->resource[i];
 			unsigned long r_size;
 
-			if ((r->flags & mask) != type)
+			if (r->parent || (r->flags & mask) != type)
 				continue;
-			if (r->parent)
-				BUG();
 			r_size = r->end - r->start + 1;
 			/* For bridges size != alignment */
 			align = (i < PCI_BRIDGE_RESOURCES) ? r_size : r->start;

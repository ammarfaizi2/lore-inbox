Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbSKFR7Y>; Wed, 6 Nov 2002 12:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265882AbSKFR7X>; Wed, 6 Nov 2002 12:59:23 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:5380 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265880AbSKFR7X>; Wed, 6 Nov 2002 12:59:23 -0500
Date: Wed, 6 Nov 2002 21:05:55 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5-bk] PCI 1/3: transparent bridge detection fix
Message-ID: <20021106210555.C686@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The detection of subtractive decoding bridges is broken: `class' variable
doesn't contain ProgIf byte at this point, I should check `dev->class'
instead.

Ivan.

--- 2.5-bk/drivers/pci/probe.c	Wed Nov  6 17:38:46 2002
+++ linux/drivers/pci/probe.c	Wed Nov  6 18:16:52 2002
@@ -384,7 +384,7 @@ int pci_setup_device(struct pci_dev * de
 		/* The PCI-to-PCI bridge spec requires that subtractive
 		   decoding (i.e. transparent) bridge must have programming
 		   interface code of 0x01. */ 
-		dev->transparent = ((class & 0xff) == 1);
+		dev->transparent = ((dev->class & 0xff) == 1);
 		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
 		break;
 

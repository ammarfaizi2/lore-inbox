Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261803AbTCLQy6>; Wed, 12 Mar 2003 11:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbTCLQy6>; Wed, 12 Mar 2003 11:54:58 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:56846 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261803AbTCLQy6>; Wed, 12 Mar 2003 11:54:58 -0500
Date: Wed, 12 Mar 2003 20:04:59 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] PCI: pbus_size_mem() fix
Message-ID: <20030312200459.A6570@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes long standing typo ('size' instead of 'r_size') which causes
overestimate of the bridge memory ranges calculated in pbus_size_mem().
For example, if we have a device with one 1Mb and one 2Mb memory ranges
behind the bridge, calculated size and alignment of the bridge memory
window will be 4Mb and 2Mb respectively, while the correct values are
3Mb and 1Mb.

Ivan.

--- 2.5/drivers/pci/setup-bus.c	Wed Mar 12 13:33:45 2003
+++ linux/drivers/pci/setup-bus.c	Wed Mar 12 18:50:03 2003
@@ -284,7 +284,7 @@ pbus_size_mem(struct pci_bus *bus, unsig
 				order = 0;
 			/* Exclude ranges with size > align from
 			   calculation of the alignment. */
-			if (size == align)
+			if (r_size == align)
 				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSFIPHO>; Sun, 9 Jun 2002 11:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSFIPHN>; Sun, 9 Jun 2002 11:07:13 -0400
Received: from p50887457.dip.t-dialin.net ([80.136.116.87]:3803 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S312590AbSFIPHN>; Sun, 9 Jun 2002 11:07:13 -0400
Date: Sun, 9 Jun 2002 09:07:07 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Dave Jones <davej@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] pcbios should use list_move_tail, too (1 occ)
Message-ID: <Pine.LNX.4.44.0206090905550.26112-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces list_move_tail for the pcbios pci driver

--- linus-2.5/arch/i386/pci/pcbios.c	Sun Jun  9 04:12:38 2002
+++ thunder-2.5/arch/i386/pci/pcbios.c	Sun Jun  9 05:15:31 2002
@@ -444,8 +444,7 @@
 			for (ln=pci_devices.next; ln != &pci_devices; ln=ln->next) {
 				d = pci_dev_g(ln);
 				if (d->bus->number == bus && d->devfn == devfn) {
-					list_del(&d->global_list);
-					list_add_tail(&d->global_list, &sorted_devices);
+					list_move_tail(&d->global_list, &sorted_devices);
 					if (d == dev)
 						found = 1;
 					break;
@@ -463,8 +462,7 @@
 		if (!found) {
 			printk(KERN_WARNING "PCI: Device %02x:%02x not found by BIOS\n",
 				dev->bus->number, dev->devfn);
-			list_del(&dev->global_list);
-			list_add_tail(&dev->global_list, &sorted_devices);
+			list_move_tail(&dev->global_list, &sorted_devices);
 		}
 	}
 	list_splice(&sorted_devices, &pci_devices);

-- 
Lightweight patch manager using pine. If you have any objections, tell me.


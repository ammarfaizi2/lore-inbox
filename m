Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLKRGN>; Mon, 11 Dec 2000 12:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbQLKRGE>; Mon, 11 Dec 2000 12:06:04 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:37387 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129226AbQLKRFt>;
	Mon, 11 Dec 2000 12:05:49 -0500
Date: Mon, 11 Dec 2000 18:34:30 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: mj@suse.cz
cc: linux-kernel@vger.kernel.org
Subject: [minor patch] pci.h 
Message-ID: <Pine.LNX.4.10.10012111826110.2565-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Martin
	this patch makes computing of pci_resource_len a bit more
straightforward and hopefully still correct.Plus an aesthetic change in a
struct declaration :)

--- /usr/src/clean/linux/include/linux/pci.h	Mon Dec 11 16:49:19 2000
+++ pci.h	Mon Dec 11 17:54:24 2000
@@ -432,8 +432,7 @@
 	int (*write_dword)(struct pci_dev *, int where, u32 val);
 };
 
-struct pbus_set_ranges_data
-{
+struct pbus_set_ranges_data {
 	int found_vga;
 	unsigned long io_start, io_end;
 	unsigned long mem_start, mem_end;
@@ -636,9 +635,8 @@
 #define pci_resource_end(dev,bar)     ((dev)->resource[(bar)].end)
 #define pci_resource_flags(dev,bar)   ((dev)->resource[(bar)].flags)
 #define pci_resource_len(dev,bar) \
-	((pci_resource_start((dev),(bar)) == 0 &&	\
-	  pci_resource_end((dev),(bar)) ==		\
-	  pci_resource_start((dev),(bar))) ? 0 :	\
+	(!(pci_resource_start((dev),(bar)) ||		\
+	   pci_resource_end((dev),(bar)))  ? 0 :	\
 	  						\
 	 (pci_resource_end((dev),(bar)) -		\
 	  pci_resource_start((dev),(bar)) + 1))


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318441AbSGaSp7>; Wed, 31 Jul 2002 14:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318448AbSGaSp7>; Wed, 31 Jul 2002 14:45:59 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:24208 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S318441AbSGaSp6>;
	Wed, 31 Jul 2002 14:45:58 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: trivial@rustcorp.com.au
Subject: [PATCH] trivial 2.4.19-rc3 zone init printk
Date: Wed, 31 Jul 2002 12:49:16 -0600
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207311249.16774.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change:

    On node 0 totalpages: 61031         <--- not including holes
    zone(0): 65172 pages.               <--- including holes
    zone(1): 0 pages.                   ...
    zone(2): 0 pages.

to:

    On node 0 totalpages: 61031         <--- not including holes
      DMA zone: 61031 pages             <--- not including holes
      Normal zone: 0 pages
      HighMem zone: 0 pages


--- linux-2.4.19-rc3/mm/page_alloc.c	Wed Jul 31 04:29:27 2002
+++ linux-2.4.19-rc3.new/mm/page_alloc.c	Wed Jul 31 04:33:50 2002
@@ -692,10 +692,9 @@
 		BUG();
 
 	totalpages = 0;
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		unsigned long size = zones_size[i];
-		totalpages += size;
-	}
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		totalpages += zones_size[i];
+
 	realtotalpages = totalpages;
 	if (zholes_size)
 		for (i = 0; i < MAX_NR_ZONES; i++)
@@ -733,7 +732,7 @@
 		if (zholes_size)
 			realsize -= zholes_size[j];
 
-		printk("zone(%lu): %lu pages.\n", j, size);
+		printk("  %s zone: %lu pages\n", zone_names[j], realsize);
 		zone->size = size;
 		zone->name = zone_names[j];
 		zone->lock = SPIN_LOCK_UNLOCKED;


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293628AbSCPA6D>; Fri, 15 Mar 2002 19:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293630AbSCPA5w>; Fri, 15 Mar 2002 19:57:52 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:59290 "EHLO gin")
	by vger.kernel.org with ESMTP id <S293628AbSCPA5p>;
	Fri, 15 Mar 2002 19:57:45 -0500
Date: Sat, 16 Mar 2002 01:57:37 +0100
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] devexit fixes in i82092.c
Message-ID: <20020316005736.GB31421@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes "undefined reference to `local symbols in discarded
section .text.exit'" linking error.

-- 

//anders/g

--- linux-2.5.7-pre1/drivers/pcmcia/i82092.c	Fri Nov  9 22:45:35 2001
+++ linux-2.5.7-pre1-reiser/drivers/pcmcia/i82092.c	Sat Mar 16 01:39:42 2002
@@ -42,7 +42,7 @@
 	name:           "i82092aa",
 	id_table:       i82092aa_pci_ids,
 	probe:          i82092aa_pci_probe,
-	remove:         i82092aa_pci_remove,
+	remove:         __devexit_p(i82092aa_pci_remove),
 	suspend:        NULL,
 	resume:         NULL 
 };
@@ -88,7 +88,7 @@
 static int socket_count;  /* shortcut */                                  	                                	
 
 
-static int __init i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int __devinit i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char configbyte;
 	int i;
@@ -160,7 +160,7 @@
 	return 0;
 }
 
-static void __exit i82092aa_pci_remove(struct pci_dev *dev)
+static void __devexit i82092aa_pci_remove(struct pci_dev *dev)
 {
 	enter("i82092aa_pci_remove");
 	

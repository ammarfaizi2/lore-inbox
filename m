Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270967AbTG0Xbu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270939AbTG0XbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:31:25 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272999AbTG0XCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:48 -0400
Date: Sun, 27 Jul 2003 21:04:34 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272004.h6RK4YBv029617@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: some isdn invalid/illegal fixups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/isdn/capi/capidrv.c linux-2.6.0-test2-ac1/drivers/isdn/capi/capidrv.c
--- linux-2.6.0-test2/drivers/isdn/capi/capidrv.c	2003-07-10 21:08:51.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/isdn/capi/capidrv.c	2003-07-15 18:01:29.000000000 +0100
@@ -1596,7 +1596,7 @@
                         rc = FVteln2capi20(bchan->num, AdditionalInfo);
 			isleasedline = (rc == 0);
 			if (rc < 0)
-				printk(KERN_ERR "capidrv-%d: WARNING: illegal leased linedefinition \"%s\"\n", card->contrnr, bchan->num);
+				printk(KERN_ERR "capidrv-%d: WARNING: invalid leased linedefinition \"%s\"\n", card->contrnr, bchan->num);
 
 			if (isleasedline) {
 				calling[0] = 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/isdn/eicon/eicon_isa.c linux-2.6.0-test2-ac1/drivers/isdn/eicon/eicon_isa.c
--- linux-2.6.0-test2/drivers/isdn/eicon/eicon_isa.c	2003-07-10 21:05:28.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/isdn/eicon/eicon_isa.c	2003-07-15 18:01:29.000000000 +0100
@@ -90,7 +90,7 @@
 	if ((Mem < 0x0c0000) ||
 	    (Mem > 0x0fc000) ||
 	    (Mem & 0xfff)) { 
-		printk(KERN_WARNING "eicon_isa: illegal membase 0x%x for %s\n",
+		printk(KERN_WARNING "eicon_isa: invalid membase 0x%x for %s\n",
 			 Mem, Id);
 		return -1;
 	}
@@ -326,7 +326,7 @@
 		/* Check for valid IRQ */
 		if ((card->irq < 0) || (card->irq > 15) || 
 		    (!((1 << card->irq) & eicon_isa_valid_irq[card->type & 0x0f]))) {
-			printk(KERN_WARNING "eicon_isa_load: illegal irq: %d\n", card->irq);
+			printk(KERN_WARNING "eicon_isa_load: invalid irq: %d\n", card->irq);
 			eicon_isa_release_shmem(card);
 			kfree(code);
 			return -EINVAL;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/isdn/hardware/avm/b1isa.c linux-2.6.0-test2-ac1/drivers/isdn/hardware/avm/b1isa.c
--- linux-2.6.0-test2/drivers/isdn/hardware/avm/b1isa.c	2003-07-10 21:08:52.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/isdn/hardware/avm/b1isa.c	2003-07-15 18:01:29.000000000 +0100
@@ -78,7 +78,7 @@
 
 	if (   card->port != 0x150 && card->port != 0x250
 	    && card->port != 0x300 && card->port != 0x340) {
-		printk(KERN_WARNING "b1isa: illegal port 0x%x.\n", card->port);
+		printk(KERN_WARNING "b1isa: invalid port 0x%x.\n", card->port);
 		retval = -EINVAL;
 		goto err_free;
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/isdn/hardware/avm/t1isa.c linux-2.6.0-test2-ac1/drivers/isdn/hardware/avm/t1isa.c
--- linux-2.6.0-test2/drivers/isdn/hardware/avm/t1isa.c	2003-07-10 21:11:00.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/isdn/hardware/avm/t1isa.c	2003-07-15 18:01:29.000000000 +0100
@@ -370,7 +370,7 @@
 	sprintf(card->name, "t1isa-%x", card->port);
 
 	if (!(((card->port & 0x7) == 0) && ((card->port & 0x30) != 0x30))) {
-		printk(KERN_WARNING "t1isa: illegal port 0x%x.\n", card->port);
+		printk(KERN_WARNING "t1isa: invalid port 0x%x.\n", card->port);
 		retval = -EINVAL;
 		goto err_free;
         }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/isdn/hardware/eicon/message.c linux-2.6.0-test2-ac1/drivers/isdn/hardware/eicon/message.c
--- linux-2.6.0-test2/drivers/isdn/hardware/eicon/message.c	2003-07-10 21:11:35.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/isdn/hardware/eicon/message.c	2003-07-15 18:01:29.000000000 +0100
@@ -4487,7 +4487,7 @@
           if(rc==WRONG_IE)
           {
             Info = 0x2007; /* Illegal message parameter coding */
-            dbug(1,dprintf("MWI_REQ illegal parameter"));
+            dbug(1,dprintf("MWI_REQ invalid parameter"));
           }
           else
           {

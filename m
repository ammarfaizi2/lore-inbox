Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130164AbQKWWux>; Thu, 23 Nov 2000 17:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130687AbQKWWun>; Thu, 23 Nov 2000 17:50:43 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:45319 "EHLO
        boss.staszic.waw.pl") by vger.kernel.org with ESMTP
        id <S130230AbQKWWub>; Thu, 23 Nov 2000 17:50:31 -0500
Date: Thu, 23 Nov 2000 23:19:37 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: Andrey Panin <pazke@orbita.don.sitek.net>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net drivers cleanup
Message-ID: <Pine.LNX.4.21.0011232122280.594-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

patch-3c503:
@@ -307,11 +307,12 @@
     {
 	ei_status.tx_start_page = EL2_MB1_START_PG;
 	ei_status.rx_start_page = EL2_MB1_START_PG + TX_PAGES;
-	printk("\n%s: %s, %dkB RAM, using programmed I/O (REJUMPER for SHARED MEMORY).\n",
-	       dev->name, ei_status.name, (wordlength+1)<<3);
+	printk(	KERN_ERR "\n%s: %s, %dkB RAM, using programmed I/O (REJUMPER for SHARED MEMORY).\n",
-->			  ^^ superfluous
+		dev->name, ei_status.name, (wordlength+1)<<3);

Either remove this '\n' or change to ("\n" KERN_ERR "%s...\n").


patch-3c507:
@@ -323,8 +323,8 @@
 
 static int __init el16_probe1(struct net_device *dev, int ioaddr)
 {
-	static unsigned char init_ID_done = 0, version_printed = 0;
-	int i, irq, irqval, retval;
+	static unsigned char init_ID_done, version_printed;
+	int i, irq, retval;

This is wrong because later we depend on assumption that
these values are equal to 0 (they aren't autoinitialized to 0).


patch-lne390:
@@ -121,14 +121,14 @@
 
 	if (!EISA_bus) {
 #if LNE390_DEBUG & LNE390_D_PROBE
-		printk("lne390-debug: Not an EISA bus. Not probing high ports.\n");
+		printk(kern_debug "lne390-debug: Not an EISA bus. Not probing high ports.\n");
		       ^^^^^^^^^^ should be KERN_DEBUG of course ;)


patch-wd:
@@ -124,7 +124,7 @@
 	int ancient = 0;			/* An old card without config registers. */
 	int word16 = 0;				/* 0 = 8 bit, 1 = 16 bit */
 	const char *model_name;
-	static unsigned version_printed = 0;
+	static unsigned version_printed;

This is wrong because later we depend on assumption that
version_printed is equal to 0 (it isn't autoinitialized to 0).


Regards
--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

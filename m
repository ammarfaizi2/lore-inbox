Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbRBEOVh>; Mon, 5 Feb 2001 09:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129480AbRBEOV1>; Mon, 5 Feb 2001 09:21:27 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:34019 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129036AbRBEOVL>; Mon, 5 Feb 2001 09:21:11 -0500
Date: Mon, 5 Feb 2001 15:01:59 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Donald Becker <becker@scyld.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.1-ac1: W89c840 -- printout inconsistency?
Message-ID: <Pine.GSO.3.96.1010205145202.18067L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 While working on the CPU capabilities changes I noticed the W89c840
driver prints a different cache alignment from what it really sets.  It's
possible that it's the intended behaviour, but I really doubt it.  I don't
have such a board and I haven't ever used the driver. 

 The following patch fixes it. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.1-ac1-winbond-0
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/net/winbond-840.c linux-2.4.1-ac1/drivers/net/winbond-840.c
--- linux-2.4.1-ac1.macro/drivers/net/winbond-840.c	Sat Feb  3 12:16:41 2001
+++ linux-2.4.1-ac1/drivers/net/winbond-840.c	Sun Feb  4 17:12:28 2001
@@ -832,7 +832,7 @@ static void init_registers(struct net_de
 	if (x86 <= 4)
 		printk(KERN_INFO "%s: This is a 386/486 PCI system, setting cache "
 			   "alignment to %x.\n", dev->name,
-			   (x86 <= 4 ? 0x4810 : 0x8010));
+			   (x86 <= 4 ? 0x4810 : 0xE010));
 #endif
 #else
 	writel(0xE010, ioaddr + PCIBusCfg);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

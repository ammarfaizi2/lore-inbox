Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262515AbRE3Ap6>; Tue, 29 May 2001 20:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbRE3Apl>; Tue, 29 May 2001 20:45:41 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:3343 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262531AbRE3Ap0>; Tue, 29 May 2001 20:45:26 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300042.CAA04527@green.mif.pg.gda.pl>
Subject: [PATCH] net #5
To: alan@lxorguk.ukuu.org.uk (Alan Cox), elmer@ylenurme.ee, linux-mips@fnet.fr
Date: Wed, 30 May 2001 02:42:56 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes some long udelay()s in aironet.c and saa9730.c
in the current kernel tree.

Andrzej

*************************** PATCH 5 *******************************
diff -uNr linux-2.4.5-ac4/drivers/net/aironet4500_card.c linux/drivers/net/aironet4500_card.c
--- linux-2.4.5-ac4/drivers/net/aironet4500_card.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/aironet4500_card.c	Wed May 30 01:12:57 2001
@@ -723,14 +723,14 @@
 	awc_i365_card_release(s);
 
 
-	udelay(100000);
+	mdelay(100);
 	
 	i365_out(s, 0x2, 0x10 ); 	// power enable
-	udelay(200000);
+	mdelay(200);
 	
 	i365_out(s, 0x2, 0x10 | 0x01 | 0x04 | 0x80);	//power enable
 	
-	udelay(250000);
+	mdelay(250);
 	
 	if (!s->irq)
 		s->irq = 11;
@@ -756,7 +756,7 @@
 	i365_out(s,0x15,0x3f | 0x40);		// enab mem reg bit
 	i365_out(s,0x06,0x01);			// enab mem 
 	
-	udelay(10000);
+	mdelay(10);
 	
 	cis[0] = 0x45;
 	
@@ -767,7 +767,7 @@
 
 	mem[0x3e0] = 0x45;
 
-	udelay(10000);
+	mdelay(10);
 	
 	memcpy_fromio(cis,0xD000, 0x3e0);
 	
@@ -795,7 +795,7 @@
 		s->socket, s->manufacturer,s->product);
 
 	i365_out(s,0x07, 0x1 | 0x2); 		// enable io 16bit
-	udelay(1000);
+	mdelay(1);
 	port = s->io;
 	i365_out(s,0x08, port & 0xff);
 	i365_out(s,0x09, (port & 0xff00)/ 0x100);
@@ -804,7 +804,7 @@
 
 	i365_out(s,0x06, 0x40); 		// enable io window
 
-	udelay(1000);
+	mdelay(1);
 
 	i365_out(s,0x3e0,0x45);
 	
@@ -822,13 +822,10 @@
 
 	
 	outw(0x10, s->io + 0x34);
-	udelay(10000);
+	mdelay(10);
 	
 	return 0;
-	
-	
 
-		
 };
 
 
diff -uNr linux-2.4.5-ac4/drivers/net/saa9730.c linux/drivers/net/saa9730.c
--- linux-2.4.5-ac4/drivers/net/saa9730.c	Sat May 19 18:35:48 2001
+++ linux/drivers/net/saa9730.c	Wed May 30 01:12:57 2001
@@ -335,7 +335,7 @@
 			printk("Error: lan_saa9730_mii_init: timeout\n");
 			return -1;
 		}
-		udelay(1000);	/* wait 1 ms. */
+		mdelay(1);	/* wait 1 ms. */
 	}
 
 	/* Now set the control and address register. */
@@ -350,11 +350,11 @@
 			printk("Error: lan_saa9730_mii_init: timeout\n");
 			return -1;
 		}
-		udelay(1000);	/* wait 1 ms. */
+		mdelay(1);	/* wait 1 ms. */
 	}
 
 	/* Wait for 1 ms. */
-	udelay(1000);
+	mdelay(1);
 
 	/* Check the link status. */
 	if (INL(&lp->lan_saa9730_regs->StationMgmtData) &
@@ -369,7 +369,7 @@
 		     &lp->lan_saa9730_regs->StationMgmtCtl);
 
 		/* Wait for 1 ms. */
-		udelay(1000);
+		mdelay(1);
 
 		/* set 'CONTROL' = force reset and renegotiate */
 		OUTL(PHY_CONTROL_RESET | PHY_CONTROL_AUTO_NEG |
@@ -377,7 +377,7 @@
 		     &lp->lan_saa9730_regs->StationMgmtData);
 
 		/* Wait for 50 ms. */
-		udelay(50 * 1000);
+		mdelay(50);
 
 		/* set 'BUSY' to start operation */
 		OUTL(MD_CA_BUSY | PHY_ADDRESS << MD_CA_PHY_SHF | MD_CA_WR |
@@ -393,11 +393,11 @@
 				    ("Error: lan_saa9730_mii_init: timeout\n");
 				return -1;
 			}
-			udelay(1000);	/* wait 1 ms. */
+			mdelay(1);	/* wait 1 ms. */
 		}
 
 		/* Wait for 1 ms. */
-		udelay(1000);
+		mdelay(1);
 
 		for (l = 0; l < 2; l++) {
 			/* set PHY address = 'STATUS' */
@@ -415,11 +415,11 @@
 					    ("Error: lan_saa9730_mii_init: timeout\n");
 					return -1;
 				}
-				udelay(1000);	/* wait 1 ms. */
+				mdelay(1);	/* wait 1 ms. */
 			}
 
 			/* wait for 3 sec. */
-			udelay(3000 * 1000);
+			mdelay(3000);
 
 			/* check the link status */
 			if (INL(&lp->lan_saa9730_regs->StationMgmtData) &
@@ -495,7 +495,7 @@
 			    ("Error: lan_sa9730_stop: MAC reset timeout\n");
 			return -1;
 		}
-		udelay(1000);	/* wait 1 ms. */
+		mdelay(1);	/* wait 1 ms. */
 	}
 
 	return 0;


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk

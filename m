Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317307AbSFGRmZ>; Fri, 7 Jun 2002 13:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317310AbSFGRmY>; Fri, 7 Jun 2002 13:42:24 -0400
Received: from p50886B5E.dip.t-dialin.net ([80.136.107.94]:3721 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317307AbSFGRmV>; Fri, 7 Jun 2002 13:42:21 -0400
Date: Fri, 7 Jun 2002 11:42:06 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Mikael Pettersson <mikpe@csd.uu.se>
Subject: [PATCH][2.5] tulip: change device names
Message-ID: <Pine.LNX.4.44.0206071140080.17181-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is supposed to fix the misidentified names from 
drivers/net/tulip/media.c, which previously printk'd "eth%d".

--- linus-2.5/drivers/net/tulip/media.c	Wed Jun  5 10:02:45 2002
+++ thunder-2.5.20/drivers/net/tulip/media.c	Fri Jun  7 11:39:06 2002
@@ -182,9 +182,9 @@
 		switch (mleaf->type) {
 		case 0:					/* 21140 non-MII xcvr. */
 			if (tulip_debug > 1)
-				printk(KERN_DEBUG "%s: Using a 21140 non-MII transceiver"
+				printk(KERN_DEBUG "tulip%d: Using a 21140 non-MII transceiver"
 					   " with control setting %2.2x.\n",
-					   dev->name, p[1]);
+					   dev->ifindex, p[1]);
 			dev->if_port = p[0];
 			if (startup)
 				outl(mtable->csr12dir | 0x100, ioaddr + CSR12);
@@ -205,15 +205,15 @@
 				struct medialeaf *rleaf = &mtable->mleaf[mtable->has_reset];
 				unsigned char *rst = rleaf->leafdata;
 				if (tulip_debug > 1)
-					printk(KERN_DEBUG "%s: Resetting the transceiver.\n",
-						   dev->name);
+					printk(KERN_DEBUG "tulip%d: Resetting the transceiver.\n",
+						   dev->ifindex);
 				for (i = 0; i < rst[0]; i++)
 					outl(get_u16(rst + 1 + (i<<1)) << 16, ioaddr + CSR15);
 			}
 			if (tulip_debug > 1)
-				printk(KERN_DEBUG "%s: 21143 non-MII %s transceiver control "
+				printk(KERN_DEBUG "tulip%d: 21143 non-MII %s transceiver control "
 					   "%4.4x/%4.4x.\n",
-					   dev->name, medianame[dev->if_port], setup[0], setup[1]);
+					   dev->ifindex, medianame[dev->if_port], setup[0], setup[1]);
 			if (p[0] & 0x40) {	/* SIA (CSR13-15) setup values are provided. */
 				csr13val = setup[0];
 				csr14val = setup[1];
@@ -240,8 +240,8 @@
 				if (startup) outl(csr13val, ioaddr + CSR13);
 			}
 			if (tulip_debug > 1)
-				printk(KERN_DEBUG "%s:  Setting CSR15 to %8.8x/%8.8x.\n",
-					   dev->name, csr15dir, csr15val);
+				printk(KERN_DEBUG "tulip%d:  Setting CSR15 to %8.8x/%8.8x.\n",
+					   dev->ifindex, csr15dir, csr15val);
 			if (mleaf->type == 4)
 				new_csr6 = 0x82020000 | ((setup[2] & 0x71) << 18);
 			else
@@ -285,8 +285,8 @@
 				if (tp->mii_advertise == 0)
 					tp->mii_advertise = tp->advertising[phy_num];
 				if (tulip_debug > 1)
-					printk(KERN_DEBUG "%s:  Advertising %4.4x on MII %d.\n",
-					       dev->name, tp->mii_advertise, tp->phys[phy_num]);
+					printk(KERN_DEBUG "tulip%d:  Advertising %4.4x on MII %d.\n",
+					       dev->ifindex, tp->mii_advertise, tp->phys[phy_num]);
 				tulip_mdio_write(dev, tp->phys[phy_num], 4, tp->mii_advertise);
 			}
 			break;
@@ -303,8 +303,8 @@
 				struct medialeaf *rleaf = &mtable->mleaf[mtable->has_reset];
 				unsigned char *rst = rleaf->leafdata;
 				if (tulip_debug > 1)
-					printk(KERN_DEBUG "%s: Resetting the transceiver.\n",
-						   dev->name);
+					printk(KERN_DEBUG "tulip%d: Resetting the transceiver.\n",
+						   dev->ifindex);
 				for (i = 0; i < rst[0]; i++)
 					outl(get_u16(rst + 1 + (i<<1)) << 16, ioaddr + CSR15);
 			}
@@ -312,20 +312,20 @@
 			break;
 		}
 		default:
-			printk(KERN_DEBUG "%s:  Invalid media table selection %d.\n",
-					   dev->name, mleaf->type);
+			printk(KERN_DEBUG "tulip%d:  Invalid media table selection %d.\n",
+					   dev->ifindex, mleaf->type);
 			new_csr6 = 0x020E0000;
 		}
 		if (tulip_debug > 1)
-			printk(KERN_DEBUG "%s: Using media type %s, CSR12 is %2.2x.\n",
-				   dev->name, medianame[dev->if_port],
+			printk(KERN_DEBUG "tulip%d: Using media type %s, CSR12 is %2.2x.\n",
+				   dev->ifindex, medianame[dev->if_port],
 				   inl(ioaddr + CSR12) & 0xff);
 	} else if (tp->chip_id == LC82C168) {
 		if (startup && ! tp->medialock)
 			dev->if_port = tp->mii_cnt ? 11 : 0;
 		if (tulip_debug > 1)
-			printk(KERN_DEBUG "%s: PNIC PHY status is %3.3x, media %s.\n",
-				   dev->name, inl(ioaddr + 0xB8), medianame[dev->if_port]);
+			printk(KERN_DEBUG "tulip%d: PNIC PHY status is %3.3x, media %s.\n",
+				   dev->ifindex, inl(ioaddr + 0xB8), medianame[dev->if_port]);
 		if (tp->mii_cnt) {
 			new_csr6 = 0x810C0000;
 			outl(0x0001, ioaddr + CSR15);
@@ -356,9 +356,9 @@
 		} else
 			new_csr6 = 0x038600000;
 		if (tulip_debug > 1)
-			printk(KERN_DEBUG "%s: No media description table, assuming "
+			printk(KERN_DEBUG "tulip%d: No media description table, assuming "
 				   "%s transceiver, CSR12 %2.2x.\n",
-				   dev->name, medianame[dev->if_port],
+				   dev->ifindex, medianame[dev->if_port],
 				   inl(ioaddr + CSR12));
 	}
 
@@ -380,16 +380,16 @@
 	bmsr = tulip_mdio_read(dev, tp->phys[0], MII_BMSR);
 	lpa = tulip_mdio_read(dev, tp->phys[0], MII_LPA);
 	if (tulip_debug > 1)
-		printk(KERN_INFO "%s: MII status %4.4x, Link partner report "
-			   "%4.4x.\n", dev->name, bmsr, lpa);
+		printk(KERN_INFO "tulip%d: MII status %4.4x, Link partner report "
+			   "%4.4x.\n", dev->ifindex, bmsr, lpa);
 	if (bmsr == 0xffff)
 		return -2;
 	if ((bmsr & BMSR_LSTATUS) == 0) {
 		int new_bmsr = tulip_mdio_read(dev, tp->phys[0], MII_BMSR);
 		if ((new_bmsr & BMSR_LSTATUS) == 0) {
 			if (tulip_debug  > 1)
-				printk(KERN_INFO "%s: No link beat on the MII interface,"
-					   " status %4.4x.\n", dev->name, new_bmsr);
+				printk(KERN_INFO "tulip%d: No link beat on the MII interface,"
+					   " status %4.4x.\n", dev->ifindex, new_bmsr);
 			return -1;
 		}
 	}
@@ -408,9 +408,9 @@
 		tulip_restart_rxtx(tp);
 
 		if (tulip_debug > 0)
-			printk(KERN_INFO "%s: Setting %s-duplex based on MII"
+			printk(KERN_INFO "tulip%d: Setting %s duplex based on MII"
 				   "#%d link partner capability of %4.4x.\n",
-				   dev->name, tp->full_duplex ? "full" : "half",
+				   dev->ifindex, tp->full_duplex ? "full" : "half",
 				   tp->phys[0], lpa);
 		return 1;
 	}

-- 
Lightweight patch manager using pine. If you have any objections, tell me.


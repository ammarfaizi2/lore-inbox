Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264112AbRFPCAh>; Fri, 15 Jun 2001 22:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFPCA1>; Fri, 15 Jun 2001 22:00:27 -0400
Received: from mx.ma.nma.ne.jp ([61.125.128.21]:47247 "HELO mx.ma.nma.ne.jp")
	by vger.kernel.org with SMTP id <S264112AbRFPCAU>;
	Fri, 15 Jun 2001 22:00:20 -0400
Message-ID: <3B2ABC9E.E79086A6@ma.nma.ne.jp>
Date: Sat, 16 Jun 2001 10:55:42 +0900
From: Masaki Tsuji <jammasa@ma.nma.ne.jp>
X-Mailer: Mozilla 4.75 [ja] (Windows NT 5.0; U)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] tulip.c
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear sirs,


Few year ago, I wrote patch for tulipl.c(kernel-version 2.0.35)
 that works on MX98715,and I found that it mostly work version 2.2.1 and 2.2.11.
So I'll send patch for tulip.c(kernel-version 2.2.1, 2.2.11)

I tested it on 2.2.1 to 2.2.13, but I think it should work on 2.2.1 to 2.2.13.
Not need on later 2.2.14 


Masaki
--


--- linux-2.2.1-org/drivers/net/tulip.c	Wed Jan 20 06:18:45 1999
+++ linux-2.2.1-fw/drivers/net/tulip.c	Thu Mar  8 06:50:51 2001
@@ -317,7 +317,7 @@
 enum tulip_offsets {
 	CSR0=0,    CSR1=0x08, CSR2=0x10, CSR3=0x18, CSR4=0x20, CSR5=0x28,
 	CSR6=0x30, CSR7=0x38, CSR8=0x40, CSR9=0x48, CSR10=0x50, CSR11=0x58,
-	CSR12=0x60, CSR13=0x68, CSR14=0x70, CSR15=0x78 };
+	CSR12=0x60, CSR13=0x68, CSR14=0x70, CSR15=0x78, CSR20=0xa0 };
 
 /* The bits in the CSR5 status registers, mostly interrupt sources. */
 enum status_bits {
@@ -817,11 +817,17 @@
 			outl(0x0201F078, ioaddr + 0xB8); /* Turn on autonegotiation. */
 		}
 		break;
-	case MX98713: case MX98715: case MX98725:
+	case MX98713:
 		outl(0x00000000, ioaddr + CSR6);
 		outl(0x000711C0, ioaddr + CSR14); /* Turn on NWay. */
 		outl(0x00000001, ioaddr + CSR13);
 		break;
+	case MX98715: case MX98725:
+		outl(0x03a60200, ioaddr + CSR6);
+		outl(0x000711C4, ioaddr + CSR14); /* Turn on NWay. */
+		outl(0x00000001, ioaddr + CSR13);
+		outl(inl(ioaddr + CSR9)|0x30000000L, ioaddr + CSR9);
+		break;
 	}
 
 	return dev;
@@ -1543,9 +1549,9 @@
 		if (media_cap[dev->if_port] & MediaIsMII) {
 			new_csr6 = 0x020E0000;
 		} else if (media_cap[dev->if_port] & MediaIsFx) {
-			new_csr6 = 0x028600000;
+			new_csr6 = 0x02860000;
 		} else
-			new_csr6 = 0x038600000;
+			new_csr6 = 0x03820000;
 		if (tulip_debug > 1)
 			printk(KERN_DEBUG "%s: No media description table, assuming "
 				   "%s transceiver, CSR12 %2.2x.\n",

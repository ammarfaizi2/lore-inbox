Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293237AbSBWWhN>; Sat, 23 Feb 2002 17:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293240AbSBWWhD>; Sat, 23 Feb 2002 17:37:03 -0500
Received: from web21305.mail.yahoo.com ([216.136.129.141]:6165 "HELO
	web21305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293238AbSBWWgd>; Sat, 23 Feb 2002 17:36:33 -0500
Message-ID: <20020223223632.17818.qmail@web21305.mail.yahoo.com>
Date: Sun, 24 Feb 2002 09:36:32 +1100 (EST)
From: =?iso-8859-1?q?Mark=20ZZZ=20Smith?= <markzzzsmith@yahoo.com.au>
Subject: [PATCH] Accept large ethernet frames to support VLANs (natsemi.c, against 2.4.17)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is my first shot at a kernel patch. It enables
accepting ethernet frames larger than 1518 bytes on
the natsemi DP83815 based ethernet cards (eg Netgear
FA311/Fa312), to support 802.1Q VLANs.

It seems to work for me, although I've only tested it
between two linux boxes running VLANs (both with
Netgear FA312 cards), rather than into a VLAN capable
ethernet switch, as I don't have one at home.

For any comments, suggestions or criticisms, please CC
me, as I'm not subscribed to the mailing list.

Thanks,
Mark.

--- linux.2.4.17/drivers/net/natsemi.c  Sat Dec 22
15:38:15 2001
+++ linux.2.4.17.mrs/drivers/net/natsemi.c      Sat
Feb 23 19:04:46 2002
@@ -102,6 +102,11 @@
        version 1.0.13:
                * ETHTOOL_[GS]EEPROM support (Tim
Hockin)
 
+       version 1.0.13+MRS-VLAN 
+               * Switch on RxAcceptLong to support
big ethernet frames for
+               802.1Q VLANs
+               Mark R. Smith,
markzzzsmith@yahoo.com.au
+
        TODO:
        * big endian support with CFG:BEM instead of
cpu_to_le32
        * support for an external PHY
@@ -109,8 +114,8 @@
 */
 
 #define DRV_NAME       "natsemi"
-#define DRV_VERSION    "1.07+LK1.0.13"
-#define DRV_RELDATE    "Oct 19, 2001"
+#define DRV_VERSION    "1.07+LK1.0.13+MRS-VLAN"
+#define DRV_RELDATE    "Feb 23, 2002"
 
 /* Updated to recommendations in pci-skeleton v2.03.
*/
 
@@ -1162,8 +1167,9 @@
 
        /* DRTH 0x10: start copying to memory if 128
bytes are in the fifo
         * MXDMA 0: up to 256 byte bursts
+        * RxAcceptLong: accept long frames for 802.1Q
VLANs
         */
-       np->rx_config = RxMxdma_256 | 0x20;
+       np->rx_config = RxMxdma_256 | 0x20 |
RxAcceptLong; 
        writel(np->rx_config, ioaddr + RxConfig);
 
        /* Disable PME:


http://movies.yahoo.com.au - Yahoo! Movies
- Vote for your nominees in our online Oscars pool.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266684AbRGFM7e>; Fri, 6 Jul 2001 08:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266685AbRGFM7Y>; Fri, 6 Jul 2001 08:59:24 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:12734 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266684AbRGFM7O>;
	Fri, 6 Jul 2001 08:59:14 -0400
Message-ID: <3B45B61F.BA6AA1BF@mandrakesoft.com>
Date: Fri, 06 Jul 2001 08:59:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Juergen Wolf <JuWo@N-Club.de>
Cc: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Re: Problem with SMC Etherpower II + kernel newer 2.4.2
In-Reply-To: <Pine.LNX.4.30.0107021014230.15054-100000@flash.datafoundation.com> <3B42DEC2.AAB1E65B@N-Club.de> <20010704145752.A29311@se1.cogenit.fr> <3B456D45.FBF10C1A@N-Club.de> <20010706134421.B20614@se1.cogenit.fr> <3B45AEBD.8D0599E3@N-Club.de>
Content-Type: multipart/mixed;
 boundary="------------2280F15F93A1707F47983FF9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2280F15F93A1707F47983FF9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is the patch I have in CVS, against kernel 2.4.7-pre3.
-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
--------------2280F15F93A1707F47983FF9
Content-Type: text/plain; charset=us-ascii;
 name="epic100-2.4.7.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="epic100-2.4.7.3.patch"

--- /spare/tmp/linux-2.4.7-pre3/drivers/net/epic100.c	Mon Jul  2 21:03:04 2001
+++ linux/drivers/net/epic100.c	Fri Jul  6 12:56:40 2001
@@ -48,13 +48,16 @@
 	* ethtool driver info support (jgarzik)
 
 	LK1.1.9:
-	* MII ioctl support (jgarzik)
+	* ethtool media get/set support (jgarzik)
+
+	LK1.1.10:
+	* revert MII transceiver init change (jgarzik)
 
 */
 
 #define DRV_NAME	"epic100"
-#define DRV_VERSION	"1.11+LK1.1.9"
-#define DRV_RELDATE	"July 2, 2001"
+#define DRV_VERSION	"1.11+LK1.1.10"
+#define DRV_RELDATE	"July 6, 2001"
 
 
 /* The user-configurable values.
@@ -448,7 +451,7 @@
 	outl(0x0008, ioaddr + TEST1);
 
 	/* Turn on the MII transceiver. */
-	outl(dev->if_port == 1 ? 0x13 : 0x12, ioaddr + MIICfg);
+	outl(0x12, ioaddr + MIICfg);
 	if (chip_idx == 1)
 		outl((inl(ioaddr + NVCTL) & ~0x003C) | 0x4800, ioaddr + NVCTL);
 	outl(0x0200, ioaddr + GENCTL);

--------------2280F15F93A1707F47983FF9--


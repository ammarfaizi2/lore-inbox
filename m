Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbUK2PjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbUK2PjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUK2PjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:39:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10512 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261734AbUK2Pes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:34:48 -0500
Date: Mon, 29 Nov 2004 16:34:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: davem@redhat.com, jgarzik@pobox.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove dp83840.h
Message-ID: <20041129153444.GX9722@stusta.de>
References: <20041129111943.GB9722@stusta.de> <20041129113613.GA2718@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129113613.GA2718@linux-mips.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 12:36:13PM +0100, Ralf Baechle wrote:
> On Mon, Nov 29, 2004 at 12:19:43PM +0100, Adrian Bunk wrote:
> 
> > dp83840.h is included once but none of the definitions it contains is 
> > actually used.
> > 
> > Is the patch below to remove it OK, or is there any usage planned?
> 
> I would suggest to keep the file as documentation of the DP83840.

What about moving it to Documentation/ ?

>   Ralf

cu
Adrian


diffstat output:
 Documentation/networking/00-INDEX    |    2 +
 Documentation/networking/dp83840.txt |   41 +++++++++++++++++++++++++++
 drivers/net/ioc3-eth.c               |    1 
 include/linux/dp83840.h              |   41 ---------------------------
 4 files changed, 43 insertions(+), 42 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/net/ioc3-eth.c.old	2004-11-29 12:14:25.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/net/ioc3-eth.c	2004-11-29 12:14:34.000000000 +0100
@@ -56,7 +56,6 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/skbuff.h>
-#include <linux/dp83840.h>
 #include <net/ip.h>
 
 #include <asm/byteorder.h>
--- linux-2.6.10-rc2-mm3-full/include/linux/dp83840.h	2004-10-18 23:54:32.000000000 +0200
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,41 +0,0 @@
-/*
- * linux/dp83840.h: definitions for DP83840 MII-compatible transceivers
- *
- * Copyright (C) 1996, 1999 David S. Miller (davem@redhat.com)
- */
-#ifndef __LINUX_DP83840_H
-#define __LINUX_DP83840_H
-
-#include <linux/mii.h>
-
-/*
- * Data sheets and programming docs for the DP83840 are available at
- * from http://www.national.com/
- *
- * The DP83840 is capable of both 10 and 100Mbps ethernet, in both
- * half and full duplex mode.  It also supports auto negotiation.
- *
- * But.... THIS THING IS A PAIN IN THE ASS TO PROGRAM!
- * Debugging eeprom burnt code is more fun than programming this chip!
- */
-
-/* First, the MII register numbers (actually DP83840 register numbers). */
-#define MII_CSCONFIG        0x17        /* CS configuration            */
-
-/* The Carrier Sense config register. */
-#define CSCONFIG_RESV1          0x0001  /* Unused...                   */
-#define CSCONFIG_LED4           0x0002  /* Pin for full-dplx LED4      */
-#define CSCONFIG_LED1           0x0004  /* Pin for conn-status LED1    */
-#define CSCONFIG_RESV2          0x0008  /* Unused...                   */
-#define CSCONFIG_TCVDISAB       0x0010  /* Turns off the transceiver   */
-#define CSCONFIG_DFBYPASS       0x0020  /* Bypass disconnect function  */
-#define CSCONFIG_GLFORCE        0x0040  /* Good link force for 100mbps */
-#define CSCONFIG_CLKTRISTATE    0x0080  /* Tristate 25m clock          */
-#define CSCONFIG_RESV3          0x0700  /* Unused...                   */
-#define CSCONFIG_ENCODE         0x0800  /* 1=MLT-3, 0=binary           */
-#define CSCONFIG_RENABLE        0x1000  /* Repeater mode enable        */
-#define CSCONFIG_TCDISABLE      0x2000  /* Disable timeout counter     */
-#define CSCONFIG_RESV4          0x4000  /* Unused...                   */
-#define CSCONFIG_NDISABLE       0x8000  /* Disable NRZI                */
-
-#endif /* __LINUX_DP83840_H */
--- /dev/null	2004-11-25 03:16:25.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/Documentation/networking/dp83840.txt	2004-11-29 16:29:54.000000000 +0100
@@ -0,0 +1,41 @@
+/*
+ * linux/dp83840.h: definitions for DP83840 MII-compatible transceivers
+ *
+ * Copyright (C) 1996, 1999 David S. Miller (davem@redhat.com)
+ */
+#ifndef __LINUX_DP83840_H
+#define __LINUX_DP83840_H
+
+#include <linux/mii.h>
+
+/*
+ * Data sheets and programming docs for the DP83840 are available at
+ * from http://www.national.com/
+ *
+ * The DP83840 is capable of both 10 and 100Mbps ethernet, in both
+ * half and full duplex mode.  It also supports auto negotiation.
+ *
+ * But.... THIS THING IS A PAIN IN THE ASS TO PROGRAM!
+ * Debugging eeprom burnt code is more fun than programming this chip!
+ */
+
+/* First, the MII register numbers (actually DP83840 register numbers). */
+#define MII_CSCONFIG        0x17        /* CS configuration            */
+
+/* The Carrier Sense config register. */
+#define CSCONFIG_RESV1          0x0001  /* Unused...                   */
+#define CSCONFIG_LED4           0x0002  /* Pin for full-dplx LED4      */
+#define CSCONFIG_LED1           0x0004  /* Pin for conn-status LED1    */
+#define CSCONFIG_RESV2          0x0008  /* Unused...                   */
+#define CSCONFIG_TCVDISAB       0x0010  /* Turns off the transceiver   */
+#define CSCONFIG_DFBYPASS       0x0020  /* Bypass disconnect function  */
+#define CSCONFIG_GLFORCE        0x0040  /* Good link force for 100mbps */
+#define CSCONFIG_CLKTRISTATE    0x0080  /* Tristate 25m clock          */
+#define CSCONFIG_RESV3          0x0700  /* Unused...                   */
+#define CSCONFIG_ENCODE         0x0800  /* 1=MLT-3, 0=binary           */
+#define CSCONFIG_RENABLE        0x1000  /* Repeater mode enable        */
+#define CSCONFIG_TCDISABLE      0x2000  /* Disable timeout counter     */
+#define CSCONFIG_RESV4          0x4000  /* Unused...                   */
+#define CSCONFIG_NDISABLE       0x8000  /* Disable NRZI                */
+
+#endif /* __LINUX_DP83840_H */
--- linux-2.6.10-rc2-mm3-full/Documentation/networking/00-INDEX.old	2004-11-29 16:32:03.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/Documentation/networking/00-INDEX	2004-11-29 16:33:10.000000000 +0100
@@ -42,6 +42,8 @@
 	- the Digi International RightSwitch SE-X Ethernet driver
 dmfe.txt
 	- info on the Davicom DM9102(A)/DM9132/DM9801 fast ethernet driver.
+dp83840.txt
+	- the former dp83840.h
 e100.txt
 	- info on Intel's EtherExpress PRO/100 line of 10/100 boards
 e1000.txt


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUDHXYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUDHXYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:24:39 -0400
Received: from palrel11.hp.com ([156.153.255.246]:48558 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261671AbUDHXYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:24:23 -0400
Date: Thu, 8 Apr 2004 16:24:20 -0700
To: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2.6] IrDA header move
Message-ID: <20040408232420.GA5100@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Dave,

	The attached shell script+patch move some IrDA driver headers
around.
	I've always been annoyed that some IrDA driver headers are not
together with the IrDA drivers (like for any other Linux driver), but
instead they are part of the main IrDA stack. Moreover, some driver
headers are in the IrDA driver directory, so it's not even
consistent. This patch fixes that.
	The patch also remove two obsolete driver headers. When the
corresponding drivers were remove from the kernel a few months ago,
their headers were left behind. This is clearly a consequence of their
illogical location.

	The patch comes as a shell script and a patch. You just need
to run the script in the linux directory, and apply the patch. Jeff
told me that this solution was better because BK can keep track of
file move. If you don't like that, I can send you the massive patch.
	Would you mind that to push that to Linus ?

	Thanks in advance...

	Jean

-------------------------------------------------------------------
#!/bin/sh

# Remove obsolete driver header
rm include/net/irda/smc-ircc.h
rm include/net/irda/toshoboe.h

# Move current driver headers with their friends
mv include/net/irda/ali-ircc.h drivers/net/irda/
mv include/net/irda/au1000_ircc.h drivers/net/irda/
mv include/net/irda/irda-usb.h drivers/net/irda/
mv include/net/irda/irport.h drivers/net/irda/
mv include/net/irda/nsc-ircc.h drivers/net/irda/
mv include/net/irda/vlsi_ir.h drivers/net/irda/
mv include/net/irda/w83977af.h drivers/net/irda/
mv include/net/irda/w83977af_ir.h drivers/net/irda/
-------------------------------------------------------------------
diff -u -p linux/drivers/net/irda/ali-ircc.d1.c linux/drivers/net/irda/ali-ircc.c
--- linux/drivers/net/irda/ali-ircc.d1.c	Thu Apr  8 15:50:46 2004
+++ linux/drivers/net/irda/ali-ircc.c	Thu Apr  8 15:51:32 2004
@@ -44,7 +44,7 @@
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
 
-#include <net/irda/ali-ircc.h>
+#include "ali-ircc.h"
 
 #define CHIP_IO_EXTENT 8
 #define BROKEN_DONGLE_ID
diff -u -p linux/drivers/net/irda/au1k_ir.d1.c linux/drivers/net/irda/au1k_ir.c
--- linux/drivers/net/irda/au1k_ir.d1.c	Thu Apr  8 15:51:52 2004
+++ linux/drivers/net/irda/au1k_ir.c	Thu Apr  8 15:52:10 2004
@@ -52,7 +52,7 @@
 #include <net/irda/irmod.h>
 #include <net/irda/wrapper.h>
 #include <net/irda/irda_device.h>
-#include "net/irda/au1000_ircc.h"
+#include "au1000_ircc.h"
 
 static int au1k_irda_net_init(struct net_device *);
 static int au1k_irda_start(struct net_device *);
diff -u -p linux/drivers/net/irda/irda-usb.d1.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d1.c	Thu Apr  8 15:52:24 2004
+++ linux/drivers/net/irda/irda-usb.c	Thu Apr  8 15:52:41 2004
@@ -62,7 +62,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/usb.h>
 
-#include <net/irda/irda-usb.h>
+#include "irda-usb.h"
 
 /*------------------------------------------------------------------*/
 
diff -u -p linux/drivers/net/irda/irport.d1.c linux/drivers/net/irda/irport.c
--- linux/drivers/net/irda/irport.d1.c	Thu Apr  8 15:52:55 2004
+++ linux/drivers/net/irda/irport.c	Thu Apr  8 15:53:12 2004
@@ -58,7 +58,7 @@
 
 #include <net/irda/irda.h>
 #include <net/irda/wrapper.h>
-#include <net/irda/irport.h>
+#include "irport.h"
 
 #define IO_EXTENT 8
 
diff -u -p linux/drivers/net/irda/nsc-ircc.d1.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d1.c	Thu Apr  8 15:53:27 2004
+++ linux/drivers/net/irda/nsc-ircc.c	Thu Apr  8 15:53:48 2004
@@ -63,7 +63,7 @@
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
 
-#include <net/irda/nsc-ircc.h>
+#include "nsc-ircc.h"
 
 #define CHIP_IO_EXTENT 8
 #define BROKEN_DONGLE_ID
diff -u -p linux/drivers/net/irda/vlsi_ir.d1.c linux/drivers/net/irda/vlsi_ir.c
--- linux/drivers/net/irda/vlsi_ir.d1.c	Thu Apr  8 15:54:04 2004
+++ linux/drivers/net/irda/vlsi_ir.c	Thu Apr  8 15:54:20 2004
@@ -54,7 +54,7 @@ MODULE_LICENSE("GPL");
 #include <net/irda/wrapper.h>
 #include <net/irda/crc.h>
 
-#include <net/irda/vlsi_ir.h>
+#include "vlsi_ir.h"
 
 /********************************************************/
 
diff -u -p linux/drivers/net/irda/w83977af_ir.d1.c linux/drivers/net/irda/w83977af_ir.c
--- linux/drivers/net/irda/w83977af_ir.d1.c	Thu Apr  8 15:54:37 2004
+++ linux/drivers/net/irda/w83977af_ir.c	Thu Apr  8 15:55:03 2004
@@ -58,8 +58,8 @@
 #include <net/irda/irda.h>
 #include <net/irda/wrapper.h>
 #include <net/irda/irda_device.h>
-#include <net/irda/w83977af.h>
-#include <net/irda/w83977af_ir.h>
+#include "w83977af.h"
+#include "w83977af_ir.h"
 
 #ifdef  CONFIG_ARCH_NETWINDER            /* Adjust to NetWinder differences */
 #undef  CONFIG_NETWINDER_TX_DMA_PROBLEMS /* Not needed */

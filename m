Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUAZVak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUAZVak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:30:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6092 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265389AbUAZV3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:29:43 -0500
Date: Mon, 26 Jan 2004 13:15:32 -0800 (PST)
Message-Id: <20040126.131532.115920356.davem@redhat.com>
To: jt@hpl.hp.com, jt@bougret.hpl.hp.com
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] 2.6.2-rc2: link error with IrDA drivers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040126211603.GA17646@bougret.hpl.hp.com>
References: <20040126205829.GF513@fs.tum.de>
	<20040126.125713.39171691.davem@redhat.com>
	<20040126211603.GA17646@bougret.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
   Date: Mon, 26 Jan 2004 13:16:03 -0800

   	I've just sent the following patch to Andrew (following his
   bug report), and I think it's slightly better and safer. Sorry I
   forgot to cc you.

In my personal opinion it's worse not better.

Andrew, back out jt's version of the fix from your tree, I'll
send Linus the correct fix (attached below).  I verified that
nothing external wants to get at any of these symbols.

Thanks everyone.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1520  -> 1.1521 
#	drivers/net/irda/via-ircc.c	1.6     -> 1.7    
#	drivers/net/irda/nsc-ircc.c	1.29    -> 1.30   
#	drivers/net/irda/girbil.c	1.8     -> 1.9    
#	drivers/net/irda/ep7211_ir.c	1.5     -> 1.6    
#	drivers/net/irda/litelink-sir.c	1.1     -> 1.2    
#	drivers/net/irda/tekram-sir.c	1.4     -> 1.5    
#	drivers/net/irda/act200l-sir.c	1.1     -> 1.2    
#	drivers/net/irda/w83977af_ir.c	1.23    -> 1.24   
#	drivers/net/irda/ali-ircc.c	1.24    -> 1.25   
#	drivers/net/irda/ma600.c	1.7     -> 1.8    
#	drivers/net/irda/girbil-sir.c	1.1     -> 1.2    
#	drivers/net/irda/act200l.c	1.7     -> 1.8    
#	drivers/net/irda/esi.c	1.6     -> 1.7    
#	drivers/net/irda/litelink.c	1.6     -> 1.7    
#	drivers/net/irda/tekram.c	1.9     -> 1.10   
#	drivers/net/irda/actisys-sir.c	1.4     -> 1.5    
#	drivers/net/irda/smsc-ircc2.c	1.8     -> 1.9    
#	drivers/net/irda/ma600-sir.c	1.1     -> 1.2    
#	drivers/net/irda/irport.c	1.21    -> 1.22   
#	drivers/net/irda/mcp2120-sir.c	1.1     -> 1.2    
#	drivers/net/irda/old_belkin-sir.c	1.1     -> 1.2    
#	drivers/net/irda/old_belkin.c	1.8     -> 1.9    
#	drivers/net/irda/mcp2120.c	1.7     -> 1.8    
#	drivers/net/irda/actisys.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/26	davem@nuts.ninka.net	1.1521
# [IRDA]: Mark init/exit functions of drivers static to fix build.
# --------------------------------------------
#
diff -Nru a/drivers/net/irda/act200l-sir.c b/drivers/net/irda/act200l-sir.c
--- a/drivers/net/irda/act200l-sir.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/act200l-sir.c	Mon Jan 26 13:20:40 2004
@@ -93,12 +93,12 @@
 	.set_speed	= act200l_change_speed,
 };
 
-int __init act200l_init(void)
+static int __init act200l_init(void)
 {
 	return irda_register_dongle(&act200l);
 }
 
-void __exit act200l_cleanup(void)
+static void __exit act200l_cleanup(void)
 {
 	irda_unregister_dongle(&act200l);
 }
diff -Nru a/drivers/net/irda/act200l.c b/drivers/net/irda/act200l.c
--- a/drivers/net/irda/act200l.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/act200l.c	Mon Jan 26 13:20:40 2004
@@ -92,12 +92,12 @@
 	.owner = THIS_MODULE,
 };
 
-int __init act200l_init(void)
+static int __init act200l_init(void)
 {
 	return irda_device_register_dongle(&dongle);
 }
 
-void __exit act200l_cleanup(void)
+static void __exit act200l_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
diff -Nru a/drivers/net/irda/actisys-sir.c b/drivers/net/irda/actisys-sir.c
--- a/drivers/net/irda/actisys-sir.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/actisys-sir.c	Mon Jan 26 13:20:40 2004
@@ -89,7 +89,7 @@
 	.set_speed	= actisys_change_speed,
 };
 
-int __init actisys_sir_init(void)
+static int __init actisys_sir_init(void)
 {
 	int ret;
 
@@ -107,7 +107,7 @@
 	return 0;
 }
 
-void __exit actisys_sir_cleanup(void)
+static void __exit actisys_sir_cleanup(void)
 {
 	/* We have to remove both dongles */
 	irda_unregister_dongle(&act220l_plus);
diff -Nru a/drivers/net/irda/actisys.c b/drivers/net/irda/actisys.c
--- a/drivers/net/irda/actisys.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/actisys.c	Mon Jan 26 13:20:40 2004
@@ -91,7 +91,7 @@
  *	So, we register a dongle of each sort and let irattach
  * pick the right one...
  */
-int __init actisys_init(void)
+static int __init actisys_init(void)
 {
 	int ret;
 
@@ -108,7 +108,7 @@
 	return 0;
 }
 
-void __exit actisys_cleanup(void)
+static void __exit actisys_cleanup(void)
 {
 	/* We have to remove both dongles */
 	irda_device_unregister_dongle(&dongle);
diff -Nru a/drivers/net/irda/ali-ircc.c b/drivers/net/irda/ali-ircc.c
--- a/drivers/net/irda/ali-ircc.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/ali-ircc.c	Mon Jan 26 13:20:40 2004
@@ -133,7 +133,7 @@
  *    Initialize chip. Find out whay kinds of chips we are dealing with
  *    and their configuation registers address
  */
-int __init ali_ircc_init(void)
+static int __init ali_ircc_init(void)
 {
 	ali_chip_t *chip;
 	chipio_t info;
diff -Nru a/drivers/net/irda/ep7211_ir.c b/drivers/net/irda/ep7211_ir.c
--- a/drivers/net/irda/ep7211_ir.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/ep7211_ir.c	Mon Jan 26 13:20:40 2004
@@ -97,7 +97,7 @@
  *    Initialize EP7211 I/R module
  *
  */
-int __init ep7211_ir_init(void)
+static int __init ep7211_ir_init(void)
 {
 	return irda_device_register_dongle(&dongle);
 }
diff -Nru a/drivers/net/irda/esi.c b/drivers/net/irda/esi.c
--- a/drivers/net/irda/esi.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/esi.c	Mon Jan 26 13:20:40 2004
@@ -52,12 +52,12 @@
 	.owner = THIS_MODULE,
 };
 
-int __init esi_init(void)
+static int __init esi_init(void)
 {
 	return irda_device_register_dongle(&dongle);
 }
 
-void __exit esi_cleanup(void)
+static void __exit esi_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
diff -Nru a/drivers/net/irda/girbil-sir.c b/drivers/net/irda/girbil-sir.c
--- a/drivers/net/irda/girbil-sir.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/girbil-sir.c	Mon Jan 26 13:20:40 2004
@@ -72,12 +72,12 @@
 	.set_speed	= girbil_change_speed,
 };
 
-int __init girbil_init(void)
+static int __init girbil_init(void)
 {
 	return irda_register_dongle(&girbil);
 }
 
-void __exit girbil_cleanup(void)
+static void __exit girbil_cleanup(void)
 {
 	irda_unregister_dongle(&girbil);
 }
diff -Nru a/drivers/net/irda/girbil.c b/drivers/net/irda/girbil.c
--- a/drivers/net/irda/girbil.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/girbil.c	Mon Jan 26 13:20:40 2004
@@ -71,12 +71,12 @@
 	.owner = THIS_MODULE,
 };
 
-int __init girbil_init(void)
+static int __init girbil_init(void)
 {
 	return irda_device_register_dongle(&dongle);
 }
 
-void __exit girbil_cleanup(void)
+static void __exit girbil_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
diff -Nru a/drivers/net/irda/irport.c b/drivers/net/irda/irport.c
--- a/drivers/net/irda/irport.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/irport.c	Mon Jan 26 13:20:40 2004
@@ -98,7 +98,7 @@
 EXPORT_SYMBOL(irport_net_open);
 EXPORT_SYMBOL(irport_net_close);
 
-int __init irport_init(void)
+static int __init irport_init(void)
 {
  	int i;
 
diff -Nru a/drivers/net/irda/litelink-sir.c b/drivers/net/irda/litelink-sir.c
--- a/drivers/net/irda/litelink-sir.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/litelink-sir.c	Mon Jan 26 13:20:40 2004
@@ -64,12 +64,12 @@
 	.set_speed	= litelink_change_speed,
 };
 
-int __init litelink_sir_init(void)
+static int __init litelink_sir_init(void)
 {
 	return irda_register_dongle(&litelink);
 }
 
-void __exit litelink_sir_cleanup(void)
+static void __exit litelink_sir_cleanup(void)
 {
 	irda_unregister_dongle(&litelink);
 }
diff -Nru a/drivers/net/irda/litelink.c b/drivers/net/irda/litelink.c
--- a/drivers/net/irda/litelink.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/litelink.c	Mon Jan 26 13:20:40 2004
@@ -56,12 +56,12 @@
 	.owner = THIS_MODULE,
 };
 
-int __init litelink_init(void)
+static int __init litelink_init(void)
 {
 	return irda_device_register_dongle(&dongle);
 }
 
-void __exit litelink_cleanup(void)
+static void __exit litelink_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
diff -Nru a/drivers/net/irda/ma600-sir.c b/drivers/net/irda/ma600-sir.c
--- a/drivers/net/irda/ma600-sir.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/ma600-sir.c	Mon Jan 26 13:20:40 2004
@@ -66,13 +66,13 @@
 };
 
 
-int __init ma600_sir_init(void)
+static int __init ma600_sir_init(void)
 {
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	return irda_register_dongle(&ma600);
 }
 
-void __exit ma600_sir_cleanup(void)
+static void __exit ma600_sir_cleanup(void)
 {
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	irda_unregister_dongle(&ma600);
diff -Nru a/drivers/net/irda/ma600.c b/drivers/net/irda/ma600.c
--- a/drivers/net/irda/ma600.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/ma600.c	Mon Jan 26 13:20:40 2004
@@ -82,13 +82,13 @@
 	.owner = THIS_MODULE,
 };
 
-int __init ma600_init(void)
+static int __init ma600_init(void)
 {
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	return irda_device_register_dongle(&dongle);
 }
 
-void __exit ma600_cleanup(void)
+static void __exit ma600_cleanup(void)
 {
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	irda_device_unregister_dongle(&dongle);
diff -Nru a/drivers/net/irda/mcp2120-sir.c b/drivers/net/irda/mcp2120-sir.c
--- a/drivers/net/irda/mcp2120-sir.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/mcp2120-sir.c	Mon Jan 26 13:20:40 2004
@@ -49,12 +49,12 @@
 	.set_speed	= mcp2120_change_speed,
 };
 
-int __init mcp2120_init(void)
+static int __init mcp2120_init(void)
 {
 	return irda_register_dongle(&mcp2120);
 }
 
-void __exit mcp2120_cleanup(void)
+static void __exit mcp2120_cleanup(void)
 {
 	irda_unregister_dongle(&mcp2120);
 }
diff -Nru a/drivers/net/irda/mcp2120.c b/drivers/net/irda/mcp2120.c
--- a/drivers/net/irda/mcp2120.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/mcp2120.c	Mon Jan 26 13:20:40 2004
@@ -48,12 +48,12 @@
 	.owner = THIS_MODULE,
 };
 
-int __init mcp2120_init(void)
+static int __init mcp2120_init(void)
 {
 	return irda_device_register_dongle(&dongle);
 }
 
-void __exit mcp2120_cleanup(void)
+static void __exit mcp2120_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
diff -Nru a/drivers/net/irda/nsc-ircc.c b/drivers/net/irda/nsc-ircc.c
--- a/drivers/net/irda/nsc-ircc.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/nsc-ircc.c	Mon Jan 26 13:20:40 2004
@@ -155,7 +155,7 @@
  *    Initialize chip. Just try to find out how many chips we are dealing with
  *    and where they are
  */
-int __init nsc_ircc_init(void)
+static int __init nsc_ircc_init(void)
 {
 	chipio_t info;
 	nsc_chip_t *chip;
diff -Nru a/drivers/net/irda/old_belkin-sir.c b/drivers/net/irda/old_belkin-sir.c
--- a/drivers/net/irda/old_belkin-sir.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/old_belkin-sir.c	Mon Jan 26 13:20:40 2004
@@ -78,12 +78,12 @@
 	.set_speed	= old_belkin_change_speed,
 };
 
-int __init old_belkin_init(void)
+static int __init old_belkin_init(void)
 {
 	return irda_register_dongle(&old_belkin);
 }
 
-void __exit old_belkin_cleanup(void)
+static void __exit old_belkin_cleanup(void)
 {
 	irda_unregister_dongle(&old_belkin);
 }
diff -Nru a/drivers/net/irda/old_belkin.c b/drivers/net/irda/old_belkin.c
--- a/drivers/net/irda/old_belkin.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/old_belkin.c	Mon Jan 26 13:20:40 2004
@@ -82,12 +82,12 @@
 	.owner = THIS_MODULE,
 };
 
-int __init old_belkin_init(void)
+static int __init old_belkin_init(void)
 {
 	return irda_device_register_dongle(&dongle);
 }
 
-void __exit old_belkin_cleanup(void)
+static void __exit old_belkin_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
diff -Nru a/drivers/net/irda/smsc-ircc2.c b/drivers/net/irda/smsc-ircc2.c
--- a/drivers/net/irda/smsc-ircc2.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/smsc-ircc2.c	Mon Jan 26 13:20:40 2004
@@ -322,7 +322,7 @@
  *    Initialize chip. Just try to find out how many chips we are dealing with
  *    and where they are
  */
-int __init smsc_ircc_init(void)
+static int __init smsc_ircc_init(void)
 {
 	int ret=-ENODEV;
 
@@ -1727,7 +1727,7 @@
 	return 0;
 }
 
-void __exit smsc_ircc_cleanup(void)
+static void __exit smsc_ircc_cleanup(void)
 {
 	int i;
 
diff -Nru a/drivers/net/irda/tekram-sir.c b/drivers/net/irda/tekram-sir.c
--- a/drivers/net/irda/tekram-sir.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/tekram-sir.c	Mon Jan 26 13:20:40 2004
@@ -59,7 +59,7 @@
 	.set_speed	= tekram_change_speed,
 };
 
-int __init tekram_sir_init(void)
+static int __init tekram_sir_init(void)
 {
 	if (tekram_delay < 1  ||  tekram_delay > 500)
 		tekram_delay = 200;
@@ -68,7 +68,7 @@
 	return irda_register_dongle(&tekram);
 }
 
-void __exit tekram_sir_cleanup(void)
+static void __exit tekram_sir_cleanup(void)
 {
 	irda_unregister_dongle(&tekram);
 }
diff -Nru a/drivers/net/irda/tekram.c b/drivers/net/irda/tekram.c
--- a/drivers/net/irda/tekram.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/tekram.c	Mon Jan 26 13:20:40 2004
@@ -52,12 +52,12 @@
 	.owner = THIS_MODULE,
 };
 
-int __init tekram_init(void)
+static int __init tekram_init(void)
 {
 	return irda_device_register_dongle(&dongle);
 }
 
-void __exit tekram_cleanup(void)
+static void __exit tekram_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
diff -Nru a/drivers/net/irda/via-ircc.c b/drivers/net/irda/via-ircc.c
--- a/drivers/net/irda/via-ircc.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/via-ircc.c	Mon Jan 26 13:20:40 2004
@@ -145,7 +145,7 @@
  *
  *    Initialize chip. Just find out chip type and resource.
  */
-int __init via_ircc_init(void)
+static int __init via_ircc_init(void)
 {
 	int rc;
 
diff -Nru a/drivers/net/irda/w83977af_ir.c b/drivers/net/irda/w83977af_ir.c
--- a/drivers/net/irda/w83977af_ir.c	Mon Jan 26 13:20:40 2004
+++ b/drivers/net/irda/w83977af_ir.c	Mon Jan 26 13:20:40 2004
@@ -110,7 +110,7 @@
  *    Initialize chip. Just try to find out how many chips we are dealing with
  *    and where they are
  */
-int __init w83977af_init(void)
+static int __init w83977af_init(void)
 {
         int i;
 
@@ -129,7 +129,7 @@
  *    Close all configured chips
  *
  */
-void __exit w83977af_cleanup(void)
+static void __exit w83977af_cleanup(void)
 {
 	int i;
 

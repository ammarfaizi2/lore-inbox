Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWHQJbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWHQJbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWHQJbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:31:04 -0400
Received: from tiu.fh-brandenburg.de ([195.37.0.8]:44143 "EHLO
	tiu.fh-brandenburg.de") by vger.kernel.org with ESMTP
	id S964776AbWHQJbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:31:01 -0400
Date: Thu, 17 Aug 2006 11:30:53 +0200
From: Markus Dahms <dahms@fh-brandenburg.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC][RESEND] remove broken URLs from net drivers' output
Message-ID: <20060817093053.GA13992@fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove broken URLs (www.scyld.com) from network drivers' logging output.
URLs in comments and other strings are left intact.

Signed-off-by: Markus Dahms <dahms@fh-brandenburg.de>

---

(second try, got no reaction last time)

I was tired of always seeing an URL not working anymore on initialization
of 3c59x and natsemi. So this is an attempt to get rid of these messages.

The patch is against 2.6.18-rc4-git
(c4e321b85a89d7cd392d3105b2c033a6c58ed337 from .../gregkh/linux-2.6).

Btw: Is there a policy for message output for drivers with respect to
author name, email addresses, copyright messages or home pages?

Markus

 3c509.c     |    5 ++---
 3c59x.c     |    2 +-
 atp.c       |    8 +++-----
 eepro100.c  |    2 +-
 epic100.c   |   10 ++++------
 natsemi.c   |    1 -
 ne2k-pci.c  |    3 +--
 sundance.c  |    3 +--
 yellowfin.c |    1 -
 9 files changed, 13 insertions(+), 22 deletions(-)


diff --git a/drivers/net/3c509.c b/drivers/net/3c509.c
index cbdae54..dccf142 100644
--- a/drivers/net/3c509.c
+++ b/drivers/net/3c509.c
@@ -96,8 +96,7 @@ #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 
-static char versionA[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE " becker@scyld.com\n";
-static char versionB[] __initdata = "http://www.scyld.com/network/3c509.html\n";
+static char version[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE " becker@scyld.com\n";
 
 #if defined(CONFIG_PM) && (defined(CONFIG_MCA) || defined(CONFIG_EISA))
 #define EL3_SUSPEND
@@ -360,7 +359,7 @@ #endif
 	printk(", IRQ %d.\n", dev->irq);
 
 	if (el3_debug > 0)
-		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
+		printk(KERN_INFO "%s", version);
 	return 0;
 
 }
diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
index 80e8ca0..098c7aa 100644
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -103,7 +103,7 @@ #include <linux/delay.h>
 
 
 static char version[] __devinitdata =
-DRV_NAME ": Donald Becker and others. www.scyld.com/network/vortex.html\n";
+DRV_NAME ": Donald Becker and others.\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("3Com 3c59x/3c9xx ethernet driver ");
diff --git a/drivers/net/atp.c b/drivers/net/atp.c
index bfa674e..697967f 100644
--- a/drivers/net/atp.c
+++ b/drivers/net/atp.c
@@ -31,10 +31,8 @@
 
 */
 
-static const char versionA[] =
+static const char version[] =
 "atp.c:v1.09=ac 2002/10/01 Donald Becker <becker@scyld.com>\n";
-static const char versionB[] =
-"  http://www.scyld.com/network/atp.html\n";
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
@@ -324,7 +322,7 @@ #endif
 
 #ifndef MODULE
 	if (net_debug)
-		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
+		printk(KERN_INFO "%s", version);
 #endif
 
 	printk(KERN_NOTICE "%s: Pocket adapter found at %#3lx, IRQ %d, SAPROM "
@@ -932,7 +930,7 @@ static void set_rx_mode_8012(struct net_
 
 static int __init atp_init_module(void) {
 	if (debug)					/* Emit version even if no cards detected. */
-		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
+		printk(KERN_INFO "%s", version);
 	return atp_init();
 }
 
diff --git a/drivers/net/eepro100.c b/drivers/net/eepro100.c
index e445988..0f4b495 100644
--- a/drivers/net/eepro100.c
+++ b/drivers/net/eepro100.c
@@ -28,7 +28,7 @@
 */
 
 static const char * const version =
-"eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html\n"
+"eepro100.c:v1.09j-t 9/29/99 Donald Becker\n"
 "eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others\n";
 
 /* A few user-configurable values that apply to all boards.
diff --git a/drivers/net/epic100.c b/drivers/net/epic100.c
index a67650c..ebef8ae 100644
--- a/drivers/net/epic100.c
+++ b/drivers/net/epic100.c
@@ -93,8 +93,6 @@ #include <asm/uaccess.h>
 static char version[] __devinitdata =
 DRV_NAME ".c:v1.11 1/7/2001 Written by Donald Becker <becker@scyld.com>\n";
 static char version2[] __devinitdata =
-"  http://www.scyld.com/network/epic100.html\n";
-static char version3[] __devinitdata =
 "  (unofficial 2.4.x kernel port, version " DRV_VERSION ", " DRV_RELDATE ")\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
@@ -323,8 +321,8 @@ static int __devinit epic_init_one (stru
 #ifndef MODULE
 	static int printed_version;
 	if (!printed_version++)
-		printk (KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
-			version, version2, version3);
+		printk (KERN_INFO "%s" KERN_INFO "%s",
+			version, version2);
 #endif
 
 	card_idx++;
@@ -1600,8 +1598,8 @@ static int __init epic_init (void)
 {
 /* when a module, this is printed whether or not devices are found in probe */
 #ifdef MODULE
-	printk (KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
-		version, version2, version3);
+	printk (KERN_INFO "%s" KERN_INFO "%s",
+		version, version2);
 #endif
 
 	return pci_module_init (&epic_driver);
diff --git a/drivers/net/natsemi.c b/drivers/net/natsemi.c
index db0475a..e2039e7 100644
--- a/drivers/net/natsemi.c
+++ b/drivers/net/natsemi.c
@@ -129,7 +129,6 @@ static const char version[] __devinitdat
   KERN_INFO DRV_NAME " dp8381x driver, version "
       DRV_VERSION ", " DRV_RELDATE "\n"
   KERN_INFO "  originally by Donald Becker <becker@scyld.com>\n"
-  KERN_INFO "  http://www.scyld.com/network/natsemi.html\n"
   KERN_INFO "  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
diff --git a/drivers/net/ne2k-pci.c b/drivers/net/ne2k-pci.c
index 34bdba9..40df830 100644
--- a/drivers/net/ne2k-pci.c
+++ b/drivers/net/ne2k-pci.c
@@ -63,8 +63,7 @@ #include "8390.h"
 
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
-KERN_INFO DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " D. Becker/P. Gortmaker\n"
-KERN_INFO "  http://www.scyld.com/network/ne2k-pci.html\n";
+KERN_INFO DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " D. Becker/P. Gortmaker\n";
 
 #if defined(__powerpc__)
 #define inl_le(addr)  le32_to_cpu(inl(addr))
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index ac17377..e3773df 100644
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -108,8 +108,7 @@ #endif
 
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
-KERN_INFO DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE "  Written by Donald Becker\n"
-KERN_INFO "  http://www.scyld.com/network/sundance.html\n";
+KERN_INFO DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE "  Written by Donald Becker\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Sundance Alta Ethernet driver");
diff --git a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
index 8459a18..58582f8 100644
--- a/drivers/net/yellowfin.c
+++ b/drivers/net/yellowfin.c
@@ -109,7 +109,6 @@ #include <asm/io.h>
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
 KERN_INFO DRV_NAME ".c:v1.05  1/09/2001  Written by Donald Becker <becker@scyld.com>\n"
-KERN_INFO "  http://www.scyld.com/network/yellowfin.html\n"
 KERN_INFO "  (unofficial 2.4.x port, " DRV_VERSION ", " DRV_RELDATE ")\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");

-- 
Computers are not intelligent.  They only think they are.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUATAYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUATAXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:23:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:32172 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265161AbUATAAT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:19 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567673681@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:27 -0800
Message-Id: <1074556767824@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.27, 2004/01/19 15:07:28-08:00, greg@kroah.com

[PATCH] I2C: add I2C_DEBUG_CHIP config option and convert the i2c chip drivers to use it.

This cleans up the mismatch of ways we could enable debugging messages.


 drivers/i2c/Kconfig           |    9 +++++++++
 drivers/i2c/chips/adm1021.c   |    5 +++++
 drivers/i2c/chips/asb100.c    |    6 ++++--
 drivers/i2c/chips/eeprom.c    |    5 ++++-
 drivers/i2c/chips/it87.c      |   13 +++++++++----
 drivers/i2c/chips/lm75.c      |    5 ++++-
 drivers/i2c/chips/lm78.c      |    7 ++++++-
 drivers/i2c/chips/lm83.c      |    5 +++++
 drivers/i2c/chips/lm85.c      |    5 +++++
 drivers/i2c/chips/lm90.c      |    5 +++++
 drivers/i2c/chips/via686a.c   |    5 +++++
 drivers/i2c/chips/w83781d.c   |    7 ++++++-
 drivers/i2c/chips/w83l785ts.c |    5 +++++
 13 files changed, 72 insertions(+), 10 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/Kconfig	Mon Jan 19 15:27:56 2004
@@ -49,5 +49,14 @@
 	  messages to the system log.  Select this if you are having a
 	  problem with I2C support and want to see more of what is going on.
 
+config I2C_DEBUG_CHIP
+	bool "I2C Chip debugging messages"
+	depends on I2C
+	help
+	  Say Y here if you want the I2C chip drivers to produce a bunch of
+	  debug messages to the system log.  Select this if you are having
+	  a problem with I2C support and want to see more of what is going
+	  on.
+
 endmenu
 
diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/adm1021.c	Mon Jan 19 15:27:56 2004
@@ -19,6 +19,11 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/asb100.c	Mon Jan 19 15:27:56 2004
@@ -36,7 +36,10 @@
     asb100	7	3	1	4	0x31	0x0694	yes	no
 */
 
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
 
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -1035,7 +1038,6 @@
 
 static int __init asb100_init(void)
 {
-	printk(KERN_INFO "asb100 version %s\n", ASB100_VERSION);
 	return i2c_add_driver(&asb100_driver);
 }
 
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/eeprom.c	Mon Jan 19 15:27:56 2004
@@ -26,7 +26,10 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* #define DEBUG */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/it87.c	Mon Jan 19 15:27:56 2004
@@ -31,6 +31,11 @@
     type at module load time.
 */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -667,10 +672,10 @@
 		}
 		else {
 			if (kind == 0)
-				printk
-				    ("it87.o: Ignoring 'force' parameter for unknown chip at "
-				     "adapter %d, address 0x%02x\n",
-				     i2c_adapter_id(adapter), address);
+				dev_info(&adapter->dev, 
+					"Ignoring 'force' parameter for unknown chip at "
+					"adapter %d, address 0x%02x\n",
+					i2c_adapter_id(adapter), address);
 			goto ERROR1;
 		}
 	}
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/lm75.c	Mon Jan 19 15:27:56 2004
@@ -18,7 +18,10 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
 
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/lm78.c	Mon Jan 19 15:27:56 2004
@@ -18,6 +18,11 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -615,7 +620,7 @@
 			kind = lm79;
 		else {
 			if (kind == 0)
-				printk(KERN_WARNING "lm78.o: Ignoring 'force' "
+				dev_warn(&adapter->dev, "Ignoring 'force' "
 					"parameter for unknown chip at "
 					"adapter %d, address 0x%02x\n",
 					i2c_adapter_id(adapter), address);
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/lm83.c	Mon Jan 19 15:27:56 2004
@@ -27,6 +27,11 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/lm85.c	Mon Jan 19 15:27:56 2004
@@ -22,6 +22,11 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/lm90.c	Mon Jan 19 15:27:56 2004
@@ -35,6 +35,11 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/via686a.c	Mon Jan 19 15:27:56 2004
@@ -31,6 +31,11 @@
     Warning - only supports a single device.
 */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Jan 19 15:27:56 2004
@@ -36,6 +36,11 @@
 
 */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -1651,7 +1656,7 @@
 	if (time_after
 	    (jiffies - data->last_updated, (unsigned long) (HZ + HZ / 2))
 	    || time_before(jiffies, data->last_updated) || !data->valid) {
-		pr_debug(KERN_DEBUG "Starting device update\n");
+		pr_debug("Starting device update\n");
 
 		for (i = 0; i <= 8; i++) {
 			if ((data->type == w83783s || data->type == w83697hf)
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Mon Jan 19 15:27:56 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Mon Jan 19 15:27:56 2004
@@ -27,6 +27,11 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>


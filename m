Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUCWXRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUCWXRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:17:40 -0500
Received: from havoc.gtf.org ([216.162.42.101]:32412 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262901AbUCWXRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:17:17 -0500
Date: Tue, 23 Mar 2004 18:17:16 -0500
From: David Eger <eger@havoc.gtf.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] UTF-8ifying the kernel sources
Message-ID: <20040323231716.GE25510@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ur linux-2.6.4/arch/ppc/platforms/proc_rtas.c linux-utf8-2.6.4-cstrings2utf8/arch/ppc/platforms/proc_rtas.c
--- linux-2.6.4/arch/ppc/platforms/proc_rtas.c	2004-02-16 01:00:13.000000000 +0100
+++ linux-utf8-2.6.4-cstrings2utf8/arch/ppc/platforms/proc_rtas.c	2004-03-23 17:41:48.718738032 +0100
@@ -515,7 +515,7 @@
 			have_strings = 1;
 			break;
 		case THERMAL_SENSOR:
-			n += sprintf(buf+n, "Temp. (�C/�F):\t");
+			n += sprintf(buf+n, "Temp. (°C/°F):\t");
 			temperature = 1;
 			break;
 		case LID_STATUS:
diff -ur linux-2.6.4/arch/ppc64/kernel/rtas-proc.c linux-utf8-2.6.4-cstrings2utf8/arch/ppc64/kernel/rtas-proc.c
--- linux-2.6.4/arch/ppc64/kernel/rtas-proc.c	2004-03-22 14:18:55.000000000 +0100
+++ linux-utf8-2.6.4-cstrings2utf8/arch/ppc64/kernel/rtas-proc.c	2004-03-23 17:41:48.844718880 +0100
@@ -608,7 +608,7 @@
 			}
 			break;
 		case THERMAL_SENSOR:
-			n += sprintf(buf+n, "Temp. (�C/�F):\t");
+			n += sprintf(buf+n, "Temp. (°C/°F):\t");
 			temperature = 1;
 			break;
 		case LID_STATUS:
diff -ur linux-2.6.4/drivers/macintosh/therm_adt7467.c linux-utf8-2.6.4-cstrings2utf8/drivers/macintosh/therm_adt7467.c
--- linux-2.6.4/drivers/macintosh/therm_adt7467.c	2004-02-16 02:55:03.000000000 +0100
+++ linux-utf8-2.6.4-cstrings2utf8/drivers/macintosh/therm_adt7467.c	2004-03-23 17:41:48.891711736 +0100
@@ -53,7 +53,7 @@
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(limit_adjust,"i");
-MODULE_PARM_DESC(limit_adjust,"Adjust maximum temperatures (50�C cpu, 70�C gpu) by N �C.");
+MODULE_PARM_DESC(limit_adjust,"Adjust maximum temperatures (50°C cpu, 70°C gpu) by N °C.");
 MODULE_PARM(fan_speed,"i");
 MODULE_PARM_DESC(fan_speed,"Specify fan speed (0-255) when lim < temp < lim+8 (default 128)");
 
@@ -142,7 +142,7 @@
 	}
 		
 	printk(KERN_INFO "adt746x: Putting max temperatures back from %d, %d, %d,"
-		" to %d, %d, %d, (�C)\n", 
+		" to %d, %d, %d, (°C)\n", 
 		th->limits[0], th->limits[1], th->limits[2],
 		th->initial_limits[0], th->initial_limits[1], th->initial_limits[2]);
 	
@@ -271,14 +271,14 @@
 				int var = temps[i] - lims[i];
 				if (var > 8) {
 					if (th->overriding[fan_number] == 0)
-						printk(KERN_INFO "adt746x: Limit exceeded by %d�C, overriding specified fan speed for %s.\n",
+						printk(KERN_INFO "adt746x: Limit exceeded by %d°C, overriding specified fan speed for %s.\n",
 							var, fan_number?"GPU":"CPU");
 					th->overriding[fan_number] = 1;
 					write_fan_speed(th, 255, fan_number);
 					started = 1;
 				} else if ((!th->overriding[fan_number] || var < 6) && var > 0) {
 					if (th->overriding[fan_number] == 1)
-						printk(KERN_INFO "adt746x: Limit exceeded by %d�C, setting speed to specified for %s.\n",
+						printk(KERN_INFO "adt746x: Limit exceeded by %d°C, setting speed to specified for %s.\n",
 							var, fan_number?"GPU":"CPU");					
 					th->overriding[fan_number] = 0;
 					write_fan_speed(th, fan_speed, fan_number);
@@ -309,8 +309,8 @@
 		||  temps[1] != th->cached_temp[1]
 		||  temps[2] != th->cached_temp[2]) {
 			printk(KERN_INFO "adt746x: Temperature infos:"
-					 " thermostats: %d,%d,%d �C;"
-					 " limits: %d,%d,%d �C;"
+					 " thermostats: %d,%d,%d °C;"
+					 " limits: %d,%d,%d °C;"
 					 " fan speed: %d RPM\n",
 				temps[0], temps[1], temps[2],
 				lims[0],  lims[1],  lims[2],
@@ -381,7 +381,7 @@
 	}
 	
 	printk(KERN_INFO "adt746x: Lowering max temperatures from %d, %d, %d"
-		" to %d, %d, %d (�C)\n", 
+		" to %d, %d, %d (°C)\n", 
 		th->initial_limits[0], th->initial_limits[1], th->initial_limits[2], 
 		th->limits[0], th->limits[1], th->limits[2]);
 
@@ -421,7 +421,7 @@
 #define BUILD_SHOW_FUNC_DEG(name, data)				\
 static ssize_t show_##name(struct device *dev, char *buf)	\
 {								\
-	return sprintf(buf, "%d�C\n", data);			\
+	return sprintf(buf, "%d°C\n", data);			\
 }
 #define BUILD_SHOW_FUNC_INT(name, data)				\
 static ssize_t show_##name(struct device *dev, char *buf)	\
@@ -435,7 +435,7 @@
 	int val;						\
 	int i;							\
 	val = simple_strtol(buf, NULL, 10);			\
-	printk(KERN_INFO "Adjusting limits by %d�C\n", val);	\
+	printk(KERN_INFO "Adjusting limits by %d°C\n", val);	\
 	limit_adjust = val;					\
 	for (i=0; i < 3; i++)					\
 		set_limit(thermostat, i);			\
diff -ur linux-2.6.4/drivers/mtd/chips/cfi_probe.c linux-utf8-2.6.4-cstrings2utf8/drivers/mtd/chips/cfi_probe.c
--- linux-2.6.4/drivers/mtd/chips/cfi_probe.c	2003-07-14 05:36:47.000000000 +0200
+++ linux-utf8-2.6.4-cstrings2utf8/drivers/mtd/chips/cfi_probe.c	2004-03-23 17:41:48.981698056 +0100
@@ -250,12 +250,12 @@
 	else
 		printk("No Vpp line\n");
 	
-	printk("Typical byte/word write timeout: %d �s\n", 1<<cfip->WordWriteTimeoutTyp);
-	printk("Maximum byte/word write timeout: %d �s\n", (1<<cfip->WordWriteTimeoutMax) * (1<<cfip->WordWriteTimeoutTyp));
+	printk("Typical byte/word write timeout: %d µs\n", 1<<cfip->WordWriteTimeoutTyp);
+	printk("Maximum byte/word write timeout: %d µs\n", (1<<cfip->WordWriteTimeoutMax) * (1<<cfip->WordWriteTimeoutTyp));
 	
 	if (cfip->BufWriteTimeoutTyp || cfip->BufWriteTimeoutMax) {
-		printk("Typical full buffer write timeout: %d �s\n", 1<<cfip->BufWriteTimeoutTyp);
-		printk("Maximum full buffer write timeout: %d �s\n", (1<<cfip->BufWriteTimeoutMax) * (1<<cfip->BufWriteTimeoutTyp));
+		printk("Typical full buffer write timeout: %d µs\n", 1<<cfip->BufWriteTimeoutTyp);
+		printk("Maximum full buffer write timeout: %d µs\n", (1<<cfip->BufWriteTimeoutMax) * (1<<cfip->BufWriteTimeoutTyp));
 	}
 	else
 		printk("Full buffer write not supported\n");
diff -ur linux-2.6.4/drivers/net/wireless/netwave_cs.c linux-utf8-2.6.4-cstrings2utf8/drivers/net/wireless/netwave_cs.c
--- linux-2.6.4/drivers/net/wireless/netwave_cs.c	2004-03-22 14:19:17.000000000 +0100
+++ linux-utf8-2.6.4-cstrings2utf8/drivers/net/wireless/netwave_cs.c	2004-03-23 17:41:49.094680880 +0100
@@ -4,18 +4,18 @@
  * Version:       0.4.1
  * Description:   Netwave AirSurfer Wireless LAN PC Card driver
  * Status:        Experimental.
- * Authors:       John Markus Bj�rndalen <johnm@cs.uit.no>
+ * Authors:       John Markus Bjørndalen <johnm@cs.uit.no>
  *                Dag Brattli <dagb@cs.uit.no>
  *                David Hinds <dahinds@users.sourceforge.net>
  * Created at:    A long time ago!
  * Modified at:   Mon Nov 10 11:54:37 1997
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  * 
- *     Copyright (c) 1997 University of Troms�, Norway
+ *     Copyright (c) 1997 University of Tromsø, Norway
  *
  * Revision History:
  *
- *   08-Nov-97 15:14:47   John Markus Bj�rndalen <johnm@cs.uit.no>
+ *   08-Nov-97 15:14:47   John Markus Bjørndalen <johnm@cs.uit.no>
  *    - Fixed some bugs in netwave_rx and cleaned it up a bit. 
  *      (One of the bugs would have destroyed packets when receiving
  *      multiple packets per interrupt). 
@@ -164,7 +164,7 @@
 MODULE_PARM(pc_debug, "i");
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static char *version =
-"netwave_cs.c 0.3.0 Thu Jul 17 14:36:02 1997 (John Markus Bj�rndalen)\n";
+"netwave_cs.c 0.3.0 Thu Jul 17 14:36:02 1997 (John Markus Bjørndalen)\n";
 #else
 #define DEBUG(n, args...)
 #endif

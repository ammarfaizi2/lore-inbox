Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbTCWBSY>; Sat, 22 Mar 2003 20:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbTCWBSY>; Sat, 22 Mar 2003 20:18:24 -0500
Received: from dp.samba.org ([66.70.73.150]:51158 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262196AbTCWBSW>;
	Sat, 22 Mar 2003 20:18:22 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15997.3368.18276.321852@nanango.paulus.ozlabs.org>
Date: Sun, 23 Mar 2003 12:26:00 +1100 (EST)
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] update macintosh-specific headers
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates include/linux/adb.h and include/linux/pmu.h with
some additional definitions that we need on powermacs and powerbooks.
Please apply.

Paul.

diff -urN linux-2.5/include/linux/adb.h linuxppc-2.5/include/linux/adb.h
--- linux-2.5/include/linux/adb.h	2002-02-06 04:39:43.000000000 +1100
+++ linuxppc-2.5/include/linux/adb.h	2003-02-03 08:51:33.000000000 +1100
@@ -30,6 +30,15 @@
 #define POWER_PACKET	4
 #define MACIIC_PACKET	5
 #define PMU_PACKET	6
+#define ADB_QUERY	7
+
+/* ADB queries */
+
+/* ADB_QUERY_GETDEVINFO
+ * Query ADB slot for device presence
+ * data[2] = id, rep[0] = orig addr, rep[1] = handler_id
+ */
+#define ADB_QUERY_GETDEVINFO	1
 
 #ifdef __KERNEL__
 
diff -urN linux-2.5/include/linux/pmu.h linuxppc-2.5/include/linux/pmu.h
--- linux-2.5/include/linux/pmu.h	2002-05-19 00:06:16.000000000 +1000
+++ linuxppc-2.5/include/linux/pmu.h	2003-02-03 08:51:33.000000000 +1100
@@ -30,6 +30,7 @@
 #define PMU_SET_INTR_MASK	0x70	/* set PMU interrupt mask */
 #define PMU_INT_ACK		0x78	/* read interrupt bits */
 #define PMU_SHUTDOWN		0x7e	/* turn power off */
+#define PMU_CPU_SPEED		0x7d	/* control CPU speed on some models */
 #define PMU_SLEEP		0x7f	/* put CPU to sleep */
 #define PMU_POWER_EVENTS	0x8f	/* Send power-event commands to PMU */
 #define PMU_RESET		0xd0	/* reset CPU */
@@ -191,6 +192,10 @@
 /* values for pmu_battery_info.flags */
 #define PMU_BATT_PRESENT	0x00000001
 #define PMU_BATT_CHARGING	0x00000002
+#define PMU_BATT_TYPE_MASK	0x000000f0
+#define PMU_BATT_TYPE_SMART	0x00000010 /* Smart battery */
+#define PMU_BATT_TYPE_HOOPER	0x00000020 /* 3400/3500 */
+#define PMU_BATT_TYPE_COMET	0x00000030 /* 2400 */
 
 struct pmu_battery_info
 {

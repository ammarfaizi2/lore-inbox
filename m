Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264811AbUEKRnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264811AbUEKRnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUEKRnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:43:24 -0400
Received: from outmx012.isp.belgacom.be ([195.238.3.70]:23238 "EHLO
	outmx012.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264889AbUEKRml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:42:41 -0400
Subject: [PATCH 2.6.6-mm1] bluetooth definition redundancy fix
From: FabF <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-fV9XN9AsOGk5RMihMIdm"
Message-Id: <1084381970.7894.4.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 19:12:50 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx012.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fV9XN9AsOGk5RMihMIdm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

	HCI Core debug context is redefined 4 times in mm1 bluetooth
module.Here's a trivial patch to have it in hci_core.h (only).

Regards,
FabF

--=-fV9XN9AsOGk5RMihMIdm
Content-Disposition: attachment; filename=bluetooth1.diff
Content-Type: text/x-patch; name=bluetooth1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/include/net/bluetooth/hci_core.h edited/include/net/bluetooth/hci_core.h
--- orig/include/net/bluetooth/hci_core.h	2004-05-10 04:32:37.000000000 +0200
+++ edited/include/net/bluetooth/hci_core.h	2004-05-12 18:54:20.000000000 +0200
@@ -32,6 +32,12 @@
 #include <linux/proc_fs.h>
 #include <net/bluetooth/hci.h>
 
+#ifndef CONFIG_BT_HCI_CORE_DEBUG
+#undef  BT_DBG
+#define BT_DBG( A... )
+#endif
+
+
 /* HCI upper protocols */
 #define HCI_PROTO_L2CAP	0
 #define HCI_PROTO_SCO	1
diff -Naur orig/net/bluetooth/hci_conn.c edited/net/bluetooth/hci_conn.c
--- orig/net/bluetooth/hci_conn.c	2004-05-10 04:33:21.000000000 +0200
+++ edited/net/bluetooth/hci_conn.c	2004-05-12 18:55:00.000000000 +0200
@@ -52,11 +52,6 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#ifndef CONFIG_BT_HCI_CORE_DEBUG
-#undef  BT_DBG
-#define BT_DBG( A... )
-#endif
-
 void hci_acl_connect(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
diff -Naur orig/net/bluetooth/hci_core.c edited/net/bluetooth/hci_core.c
--- orig/net/bluetooth/hci_core.c	2004-05-10 04:32:26.000000000 +0200
+++ edited/net/bluetooth/hci_core.c	2004-05-12 18:55:08.000000000 +0200
@@ -53,11 +53,6 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#ifndef CONFIG_BT_HCI_CORE_DEBUG
-#undef  BT_DBG
-#define BT_DBG( A... )
-#endif
-
 static void hci_cmd_task(unsigned long arg);
 static void hci_rx_task(unsigned long arg);
 static void hci_tx_task(unsigned long arg);
diff -Naur orig/net/bluetooth/hci_sock.c edited/net/bluetooth/hci_sock.c
--- orig/net/bluetooth/hci_sock.c	2004-05-10 04:32:38.000000000 +0200
+++ edited/net/bluetooth/hci_sock.c	2004-05-12 18:59:34.000000000 +0200
@@ -54,11 +54,6 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#ifndef CONFIG_BT_HCI_SOCK_DEBUG
-#undef  BT_DBG
-#define BT_DBG( A... )
-#endif
-
 /* ----- HCI socket interface ----- */
 
 static inline int hci_test_bit(int nr, void *addr)
diff -Naur orig/net/bluetooth/hci_sysfs.c edited/net/bluetooth/hci_sysfs.c
--- orig/net/bluetooth/hci_sysfs.c	2004-05-10 04:33:04.000000000 +0200
+++ edited/net/bluetooth/hci_sysfs.c	2004-05-12 18:59:45.000000000 +0200
@@ -5,11 +5,6 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#ifndef CONFIG_BT_HCI_CORE_DEBUG
-#undef  BT_DBG
-#define BT_DBG( A... )
-#endif
-
 static ssize_t show_name(struct class_device *cdev, char *buf)
 {
 	struct hci_dev *hdev = class_get_devdata(cdev);

--=-fV9XN9AsOGk5RMihMIdm--


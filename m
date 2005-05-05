Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVEEAXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVEEAXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 20:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVEEAXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 20:23:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14089 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261970AbVEEAXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 20:23:13 -0400
Date: Thu, 5 May 2005 02:23:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: marcel@holtmann.or, maxk@qualcomm.com
Cc: bluez-devel@lists.sf.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/bluetooth/: possible cleanups
Message-ID: <20050505002310.GF3593@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- #ifdef HCI_DATA_DUMP the following function:
  lib.c: bt_dump
- #if 0 the following unused global functions:
  - hci_core.c: hci_suspend_dev
  - hci_core.c: hci_resume_dev
- remove the following unneeded EXPORT_SYMBOL's:
  - hci_core.c: hci_dev_get
  - hci_core.c: hci_send_cmd
  - hci_event.c: hci_si_event

Please review which of these changes do make sense and which conflict 
with pending patches.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/net/bluetooth/hci_core.h |    2 --
 net/bluetooth/hci_core.c         |    6 ++++--
 net/bluetooth/hci_event.c        |    1 -
 net/bluetooth/lib.c              |    2 ++
 4 files changed, 6 insertions(+), 5 deletions(-)

--- linux-2.6.12-rc3-mm2-full/include/net/bluetooth/hci_core.h.old	2005-05-03 10:38:41.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/include/net/bluetooth/hci_core.h	2005-05-03 10:38:49.000000000 +0200
@@ -375,8 +375,6 @@
 void hci_free_dev(struct hci_dev *hdev);
 int hci_register_dev(struct hci_dev *hdev);
 int hci_unregister_dev(struct hci_dev *hdev);
-int hci_suspend_dev(struct hci_dev *hdev);
-int hci_resume_dev(struct hci_dev *hdev);
 int hci_dev_open(__u16 dev);
 int hci_dev_close(__u16 dev);
 int hci_dev_reset(__u16 dev);
--- linux-2.6.12-rc3-mm2-full/net/bluetooth/hci_core.c.old	2005-05-03 10:38:58.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/net/bluetooth/hci_core.c	2005-05-03 10:47:49.000000000 +0200
@@ -299,7 +299,6 @@
 	read_unlock(&hci_dev_list_lock);
 	return hdev;
 }
-EXPORT_SYMBOL(hci_dev_get);
 
 /* ---- Inquiry support ---- */
 static void inquiry_cache_flush(struct hci_dev *hdev)
@@ -899,6 +898,8 @@
 }
 EXPORT_SYMBOL(hci_unregister_dev);
 
+#if 0
+
 /* Suspend HCI device */
 int hci_suspend_dev(struct hci_dev *hdev)
 {
@@ -915,6 +916,8 @@
 }
 EXPORT_SYMBOL(hci_resume_dev);
 
+#endif  /*  0  */
+
 /* ---- Interface to upper protocols ---- */
 
 /* Register/Unregister protocols.
@@ -1042,7 +1045,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(hci_send_cmd);
 
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 ogf, __u16 ocf)
--- linux-2.6.12-rc3-mm2-full/net/bluetooth/lib.c.old	2005-05-03 10:39:29.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/net/bluetooth/lib.c	2005-05-03 10:39:49.000000000 +0200
@@ -34,6 +34,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 
+#ifdef HCI_DATA_DUMP
 void bt_dump(char *pref, __u8 *buf, int count)
 {
 	char *ptr;
@@ -58,6 +59,7 @@
 		printk(KERN_INFO "%s:%s\n", pref, line);
 }
 EXPORT_SYMBOL(bt_dump);
+#endif  /*  HCI_DATA_DUMP  */
 
 void baswap(bdaddr_t *dst, bdaddr_t *src)
 {
--- linux-2.6.12-rc3-mm2-full/net/bluetooth/hci_event.c.old	2005-05-03 10:48:13.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/net/bluetooth/hci_event.c	2005-05-03 10:48:21.000000000 +0200
@@ -1040,4 +1040,3 @@
 	hci_send_to_sock(hdev, skb);
 	kfree_skb(skb);
 }
-EXPORT_SYMBOL(hci_si_event);


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbULSQe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbULSQe6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 11:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbULSQe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 11:34:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54034 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261308AbULSQeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 11:34:46 -0500
Date: Sun, 19 Dec 2004 17:34:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sf.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Network Development Mailing List <netdev@oss.sgi.com>
Subject: [2.6 patch] bluetooth: make some code static
Message-ID: <20041219163442.GC21288@stusta.de>
References: <20041214041352.GZ23151@stusta.de> <1103009649.2143.65.camel@pegasus> <20041219160758.GY21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041219160758.GY21288@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 include/net/bluetooth/hci_core.h |    2 --
 net/bluetooth/hci_conn.c         |    2 +-
 net/bluetooth/hci_core.c         |    4 ++--
 net/bluetooth/hci_sock.c         |   10 +++++-----
 net/bluetooth/l2cap.c            |    2 +-
 5 files changed, 9 insertions(+), 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/include/net/bluetooth/hci_core.h.old	2004-12-14 02:13:54.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/bluetooth/hci_core.h	2004-12-14 02:31:34.000000000 +0100
@@ -277,7 +277,6 @@
 	return NULL;
 }
 
-void hci_acl_connect(struct hci_conn *conn);
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
 void hci_add_sco(struct hci_conn *conn, __u16 handle);
 
@@ -589,6 +583,5 @@
 #define hci_req_unlock(d)	up(&d->req_lock)
 
 void hci_req_complete(struct hci_dev *hdev, int result);
-void hci_req_cancel(struct hci_dev *hdev, int err);
 
 #endif /* __HCI_CORE_H */
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_conn.c.old	2004-12-14 02:14:10.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_conn.c	2004-12-14 02:14:15.000000000 +0100
@@ -53,7 +53,7 @@
 #define BT_DBG(D...)
 #endif
 
-void hci_acl_connect(struct hci_conn *conn)
+static void hci_acl_connect(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct inquiry_entry *ie;
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_core.c.old	2004-12-14 02:14:53.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_core.c	2004-12-14 02:31:09.000000000 +0100
@@ -59,7 +59,7 @@
 static void hci_tx_task(unsigned long arg);
 static void hci_notify(struct hci_dev *hdev, int event);
 
-rwlock_t hci_task_lock = RW_LOCK_UNLOCKED;
+static rwlock_t hci_task_lock = RW_LOCK_UNLOCKED;
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
@@ -106,7 +106,7 @@
 	}
 }
 
-void hci_req_cancel(struct hci_dev *hdev, int err)
+static void hci_req_cancel(struct hci_dev *hdev, int err)
 {
 	BT_DBG("%s err 0x%2.2x", hdev->name, err);
 
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_sock.c.old	2004-12-14 02:16:59.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_sock.c	2004-12-14 02:17:59.000000000 +0100
@@ -447,7 +447,7 @@
 	goto done;
 }
 
-int hci_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int len)
+static int hci_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int len)
 {
 	struct hci_ufilter uf = { .opcode = 0 };
 	struct sock *sk = sock->sk;
@@ -514,7 +514,7 @@
 	return err;
 }
 
-int hci_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
+static int hci_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
 {
 	struct hci_ufilter uf;
 	struct sock *sk = sock->sk;
@@ -567,7 +567,7 @@
 	return 0;
 }
 
-struct proto_ops hci_sock_ops = {
+static struct proto_ops hci_sock_ops = {
 	.family		= PF_BLUETOOTH,
 	.owner		= THIS_MODULE,
 	.release	= hci_sock_release,
@@ -647,13 +647,13 @@
 	return NOTIFY_DONE;
 }
 
-struct net_proto_family hci_sock_family_ops = {
+static struct net_proto_family hci_sock_family_ops = {
 	.family	= PF_BLUETOOTH,
 	.owner	= THIS_MODULE,
 	.create	= hci_sock_create,
 };
 
-struct notifier_block hci_sock_nblock = {
+static struct notifier_block hci_sock_nblock = {
 	.notifier_call = hci_sock_dev_event
 };
 
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/l2cap.c.old	2004-12-14 02:18:13.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/l2cap.c	2004-12-14 02:18:21.000000000 +0100
@@ -61,7 +61,7 @@
 
 static struct proto_ops l2cap_sock_ops;
 
-struct bt_sock_list l2cap_sk_list = {
+static struct bt_sock_list l2cap_sk_list = {
 	.lock = RW_LOCK_UNLOCKED
 };
 


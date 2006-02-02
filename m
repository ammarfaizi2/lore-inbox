Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWBBWiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWBBWiI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWBBWiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:38:08 -0500
Received: from sipsolutions.net ([66.160.135.76]:44805 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932376AbWBBWiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:38:07 -0500
Subject: [RFC 1/4] firewire: node interface
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
In-Reply-To: <1138919238.3621.12.camel@localhost>
References: <1138919238.3621.12.camel@localhost>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 23:38:00 +0100
Message-Id: <1138919880.3621.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds just two small helper functions to allow other code to
register a struct class_interface to interface node entries.

diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
index 082c7fd..06f4544 100644
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -1796,3 +1796,11 @@ void cleanup_ieee1394_nodemgr(void)
 	class_unregister(&nodemgr_ud_class);
 	class_unregister(&nodemgr_ne_class);
 }
+
+int hpsb_register_node_interface(struct class_interface *intf)
+{
+	intf->class = &nodemgr_ne_class;
+
+	return class_interface_register(intf);
+}
+EXPORT_SYMBOL_GPL(hpsb_register_node_interface);
diff --git a/drivers/ieee1394/nodemgr.h b/drivers/ieee1394/nodemgr.h
index 0b26616..d779f81 100644
--- a/drivers/ieee1394/nodemgr.h
+++ b/drivers/ieee1394/nodemgr.h
@@ -170,6 +170,14 @@ int hpsb_node_write(struct node_entry *n
 int hpsb_node_lock(struct node_entry *ne, u64 addr,
 		   int extcode, quadlet_t *data, quadlet_t arg);
 
+/*
+ * things like mem1394 are interfaces to nodes, thus
+ * allow them to register and unregister one.
+ */
+int hpsb_register_node_interface(struct class_interface *intf);
+static inline void hpsb_unregister_node_interface(struct class_interface *intf) {
+	class_interface_unregister(intf);
+}
 
 /* Iterate the hosts, calling a given function with supplied data for each
  * host. */



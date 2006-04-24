Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWDXV0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWDXV0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWDXVXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:49 -0400
Received: from mx.pathscale.com ([64.160.42.68]:34755 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751293AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 6 of 13] ipath - fix verbs registration
X-Mercurial-Node: 3ff1e5ae1c6078b906fd1624d8f8d73a654dff94
Message-Id: <3ff1e5ae1c6078b906fd.1145913782@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:23:02 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remember when the verbs layer unregisters from the lower-level code.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 1ab168913f0f -r 3ff1e5ae1c60 drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Wed Apr 19 15:24:36 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Wed Apr 19 15:24:36 2006 -0700
@@ -46,13 +46,15 @@
 /* Acquire before ipath_devs_lock. */
 static DEFINE_MUTEX(ipath_layer_mutex);
 
+static int ipath_verbs_registered;
+
 u16 ipath_layer_rcv_opcode;
+
 static int (*layer_intr)(void *, u32);
 static int (*layer_rcv)(void *, void *, struct sk_buff *);
 static int (*layer_rcv_lid)(void *, void *);
 static int (*verbs_piobufavail)(void *);
 static void (*verbs_rcv)(void *, void *, void *, u32);
-static int ipath_verbs_registered;
 
 static void *(*layer_add_one)(int, struct ipath_devdata *);
 static void (*layer_remove_one)(void *);
@@ -585,6 +587,8 @@ void ipath_verbs_unregister(void)
 	verbs_piobufavail = NULL;
 	verbs_rcv = NULL;
 	verbs_timer_cb = NULL;
+
+	ipath_verbs_registered = 0;
 
 	mutex_unlock(&ipath_layer_mutex);
 }

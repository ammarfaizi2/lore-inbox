Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVCGUd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVCGUd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVCGUci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:32:38 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:7601 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261777AbVCGUMd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:33 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [10/many] acrypto: crypto_lb.h
In-Reply-To: <1110227854957@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:34 +0300
Message-Id: <11102278543541@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:24 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_lb.h	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_lb.h	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,63 @@
+/*
+ * 	crypto_lb.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __CRYPTO_LB_H
+#define __CRYPTO_LB_H
+
+#include "acrypto.h"
+
+#define CRYPTO_LB_NAMELEN	32
+
+struct crypto_lb 
+{
+	struct list_head 	lb_entry;
+
+	char 			name[CRYPTO_LB_NAMELEN];
+
+	void 			(*rehash)(struct crypto_lb *);
+	struct crypto_device *	(*find_device) (struct crypto_lb *,
+						struct crypto_session_initializer *, 
+						struct crypto_data *);
+
+	spinlock_t 		lock;
+
+	spinlock_t 		*crypto_device_lock;
+	struct list_head 	*crypto_device_list;
+
+	struct device_driver 	*driver;
+	struct device 		device;
+	struct class_device 	class_device;
+	struct completion 	dev_released;
+
+};
+
+int crypto_lb_register(struct crypto_lb *lb, int set_current, int set_default);
+void crypto_lb_unregister(struct crypto_lb *);
+
+inline void crypto_lb_rehash(void);
+struct crypto_device *crypto_lb_find_device(struct crypto_session_initializer *, struct crypto_data *);
+
+void crypto_wake_lb(void);
+
+int crypto_lb_init(void);
+void crypto_lb_fini(void);
+
+#endif				/* __CRYPTO_LB_H */


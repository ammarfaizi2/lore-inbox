Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVCHDIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVCHDIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVCGU1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:27:05 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:433 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261752AbVCGUM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:29 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [16/many] acrypto: crypto_user.h
In-Reply-To: <11102278551109@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:35 +0300
Message-Id: <11102278551459@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_user.h	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_user.h	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,52 @@
+/*
+ * 	crypto_user.h
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
+#ifndef __CRYPTO_USER_H
+#define __CRYPTO_USER_H
+
+#define MAX_DATA_SIZE	3
+#define ALIGN_DATA_SIZE(size)	((size + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1))
+
+enum crypto_user_data_types 
+{
+	CRYPTO_USER_DATA_SRC = 0,
+	CRYPTO_USER_DATA_DST,
+	CRYPTO_USER_DATA_KEY,
+	CRYPTO_USER_DATA_IV,
+};
+
+struct crypto_user_data
+{
+	__u16		data_size;
+	__u16		data_type;
+};
+
+
+#ifdef __KERNEL__
+
+int crypto_user_alloc_crypto_data(struct crypto_data *data, int src_size, int dst_size, int key_size, int iv_size);
+void crypto_user_free_crypto_data(struct crypto_data *data);
+void crypto_user_fill_sg(void *ptr, u16 size, struct scatterlist *sg);
+struct scatterlist *crypto_user_get_sg(struct crypto_user_data *ud, struct crypto_data *data);
+int crypto_user_fill_sg_data(struct crypto_user_data *ud, struct crypto_data *data, void *ptr);
+
+#endif /* __KERNEL__ */
+#endif /* __CRYPTO_USER_H */


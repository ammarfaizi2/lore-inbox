Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVCGUd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVCGUd6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVCGUa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:30:27 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:6833 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261776AbVCGUMc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:32 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [18/many] acrypto: crypto_user_direct.h
In-Reply-To: <111022785593@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:35 +0300
Message-Id: <11102278553597@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_user_direct.h	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_user_direct.h	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,74 @@
+/*
+ * 	crypto_user_direct.h
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
+#ifndef __CRYPTO_USER_DIRECT_H
+#define __CRYPTO_USER_DIRECT_H
+
+struct crypto_user_direct
+{
+	__u64			src;
+	__u32			src_size;
+	__u64			dst;
+	__u32			dst_size;
+	
+	__u16 			operation;
+	__u16 			type;
+	__u16 			mode;
+	__u16 			priority;
+
+	int			pid;
+
+	int			key_size;
+	int			iv_size;
+
+	__u8			data[0];
+};
+
+#ifdef __KERNEL__
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+
+struct crypto_user_direct_kern
+{
+	struct list_head	entry;
+
+	u32			seq;
+	u32			ack;
+
+	struct crypto_user_direct	usr;
+	u8			*key;
+	u8			*iv;
+
+	int			snum, dnum;
+	struct page		**sp, **dp;
+	struct vm_area_struct 	**svma, **dvma;
+	struct mm_struct 	*mm;
+};
+
+int crypto_user_direct_init(void);
+void crypto_user_direct_fini(void);
+int crypto_user_direct_add_request(u32 seq, u32 ack, struct crypto_user_direct *usr);
+
+#endif /* __KERNEL__ */
+
+#endif /* __CRYPTO_USER_DIRECT_H */


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbULFUos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbULFUos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbULFUos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:44:48 -0500
Received: from math.ut.ee ([193.40.5.125]:30705 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261479AbULFUop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:44:45 -0500
Date: Mon, 6 Dec 2004 22:44:39 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
To: linux-kernel@vger.kernel.org
cc: mroos@ut.ee
Subject: [PATCH 2.6] clean-up: fixes "unsigned<0" warning
Message-ID: <Pine.SOC.4.61.0412062241420.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes 5 warnings "comparison of unsigned expression < 0 is
always false" occuring on lines 1987, 1988, 1989, 1990, 1992

Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>

--- a/drivers/block/as-iosched.c	2004-11-30 19:43:52.000000000 +0000
+++ b/drivers/block/as-iosched.c	2004-10-31 13:09:19.000000000 +0000
@@ -1974,23 +1974,21 @@
  SHOW_FUNCTION(as_write_batchexpire_show, ad->batch_expire[REQ_ASYNC]);
  #undef SHOW_FUNCTION

-#define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX)				\
+#define STORE_FUNCTION(__FUNC, __PTR, MAX)				\
  static ssize_t __FUNC(struct as_data *ad, const char *page, size_t count)	\
  {									\
  	int ret = as_var_store(__PTR, (page), count);		\
-	if (*(__PTR) < (MIN))						\
-		*(__PTR) = (MIN);					\
-	else if (*(__PTR) > (MAX))					\
+	if (*(__PTR) > (MAX))						\
  		*(__PTR) = (MAX);					\
  	return ret;							\
  }
-STORE_FUNCTION(as_readexpire_store, &ad->fifo_expire[REQ_SYNC], 0, INT_MAX);
-STORE_FUNCTION(as_writeexpire_store, &ad->fifo_expire[REQ_ASYNC], 0, INT_MAX);
-STORE_FUNCTION(as_anticexpire_store, &ad->antic_expire, 0, INT_MAX);
+STORE_FUNCTION(as_readexpire_store, &ad->fifo_expire[REQ_SYNC], INT_MAX);
+STORE_FUNCTION(as_writeexpire_store, &ad->fifo_expire[REQ_ASYNC], INT_MAX);
+STORE_FUNCTION(as_anticexpire_store, &ad->antic_expire, INT_MAX);
  STORE_FUNCTION(as_read_batchexpire_store,
-			&ad->batch_expire[REQ_SYNC], 0, INT_MAX);
+			&ad->batch_expire[REQ_SYNC], INT_MAX);
  STORE_FUNCTION(as_write_batchexpire_store,
-			&ad->batch_expire[REQ_ASYNC], 0, INT_MAX);
+			&ad->batch_expire[REQ_ASYNC], INT_MAX);
  #undef STORE_FUNCTION

  static struct as_fs_entry as_est_entry = {

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752317AbWFXPR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbWFXPR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbWFXPR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:17:29 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:30662 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1752298AbWFXPR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:17:28 -0400
Message-ID: <351162245.07531@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625071729.008111818@localhost.localdomain>
References: <20060625071036.241325936@localhost.localdomain>
Date: Sun, 25 Jun 2006 15:10:37 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>,
       Fengguang Wu <wfg@mail.ustc.edu.cn>
Subject: [PATCH 1/7] iosched: introduce WRITEA
Content-Disposition: inline; filename=iosched-reada-redef.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce WRITEA as 3, and redefine SWRITE as 5.

I'm not sure if WRITEA will ever be used, though it would be better to
redefine SWRITE to avoid possible conflict with BIO_RW_AHEAD.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-rc6-mm2.orig/include/linux/fs.h
+++ linux-2.6.17-rc6-mm2/include/linux/fs.h
@@ -74,8 +74,9 @@ extern int dir_notify_enable;
 #define READ 0
 #define WRITE 1
 #define READA 2		/* read-ahead  - don't block if no resources */
-#define SWRITE 3	/* for ll_rw_block() - wait for buffer lock */
+#define WRITEA 3	/* write-ahead - don't block if no resources */
 #define SPECIAL 4	/* For non-blockdevice requests in request queue */
+#define SWRITE 5	/* for ll_rw_block() - wait for buffer lock */
 #define READ_SYNC	(READ | (1 << BIO_RW_SYNC))
 #define WRITE_SYNC	(WRITE | (1 << BIO_RW_SYNC))
 #define WRITE_BARRIER	((1 << BIO_RW) | (1 << BIO_RW_BARRIER))

--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933325AbWFXIYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933325AbWFXIYe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 04:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933318AbWFXIXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 04:23:10 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:17110 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1752184AbWFXIXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 04:23:05 -0400
Message-ID: <351137381.34985@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060624082310.253199615@localhost.localdomain>
References: <20060624082006.574472632@localhost.localdomain>
Date: Sat, 24 Jun 2006 16:20:07 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
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

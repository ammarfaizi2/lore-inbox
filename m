Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263952AbTCVWrD>; Sat, 22 Mar 2003 17:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263938AbTCVWoj>; Sat, 22 Mar 2003 17:44:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16261
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263937AbTCVWmy>; Sat, 22 Mar 2003 17:42:54 -0500
Date: Sat, 22 Mar 2003 23:58:35 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303222358.h2MNwZ1J020739@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: use right object for i2o_config - kernel not user copy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/message/i2o/i2o_config.c linux-2.5.65-ac3/drivers/message/i2o/i2o_config.c
--- linux-2.5.65-bk3/drivers/message/i2o/i2o_config.c	2003-03-22 19:33:59.000000000 +0000
+++ linux-2.5.65-ac3/drivers/message/i2o/i2o_config.c	2003-03-22 20:41:45.000000000 +0000
@@ -437,7 +437,7 @@
 	put_user(len, kcmd.reslen);
 	if(len > reslen)
 		ret = -ENOBUFS;
-	else if(copy_to_user(cmd->resbuf, res, len))
+	else if(copy_to_user(kcmd.resbuf, res, len))
 		ret = -EFAULT;
 
 	kfree(res);

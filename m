Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279241AbRJ2MGN>; Mon, 29 Oct 2001 07:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279243AbRJ2MFx>; Mon, 29 Oct 2001 07:05:53 -0500
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:2297 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S279241AbRJ2MFt>; Mon, 29 Oct 2001 07:05:49 -0500
Date: Mon, 29 Oct 2001 17:35:43 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: <linux-i2c@pelican.tk.uni-linz.ac.at>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix for warnings for i2o
Message-ID: <Pine.GSO.4.33.0110291733020.28035-100000@cbin2-view1.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i2o code compilation gives a warning which is due
to the fact that queue_buggy (i2o_block.c:1375, 1378)
is compared to 1 and 2, even though it's 1 bit in size.

queue_buggy is set to 0, 1 and 2 and hence the warnings
go away when the size is increased.

diffs attached ....

Index: i2o.h
===================================================================
RCS file: /vger/linux/include/linux/i2o.h,v
retrieving revision 1.17
diff -u -r1.17 i2o.h
--- i2o.h	22 Oct 2001 06:46:34 -0000	1.17
+++ i2o.h	29 Oct 2001 11:34:55 -0000
@@ -82,7 +82,7 @@
 struct i2o_pci
 {
 	int		irq;
-	int		queue_buggy:1;	/* Don't send a lot of messages */
+	int		queue_buggy:3;	/* Don't send a lot of messages */
 	int		short_req:1;	/* Use small block sizes        */
 	int		dpt:1;		/* Don't quiesce                */
 #ifdef CONFIG_MTRR


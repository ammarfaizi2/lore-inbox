Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266707AbSKHBqx>; Thu, 7 Nov 2002 20:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266709AbSKHBqx>; Thu, 7 Nov 2002 20:46:53 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64979 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266707AbSKHBqw>;
	Thu, 7 Nov 2002 20:46:52 -0500
Message-Id: <200211080153.gA81rPD23909@eng4.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.46: sysfs broken for partitions
Date: Thu, 07 Nov 2002 17:53:25 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An ignored return value can cause a whole subset of the sysfs tree to go
silent. "cat /sys/block/sda/sda1/*" yields nothing without the patch, and
mysterious but appropriate numbers with it.

Rick

diff -ru linux-2.5.46/fs/partitions/check.c stat-2.5.46-rl1/fs/partitions/check.c
--- linux-2.5.46/fs/partitions/check.c	Mon Nov  4 14:30:50 2002
+++ stat-2.5.46-rl1/fs/partitions/check.c	Thu Nov  7 16:31:34 2002
@@ -294,7 +294,7 @@
 	struct part_attribute * part_attr = container_of(attr,struct part_attribute,attr);
 	ssize_t ret = 0;
 	if (part_attr->show)
-		part_attr->show(p,page,count,off);
+		ret = part_attr->show(p,page,count,off);
 	return ret;
 }
 

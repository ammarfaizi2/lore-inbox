Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262585AbTDAPMK>; Tue, 1 Apr 2003 10:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262592AbTDAPMK>; Tue, 1 Apr 2003 10:12:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:40423 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262585AbTDAPMJ>; Tue, 1 Apr 2003 10:12:09 -0500
Date: Tue, 01 Apr 2003 07:22:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, colpatch@us.ibm.com
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (2.5.66-mm2) War on warnings
Message-ID: <19200000.1049210557@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/base/node.c: In function `register_node_type':
drivers/base/node.c:96: warning: suggest parentheses around assignment used as truth value
drivers/base/memblk.c: In function `register_memblk_type':
drivers/base/memblk.c:54: warning: suggest parentheses around assignment used as truth value

Bah.

--- linux-2.5.66-mm2/drivers/base/node.c	2003-04-01 06:40:02.000000000 -0800
+++ 2.5.66-mm2/drivers/base/node.c	2003-04-01 06:37:32.000000000 -0800
@@ -93,7 +93,7 @@ int __init register_node_type(void)
 {
 	int error;
 	if (!(error = devclass_register(&node_devclass)))
-		if (error = driver_register(&node_driver))
+		if ((error = driver_register(&node_driver)))
 			devclass_unregister(&node_devclass);
 	return error;
 }
--- linux-2.5.66-mm2/drivers/base/memblk.c	2003-04-01 06:40:02.000000000 -0800
+++ 2.5.66-mm2/drivers/base/memblk.c	2003-04-01 06:38:14.000000000 -0800
@@ -51,7 +51,7 @@ int __init register_memblk_type(void)
 {
 	int error;
 	if (!(error = devclass_register(&memblk_devclass)))
-		if (error = driver_register(&memblk_driver))
+		if ((error = driver_register(&memblk_driver)))
 			devclass_unregister(&memblk_devclass);
 	return error;
 }


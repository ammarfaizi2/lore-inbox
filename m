Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265677AbSKYVHG>; Mon, 25 Nov 2002 16:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbSKYVHF>; Mon, 25 Nov 2002 16:07:05 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:46238 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265677AbSKYVHD>; Mon, 25 Nov 2002 16:07:03 -0500
Message-ID: <3DE2918E.6090007@us.ibm.com>
Date: Mon, 25 Nov 2002 13:09:34 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [patch] Fix panic on multi-node / NUMA machines
Content-Type: multipart/mixed;
 boundary="------------060207040403000007080005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060207040403000007080005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	2.5.49 panics on multi-node machines because of an mistake in the order 
topology drivers/devclasses are registered with sysfs.  This patch fixes 
the problem.

Please apply.

Cheers!

-Matt


--------------060207040403000007080005
Content-Type: text/plain;
 name="topo_ordering-2.5.49.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="topo_ordering-2.5.49.patch"

diff -Nur linux-2.5.49-vanilla/drivers/base/memblk.c linux-2.5.49-test/drivers/base/memblk.c
--- linux-2.5.49-vanilla/drivers/base/memblk.c	Fri Nov 22 13:41:12 2002
+++ linux-2.5.49-test/drivers/base/memblk.c	Mon Nov 25 13:32:31 2002
@@ -49,7 +49,7 @@
 
 static int __init register_memblk_type(void)
 {
-	driver_register(&memblk_driver);
-	return devclass_register(&memblk_devclass);
+	devclass_register(&memblk_devclass);
+	return driver_register(&memblk_driver);
 }
 postcore_initcall(register_memblk_type);
diff -Nur linux-2.5.49-vanilla/drivers/base/node.c linux-2.5.49-test/drivers/base/node.c
--- linux-2.5.49-vanilla/drivers/base/node.c	Fri Nov 22 13:40:21 2002
+++ linux-2.5.49-test/drivers/base/node.c	Mon Nov 25 13:32:04 2002
@@ -93,7 +93,7 @@
 
 static int __init register_node_type(void)
 {
-	driver_register(&node_driver);
-	return devclass_register(&node_devclass);
+	devclass_register(&node_devclass);
+	return driver_register(&node_driver);
 }
 postcore_initcall(register_node_type);

--------------060207040403000007080005--


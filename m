Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbSLLAjB>; Wed, 11 Dec 2002 19:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267386AbSLLAjB>; Wed, 11 Dec 2002 19:39:01 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63930 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267385AbSLLAjA>;
	Wed, 11 Dec 2002 19:39:00 -0500
Message-ID: <3DF7DB11.7060403@us.ibm.com>
Date: Wed, 11 Dec 2002 16:40:49 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Linux 2.5.51
References: <Pine.LNX.4.44.0212091912180.17200-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010606040907060000030901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010606040907060000030901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	This patch (from wli & myself) was overlooked for 2.5.51.  Without this 
fix, sysfs panics when registering topology for NUMA boxen.  Please add 
this to your bk tree.

[mcd@arrakis push]$ diffstat topo_ordering-2.5.51.patch
  memblk.c |    4 ++--
  node.c   |    4 ++--
  2 files changed, 4 insertions(+), 4 deletions(-)

Cheers!

-Matt

--------------010606040907060000030901
Content-Type: text/plain;
 name="topo_ordering-2.5.51.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="topo_ordering-2.5.51.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.51-vanilla/drivers/base/memblk.c linux-2.5.51-topo_ordering/drivers/base/memblk.c
--- linux-2.5.51-vanilla/drivers/base/memblk.c	Mon Dec  9 18:46:26 2002
+++ linux-2.5.51-topo_ordering/drivers/base/memblk.c	Wed Dec 11 16:36:31 2002
@@ -49,7 +49,7 @@
 
 static int __init register_memblk_type(void)
 {
-	driver_register(&memblk_driver);
-	return devclass_register(&memblk_devclass);
+	int error = devclass_register(&memblk_devclass);
+	return error ? error : driver_register(&memblk_driver);
 }
 postcore_initcall(register_memblk_type);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.51-vanilla/drivers/base/node.c linux-2.5.51-topo_ordering/drivers/base/node.c
--- linux-2.5.51-vanilla/drivers/base/node.c	Mon Dec  9 18:45:44 2002
+++ linux-2.5.51-topo_ordering/drivers/base/node.c	Wed Dec 11 16:36:06 2002
@@ -93,7 +93,7 @@
 
 static int __init register_node_type(void)
 {
-	devclass_register(&node_devclass);
-	return driver_register(&node_driver);
+	int error = devclass_register(&node_devclass);
+	return error ? error : driver_register(&node_driver);
 }
 postcore_initcall(register_node_type);

--------------010606040907060000030901--


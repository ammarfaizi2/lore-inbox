Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263743AbTCUSkn>; Fri, 21 Mar 2003 13:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263754AbTCUSj2>; Fri, 21 Mar 2003 13:39:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12676
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263758AbTCUSjV>; Fri, 21 Mar 2003 13:39:21 -0500
Date: Fri, 21 Mar 2003 19:54:36 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211954.h2LJsas0026115@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Fix ufs memory leak
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/ufs/util.c linux-2.5.65-ac2/fs/ufs/util.c
--- linux-2.5.65/fs/ufs/util.c	2003-02-10 18:38:28.000000000 +0000
+++ linux-2.5.65-ac2/fs/ufs/util.c	2003-03-14 00:58:04.000000000 +0000
@@ -48,6 +48,7 @@
 failed:
 	for (j = 0; j < i; j++)
 		brelse (ubh->bh[j]);
+	kfree(ubh);
 	return NULL;
 }
 

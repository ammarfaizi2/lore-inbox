Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279097AbRJ2KN1>; Mon, 29 Oct 2001 05:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279103AbRJ2KNR>; Mon, 29 Oct 2001 05:13:17 -0500
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:4784 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S279097AbRJ2KNF>; Mon, 29 Oct 2001 05:13:05 -0500
Date: Mon, 29 Oct 2001 15:43:31 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: <linux-kernel@vger.kernel.org>, <linware@sh.cvut.cz>,
        <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] small compile warning fix 
Message-ID: <Pine.GSO.4.33.0110291542310.198-100000@cbin2-view1.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ncplib_kernel.c defines ncp_add_mem_fromfs() but never
uses it, resulting in a compile warning. Here are the
diffs ...

thanks
Manik

Index: ncplib_kernel.c
===================================================================
RCS file: /vger/linux/fs/ncpfs/ncplib_kernel.c,v
retrieving revision 1.29
diff -u -r1.29 ncplib_kernel.c
--- ncplib_kernel.c	18 Sep 2001 22:29:08 -0000	1.29
+++ ncplib_kernel.c	29 Oct 2001 10:09:27 -0000
@@ -52,6 +52,11 @@
 	return;
 }

+#ifdef LATER
+/*
+ * This function is not currently in use. This leads to a compiler warning.
+ * Remove #ifdef when in use...
+ */
 static void ncp_add_mem_fromfs(struct ncp_server *server, const char *source, int size)
 {
 	assert_server_locked(server);
@@ -59,6 +64,7 @@
 	server->current_size += size;
 	return;
 }
+#endif

 static void ncp_add_pstring(struct ncp_server *server, const char *s)
 {


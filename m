Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945912AbWANAlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945912AbWANAlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945905AbWANAlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:41:31 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:15022 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1423248AbWANAlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:41:16 -0500
Message-Id: <20060114004037.119248000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:52 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] fuse: handle error INIT reply
Content-Disposition: inline; filename=fuse_init_reply_error.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the case when the INIT request is answered with an error.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-13 22:51:48.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-13 22:51:53.000000000 +0100
@@ -153,7 +153,7 @@ static void process_init_reply(struct fu
 	int i;
 	struct fuse_init_out *arg = &req->misc.init_out;
 
-	if (arg->major != FUSE_KERNEL_VERSION)
+	if (req->out.h.error || arg->major != FUSE_KERNEL_VERSION)
 		fc->conn_error = 1;
 	else {
 		fc->minor = arg->minor;

--

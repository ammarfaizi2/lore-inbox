Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265095AbUF1RiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265095AbUF1RiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 13:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUF1RiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 13:38:12 -0400
Received: from p5080B93F.dip.t-dialin.net ([80.128.185.63]:42400 "EHLO
	fb04206.mathematik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S265095AbUF1RiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 13:38:11 -0400
To: linux-kernel@vger.kernel.org
From: Andre Noll <noll@mathematik.tu-darmstadt.de>
Subject: nfsroot oops 2.6.7-current
Organization: not organized at all
Message-ID: <slrnce0lrs.tq5.noll@p133.mathematik.tu-darmstadt.de>
User-Agent: slrn/0.9.8.0 (Linux)
NNTP-Posting-Host: 192.168.0.1
Date: Mon, 28 Jun 2004 17:38:04 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Al's current changes to struct nameidata broke nfsroot for my discless
clients (oops in nfs_fill_super).  The patch below fixes this problem
for me.

Andre

diff -u -r1.19 rpc_pipe.c
--- linux-2.5/net/sunrpc/rpc_pipe.c	31 May 2004 03:06:56 -0000	1.19
+++ linux-2.5/net/sunrpc/rpc_pipe.c	28 Jun 2004 17:10:51 -0000
@@ -433,6 +433,7 @@
 	nd->dentry = dget(rpc_mount->mnt_root);
 	nd->last_type = LAST_ROOT;
 	nd->flags = LOOKUP_PARENT;
+	nd->depth = 0;
 
 	if (path_walk(path, nd)) {
 		printk(KERN_WARNING "%s: %s failed to find path %s\n",
-- 
Andre Noll, http://www.mathematik.tu-darmstadt.de/~noll


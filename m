Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUJCSEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUJCSEf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUJCSEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:04:35 -0400
Received: from [145.85.127.2] ([145.85.127.2]:55973 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S268039AbUJCSEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:04:33 -0400
Message-ID: <56986.217.121.83.210.1096826639.squirrel@217.121.83.210>
Date: Sun, 3 Oct 2004 20:03:58 +0200 (CEST)
Subject: [Patch] nfsd: Insecure port warning shows decimal IPv4 address
From: "Ed Schouten" <ed@il.fontys.nl>
To: linux-kernel@vger.kernel.org
Cc: torvalds@ppc970.osdl.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Made a quick patch that changes dmesg(8) output to show IPv4 addresses in
decimal form instead of hexadecimal when you receive an insecure port
warning.
---

 nfsfh.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.9-rc3/fs/nfsd/nfsfh.c	2004-09-30 05:04:26.000000000 +0200
+++ linux-2.6.9-rc3-xbox/fs/nfsd/nfsfh.c	2004-10-03 19:29:39.711659000 +0200
@@ -153,8 +153,11 @@
 		error = nfserr_perm;
 		if (!rqstp->rq_secure && EX_SECURE(exp)) {
 			printk(KERN_WARNING
-			       "nfsd: request from insecure port (%08x:%d)!\n",
-			       ntohl(rqstp->rq_addr.sin_addr.s_addr),
+			       "nfsd: request from insecure port (%d.%d.%d.%d:%d)!\n",
+			       (unsigned char)(ntohl(rqstp->rq_addr.sin_addr.s_addr) >> 24),
+			       (unsigned char)(ntohl(rqstp->rq_addr.sin_addr.s_addr) >> 16),
+			       (unsigned char)(ntohl(rqstp->rq_addr.sin_addr.s_addr) >> 8),
+			       (unsigned char)(ntohl(rqstp->rq_addr.sin_addr.s_addr)),
 			       ntohs(rqstp->rq_addr.sin_port));
 			goto out;
 		}

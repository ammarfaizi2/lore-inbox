Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUJCWtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUJCWtc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 18:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268207AbUJCWtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 18:49:32 -0400
Received: from [145.85.127.2] ([145.85.127.2]:2242 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S268206AbUJCWta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 18:49:30 -0400
Message-ID: <59409.217.121.83.210.1096843766.squirrel@217.121.83.210>
In-Reply-To: <Pine.LNX.4.10.10410031203240.7525-100000@netwinder.perches.com>
References: <56986.217.121.83.210.1096826639.squirrel@217.121.83.210>
    <Pine.LNX.4.10.10410031203240.7525-100000@netwinder.perches.com>
Date: Mon, 4 Oct 2004 00:49:26 +0200 (CEST)
Subject: Re: [Patch] nfsd: Insecure port warning shows decimal IPv4 address
From: "Ed Schouten" <ed@il.fontys.nl>
To: linux-kernel@vger.kernel.org
Cc: "Joe Perches" <joe@perches.com>, akpm@osdl.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, October 3, 2004 9:12 pm, Joe Perches said:
> There may be a couple of places where this could be done in fs/nfsd

True. After a quick look, I found another spot in nfsproc.c. Here's a new
patch, using the NIPQUAD macro.
---

 nfsfh.c   |    4 ++--
 nfsproc.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -u -r linux-2.6.9-rc3/fs/nfsd/nfsfh.c
linux-2.6.9-rc3-xbox/fs/nfsd/nfsfh.c
--- linux-2.6.9-rc3/fs/nfsd/nfsfh.c	2004-09-30 05:04:26.000000000 +0200
+++ linux-2.6.9-rc3-xbox/fs/nfsd/nfsfh.c	2004-10-04 00:45:16.926659000 +0200
@@ -153,8 +153,8 @@
 		error = nfserr_perm;
 		if (!rqstp->rq_secure && EX_SECURE(exp)) {
 			printk(KERN_WARNING
-			       "nfsd: request from insecure port (%08x:%d)!\n",
-			       ntohl(rqstp->rq_addr.sin_addr.s_addr),
+			       "nfsd: request from insecure port (%u.%u.%u.%u:%d)!\n",
+			       NIPQUAD(rqstp->rq_addr.sin_addr.s_addr),
 			       ntohs(rqstp->rq_addr.sin_port));
 			goto out;
 		}
diff -u -r linux-2.6.9-rc3/fs/nfsd/nfsproc.c
linux-2.6.9-rc3-xbox/fs/nfsd/nfsproc.c
--- linux-2.6.9-rc3/fs/nfsd/nfsproc.c	2004-09-30 05:04:25.000000000 +0200
+++ linux-2.6.9-rc3-xbox/fs/nfsd/nfsproc.c	2004-10-04 00:44:58.225659000
+0200
@@ -128,8 +128,8 @@

 	if (NFSSVC_MAXBLKSIZE < argp->count) {
 		printk(KERN_NOTICE
-			"oversized read request from %08x:%d (%d bytes)\n",
-				ntohl(rqstp->rq_addr.sin_addr.s_addr),
+			"oversized read request from %u.%u.%u.%u:%d (%d bytes)\n",
+				NIPQUAD(rqstp->rq_addr.sin_addr.s_addr),
 				ntohs(rqstp->rq_addr.sin_port),
 				argp->count);
 		argp->count = NFSSVC_MAXBLKSIZE;

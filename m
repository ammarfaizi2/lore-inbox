Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbUB0U7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbUB0U6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:58:16 -0500
Received: from verein.lst.de ([212.34.189.10]:58832 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263109AbUB0U4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:56:44 -0500
Date: Fri, 27 Feb 2004 21:56:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill a dead function in lockd
Message-ID: <20040227205623.GA20398@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, trond.myklebust@fys.uio.no,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sleep_on hurts my eyes and this offender is compltely unused, so..


--- 1.8/fs/lockd/clntproc.c	Fri Feb  7 21:25:20 2003
+++ edited/fs/lockd/clntproc.c	Fri Feb 27 22:35:15 2004
@@ -195,19 +195,6 @@
 }
 
 /*
- * Wait while server is in grace period
- */
-static inline int
-nlmclnt_grace_wait(struct nlm_host *host)
-{
-	if (!host->h_reclaiming)
-		interruptible_sleep_on_timeout(&host->h_gracewait, 10*HZ);
-	else
-		interruptible_sleep_on(&host->h_gracewait);
-	return signalled()? -ERESTARTSYS : 0;
-}
-
-/*
  * Allocate an NLM RPC call struct
  */
 struct nlm_rqst *

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269018AbUIHNZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269018AbUIHNZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUIHNWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:22:45 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:53682 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S268328AbUIHNSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:18:03 -0400
Date: Wed, 8 Sep 2004 09:17:56 -0400
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, cherry@osdl.org
Subject: [PATCH 2.6.9-rc1] Coda - fix sparse warnings
Message-ID: <20040908131755.GA12173@delft.aura.cs.cmu.edu>
Mail-Followup-To: torvalds@osdl.org, linux-kernel@vger.kernel.org,
	cherry@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094571421.28147.20.camel@cherrybomb.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040803i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reused the coda_file_read wrapper for sendfile and accidentally left
the __user tag on the buffer. This patch should fix the sparse warnings.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>


diff -urN --exclude '*.orig' linux-2.6.9-rc1-bk7.coda_sendfile/fs/coda/file.c linux-2.6.9-rc1-bk7.coda_sendfile2/fs/coda/file.c
--- linux-2.6.9-rc1-bk7.coda_sendfile/fs/coda/file.c	2004-09-01 12:15:15.000000000 -0400
+++ linux-2.6.9-rc1-bk7.coda_sendfile2/fs/coda/file.c	2004-09-08 09:07:53.000000000 -0400
@@ -46,7 +46,7 @@
 
 static ssize_t
 coda_file_sendfile(struct file *coda_file, loff_t *ppos, size_t count,
-		   read_actor_t actor, void __user *target)
+		   read_actor_t actor, void *target)
 {
 	struct coda_file_info *cfi;
 	struct file *host_file;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWDCRW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWDCRW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWDCRW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:22:26 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:33950 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932368AbWDCRWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:22:25 -0400
Date: Mon, 3 Apr 2006 19:22:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cornelia.huck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 4/9] s390: Wrong return codes in cio_ignore_proc_init().
Message-ID: <20060403172224.GD11049@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[patch 4/9] s390: Wrong return codes in cio_ignore_proc_init().

cio_ignore_proc_init() returns 1 in case of success and 0 in case
of failure. The caller tests for != 0, so better return 0 in case of
success and -ENOENT in case of failure.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/blacklist.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2006-04-03 18:46:37.000000000 +0200
@@ -414,11 +414,11 @@ cio_ignore_proc_init (void)
 	entry = create_proc_entry ("cio_ignore", S_IFREG | S_IRUGO | S_IWUSR,
 				   &proc_root);
 	if (!entry)
-		return 0;
+		return -ENOENT;
 
 	entry->proc_fops = &cio_ignore_proc_fops;
 
-	return 1;
+	return 0;
 }
 
 __initcall (cio_ignore_proc_init);

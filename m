Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbULPIXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbULPIXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 03:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbULPIXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 03:23:11 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:18848 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261860AbULPIXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 03:23:06 -0500
Date: Thu, 16 Dec 2004 09:22:38 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Gerald Schaefer <geraldsc@de.ibm.com>
Subject: [patch 1/2] s390: z/VM monreader driver bugfix.
Message-ID: <20041216082238.GB5043@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/2] s390: z/VM monreader driver bugfix.

From: Gerald Schaefer <geraldsc@de.ibm.com>

 - Use nonseekable_open() to disable seeking and pread()/pwrite().

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 drivers/s390/char/monreader.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-2.6/drivers/s390/char/monreader.c linux-2.6-patched/drivers/s390/char/monreader.c
--- linux-2.6/drivers/s390/char/monreader.c	2004-12-16 08:52:03.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/monreader.c	2004-12-16 08:52:23.000000000 +0100
@@ -450,7 +450,7 @@
 	}
 	P_INFO("open, established connection to *MONITOR service\n\n");
 	filp->private_data = monpriv;
-	return 0;
+	return nonseekable_open(inode, filp);
 
 out_unregister:
 	iucv_unregister_program(monpriv->iucv_handle);

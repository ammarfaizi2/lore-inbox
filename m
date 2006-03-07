Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWCGHWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWCGHWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWCGHWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:22:00 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:20692 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932301AbWCGHWA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:22:00 -0500
Date: Tue, 7 Mar 2006 08:21:42 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/3] s390: iucv message limit for smsg
Message-ID: <20060307072142.GB9329@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The message limit on the iucv connect call for the smsg module is too low.
Therefore increase the smsg message limit to 255.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/net/smsgiucv.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/net/smsgiucv.c linux-2.6-patched/drivers/s390/net/smsgiucv.c
--- linux-2.6/drivers/s390/net/smsgiucv.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/smsgiucv.c	2006-03-07 07:59:25.000000000 +0100
@@ -168,7 +168,7 @@ smsg_init(void)
 		driver_unregister(&smsg_driver);
 		return -EIO;	/* better errno ? */
 	}
-	rc = iucv_connect (&smsg_pathid, 1, 0, "*MSG    ", 0, 0, 0, 0,
+	rc = iucv_connect (&smsg_pathid, 255, 0, "*MSG    ", 0, 0, 0, 0,
 			   smsg_handle, 0);
 	if (rc) {
 		printk(KERN_ERR "SMSGIUCV: failed to connect to *MSG");

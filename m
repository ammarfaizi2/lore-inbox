Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWIRMOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWIRMOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWIRMOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:14:36 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:26085 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965011AbWIRMOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:14:35 -0400
Subject: [Patch] fix: sched_clock() use in zfcp driver
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Cedric Le Goater <clg@fr.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 14:14:24 +0200
Message-Id: <1158581665.3060.60.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are not supposed to use sched_clock().
Reverting a change which wasn't meant to slip through with
statistics-infrastructure-exploitation-zfcp.patch.
It fixes zfcp, which couldn't be compiled as module (found by Cedric).
Please apply.

Signed-off-by: Martin Peschke <mp3@de.ibm.com> 
---

 zfcp_fsf.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urp a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
--- a/drivers/s390/scsi/zfcp_fsf.c	2006-09-18 09:23:08.000000000 +0200
+++ b/drivers/s390/scsi/zfcp_fsf.c	2006-09-18 12:15:13.000000000 +0200
@@ -4851,7 +4851,7 @@ zfcp_fsf_req_send(struct zfcp_fsf_req *f
 	req_queue->free_index %= QDIO_MAX_BUFFERS_PER_Q;  /* wrap if needed */
 	new_distance_from_int = zfcp_qdio_determine_pci(req_queue, fsf_req);
 
-	fsf_req->issued = sched_clock();
+	fsf_req->issued = get_clock();
 
 	retval = do_QDIO(adapter->ccw_device,
 			 QDIO_FLAG_SYNC_OUTPUT,




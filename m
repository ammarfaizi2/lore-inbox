Return-Path: <linux-kernel-owner+w=401wt.eu-S1751231AbXAIJ00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbXAIJ00 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXAIJ00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:26:26 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:46663 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbXAIJ0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:26:25 -0500
Date: Tue, 9 Jan 2007 10:26:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [S390] locking problem with __cpcmd.
Message-ID: <20070109092626.GA767@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] locking problem with __cpcmd.

Changeset 740b5706b9c4b3767f597b3ea76654c6f2a800b2 moved the protecting
spinlock from __cpcmd to cpcmd. Therefore vmcp can no longer use __cpcmd,
instead we have to use cpcmd.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmcp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/char/vmcp.c linux-2.6-patched/drivers/s390/char/vmcp.c
--- linux-2.6/drivers/s390/char/vmcp.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/vmcp.c	2007-01-09 10:08:02.000000000 +0100
@@ -117,7 +117,7 @@ vmcp_write(struct file *file, const char
 		return -ENOMEM;
 	}
 	debug_text_event(vmcp_debug, 1, cmd);
-	session->resp_size = __cpcmd(cmd, session->response,
+	session->resp_size = cpcmd(cmd, session->response,
 				     session->bufsize,
 				     &session->resp_code);
 	up(&session->mutex);

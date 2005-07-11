Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVGKQxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVGKQxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVGKQkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:40:15 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:39656 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262141AbVGKQiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:38:20 -0400
Date: Mon, 11 Jul 2005 18:38:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cborntra@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 12/12] s390: use __cpcmd in vmcp_write.
Message-ID: <20050711163819.GL10822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 12/12] s390: use __cpcmd in vmcp_write.

From: Christian Borntraeger <cborntra@de.ibm.com>

vmcp_write uses GPF_DMA for the memory allocation of the response
buffer, so it can use the low level function __cpcmd directly,
no need to call the wrapper.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/vmcp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/vmcp.c linux-2.6-patched/drivers/s390/char/vmcp.c
--- linux-2.6/drivers/s390/char/vmcp.c	2005-07-11 17:37:30.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/vmcp.c	2005-07-11 17:37:51.000000000 +0200
@@ -115,9 +115,9 @@ vmcp_write(struct file *file, const char
 		return -ENOMEM;
 	}
 	debug_text_event(vmcp_debug, 1, cmd);
-	session->resp_size = cpcmd(cmd, session->response,
-				   session->bufsize,
-				   &session->resp_code);
+	session->resp_size = __cpcmd(cmd, session->response,
+				     session->bufsize,
+				     &session->resp_code);
 	up(&session->mutex);
 	kfree(cmd);
 	*ppos = 0;		/* reset the file pointer after a command */

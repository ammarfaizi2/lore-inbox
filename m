Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWJLROJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWJLROJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWJLROJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:14:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26496 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751426AbWJLROG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:14:06 -0400
Subject: [PATCH 6/7] [DLM] fix iovec length in recvmsg
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Patrick Caulfield <pcaulfie@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 12 Oct 2006 18:19:20 +0100
Message-Id: <1160673560.11901.824.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 4c5e1b1a8c3f591b21f09001d6748296ddff33b8 Mon Sep 17 00:00:00 2001
From: Patrick Caulfield <pcaulfie@redhat.com>
Date: Thu, 12 Oct 2006 10:41:22 +0100
Subject: [DLM] fix iovec length in recvmsg

The DLM always passes the iovec length as 1, this is wrong when the circular
buffer wraps round.

Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/lowcomms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 7bcea7c..867f93d 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -548,7 +548,7 @@ static int receive_from_sock(void)
 	}
 	len = iov[0].iov_len + iov[1].iov_len;
 
-	r = ret = kernel_recvmsg(sctp_con.sock, &msg, iov, 1, len,
+	r = ret = kernel_recvmsg(sctp_con.sock, &msg, iov, msg.msg_iovlen, len,
 				 MSG_NOSIGNAL | MSG_DONTWAIT);
 	if (ret <= 0)
 		goto out_close;
-- 
1.4.1




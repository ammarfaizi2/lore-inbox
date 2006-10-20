Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWJTJJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWJTJJx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWJTJJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:09:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:909 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751687AbWJTJJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:09:52 -0400
Subject: [PATCH 1/8] [DLM] fix iovec length in recvmsg
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: Patrick Caulfield <pcaulfie@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 20 Oct 2006 10:18:04 +0100
Message-Id: <1161335884.27980.183.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 42fb00838a644d03f9a2a5fbbe0b668a5ff5df4d Mon Sep 17 00:00:00 2001
From: Patrick Caulfield <pcaulfie@redhat.com>
Date: Fri, 13 Oct 2006 17:12:05 +0100
Subject: [DLM] fix iovec length in recvmsg

I didn't spot that the msg_iovlen was set to 2 if there
were two elements in the iovec but left at zero if not :(

I think this might be why bob was still seeing trouble.

Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/lowcomms.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 867f93d..6da6b14 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -519,6 +519,7 @@ static int receive_from_sock(void)
 	msg.msg_flags = 0;
 	msg.msg_control = incmsg;
 	msg.msg_controllen = sizeof(incmsg);
+	msg.msg_iovlen = 1;
 
 	/* I don't see why this circular buffer stuff is necessary for SCTP
 	 * which is a packet-based protocol, but the whole thing breaks under
-- 
1.4.1




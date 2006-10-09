Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933004AbWJIT1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbWJIT1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932956AbWJIT1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:27:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36287 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S933004AbWJIT1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:27:31 -0400
Date: Mon, 9 Oct 2006 20:27:30 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dlm gfp_t annotations
Message-ID: <20061009192730.GU29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dlm/lowcomms.c |    6 +++---
 fs/dlm/lowcomms.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 23f5ce1..7bcea7c 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -174,7 +174,7 @@ static int nodeid_to_addr(int nodeid, st
 	return 0;
 }
 
-static struct nodeinfo *nodeid2nodeinfo(int nodeid, int alloc)
+static struct nodeinfo *nodeid2nodeinfo(int nodeid, gfp_t alloc)
 {
 	struct nodeinfo *ni;
 	int r;
@@ -726,7 +726,7 @@ static int init_sock(void)
 }
 
 
-static struct writequeue_entry *new_writequeue_entry(int allocation)
+static struct writequeue_entry *new_writequeue_entry(gfp_t allocation)
 {
 	struct writequeue_entry *entry;
 
@@ -748,7 +748,7 @@ static struct writequeue_entry *new_writ
 	return entry;
 }
 
-void *dlm_lowcomms_get_buffer(int nodeid, int len, int allocation, char **ppc)
+void *dlm_lowcomms_get_buffer(int nodeid, int len, gfp_t allocation, char **ppc)
 {
 	struct writequeue_entry *e;
 	int offset = 0;
diff --git a/fs/dlm/lowcomms.h b/fs/dlm/lowcomms.h
index 6c04bb0..2d045e0 100644
--- a/fs/dlm/lowcomms.h
+++ b/fs/dlm/lowcomms.h
@@ -19,7 +19,7 @@ void dlm_lowcomms_exit(void);
 int dlm_lowcomms_start(void);
 void dlm_lowcomms_stop(void);
 int dlm_lowcomms_close(int nodeid);
-void *dlm_lowcomms_get_buffer(int nodeid, int len, int allocation, char **ppc);
+void *dlm_lowcomms_get_buffer(int nodeid, int len, gfp_t allocation, char **ppc);
 void dlm_lowcomms_commit_buffer(void *mh);
 
 #endif				/* __LOWCOMMS_DOT_H__ */
-- 
1.4.2.GIT


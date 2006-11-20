Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933895AbWKTC1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933895AbWKTC1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933884AbWKTCYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:24:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43537 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933877AbWKTCYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:24:05 -0500
Date: Mon, 20 Nov 2006 03:24:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, swhiteho@redhat.com
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [-mm patch] fs/dlm/lowcomms-tcp.c: remove 2 functions
Message-ID: <20061120022404.GL31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-gfs2-nmw.patch
>...
>  git trees
>...

This patch removes the following unused functions:
- lowcomms_send_message()
- lowcomms_max_buffer_size()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/dlm/lowcomms-tcp.c |   24 ------------------------
 1 file changed, 24 deletions(-)

--- linux-2.6.19-rc5-mm2/fs/dlm/lowcomms-tcp.c.old	2006-11-20 01:16:31.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/dlm/lowcomms-tcp.c	2006-11-20 01:17:22.000000000 +0100
@@ -913,22 +913,6 @@
 	return -1;
 }
 
-/* API send message call, may queue the request */
-/* N.B. This is the old interface - use the new one for new calls */
-int lowcomms_send_message(int nodeid, char *buf, int len, gfp_t allocation)
-{
-	struct writequeue_entry *e;
-	char *b;
-
-	e = dlm_lowcomms_get_buffer(nodeid, len, allocation, &b);
-	if (e) {
-		memcpy(b, buf, len);
-		dlm_lowcomms_commit_buffer(e);
-		return 0;
-	}
-	return -ENOBUFS;
-}
-
 /* Look for activity on active sockets */
 static void process_sockets(void)
 {
@@ -1129,14 +1113,6 @@
 	return 0;
 }
 
-/*
- * Return the largest buffer size we can cope with.
- */
-int lowcomms_max_buffer_size(void)
-{
-	return PAGE_CACHE_SIZE;
-}
-
 void dlm_lowcomms_stop(void)
 {
 	int i;


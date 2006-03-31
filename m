Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWCaV0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWCaV0A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 16:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWCaVZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 16:25:59 -0500
Received: from hera.kernel.org ([140.211.167.34]:8424 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750812AbWCaVZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 16:25:59 -0500
Date: Fri, 31 Mar 2006 21:25:49 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603312125.k2VLPnX0003602@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] 9p: cleanup unused functions
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From nobody Mon Sep 17 00:00:00 2001
From: Eric Van Hensbergen <ericvh@gmail.com>
Date: Fri Mar 31 15:20:06 2006 -0600
Subject: [PATCH] 9p: remove unused functions

This patch just removes some unused functions that were previously

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/conv.c  |   26 --------------------------
 fs/9p/fcall.c |   25 -------------------------
 fs/9p/mux.c   |   26 --------------------------
 3 files changed, 0 insertions(+), 77 deletions(-)

6b9742bbf5beb884dd9a1f285d04da8b14c6a09d
diff --git a/fs/9p/conv.c b/fs/9p/conv.c
index a767e05..63311ef 100644
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -535,32 +535,6 @@ struct v9fs_fcall *v9fs_create_tversion(
 	return fc;
 }
 
-#if 0
-struct v9fs_fcall *v9fs_create_tauth(u32 afid, char *uname, char *aname)
-{
-	int size;
-	struct v9fs_fcall *fc;
-	struct cbuf buffer;
-	struct cbuf *bufp = &buffer;
-
-	size = 4 + 2 + strlen(uname) + 2 + strlen(aname);	/* afid[4] uname[s] aname[s] */
-	fc = v9fs_create_common(bufp, size, TAUTH);
-	if (IS_ERR(fc))
-		goto error;
-
-	v9fs_put_int32(bufp, afid, &fc->params.tauth.afid);
-	v9fs_put_str(bufp, uname, &fc->params.tauth.uname);
-	v9fs_put_str(bufp, aname, &fc->params.tauth.aname);
-
-	if (buf_check_overflow(bufp)) {
-		kfree(fc);
-		fc = ERR_PTR(-ENOMEM);
-	}
-      error:
-	return fc;
-}
-#endif  /*  0  */
-
 struct v9fs_fcall *
 v9fs_create_tattach(u32 fid, u32 afid, char *uname, char *aname)
 {
diff --git a/fs/9p/fcall.c b/fs/9p/fcall.c
index 71742ba..d78cb77 100644
--- a/fs/9p/fcall.c
+++ b/fs/9p/fcall.c
@@ -147,31 +147,6 @@ v9fs_t_clunk(struct v9fs_session_info *v
 	return ret;
 }
 
-#if 0
-/**
- * v9fs_v9fs_t_flush - flush a pending transaction
- * @v9ses: 9P2000 session information
- * @tag: tag to release
- *
- */
-int v9fs_t_flush(struct v9fs_session_info *v9ses, u16 oldtag)
-{
-	int ret;
-	struct v9fs_fcall *tc;
-
-	dprintk(DEBUG_9P, "oldtag %d\n", oldtag);
-
-	tc = v9fs_create_tflush(oldtag);
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, NULL);
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-#endif
-
 /**
  * v9fs_t_stat - read a file's meta-data
  * @v9ses: 9P2000 session information
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index 3e5b124..a06eb6f 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -915,32 +915,6 @@ v9fs_mux_rpc(struct v9fs_mux_data *m, st
 	return err;
 }
 
-#if 0
-/**
- * v9fs_mux_rpcnb - sends 9P request without waiting for response.
- * @m: mux data
- * @tc: request to be sent
- * @cb: callback function to be called when response arrives
- * @cba: value to pass to the callback function
- */
-int v9fs_mux_rpcnb(struct v9fs_mux_data *m, struct v9fs_fcall *tc,
-		   v9fs_mux_req_callback cb, void *a)
-{
-	int err;
-	struct v9fs_req *req;
-
-	req = v9fs_send_request(m, tc, cb, a);
-	if (IS_ERR(req)) {
-		err = PTR_ERR(req);
-		dprintk(DEBUG_MUX, "error %d\n", err);
-		return PTR_ERR(req);
-	}
-
-	dprintk(DEBUG_MUX, "mux %p tc %p tag %d\n", m, tc, req->tag);
-	return 0;
-}
-#endif  /*  0  */
-
 /**
  * v9fs_mux_cancel - cancel all pending requests with error
  * @m: mux data
-- 
1.2.4.gb0a3de4


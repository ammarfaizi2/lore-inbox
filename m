Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWAUAbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWAUAbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWAUAbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:31:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11283 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932310AbWAUAbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:31:04 -0500
Date: Sat, 21 Jan 2006 01:31:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ericvh@gmail.com, rminnich@lanl.gov, lucho@ionkov.net
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/9p/: possible cleanups
Message-ID: <20060121003103.GG31803@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- mux.c: v9fs_poll_mux() was inline but not static resuling in needless
         object size bloat
- mux.c: remove all "inline"s: gcc should know best what to inline
- #if 0 the following unused global functions:
  - 9p.c: v9fs_v9fs_t_flush()
  - conv.c: v9fs_create_tauth()
  - mux.c: v9fs_mux_rpcnb()


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/9p/9p.c   |    2 ++
 fs/9p/9p.h   |    2 --
 fs/9p/conv.c |    2 ++
 fs/9p/conv.h |    1 -
 fs/9p/mux.c  |   11 ++++++-----
 fs/9p/mux.h  |    2 --
 6 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.16-rc1-mm2-full/fs/9p/9p.h.old	2006-01-21 00:48:21.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/9p/9p.h	2006-01-21 00:48:30.000000000 +0100
@@ -348,8 +348,6 @@
 
 int v9fs_t_clunk(struct v9fs_session_info *v9ses, u32 fid);
 
-int v9fs_t_flush(struct v9fs_session_info *v9ses, u16 oldtag);
-
 int v9fs_t_stat(struct v9fs_session_info *v9ses, u32 fid,
 		struct v9fs_fcall **rcall);
 
--- linux-2.6.16-rc1-mm2-full/fs/9p/9p.c.old	2006-01-21 00:48:45.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/9p/9p.c	2006-01-21 01:14:14.000000000 +0100
@@ -149,6 +149,7 @@
 	return ret;
 }
 
+#if 0
 /**
  * v9fs_v9fs_t_flush - flush a pending transaction
  * @v9ses: 9P2000 session information
@@ -172,6 +173,7 @@
 
 	return ret;
 }
+#endif  /*  0  */
 
 /**
  * v9fs_t_stat - read a file's meta-data
--- linux-2.6.16-rc1-mm2-full/fs/9p/conv.h.old	2006-01-21 00:49:23.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/9p/conv.h	2006-01-21 00:49:31.000000000 +0100
@@ -33,7 +33,6 @@
 void v9fs_set_tag(struct v9fs_fcall *fc, u16 tag);
 
 struct v9fs_fcall *v9fs_create_tversion(u32 msize, char *version);
-struct v9fs_fcall *v9fs_create_tauth(u32 afid, char *uname, char *aname);
 struct v9fs_fcall *v9fs_create_tattach(u32 fid, u32 afid, char *uname,
 	char *aname);
 struct v9fs_fcall *v9fs_create_tflush(u16 oldtag);
--- linux-2.6.16-rc1-mm2-full/fs/9p/conv.c.old	2006-01-21 00:49:44.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/9p/conv.c	2006-01-21 00:49:59.000000000 +0100
@@ -526,6 +526,7 @@
 	return fc;
 }
 
+#if 0
 struct v9fs_fcall *v9fs_create_tauth(u32 afid, char *uname, char *aname)
 {
 	int size;
@@ -549,6 +550,7 @@
       error:
 	return fc;
 }
+#endif  /*  0  */
 
 struct v9fs_fcall *
 v9fs_create_tattach(u32 fid, u32 afid, char *uname, char *aname)
--- linux-2.6.16-rc1-mm2-full/fs/9p/mux.h.old	2006-01-21 00:50:58.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/9p/mux.h	2006-01-21 00:51:03.000000000 +0100
@@ -50,8 +50,6 @@
 int v9fs_mux_send(struct v9fs_mux_data *m, struct v9fs_fcall *tc);
 struct v9fs_fcall *v9fs_mux_recv(struct v9fs_mux_data *m);
 int v9fs_mux_rpc(struct v9fs_mux_data *m, struct v9fs_fcall *tc, struct v9fs_fcall **rc);
-int v9fs_mux_rpcnb(struct v9fs_mux_data *m, struct v9fs_fcall *tc,
-	v9fs_mux_req_callback cb, void *a);
 
 void v9fs_mux_flush(struct v9fs_mux_data *m, int sendflush);
 void v9fs_mux_cancel(struct v9fs_mux_data *m, int err);
--- linux-2.6.16-rc1-mm2-full/fs/9p/mux.c.old	2006-01-21 00:50:13.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/9p/mux.c	2006-01-21 00:52:11.000000000 +0100
@@ -143,7 +143,7 @@
  *
  * The current implementation returns sqrt of the number of mounts.
  */
-inline int v9fs_mux_calc_poll_procs(int muxnum)
+static int v9fs_mux_calc_poll_procs(int muxnum)
 {
 	int n;
 
@@ -384,7 +384,7 @@
 /**
  * v9fs_poll_mux - polls a mux and schedules read or write works if necessary
  */
-static inline void v9fs_poll_mux(struct v9fs_mux_data *m)
+static void v9fs_poll_mux(struct v9fs_mux_data *m)
 {
 	int n;
 
@@ -756,9 +756,8 @@
 	return req;
 }
 
-static inline void
-v9fs_mux_flush_cb(void *a, struct v9fs_fcall *tc, struct v9fs_fcall *rc,
-		  int err)
+static void v9fs_mux_flush_cb(void *a, struct v9fs_fcall *tc,
+			      struct v9fs_fcall *rc, int err)
 {
 	v9fs_mux_req_callback cb;
 	int tag;
@@ -895,6 +894,7 @@
 	return err;
 }
 
+#if 0
 /**
  * v9fs_mux_rpcnb - sends 9P request without waiting for response.
  * @m: mux data
@@ -918,6 +918,7 @@
 	dprintk(DEBUG_MUX, "mux %p tc %p tag %d\n", m, tc, req->tag);
 	return 0;
 }
+#endif  /*  0  */
 
 /**
  * v9fs_mux_cancel - cancel all pending requests with error


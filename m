Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271169AbTGPWOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271168AbTGPWO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:14:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:5034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271161AbTGPWMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:12:42 -0400
Date: Wed, 16 Jul 2003 15:27:33 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: zanussi@us.ibm.com
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, bob@watson.ibm.com
Subject: Re: [PATCH] relay_open const filename
Message-Id: <20030716152733.3a9a1d02.shemminger@osdl.org>
In-Reply-To: <20030716145508.1742d722.shemminger@osdl.org>
References: <16148.6807.578262.720332@gargle.gargle.HOWL>
	<20030716145508.1742d722.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since relay_open takes a pathname, it should be "const char *".

diff -Nru a/fs/relayfs/relay.c b/fs/relayfs/relay.c
--- a/fs/relayfs/relay.c	Wed Jul 16 15:23:36 2003
+++ b/fs/relayfs/relay.c	Wed Jul 16 15:23:36 2003
@@ -660,7 +660,7 @@
  *	locking scheme can use buffers of any size, but is hardcoded at 2.
  */
 static struct rchan *
-rchan_create(char *chanpath, 
+rchan_create(const char *chanpath, 
 	     int bufsize_lockless, 
 	     int nbufs_lockless, 
 	     int bufsize_locking,
@@ -829,11 +829,11 @@
  *	to create the file.
  */
 static int 
-rchan_create_dir(char * chanpath, 
-		 char **residual, 
+rchan_create_dir(const char * chanpath, 
+		 const char **residual, 
 		 struct dentry **topdir)
 {
-	char *cp = chanpath, *next;
+	const char *cp = chanpath, *next;
 	struct dentry *parent = NULL;
 	int len, err = 0;
 	
@@ -867,12 +867,12 @@
  *	Returns 0 if successful, negative otherwise.
  */
 static int 
-rchan_create_file(char * chanpath, 
+rchan_create_file(const char * chanpath, 
 		  struct dentry **dentry, 
 		  struct rchan * data)
 {
 	int err;
-	char * fname;
+	const char * fname;
 	struct dentry *topdir;
 
 	err = rchan_create_dir(chanpath, &fname, &topdir);
@@ -1239,7 +1239,7 @@
  *	cause the channel to wrap around continuously.
  */
 int 
-relay_open(char *chanpath,
+relay_open(const char *chanpath,
 	   int bufsize_lockless,
 	   int nbufs_lockless,
 	   int bufsize_locking,
@@ -1556,7 +1556,7 @@
 	int err = 0;
 	int try_bufcount, cur_bufno = 0, include_nbufs = 1;
 	u32 cur_idx, buf_size;
-	size_t avail_count, avail_in_buf;
+	size_t avail_count = 0, avail_in_buf;
 	int unused_bytes = 0;
 
 	if (rchan->bufs_produced < rchan->n_bufs)
diff -Nru a/include/linux/relayfs_fs.h b/include/linux/relayfs_fs.h
--- a/include/linux/relayfs_fs.h	Wed Jul 16 15:23:36 2003
+++ b/include/linux/relayfs_fs.h	Wed Jul 16 15:23:36 2003
@@ -531,7 +531,7 @@
  * High-level relayfs kernel API, fs/relayfs/relay.c
  */
 extern int
-relay_open(char *chanpath,
+relay_open(const char *chanpath,
 	   int bufsize_lockless,
 	   int nbufs_lockless,
 	   int bufsize_locking,

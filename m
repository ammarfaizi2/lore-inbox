Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWFBTx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWFBTx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWFBTx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:53:28 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:49104 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751463AbWFBTx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:53:26 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 21:51:54 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 05/18] raw1394: fix whitespace after x86_64
 compat patch
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
Message-ID: <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.36) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/raw1394.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/raw1394.c	2006-06-01 20:55:05.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/raw1394.c	2006-06-01 20:55:41.000000000 +0200
@@ -407,34 +407,34 @@ static void fcp_request(struct hpsb_host
 
 #ifdef CONFIG_COMPAT
 struct compat_raw1394_req {
-        __u32 type;
-        __s32 error;
-        __u32 misc;
+	__u32 type;
+	__s32 error;
+	__u32 misc;
 
-        __u32 generation;
-        __u32 length;
+	__u32 generation;
+	__u32 length;
 
-        __u64 address;
+	__u64 address;
 
-        __u64 tag;
+	__u64 tag;
 
-        __u64 sendb;
-        __u64 recvb;
-}  __attribute__((packed));
+	__u64 sendb;
+	__u64 recvb;
+} __attribute__((packed));
 
 static const char __user *raw1394_compat_write(const char __user *buf)
 {
-	struct compat_raw1394_req __user *cr = (typeof(cr)) buf; 
+	struct compat_raw1394_req __user *cr = (typeof(cr)) buf;
 	struct raw1394_request __user *r;
 	r = compat_alloc_user_space(sizeof(struct raw1394_request));
 
 #define C(x) __copy_in_user(&r->x, &cr->x, sizeof(r->x))
 
 	if (copy_in_user(r, cr, sizeof(struct compat_raw1394_req)) ||
-		C(address) ||
-		C(tag) ||
-		C(sendb) ||
-		C(recvb))
+	    C(address) ||
+	    C(tag) ||
+	    C(sendb) ||
+	    C(recvb))
 		return ERR_PTR(-EFAULT);
 	return (const char __user *)r;
 }
@@ -442,11 +442,11 @@ static const char __user *raw1394_compat
 
 #define P(x) __put_user(r->x, &cr->x)
 
-static int 
+static int
 raw1394_compat_read(const char __user *buf, struct raw1394_request *r)
 {
-	struct compat_raw1394_req __user *cr = (typeof(cr)) r; 
-	if (!access_ok(VERIFY_WRITE,cr,sizeof(struct compat_raw1394_req)) ||
+	struct compat_raw1394_req __user *cr = (typeof(cr)) r;
+	if (!access_ok(VERIFY_WRITE, cr, sizeof(struct compat_raw1394_req)) ||
 	    P(type) ||
 	    P(error) ||
 	    P(misc) ||
@@ -511,18 +511,17 @@ static ssize_t raw1394_read(struct file 
 	}
 
 #ifdef CONFIG_COMPAT
-	if (count == sizeof(struct compat_raw1394_req) && 
-   		sizeof(struct compat_raw1394_req) != 
-			sizeof(struct raw1394_request)) { 
+	if (count == sizeof(struct compat_raw1394_req) &&
+   	    sizeof(struct compat_raw1394_req) !=
+			sizeof(struct raw1394_request)) {
 		ret = raw1394_compat_read(buffer, &req->req);
-
-	} else	
+	} else
 #endif
 	{
 		if (copy_to_user(buffer, &req->req, sizeof(req->req))) {
 			ret = -EFAULT;
 			goto out;
-		}		
+		}
 		ret = (ssize_t) sizeof(struct raw1394_request);
 	}
       out:
@@ -2347,7 +2346,6 @@ static int state_connected(struct file_i
 	return handle_async_request(fi, req, node);
 }
 
-
 static ssize_t raw1394_write(struct file *file, const char __user * buffer,
 			     size_t count, loff_t * offset_is_ignored)
 {
@@ -2356,9 +2354,9 @@ static ssize_t raw1394_write(struct file
 	ssize_t retval = 0;
 
 #ifdef CONFIG_COMPAT
-	if (count == sizeof(struct compat_raw1394_req) && 
-   		sizeof(struct compat_raw1394_req) != 
-			sizeof(struct raw1394_request)) { 
+	if (count == sizeof(struct compat_raw1394_req) &&
+   	    sizeof(struct compat_raw1394_req) !=
+			sizeof(struct raw1394_request)) {
 		buffer = raw1394_compat_write(buffer);
 		if (IS_ERR(buffer))
 			return PTR_ERR(buffer);



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVLVExz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVLVExz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVLVExx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:53:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37328 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965097AbVLVEvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:35 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 30/36] m68k: dsp56k __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQQ-0004tS-O5@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011826 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/char/dsp56k.c     |   29 +++++++++++++++--------------
 include/asm-m68k/dsp56k.h |    2 +-
 2 files changed, 16 insertions(+), 15 deletions(-)

cc2dffe59c29c37f89c0affaf31cd7ca2aef4159
diff --git a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
index 8693835..e233cf2 100644
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -165,7 +165,7 @@ static int dsp56k_reset(void)
 	return 0;
 }
 
-static int dsp56k_upload(u_char *bin, int len)
+static int dsp56k_upload(u_char __user *bin, int len)
 {
 	int i;
 	u_char *p;
@@ -199,7 +199,7 @@ static int dsp56k_upload(u_char *bin, in
 	return 0;
 }
 
-static ssize_t dsp56k_read(struct file *file, char *buf, size_t count,
+static ssize_t dsp56k_read(struct file *file, char __user *buf, size_t count,
 			   loff_t *ppos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -225,10 +225,10 @@ static ssize_t dsp56k_read(struct file *
 		}
 		case 2:  /* 16 bit */
 		{
-			short *data;
+			short __user *data;
 
 			count /= 2;
-			data = (short*) buf;
+			data = (short __user *) buf;
 			handshake(count, dsp56k.maxio, dsp56k.timeout, DSP56K_RECEIVE,
 				  put_user(dsp56k_host_interface.data.w[1], data+n++));
 			return 2*n;
@@ -244,10 +244,10 @@ static ssize_t dsp56k_read(struct file *
 		}
 		case 4:  /* 32 bit */
 		{
-			long *data;
+			long __user *data;
 
 			count /= 4;
-			data = (long*) buf;
+			data = (long __user *) buf;
 			handshake(count, dsp56k.maxio, dsp56k.timeout, DSP56K_RECEIVE,
 				  put_user(dsp56k_host_interface.data.l, data+n++));
 			return 4*n;
@@ -262,7 +262,7 @@ static ssize_t dsp56k_read(struct file *
 	}
 }
 
-static ssize_t dsp56k_write(struct file *file, const char *buf, size_t count,
+static ssize_t dsp56k_write(struct file *file, const char __user *buf, size_t count,
 			    loff_t *ppos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -287,10 +287,10 @@ static ssize_t dsp56k_write(struct file 
 		}
 		case 2:  /* 16 bit */
 		{
-			const short *data;
+			const short __user *data;
 
 			count /= 2;
-			data = (const short *)buf;
+			data = (const short __user *)buf;
 			handshake(count, dsp56k.maxio, dsp56k.timeout, DSP56K_TRANSMIT,
 				  get_user(dsp56k_host_interface.data.w[1], data+n++));
 			return 2*n;
@@ -306,10 +306,10 @@ static ssize_t dsp56k_write(struct file 
 		}
 		case 4:  /* 32 bit */
 		{
-			const long *data;
+			const long __user *data;
 
 			count /= 4;
-			data = (const long *)buf;
+			data = (const long __user *)buf;
 			handshake(count, dsp56k.maxio, dsp56k.timeout, DSP56K_TRANSMIT,
 				  get_user(dsp56k_host_interface.data.l, data+n++));
 			return 4*n;
@@ -328,6 +328,7 @@ static int dsp56k_ioctl(struct inode *in
 			unsigned int cmd, unsigned long arg)
 {
 	int dev = iminor(inode) & 0x0f;
+	void __user *argp = (void __user *)arg;
 
 	switch(dev)
 	{
@@ -336,9 +337,9 @@ static int dsp56k_ioctl(struct inode *in
 		switch(cmd) {
 		case DSP56K_UPLOAD:
 		{
-			char *bin;
+			char __user *bin;
 			int r, len;
-			struct dsp56k_upload *binary = (struct dsp56k_upload *) arg;
+			struct dsp56k_upload __user *binary = argp;
     
 			if(get_user(len, &binary->len) < 0)
 				return -EFAULT;
@@ -372,7 +373,7 @@ static int dsp56k_ioctl(struct inode *in
 		case DSP56K_HOST_FLAGS:
 		{
 			int dir, out, status;
-			struct dsp56k_host_flags *hf = (struct dsp56k_host_flags*) arg;
+			struct dsp56k_host_flags __user *hf = argp;
     
 			if(get_user(dir, &hf->dir) < 0)
 				return -EFAULT;
diff --git a/include/asm-m68k/dsp56k.h b/include/asm-m68k/dsp56k.h
index ab3dd33..2d8c0c9 100644
--- a/include/asm-m68k/dsp56k.h
+++ b/include/asm-m68k/dsp56k.h
@@ -13,7 +13,7 @@
 /* Used for uploading DSP binary code */
 struct dsp56k_upload {
 	int len;
-	char *bin;
+	char __user *bin;
 };
 
 /* For the DSP host flags */
-- 
0.99.9.GIT


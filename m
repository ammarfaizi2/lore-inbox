Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVC1Rzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVC1Rzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVC1Rpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:45:30 -0500
Received: from fep18.inet.fi ([194.251.242.243]:7813 "EHLO fep18.inet.fi")
	by vger.kernel.org with ESMTP id S261970AbVC1Rlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:41:50 -0500
Subject: [PATCH 4/9] isofs: inline macros in rock.c
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ie2p4k.4drbt3.auj0ip4uwd2grudve6958nc1i.refire@cs.helsinki.fi>
In-Reply-To: <ie2p4d.yvvame.c800krzha66tsbfqmvrvx2swh.refire@cs.helsinki.fi>
Date: Mon, 28 Mar 2005 20:41:49 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch inlines the MAYBE_CONTINUE macro in fs/isofs/rock.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 rock.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 90 insertions(+), 31 deletions(-)

Index: 2.6/fs/isofs/rock.c
===================================================================
--- 2.6.orig/fs/isofs/rock.c	2005-03-28 16:28:05.000000000 +0300
+++ 2.6/fs/isofs/rock.c	2005-03-28 16:31:53.000000000 +0300
@@ -52,34 +52,6 @@
   }                                                             \
 }
 
-#define MAYBE_CONTINUE(LABEL,DEV) \
-  {if (buffer) { kfree(buffer); buffer = NULL; } \
-  if (cont_extent){ \
-    int block, offset, offset1; \
-    struct buffer_head * pbh; \
-    buffer = kmalloc(cont_size,GFP_KERNEL); \
-    if (!buffer) goto out; \
-    block = cont_extent; \
-    offset = cont_offset; \
-    offset1 = 0; \
-    pbh = sb_bread(DEV->i_sb, block); \
-    if(pbh){       \
-      if (offset > pbh->b_size || offset + cont_size > pbh->b_size){	\
-	brelse(pbh); \
-	goto out; \
-      } \
-      memcpy(buffer + offset1, pbh->b_data + offset, cont_size - offset1); \
-      brelse(pbh); \
-      chr = (unsigned char *) buffer; \
-      len = cont_size; \
-      cont_extent = 0; \
-      cont_size = 0; \
-      cont_offset = 0; \
-      goto LABEL; \
-    }    \
-    printk("Unable to read rock-ridge attributes\n");    \
-  }}
-
 /* return length of name field; 0: not found, -1: to be ignored */
 int get_rock_ridge_filename(struct iso_directory_record *de,
 			    char *retname, struct inode *inode)
@@ -163,7 +135,36 @@
 			}
 		}
 	}
-	MAYBE_CONTINUE(repeat, inode);
+	if (buffer) {
+		kfree(buffer);
+		buffer = NULL;
+	}
+	if (cont_extent) {
+		int block, offset, offset1;
+		struct buffer_head * pbh;
+		buffer = kmalloc(cont_size,GFP_KERNEL);
+		if (!buffer)
+			goto out;
+		block = cont_extent;
+		offset = cont_offset;
+		offset1 = 0;
+		pbh = sb_bread(inode->i_sb, block);
+		if(pbh) {
+			if (offset > pbh->b_size || offset + cont_size > pbh->b_size) {
+				brelse(pbh);
+				goto out;
+     			}
+			memcpy(buffer + offset1, pbh->b_data + offset, cont_size - offset1);
+			brelse(pbh);
+			chr = (unsigned char *) buffer;
+			len = cont_size;
+			cont_extent = 0;
+			cont_size = 0;
+			cont_offset = 0;
+			goto repeat;
+		} 
+		printk("Unable to read rock-ridge attributes\n");
+	}
 	if (buffer)
 		kfree(buffer);
 	return retnamlen;	/* If 0, this file did not have a NM field */
@@ -428,7 +429,36 @@
 			}
 		}
 	}
-	MAYBE_CONTINUE(repeat, inode);
+	if (buffer) {
+		kfree(buffer);
+		buffer = NULL;
+	}
+	if (cont_extent) {
+		int block, offset, offset1;
+		struct buffer_head * pbh;
+		buffer = kmalloc(cont_size,GFP_KERNEL);
+		if (!buffer)
+			goto out;
+		block = cont_extent;
+		offset = cont_offset;
+		offset1 = 0;
+		pbh = sb_bread(inode->i_sb, block);
+		if(pbh) {
+			if (offset > pbh->b_size || offset + cont_size > pbh->b_size) {
+				brelse(pbh);
+				goto out;
+     			}
+			memcpy(buffer + offset1, pbh->b_data + offset, cont_size - offset1);
+			brelse(pbh);
+			chr = (unsigned char *) buffer;
+			len = cont_size;
+			cont_extent = 0;
+			cont_size = 0;
+			cont_offset = 0;
+			goto repeat;
+		} 
+		printk("Unable to read rock-ridge attributes\n");
+	}
       out:
 	if (buffer)
 		kfree(buffer);
@@ -597,7 +627,36 @@
 			break;
 		}
 	}
-	MAYBE_CONTINUE(repeat, inode);
+	if (buffer) {
+		kfree(buffer);
+		buffer = NULL;
+	}
+	if (cont_extent) {
+		int block, offset, offset1;
+		struct buffer_head * pbh;
+		buffer = kmalloc(cont_size,GFP_KERNEL);
+		if (!buffer)
+			goto out;
+		block = cont_extent;
+		offset = cont_offset;
+		offset1 = 0;
+		pbh = sb_bread(inode->i_sb, block);
+		if(pbh) {
+			if (offset > pbh->b_size || offset + cont_size > pbh->b_size) {
+				brelse(pbh);
+				goto out;
+     			}
+			memcpy(buffer + offset1, pbh->b_data + offset, cont_size - offset1);
+			brelse(pbh);
+			chr = (unsigned char *) buffer;
+			len = cont_size;
+			cont_extent = 0;
+			cont_size = 0;
+			cont_offset = 0;
+			goto repeat;
+		} 
+		printk("Unable to read rock-ridge attributes\n");
+	}
 	if (buffer)
 		kfree(buffer);
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVC1Rvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVC1Rvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVC1Rsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:48:36 -0500
Received: from fep19.inet.fi ([194.251.242.244]:21151 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S261981AbVC1RmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:42:21 -0500
Subject: [PATCH 8/9] isofs: remove redundant kfree checks from rock
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ie2p5f.t67m3i.aid9ej9zr5l2bzvc37myo8bgc.refire@cs.helsinki.fi>
In-Reply-To: <ie2p57.ci8bth.die9b1q2orkmf9yc1r3uljtl1.refire@cs.helsinki.fi>
Date: Mon, 28 Mar 2005 20:42:20 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes redundant kfree() NULL checks from fs/isofs/rock.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 rock.c |   36 ++++++++++++------------------------
 1 files changed, 12 insertions(+), 24 deletions(-)

Index: 2.6/fs/isofs/rock.c
===================================================================
--- 2.6.orig/fs/isofs/rock.c	2005-03-28 18:24:50.000000000 +0300
+++ 2.6/fs/isofs/rock.c	2005-03-28 18:24:53.000000000 +0300
@@ -130,18 +130,15 @@
 				retnamlen += rr->len - 5;
 				break;
 			case SIG('R', 'E'):
-				if (buffer)
-					kfree(buffer);
+				kfree(buffer);
 				return -1;
 			default:
 				break;
 			}
 		}
 	}
-	if (buffer) {
-		kfree(buffer);
-		buffer = NULL;
-	}
+	kfree(buffer);
+	buffer = NULL;
 	if (cont_extent) {
 		int block, offset, offset1;
 		struct buffer_head * pbh;
@@ -168,12 +165,10 @@
 		} 
 		printk("Unable to read rock-ridge attributes\n");
 	}
-	if (buffer)
-		kfree(buffer);
+	kfree(buffer);
 	return retnamlen;	/* If 0, this file did not have a NM field */
       out:
-	if (buffer)
-		kfree(buffer);
+	kfree(buffer);
 	return 0;
 }
 
@@ -426,10 +421,8 @@
 			}
 		}
 	}
-	if (buffer) {
-		kfree(buffer);
-		buffer = NULL;
-	}
+	kfree(buffer);
+	buffer = NULL;
 	if (cont_extent) {
 		int block, offset, offset1;
 		struct buffer_head * pbh;
@@ -457,8 +450,7 @@
 		printk("Unable to read rock-ridge attributes\n");
 	}
       out:
-	if (buffer)
-		kfree(buffer);
+	kfree(buffer);
 	return 0;
 }
 
@@ -625,10 +617,8 @@
 			break;
 		}
 	}
-	if (buffer) {
-		kfree(buffer);
-		buffer = NULL;
-	}
+	kfree(buffer);
+	buffer = NULL;
 	if (cont_extent) {
 		int block, offset, offset1;
 		struct buffer_head * pbh;
@@ -655,8 +645,7 @@
 		} 
 		printk("Unable to read rock-ridge attributes\n");
 	}
-	if (buffer)
-		kfree(buffer);
+	kfree(buffer);
 
 	if (rpnt == link)
 		goto fail;
@@ -670,8 +659,7 @@
 
 	/* error exit from macro */
       out:
-	if (buffer)
-		kfree(buffer);
+	kfree(buffer);
 	goto fail;
       out_noread:
 	printk("unable to read i-node block");

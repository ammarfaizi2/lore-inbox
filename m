Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWEaKdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWEaKdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 06:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWEaKdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 06:33:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:20645 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964958AbWEaKdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 06:33:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ctiq9CkmMQxtIaKexUkU42XAOCdoev6JvhEgOVxgh4AxUoMwrgqD/DbTivE228nwQagBPczpteyGPTgh00lc4ny9ptKf5PLdbPKqRMFr7NROIgkR5C02rdFqeuIREjrQv/JfFVEHe+pC7dlINexmv3GmLhlRN+imCnNdQFrP4wc=
Date: Wed, 31 May 2006 14:34:20 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Clements <Paul.Clements@steeleye.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: endian annotations
Message-ID: <20060531103420.GA7267@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/nbd.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/include/linux/nbd.h
+++ b/include/linux/nbd.h
@@ -75,15 +75,15 @@ struct nbd_device {
 /*
  * This is the packet used for communication between client and
  * server. All data are in network byte order.
  */
 struct nbd_request {
-	u32 magic;
-	u32 type;	/* == READ || == WRITE 	*/
+	__be32 magic;
+	__be32 type;	/* == READ || == WRITE 	*/
 	char handle[8];
-	u64 from;
-	u32 len;
+	__be64 from;
+	__be32 len;
 }
 #ifdef __GNUC__
 	__attribute__ ((packed))
 #endif
 ;
@@ -91,10 +91,10 @@ struct nbd_request {
 /*
  * This is the reply packet that nbd-server sends back to the client after
  * it has completed an I/O request (or an error occurs).
  */
 struct nbd_reply {
-	u32 magic;
-	u32 error;		/* 0 = ok, else error	*/
+	__be32 magic;
+	__be32 error;		/* 0 = ok, else error	*/
 	char handle[8];		/* handle you got from request	*/
 };
 #endif


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbVLVV2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVLVV2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVLVV2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:28:33 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:3598 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030282AbVLVV2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:28:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=nufvJY45u9QnTTdpe7oMXShGc1Mid9BjUC63Z5j692DSs3RK4UJafcI0/hgjC9ZdiNNbCShDfMK5/0ba6T1YjIs6XhCefpsYAEc3c7BTUFnMyN0T+t8Zp1U8lGV799fSMa2OCYsx7WsSmVP59MtPq1hl8738s8kZ46akYt424l8=
Date: Fri, 23 Dec 2005 00:42:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Paul Clements <Paul.Clements@steeleye.com>
Subject: nbd: add endian annotations
Message-ID: <20051222214235.GA16883@mipter.zuzino.mipt.ru>
References: <20051222101523.GP27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222101523.GP27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/include/linux/nbd.h
+++ b/include/linux/nbd.h
@@ -68,11 +68,11 @@ struct nbd_device {
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
@@ -84,8 +84,8 @@ struct nbd_request {
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


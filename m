Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWHSQTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWHSQTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWHSQTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:19:37 -0400
Received: from mail.gmx.de ([213.165.64.20]:28116 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932216AbWHSQTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:19:36 -0400
X-Authenticated: #704063
Subject: [Patch] Fix signedness error in drivers/media/video/vivi.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: mchehab@infradead.org
Content-Type: text/plain
Date: Sat, 19 Aug 2006 18:19:27 +0200
Message-Id: <1156004367.17863.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

when checking the -Wextra signedness warnings issued by gcc 4.1
I came across this one:

drivers/media/video/vivi.c:1001: warning: comparison of unsigned expression < 0 is always false

Since videobuf_reqbufs() returns negative values on errors the current
code does no real error checking since gcc removes the comparison.
This patch fixes this issue by making ret a normal, signed integer.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc4/drivers/media/video/vivi.c.orig	2006-08-19 18:13:45.000000000 +0200
+++ linux-2.6.18-rc4/drivers/media/video/vivi.c	2006-08-19 18:14:16.000000000 +0200
@@ -992,7 +992,8 @@ static int vidiocgmbuf (struct file *fil
 	struct vivi_fh  *fh=priv;
 	struct videobuf_queue *q=&fh->vb_vidq;
 	struct v4l2_requestbuffers req;
-	unsigned int i, ret;
+	unsigned int i;
+	int ret;
 
 	req.type   = q->type;
 	req.count  = 8;



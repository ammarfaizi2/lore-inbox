Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWBDUJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWBDUJA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWBDUJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:09:00 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:32602 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932557AbWBDUJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:09:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SqHk79fqafnro5vDvVtQA0irZI0mR/I8jY5oAtCgs/R5mYZV7iMfkwR5WxsptJXB+z8jxetL38FPye/7bjAN0rcxhXHBvP2rgi+3B4rNEONeas7WWnS7ynTxuxUSOYPqVSs0Du7GGlRWCkCjpLITvD/QQU1p04vG9ScbYtguMrg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][OSS][Multisound] vfree does own NULL checking, no need for own explicit check.
Date: Sat, 4 Feb 2006 21:09:07 +0100
User-Agent: KMail/1.9
Cc: Andrew Veliath <andrewtv@usa.net>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602042109.07674.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vfree() does it's own NULL checking, no need for explicit check before 
calling it.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/oss/msnd.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc2-git1-orig/sound/oss/msnd.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc2-git1/sound/oss/msnd.c	2006-02-04 21:05:32.000000000 +0100
@@ -95,10 +95,8 @@ void msnd_fifo_init(msnd_fifo *f)
 
 void msnd_fifo_free(msnd_fifo *f)
 {
-	if (f->data) {
-		vfree(f->data);
-		f->data = NULL;
-	}
+	vfree(f->data);
+	f->data = NULL;
 }
 
 int msnd_fifo_alloc(msnd_fifo *f, size_t n)



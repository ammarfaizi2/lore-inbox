Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWBXUt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWBXUt1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWBXUtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:49:12 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:42005 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932479AbWBXUsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:48:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=cr7Bmy2feRgebx+KHsvVix8uehGzEQEuq6LZJ0f4NG93Xd64VLQHtvWzR3zKDr6fCVCldkwtIV+ES42I+rm4qyao3wnAIqQfZ4/24a7FkU4Hn9yFFmmvZO/tQebAC1UXktptnxAbcwfTqDzD0aRDGDdsdKXgu7GQRowesswlMx0=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 10/13] vfree does its own NULL check, no need to be explicit in oss/msnd.c
Date: Fri, 24 Feb 2006 21:49:10 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Veliath <andrewtv@usa.net>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242149.10322.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vfree() does it's own NULL checking, no need for explicit check before
calling it.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/oss/msnd.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/sound/oss/msnd.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc4-mm2/sound/oss/msnd.c	2006-02-24 21:01:30.000000000 +0100
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




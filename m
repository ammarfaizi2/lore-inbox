Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129500AbRBFRab>; Tue, 6 Feb 2001 12:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129648AbRBFRaW>; Tue, 6 Feb 2001 12:30:22 -0500
Received: from hermes.mixx.net ([212.84.196.2]:49168 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129500AbRBFRaI>;
	Tue, 6 Feb 2001 12:30:08 -0500
From: Daniel Phillips <phillips@innominate.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] create_buffers silently fails for size > PAGE_SIZE
Date: Tue, 6 Feb 2001 17:45:58 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01020618282317.15914@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is in the Kernel Janitor category, no critical bugs are caused by
this.  I also wonder why we have NR_SIZES = 7.

--- ../2.4.1.clean/fs/buffer.c	Mon Jan 15 21:42:32 2001
+++ fs/buffer.c	Tue Feb  6 17:41:18 2001
@@ -1296,6 +1296,7 @@
 {
 	struct buffer_head *bh, *head;
 	long offset;
+	if (size > PAGE_SIZE) BUG();
 
 try_again:
 	head = NULL;

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

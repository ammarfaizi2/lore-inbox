Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTBQVs0>; Mon, 17 Feb 2003 16:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbTBQVs0>; Mon, 17 Feb 2003 16:48:26 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:11269 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267542AbTBQVsZ>;
	Mon, 17 Feb 2003 16:48:25 -0500
Date: Mon, 17 Feb 2003 22:58:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] char/drivers/random.c - fix warning
Message-ID: <20030217215824.GB8984@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling random.c without SYSCTL defined a warning is
issued about free_entropy_store being defined but not used.
Put ifdef's around the functions.
I could have moved the whole function, but it logically belongs
to this part of the file.

	Sam

===== drivers/char/random.c 1.30 vs edited =====
--- 1.30/drivers/char/random.c	Mon Dec 30 13:47:26 2002
+++ edited/drivers/char/random.c	Mon Feb 17 22:45:20 2003
@@ -535,14 +535,14 @@
 	r->extract_count = 0;
 	memset(r->pool, 0, r->poolinfo.POOLBYTES);
 }
-
+#ifdef CONFIG_SYSCTL
 static void free_entropy_store(struct entropy_store *r)
 {
 	if (r->pool)
 		kfree(r->pool);
 	kfree(r);
 }
-
+#endif
 /*
  * This function adds a byte into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call

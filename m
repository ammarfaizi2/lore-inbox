Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUIKX5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUIKX5q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 19:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268378AbUIKX5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 19:57:46 -0400
Received: from ozlabs.org ([203.10.76.45]:30085 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268370AbUIKX5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 19:57:44 -0400
Date: Sun, 12 Sep 2004 09:55:02 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix real bugs uncovered by -Wno-uninitialized removal 2
Message-ID: <20040911235501.GE32755@krispykreme>
References: <20040911065406.GA32755@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911065406.GA32755@krispykreme>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another real bug.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== drivers/char/hvc_console.c 1.25 vs edited =====
--- 1.25/drivers/char/hvc_console.c	Tue Aug 31 18:09:37 2004
+++ edited/drivers/char/hvc_console.c	Sun Sep 12 09:44:26 2004
@@ -801,7 +801,7 @@
 void hvc_console_print(struct console *co, const char *b, unsigned count)
 {
 	char c[16] __ALIGNED__;
-	unsigned i, n = 0;
+	unsigned i = 0, n = 0;
 	int r, donecr = 0;
 
 	/* Console access attempt outside of acceptable console range. */

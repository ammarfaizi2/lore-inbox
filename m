Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270274AbUJTCqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270274AbUJTCqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270320AbUJTCk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 22:40:59 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:55497 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270270AbUJTChS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:37:18 -0400
Date: Tue, 19 Oct 2004 19:37:16 -0700
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Avoid a build warning on 32-bit platforms
Message-ID: <20041020023716.GE8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a build warning on 32-bit platforms.

Signed-off-by: cw@f00f.org



Is this too ugly for words? :)


diff -Nru a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2004-10-19 17:48:36 -07:00
+++ b/drivers/char/random.c	2004-10-19 17:48:36 -07:00
@@ -818,11 +818,12 @@
 	 * jiffies.
 	 */
 	time = get_cycles();
-	if (time != 0) {
-		if (sizeof(time) > 4)
-			num ^= (u32)(time >> 32);
-	} else {
+	if (!time)
 		time = jiffies;
+	else {
+#if (BITS_PER_LONG > 32)
+		num ^= (u32)(time >> 32);
+#endif /* (BITS_PER_LONG > 32) */
 	}
 
 	/*

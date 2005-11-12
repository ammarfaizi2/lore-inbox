Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVKLVAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVKLVAS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVKLVAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:00:18 -0500
Received: from mail.isurf.ca ([66.154.97.68]:8392 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S964804AbVKLVAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:00:16 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: linux-kernel@vger.kernel.org
Subject: [RESEND] [PATCH] drivers/char/keyboard.c unsigned comparison
Date: Sat, 12 Nov 2005 16:00:10 -0500
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511121600.10888.ace@staticwave.ca>
X-Length: 1371
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

keycode is a checked for a value less than zero, but is defined as an unsigned int, and is only called in one place in the kernel, and passed a unsigned int, so this comparison is bogus.

Thanks to LinuxICC (http://linuxicc.sf.net)

This patch applies to Linus' git tree as of 12.11.2005

Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 449d029..6e991ea 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -198,7 +198,7 @@ int setkeycode(unsigned int scancode, un
 
 	if (scancode >= dev->keycodemax)
 		return -EINVAL;
-	if (keycode < 0 || keycode > KEY_MAX)
+	if (keycode > KEY_MAX)
 		return -EINVAL;
 	if (dev->keycodesize < sizeof(keycode) && (keycode >> (dev->keycodesize * 8)))
 		return -EINVAL;

-- 
Gabriel A. Devenyi
ace@staticwave.ca

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVKLUZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVKLUZm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVKLUZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:25:42 -0500
Received: from mail.isurf.ca ([66.154.97.68]:53410 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S932502AbVKLUZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:25:41 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char/keyboard.c unsigned comparison
Date: Sat, 12 Nov 2005 15:25:33 -0500
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121525.33864.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

keycode is a checked for a value less than zero, but is defined as an unsigned int, and is only called in one place in the kernel, and passed a unsigned int, so this comparison is bogus.

Thanks to LinuxICC (http://linuxicc.sf.net)

This patch applies to Linus' git tree as of 12.11.2005

Signed-off-by: Gabriel A. Devenyi

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

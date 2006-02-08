Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030518AbWBHUC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030518AbWBHUC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWBHUCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:02:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37841 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030504AbWBHUBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:01:54 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] gcc41 fixes: v850 get_user()
Message-Id: <E1F6vVh-0008Bu-Kg@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:01:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1135880312 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-v850/uaccess.h |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

f24dd1b50636edb17b875d8b3290ff27727af0c3
diff --git a/include/asm-v850/uaccess.h b/include/asm-v850/uaccess.h
index 64563c4..b6c4409 100644
--- a/include/asm-v850/uaccess.h
+++ b/include/asm-v850/uaccess.h
@@ -59,18 +59,13 @@ extern int bad_user_access_length (void)
 #define __get_user(var, ptr)						      \
   ({									      \
 	  int __gu_err = 0;						      \
-	  typeof(*(ptr)) __gu_val = 0;					      \
+	  typeof(*(ptr)) __gu_val = *ptr;				      \
 	  switch (sizeof (*(ptr))) {					      \
 	  case 1:							      \
 	  case 2:							      \
 	  case 4:							      \
-		  __gu_val = *(ptr);					      \
-		  break;						      \
-	  case 8:							      \
-		  memcpy(&__gu_val, ptr, sizeof(__gu_val));		      \
 		  break;						      \
 	  default:							      \
-		  __gu_val = 0;						      \
 		  __gu_err = __get_user_bad ();				      \
 		  break;						      \
 	  }								      \
-- 
0.99.9.GIT


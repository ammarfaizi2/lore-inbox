Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVLVE6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVLVE6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbVLVE6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:58:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25552 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965070AbVLVEuf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:50:35 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 18/36] m68k: dmasound_paula.c lvalues abuse (from m68k CVS)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIPS-0004s5-K9@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:50:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Zippel <zippel@linux-m68k.org>
Date: 1135191147 -0500

avoid warnings about use of cast expressions as lvalues

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 sound/oss/dmasound/dmasound_paula.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

35e5bbe9630387309d6640ccedbbec134c3e6151
diff --git a/sound/oss/dmasound/dmasound_paula.c b/sound/oss/dmasound/dmasound_paula.c
index f163868..5417815 100644
--- a/sound/oss/dmasound/dmasound_paula.c
+++ b/sound/oss/dmasound/dmasound_paula.c
@@ -245,6 +245,7 @@ static ssize_t funcname(const u_char *us
 			u_char frame[], ssize_t *frameUsed,		\
 			ssize_t frameLeft)				\
 {									\
+	const u_short *ptr = (const u_short *)userPtr;			\
 	ssize_t count, used;						\
 	u_short data;							\
 									\
@@ -254,7 +255,7 @@ static ssize_t funcname(const u_char *us
 		count = min_t(size_t, userCount, frameLeft)>>1 & ~1;	\
 		used = count*2;						\
 		while (count > 0) {					\
-			if (get_user(data, ((u_short *)userPtr)++))	\
+			if (get_user(data, ptr++))			\
 				return -EFAULT;				\
 			data = convsample(data);			\
 			*high++ = data>>8;				\
@@ -269,12 +270,12 @@ static ssize_t funcname(const u_char *us
 		count = min_t(size_t, userCount, frameLeft)>>2 & ~1;	\
 		used = count*4;						\
 		while (count > 0) {					\
-			if (get_user(data, ((u_short *)userPtr)++))	\
+			if (get_user(data, ptr++))			\
 				return -EFAULT;				\
 			data = convsample(data);			\
 			*lefth++ = data>>8;				\
 			*leftl++ = (data>>2) & 0x3f;			\
-			if (get_user(data, ((u_short *)userPtr)++))	\
+			if (get_user(data, ptr++))			\
 				return -EFAULT;				\
 			data = convsample(data);			\
 			*righth++ = data>>8;				\
-- 
0.99.9.GIT


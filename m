Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWACX17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWACX17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWACX15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:27:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:62171 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965061AbWACX1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:27:51 -0500
To: torvalds@osdl.org
Subject: [PATCH 17/41] m68k: dmasound_paula.c lvalues abuse (from m68k CVS)
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvZG-0003Mz-JK@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:27:50 +0000
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

34225af377908974eb21d905427c0b3291255ec3
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


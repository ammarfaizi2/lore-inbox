Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbVHYFUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbVHYFUo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbVHYFUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:20:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53963 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751528AbVHYFUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:20:43 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (1/22) lvalues abuse in dmasound
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8ADJ-0005a8-SN@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:23:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

result of typecast is not an lvalue.   Part of those are fixed in m68k
CVS.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7/sound/oss/dmasound/dmasound_atari.c RC13-rc7-dmasound-lvalues/sound/oss/dmasound/dmasound_atari.c
--- RC13-rc7/sound/oss/dmasound/dmasound_atari.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-dmasound-lvalues/sound/oss/dmasound/dmasound_atari.c	2005-08-25 00:54:04.000000000 -0400
@@ -217,8 +217,9 @@
 		used = count*2;
 		while (count > 0) {
 			u_short data;
-			if (get_user(data, ((u_short *)userPtr)++))
+			if (get_user(data, (u_short *)userPtr))
 				return -EFAULT;
+			userPtr += 2;
 			*p++ = data ^ 0x8080;
 			count--;
 		}
@@ -240,8 +241,9 @@
 		used = count*2;
 		while (count > 0) {
 			u_short data;
-			if (get_user(data, ((u_short *)userPtr)++))
+			if (get_user(data, (u_short *)userPtr))
 				return -EFAULT;
+			userPtr += 2;
 			*p++ = data;
 			*p++ = data;
 			count--;
@@ -271,8 +273,9 @@
 		used = count*2;
 		while (count > 0) {
 			u_short data;
-			if (get_user(data, ((u_short *)userPtr)++))
+			if (get_user(data, (u_short *)userPtr))
 				return -EFAULT;
+			userPtr += 2;
 			data ^= 0x8000;
 			*p++ = data;
 			*p++ = data;
@@ -285,8 +288,9 @@
 		used = count*4;
 		while (count > 0) {
 			u_long data;
-			if (get_user(data, ((u_int *)userPtr)++))
+			if (get_user(data, (u_int *)userPtr))
 				return -EFAULT;
+			userPtr += 4;
 			*p++ = data ^ 0x80008000;
 			count--;
 		}
@@ -309,8 +313,9 @@
 		used = count*2;
 		while (count > 0) {
 			u_short data;
-			if (get_user(data, ((u_short *)userPtr)++))
+			if (get_user(data, (u_short *)userPtr))
 				return -EFAULT;
+			userPtr += 2;
 			data = le2be16(data);
 			*p++ = data;
 			*p++ = data;
@@ -323,8 +328,9 @@
 		used = count*4;
 		while (count > 0) {
 			u_long data;
-			if (get_user(data, ((u_int *)userPtr)++))
+			if (get_user(data, (u_int *)userPtr))
 				return -EFAULT;
+			userPtr += 4;
 			data = le2be16dbl(data);
 			*p++ = data;
 			count--;
@@ -348,8 +354,9 @@
 		used = count*2;
 		while (count > 0) {
 			u_short data;
-			if (get_user(data, ((u_short *)userPtr)++))
+			if (get_user(data, (u_short *)userPtr))
 				return -EFAULT;
+			userPtr += 2;
 			data = le2be16(data) ^ 0x8000;
 			*p++ = data;
 			*p++ = data;
@@ -361,8 +368,9 @@
 		used = count;
 		while (count > 0) {
 			u_long data;
-			if (get_user(data, ((u_int *)userPtr)++))
+			if (get_user(data, (u_int *)userPtr))
 				return -EFAULT;
+			userPtr += 4;
 			data = le2be16dbl(data) ^ 0x80008000;
 			*p++ = data;
 			count--;
@@ -470,8 +478,9 @@
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, ((u_short *)userPtr)++))
+				if (get_user(data, (u_short *)userPtr))
 					return -EFAULT;
+				userPtr += 2;
 				userCount -= 2;
 				bal += hSpeed;
 			}
@@ -524,8 +533,9 @@
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, ((u_short *)userPtr)++))
+				if (get_user(data, (u_short *)userPtr))
 					return -EFAULT;
+				userPtr += 2;
 				data ^= 0x8080;
 				userCount -= 2;
 				bal += hSpeed;
@@ -561,8 +571,9 @@
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, ((u_short *)userPtr)++))
+				if (get_user(data, (u_short *)userPtr))
 					return -EFAULT;
+				userPtr += 2;
 				userCount -= 2;
 				bal += hSpeed;
 			}
@@ -579,8 +590,9 @@
 			if (bal < 0) {
 				if (userCount < 4)
 					break;
-				if (get_user(data, ((u_int *)userPtr)++))
+				if (get_user(data, (u_int *)userPtr))
 					return -EFAULT;
+				userPtr += 4;
 				userCount -= 4;
 				bal += hSpeed;
 			}
@@ -615,8 +627,9 @@
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, ((u_short *)userPtr)++))
+				if (get_user(data, (u_short *)userPtr))
 					return -EFAULT;
+				userPtr += 2;
 				data ^= 0x8000;
 				userCount -= 2;
 				bal += hSpeed;
@@ -634,8 +647,9 @@
 			if (bal < 0) {
 				if (userCount < 4)
 					break;
-				if (get_user(data, ((u_int *)userPtr)++))
+				if (get_user(data, (u_int *)userPtr))
 					return -EFAULT;
+				userPtr += 4;
 				data ^= 0x80008000;
 				userCount -= 4;
 				bal += hSpeed;
@@ -671,8 +685,9 @@
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, ((u_short *)userPtr)++))
+				if (get_user(data, (u_short *)userPtr))
 					return -EFAULT;
+				userPtr += 2;
 				data = le2be16(data);
 				userCount -= 2;
 				bal += hSpeed;
@@ -690,8 +705,9 @@
 			if (bal < 0) {
 				if (userCount < 4)
 					break;
-				if (get_user(data, ((u_int *)userPtr)++))
+				if (get_user(data, (u_int *)userPtr))
 					return -EFAULT;
+				userPtr += 4;
 				data = le2be16dbl(data);
 				userCount -= 4;
 				bal += hSpeed;
@@ -727,8 +743,9 @@
 			if (bal < 0) {
 				if (userCount < 2)
 					break;
-				if (get_user(data, ((u_short *)userPtr)++))
+				if (get_user(data, (u_short *)userPtr))
 					return -EFAULT;
+				userPtr += 2;
 				data = le2be16(data) ^ 0x8000;
 				userCount -= 2;
 				bal += hSpeed;
@@ -746,8 +763,9 @@
 			if (bal < 0) {
 				if (userCount < 4)
 					break;
-				if (get_user(data, ((u_int *)userPtr)++))
+				if (get_user(data, (u_int *)userPtr))
 					return -EFAULT;
+				userPtr += 4;
 				data = le2be16dbl(data) ^ 0x80008000;
 				userCount -= 4;
 				bal += hSpeed;
diff -urN RC13-rc7/sound/oss/dmasound/dmasound_paula.c RC13-rc7-dmasound-lvalues/sound/oss/dmasound/dmasound_paula.c
--- RC13-rc7/sound/oss/dmasound/dmasound_paula.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-dmasound-lvalues/sound/oss/dmasound/dmasound_paula.c	2005-08-25 00:54:04.000000000 -0400
@@ -253,8 +253,9 @@
 		count = min_t(size_t, userCount, frameLeft)>>1 & ~1;	\
 		used = count*2;						\
 		while (count > 0) {					\
-			if (get_user(data, ((u_short *)userPtr)++))	\
+			if (get_user(data, (u_short *)userPtr))		\
 				return -EFAULT;				\
+			userPtr += 2;					\
 			data = convsample(data);			\
 			*high++ = data>>8;				\
 			*low++ = (data>>2) & 0x3f;			\
@@ -268,13 +269,15 @@
 		count = min_t(size_t, userCount, frameLeft)>>2 & ~1;	\
 		used = count*4;						\
 		while (count > 0) {					\
-			if (get_user(data, ((u_short *)userPtr)++))	\
+			if (get_user(data, (u_short *)userPtr))		\
 				return -EFAULT;				\
+			userPtr += 2;					\
 			data = convsample(data);			\
 			*lefth++ = data>>8;				\
 			*leftl++ = (data>>2) & 0x3f;			\
-			if (get_user(data, ((u_short *)userPtr)++))	\
+			if (get_user(data, (u_short *)userPtr))		\
 				return -EFAULT;				\
+			userPtr += 2;					\
 			data = convsample(data);			\
 			*righth++ = data>>8;				\
 			*rightl++ = (data>>2) & 0x3f;			\

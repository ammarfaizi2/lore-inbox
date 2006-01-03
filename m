Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWACX2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWACX2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWACX2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:28:02 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:62683 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965064AbWACX14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:27:56 -0500
To: torvalds@osdl.org
Subject: [PATCH 18/41] m68k: lvalues abuse in dmasound
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvZL-0003N5-JY@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:27:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135191323 -0500

cast is not an lvalue

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 sound/oss/dmasound/dmasound_atari.c |   54 +++++++++++++++++++++++------------
 1 files changed, 36 insertions(+), 18 deletions(-)

d2591e8daba6ec86554ed221048709c5ff5246cd
diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
index 59eb53f..b747e77 100644
--- a/sound/oss/dmasound/dmasound_atari.c
+++ b/sound/oss/dmasound/dmasound_atari.c
@@ -217,8 +217,9 @@ static ssize_t ata_ct_u8(const u_char *u
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
@@ -240,8 +241,9 @@ static ssize_t ata_ct_s16be(const u_char
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
@@ -271,8 +273,9 @@ static ssize_t ata_ct_u16be(const u_char
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
@@ -285,8 +288,9 @@ static ssize_t ata_ct_u16be(const u_char
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
@@ -309,8 +313,9 @@ static ssize_t ata_ct_s16le(const u_char
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
@@ -323,8 +328,9 @@ static ssize_t ata_ct_s16le(const u_char
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
@@ -348,8 +354,9 @@ static ssize_t ata_ct_u16le(const u_char
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
@@ -361,8 +368,9 @@ static ssize_t ata_ct_u16le(const u_char
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
@@ -470,8 +478,9 @@ static ssize_t ata_ctx_s8(const u_char *
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
@@ -524,8 +533,9 @@ static ssize_t ata_ctx_u8(const u_char *
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
@@ -561,8 +571,9 @@ static ssize_t ata_ctx_s16be(const u_cha
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
@@ -579,8 +590,9 @@ static ssize_t ata_ctx_s16be(const u_cha
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
@@ -615,8 +627,9 @@ static ssize_t ata_ctx_u16be(const u_cha
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
@@ -634,8 +647,9 @@ static ssize_t ata_ctx_u16be(const u_cha
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
@@ -671,8 +685,9 @@ static ssize_t ata_ctx_s16le(const u_cha
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
@@ -690,8 +705,9 @@ static ssize_t ata_ctx_s16le(const u_cha
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
@@ -727,8 +743,9 @@ static ssize_t ata_ctx_u16le(const u_cha
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
@@ -746,8 +763,9 @@ static ssize_t ata_ctx_u16le(const u_cha
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
-- 
0.99.9.GIT


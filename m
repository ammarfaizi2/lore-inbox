Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030608AbWJJWhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbWJJWhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbWJJWhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:37:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51074 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030610AbWJJWhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:37:06 -0400
To: torvalds@osdl.org
Subject: [PATCH 2/16] serpent: fix endian warnings
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQDh-0008UK-Oz@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:37:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Fri, 23 Dec 2005 01:12:25 +0300

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 crypto/serpent.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/crypto/serpent.c b/crypto/serpent.c
index 465d091..2b0a19a 100644
--- a/crypto/serpent.c
+++ b/crypto/serpent.c
@@ -364,10 +364,10 @@ static void serpent_encrypt(struct crypt
 {
 	struct serpent_ctx *ctx = crypto_tfm_ctx(tfm);
 	const u32
-		*k = ctx->expkey,
-		*s = (const u32 *)src;
-	u32	*d = (u32 *)dst,
-		r0, r1, r2, r3, r4;
+		*k = ctx->expkey;
+	const __le32 *s = (const __le32 *)src;
+	__le32	*d = (__le32 *)dst;
+	u32	r0, r1, r2, r3, r4;
 
 /*
  * Note: The conversions between u8* and u32* might cause trouble
@@ -423,10 +423,10 @@ static void serpent_decrypt(struct crypt
 {
 	struct serpent_ctx *ctx = crypto_tfm_ctx(tfm);
 	const u32
-		*k = ((struct serpent_ctx *)ctx)->expkey,
-		*s = (const u32 *)src;
-	u32	*d = (u32 *)dst,
-		r0, r1, r2, r3, r4;
+		*k = ((struct serpent_ctx *)ctx)->expkey;
+	const __le32 *s = (const __le32 *)src;
+	__le32	*d = (__le32 *)dst;
+	u32	r0, r1, r2, r3, r4;
 
 	r0 = le32_to_cpu(s[0]);
 	r1 = le32_to_cpu(s[1]);
-- 
1.4.2.GIT



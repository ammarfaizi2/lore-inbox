Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVLVV4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVLVV4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbVLVV4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:56:35 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:23849 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030339AbVLVV4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:56:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=nOKZCC3lJ9G+7vIrvxY6m76yn9/nx+USU1okULbHev6d/Voj2TmJc7VAFuw1wwUacXGmNPc8yhomcdomcs9CmqWSM7oK6u5cn+qondR/LtQbUKFiasOX+w71ls6uUX6/C9f4ySbXwKuxNMZJYZv+SZSNKF0K842Yfa11kXghPMQ=
Date: Fri, 23 Dec 2005 01:12:25 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] serpent: fix endian warnings
Message-ID: <20051222221225.GC16883@mipter.zuzino.mipt.ru>
References: <20051222101523.GP27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222101523.GP27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 crypto/serpent.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/crypto/serpent.c
+++ b/crypto/serpent.c
@@ -367,10 +367,10 @@ static int serpent_setkey(void *ctx, con
 static void serpent_encrypt(void *ctx, u8 *dst, const u8 *src)
 {
 	const u32
-		*k = ((struct serpent_ctx *)ctx)->expkey,
-		*s = (const u32 *)src;
-	u32	*d = (u32 *)dst,
-		r0, r1, r2, r3, r4;
+		*k = ((struct serpent_ctx *)ctx)->expkey;
+	const __le32 *s = (const __le32 *)src;
+	__le32	*d = (__le32 *)dst;
+	u32	r0, r1, r2, r3, r4;
 
 /*
  * Note: The conversions between u8* and u32* might cause trouble
@@ -425,10 +425,10 @@ static void serpent_encrypt(void *ctx, u
 static void serpent_decrypt(void *ctx, u8 *dst, const u8 *src)
 {
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


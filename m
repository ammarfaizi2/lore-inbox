Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbVLVVod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbVLVVod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbVLVVod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:44:33 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:31476 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030316AbVLVVoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:44:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=HTZNMZdTiyU/jc6tyOfLoxgn8t84fINRhoyWb3dTb4dx/+0K8pHnUgJFMPuOXaYNX+IB9Pk2OHEFHHLV/le71y3PbCmqssZ6j9SR34ZXTNBPgDgkkvMvXo8WogxAVi1SpPIuXSd+22rnBmvCutxOJdAiR1Stgv5ilh3na4FVHuA=
Date: Fri, 23 Dec 2005 00:47:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] aes: fix endian warnings
Message-ID: <20051222214734.GB16883@mipter.zuzino.mipt.ru>
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

 crypto/aes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -73,8 +73,8 @@ byte(const u32 x, const unsigned n)
 	return x >> (n << 3);
 }
 
-#define u32_in(x) le32_to_cpu(*(const u32 *)(x))
-#define u32_out(to, from) (*(u32 *)(to) = cpu_to_le32(from))
+#define u32_in(x) le32_to_cpu(*(const __le32 *)(x))
+#define u32_out(to, from) (*(__le32 *)(to) = cpu_to_le32(from))
 
 struct aes_ctx {
 	int key_length;


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUA1WJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 17:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUA1WJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 17:09:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40578 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266206AbUA1WJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 17:09:02 -0500
Date: Wed, 28 Jan 2004 17:08:58 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] crypto/sha256.c crypto/sha512.c
In-Reply-To: <20040128213050.GB23977@certainkey.com>
Message-ID: <Xine.LNX.4.44.0401281706181.8922-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004, Jean-Luc Cooke wrote:

> Pardon my ignorance, but does silence mean "yes"?

No, but the patch looks fine to me and passes the test vectors.

Dave, I've included it below.


- James
-- 
James Morris
<jmorris@redhat.com>

diff -Naur linux-2.6.1/crypto/sha256.c linux-2.6.1-patched/crypto/sha256.c
--- linux-2.6.1/crypto/sha256.c	2004-01-09 01:59:26.000000000 -0500
+++ linux-2.6.1-patched/crypto/sha256.c	2004-01-27 14:22:00.000000000 -0500
@@ -34,12 +34,12 @@
 
 static inline u32 Ch(u32 x, u32 y, u32 z)
 {
-	return ((x & y) ^ (~x & z));
+	return z ^ (x & (y ^ z));
 }
 
 static inline u32 Maj(u32 x, u32 y, u32 z)
 {
-	return ((x & y) ^ (x & z) ^ (y & z));
+	return (x & y) | (z & (x | y));
 }
 
 static inline u32 RORu32(u32 x, u32 y)
diff -Naur linux-2.6.1/crypto/sha512.c linux-2.6.1-patched/crypto/sha512.c
--- linux-2.6.1/crypto/sha512.c	2004-01-09 02:00:03.000000000 -0500
+++ linux-2.6.1-patched/crypto/sha512.c	2004-01-27 14:22:26.000000000 -0500
@@ -34,12 +34,12 @@
 
 static inline u64 Ch(u64 x, u64 y, u64 z)
 {
-        return ((x & y) ^ (~x & z));
+        return z ^ (x & (y ^ z));
 }
 
 static inline u64 Maj(u64 x, u64 y, u64 z)
 {
-        return ((x & y) ^ (x & z) ^ (y & z));
+        return (x & y) | (z & (x | y));
 }
 
 static inline u64 RORu64(u64 x, u64 y)


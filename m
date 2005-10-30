Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932782AbVJ3GtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbVJ3GtO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 01:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932794AbVJ3GtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 01:49:13 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:12037 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932782AbVJ3GtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 01:49:12 -0500
Date: Sun, 30 Oct 2005 17:48:42 +1100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add be*/le* types without underscores
Message-ID: <20051030064842.GA5933@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

I've seen a number of patches that have started to use the __le*/__be*
types within the kernel.  Nice as they are, the underscores are really
a bit of an eye sore.  Since there seems to be no name conflict within
the kernel, why don't we use them without the underscores like just as
we do with types like u32?

Here is a patch to do just that.  I've verified that there are no
conflicts by grepping the current git tree and then building it with
the patch.

Of course userspace won't see them since they're protected by
#ifdef __KERNEL__.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/fs/ntfs/types.h b/fs/ntfs/types.h
--- a/fs/ntfs/types.h
+++ b/fs/ntfs/types.h
@@ -25,9 +25,6 @@
 
 #include <linux/types.h>
 
-typedef __le16 le16;
-typedef __le32 le32;
-typedef __le64 le64;
 typedef __u16 __bitwise sle16;
 typedef __u32 __bitwise sle32;
 typedef __u64 __bitwise sle64;
diff --git a/include/linux/types.h b/include/linux/types.h
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -171,6 +171,13 @@ typedef __u64 __bitwise __be64;
 #endif
 
 #ifdef __KERNEL__
+typedef u16 __bitwise le16;
+typedef u16 __bitwise be16;
+typedef u32 __bitwise le32;
+typedef u32 __bitwise be32;
+typedef u64 __bitwise le64;
+typedef u64 __bitwise be64;
+
 typedef unsigned __bitwise__ gfp_t;
 #endif
 

--FL5UXtIhxfXey3p5--

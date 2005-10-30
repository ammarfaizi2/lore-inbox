Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVJ3XBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVJ3XBD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 18:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVJ3XBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 18:01:01 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:36872 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932082AbVJ3XBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 18:01:01 -0500
Date: Mon, 31 Oct 2005 10:00:39 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add be*/le* types without underscores
Message-ID: <20051030230039.GA28488@gondor.apana.org.au>
References: <20051030064842.GA5933@gondor.apana.org.au> <Pine.LNX.4.64.0510301134440.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510301134440.27915@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 30, 2005 at 11:36:46AM -0800, Linus Torvalds wrote:
> 
> I think that
> 
> 	typedef __le16 le16;
> 
> should do what you want, but you should check.

Good point.  I've just checked and your suggestion definitely works.
I've also changed the ifdef around __be64/__le64 so that they always
exist in the kernel.

So here it is again:


[PATCH] Add be*/le* types without underscores

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

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/include/linux/types.h b/include/linux/types.h
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -165,12 +165,19 @@ typedef __u16 __bitwise __le16;
 typedef __u16 __bitwise __be16;
 typedef __u32 __bitwise __le32;
 typedef __u32 __bitwise __be32;
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if defined(__KERNEL__) || (defined(__GNUC__) && !defined(__STRICT_ANSI__))
 typedef __u64 __bitwise __le64;
 typedef __u64 __bitwise __be64;
 #endif
 
 #ifdef __KERNEL__
+typedef __le16 le16;
+typedef __be16 be16;
+typedef __le32 le32;
+typedef __be32 be32;
+typedef __le64 le64;
+typedef __be64 be64;
+
 typedef unsigned __bitwise__ gfp_t;
 #endif
 

--OXfL5xGRrasGEqWY--

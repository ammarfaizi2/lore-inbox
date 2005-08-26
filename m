Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbVHZTXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbVHZTXW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbVHZTXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:23:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030212AbVHZTXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:23:13 -0400
Message-Id: <20050826191844.561248000@localhost.localdomain>
References: <20050826191755.052951000@localhost.localdomain>
Date: Fri, 26 Aug 2005 12:17:58 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Sergey Vlasov <vsu@altlinux.ru>, Tavis Ormandy <taviso@gentoo.org>,
       Tim Yamin <plasmaroo@gentoo.org>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 3/7] [PATCH] Revert unnecessary zlib_inflate/inftrees.c fix
Content-Disposition: inline; filename=zlib-revert-broken-change.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

It turns out that empty distance code tables are not an error, and that
a compressed block with only literals can validly have an empty table
and should not be flagged as a data error.

Some old versions of gzip had problems with this case, but it does not
affect the zlib code in the kernel.

Analysis and explanations thanks to Sergey Vlasov <vsu@altlinux.ru>

Cc: Sergey Vlasov <vsu@altlinux.ru>
Cc: Tavis Ormandy <taviso@gentoo.org>
Cc: Tim Yamin <plasmaroo@gentoo.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 lib/zlib_inflate/inftrees.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12.y/lib/zlib_inflate/inftrees.c
===================================================================
--- linux-2.6.12.y.orig/lib/zlib_inflate/inftrees.c
+++ linux-2.6.12.y/lib/zlib_inflate/inftrees.c
@@ -141,7 +141,7 @@ static int huft_build(
   {
     *t = NULL;
     *m = 0;
-    return Z_DATA_ERROR;
+    return Z_OK;
   }
 
 

--

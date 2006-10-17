Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWJQVTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWJQVTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWJQVTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:19:40 -0400
Received: from mail.zelnet.ru ([80.92.97.13]:60898 "EHLO mail.zelnet.ru")
	by vger.kernel.org with ESMTP id S1750786AbWJQVTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:19:39 -0400
Message-ID: <453548DD.3000701@namesys.com>
Date: Wed, 18 Oct 2006 01:19:25 +0400
From: Edward Shishkin <edward@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andrew.j.wade@gmail.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: =?UTF-8?B?UmU6IFsyLjYuMTktcmMyLW1tMV0gZXJyb3I6IHRvbyBmZXcgYXJndW0=?=
 =?UTF-8?B?ZW50cyB0byBmdW5jdGlvbiDigJhjcnlwdG9fYWxsb2NfaGFzaOKAmQ==?=
References: <20061016230645.fed53c5b.akpm@osdl.org> <200610171603.38253.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200610171603.38253.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080209030100060709020601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080209030100060709020601
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Andrew James Wade wrote:

>Hello,
>
>The latest -mm introduced a new error:
>
>  CC      fs/reiser4/plugin/crypto/digest.o
>fs/reiser4/plugin/crypto/digest.c: In function ‘alloc_sha256’:
>fs/reiser4/plugin/crypto/digest.c:17: error: too few arguments to function ‘crypto_alloc_hash’
>make[2]: *** [fs/reiser4/plugin/crypto/digest.o] Error 1
>make[1]: *** [fs/reiser4] Error 2
>make: *** [fs] Error 2
>
>Andrew Wade
>  
>
The fix is attached.
Andrew, please apply.
Thanks.

--------------080209030100060709020601
Content-Type: text/x-patch;
 name="reiser4-fix-alloc_sha256.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiser4-fix-alloc_sha256.patch"

Fixed alloc_sha256 (missed argument)

Signed-off-by: Edward Shishkin <edward@namesys.com>
---
 linux-2.6.19-rc2-mm1/fs/reiser4/plugin/crypto/digest.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc2-mm1/fs/reiser4/plugin/crypto/digest.c.orig
+++ linux-2.6.19-rc2-mm1/fs/reiser4/plugin/crypto/digest.c
@@ -14,7 +14,7 @@
 static struct crypto_hash * alloc_sha256 (void)
 {
 #if REISER4_SHA256
-	return crypto_alloc_hash ("sha256", 0);
+	return crypto_alloc_hash ("sha256", 0, CRYPTO_ALG_ASYNC);
 #else
 	warning("edward-1418", "sha256 unsupported");
 	return ERR_PTR(-EINVAL);

--------------080209030100060709020601--

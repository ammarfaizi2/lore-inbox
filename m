Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753483AbWKCTv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbWKCTv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbWKCTv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:51:27 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:17400 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753483AbWKCTv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:51:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=mXR8tyKBNes68NRQPp8QegxCxhtlFAPoMtJLcAnQXY86jpyNywPD7XNx79Z7jvmqnTvfKC63mPgW738uIMG0pihCOkjx5wC+dwJQiRXo+tQdVlSeKKsDCYl2kXPW/qQJQIgNWZGvrQu2IX08QVF1mLGHX9Ete0MCwzjEmhgKoeo=
Message-ID: <454B9DBA.8030705@gmail.com>
Date: Fri, 03 Nov 2006 14:51:22 -0500
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: mhalcrow@us.ibm.com, phillip@hellewell.homeip.net
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ecryptfs: bad allocation result check
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kmalloc() result in* *ecryptfs_crypto_api_algify_cipher_name() is
assigned to an indirectly referenced pointer and not to the pointer
itself, so the current result check is incorrect.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

 crypto.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index f49f105..136175a 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -134,7 +134,7 @@ int ecryptfs_crypto_api_algify_cipher_na
 
 	algified_name_len = (chaining_modifier_len + cipher_name_len + 3);
 	(*algified_name) = kmalloc(algified_name_len, GFP_KERNEL);
-	if (!(algified_name)) {
+	if (!(*algified_name)) {
 		rc = -ENOMEM;
 		goto out;
 	}



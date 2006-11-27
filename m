Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756986AbWK0FIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986AbWK0FIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756995AbWK0FIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:08:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:60964 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756986AbWK0FIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:08:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=aI7i8F+8KVFdAlGKWE/AxeGNyO5zlePUWDLhDBcxTWGKrZTOAd5fbhLTYAujEH6XazoM4uf31/w8etOnwH0+f5v6ebIRv/ESj88TpSzzZLuwKMtljPZNk0KeL/+GefOxXC8I8PvTkHB8iSZQWQUfb0IPxqwQ2dzvGPL0elfe68s=
Date: Mon, 27 Nov 2006 14:01:01 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Mike Halcrow <mhalcrow@us.ibm.com>,
       Phillip Hellewell <phillip@hellewell.homeip.net>
Subject: [PATCH] ecryptfs: fix crypto_alloc_blkcipher() error check
Message-ID: <20061127050101.GE1231@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Mike Halcrow <mhalcrow@us.ibm.com>,
	Phillip Hellewell <phillip@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of crypto_alloc_blkcipher() should be checked by
IS_ERR().

Cc: Mike Halcrow <mhalcrow@us.ibm.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 fs/ecryptfs/crypto.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: work-fault-inject/fs/ecryptfs/crypto.c
===================================================================
--- work-fault-inject.orig/fs/ecryptfs/crypto.c
+++ work-fault-inject/fs/ecryptfs/crypto.c
@@ -820,7 +820,8 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 	crypt_stat->tfm = crypto_alloc_blkcipher(full_alg_name, 0,
 						 CRYPTO_ALG_ASYNC);
 	kfree(full_alg_name);
-	if (!crypt_stat->tfm) {
+	if (IS_ERR(crypt_stat->tfm)) {
+		rc = PTR_ERR(crypt_stat->tfm);
 		ecryptfs_printk(KERN_ERR, "cryptfs: init_crypt_ctx(): "
 				"Error initializing cipher [%s]\n",
 				crypt_stat->cipher);

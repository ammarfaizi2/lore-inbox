Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSKRNHY>; Mon, 18 Nov 2002 08:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSKRNHX>; Mon, 18 Nov 2002 08:07:23 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:5135 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S262452AbSKRNHW>; Mon, 18 Nov 2002 08:07:22 -0500
Date: Tue, 19 Nov 2002 00:14:10 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: [PATCH] Re: 2.5.48 Compilation Failure skbuff.c
In-Reply-To: <20021118125450.GA14855@outpost.ds9a.nl>
Message-ID: <Mutt.LNX.4.44.0211190013030.22010-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, bert hubert wrote:

> On Mon, Nov 18, 2002 at 01:36:48PM +0100, Rene Blokland wrote:
> > Hello, 2.5.48 Doesn't compile for me on a AMD k6-3 with gcc-3.2 and glibc-2.3.1
> 
> I bet this just made ipsec mandatory :-)

Not quite yet :-)

A fix is below.


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.48.orig/include/linux/crypto.h linux-2.5.48.w1/include/linux/crypto.h
--- linux-2.5.48.orig/include/linux/crypto.h	Tue Nov 12 00:12:06 2002
+++ linux-2.5.48.w1/include/linux/crypto.h	Tue Nov 19 00:09:39 2002
@@ -196,12 +196,7 @@
 
 static inline const char *crypto_tfm_alg_modname(struct crypto_tfm *tfm)
 {
-	struct crypto_alg *alg = tfm->__crt_alg;
-	
-	if (alg->cra_module)
-		return alg->cra_module->name;
-	else
-		return NULL;
+	return module_name(tfm->__crt_alg->cra_module);
 }
 
 static inline u32 crypto_tfm_alg_type(struct crypto_tfm *tfm)


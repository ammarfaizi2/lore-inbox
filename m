Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSKRNFj>; Mon, 18 Nov 2002 08:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSKRNFj>; Mon, 18 Nov 2002 08:05:39 -0500
Received: from almesberger.net ([63.105.73.239]:54802 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262783AbSKRNFg>; Mon, 18 Nov 2002 08:05:36 -0500
Date: Mon, 18 Nov 2002 10:12:30 -0300
From: Werner Almesberger <wa@almesberger.net>
To: reneb@cistron.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.48 Compilation Failure skbuff.c
Message-ID: <20021118101230.N1407@almesberger.net>
References: <slrnathnn0.aas.reneb@orac.aais.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnathnn0.aas.reneb@orac.aais.org>; from reneb@orac.aais.org on Mon, Nov 18, 2002 at 01:36:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Blokland wrote:
> include/linux/crypto.h: In function `crypto_tfm_alg_modname':
> include/linux/crypto.h:202: dereferencing pointer to incomplete type
[...]
> Any comments?

Disabling modules should work around this. Alternatively, you can
try the untested patch below. I also had to disable devfs to build
2.4.58.

- Werner

---------------------------------- cut here -----------------------------------

--- ../linux-2.5.48.orig/include/linux/crypto.h	Mon Nov 18 01:29:29 2002
+++ linux-2.5.48/include/linux/crypto.h	Mon Nov 18 10:03:46 2002
@@ -16,6 +16,7 @@
 #ifndef _LINUX_CRYPTO_H
 #define _LINUX_CRYPTO_H
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -196,12 +197,16 @@
 
 static inline const char *crypto_tfm_alg_modname(struct crypto_tfm *tfm)
 {
+#ifdef CONFIG_MODULES
 	struct crypto_alg *alg = tfm->__crt_alg;
 	
 	if (alg->cra_module)
 		return alg->cra_module->name;
 	else
 		return NULL;
+#else
+	return NULL;
+#endif
 }
 
 static inline u32 crypto_tfm_alg_type(struct crypto_tfm *tfm)

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVDKLIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVDKLIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 07:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVDKLIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 07:08:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43971 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261774AbVDKLIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 07:08:39 -0400
Date: Mon, 11 Apr 2005 13:08:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050411110822.GA10401@elf.ucw.cz>
References: <4259B474.4040407@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4259B474.4040407@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch adds the core functionality for the encrypted
> suspend image.

+#ifdef CONFIG_SWSUSP_ENCRYPT
+static struct crypto_tfm *crypto_init(int mode)
+{
+       struct crypto_tfm *tfm;
+       int len;
+
+       tfm = crypto_alloc_tfm(CIPHER, CRYPTO_TFM_MODE_CBC);
+       if(!tfm) {
          ~ please put space between if and (

+               printk(KERN_ERR "swsusp: no tfm, suspend not
possible\n");
+               return NULL;
+       }
+
+       if(sizeof(key) < crypto_tfm_alg_min_keysize(tfm)) {

same here.

Was it really neccessary to include "union u"? I don't like its name,
and perhaps few casts are better than this. If not, it probably should
go in separate patch, and ASAP.

Splitting it to code/kconfig/doc probably does not make much sense, it
is small enough, already.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

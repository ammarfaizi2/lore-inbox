Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVDKNLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVDKNLU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 09:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVDKNLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 09:11:20 -0400
Received: from hermes.domdv.de ([193.102.202.1]:2311 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261577AbVDKNLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 09:11:08 -0400
Message-ID: <425A776B.3070107@domdv.de>
Date: Mon, 11 Apr 2005 15:11:07 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <4259B474.4040407@domdv.de> <20050411110822.GA10401@elf.ucw.cz>
In-Reply-To: <20050411110822.GA10401@elf.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>The following patch adds the core functionality for the encrypted
>>suspend image.
> 
> 
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +static struct crypto_tfm *crypto_init(int mode)
> +{
> +       struct crypto_tfm *tfm;
> +       int len;
> +
> +       tfm = crypto_alloc_tfm(CIPHER, CRYPTO_TFM_MODE_CBC);
> +       if(!tfm) {
>           ~ please put space between if and (
> 
> +               printk(KERN_ERR "swsusp: no tfm, suspend not
> possible\n");
> +               return NULL;
> +       }
> +
> +       if(sizeof(key) < crypto_tfm_alg_min_keysize(tfm)) {
> 
> same here.
> 
> Was it really neccessary to include "union u"? I don't like its name,
> and perhaps few casts are better than this. If not, it probably should
> go in separate patch, and ASAP.

I'll revert this and use few casts.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

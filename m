Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVGUFcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVGUFcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVGUFaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:30:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21194 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261632AbVGUF3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:29:24 -0400
Date: Thu, 21 Jul 2005 07:29:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LZF Cryptoapi support.
Message-ID: <20050721052917.GA5230@atrey.karlin.mff.cuni.cz>
References: <1121657429.13487.41.camel@localhost> <20050719135441.GB2410@elf.ucw.cz> <1121921767.2938.207.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121921767.2938.207.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> New revision. Anything left to fix up?

It certainly looks better now.

> +static int lzf_compress_init(void *context)
> +{
> +	struct lzf_ctx *ctx = (struct lzf_ctx *)context;
> +
> +	/* Get LZF ready to go */
> +	ctx->hbuf = vmalloc_32((1 << hlog) * sizeof(char *));
> +	if (!ctx->hbuf) {
> +		printk(KERN_WARNING
> +		       "Failed to allocate %d bytes for lzf workspace\n",
> +		       (1 << hlog) * sizeof(char *));
> +		return -ENOMEM;
> +	}
> +
> +	/* Allocate local buffer */
> +	ctx->local_buffer = (char *)get_zeroed_page(GFP_ATOMIC);
> +
> +	if (!ctx->local_buffer) {
> +		lzf_compress_exit(ctx);
> +		return -ENOMEM;
> +	}
> +
> +	/* Allocate page buffer */
> +	ctx->page_buffer = (char *)get_zeroed_page(GFP_ATOMIC);

Why GFP_ATOMIC in last two?


> +	if (!ctx->page_buffer) {
> +		free_page((unsigned long)ctx->local_buffer);
> +		lzf_compress_exit(ctx);
> +		return -ENOMEM;
> +	}
> +
> +	ctx->first_call = 1;
> +
> +	return 0;
> +}
> +
> +static int lzf_compress(void *context, const u8 * in_data, unsigned int in_len,
                                                    ~ extra space; it
is inconsistent all over the file.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

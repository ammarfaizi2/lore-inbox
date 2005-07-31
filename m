Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVGaD43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVGaD43 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 23:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVGaD43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 23:56:29 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:46096 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261605AbVGaD41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 23:56:27 -0400
Date: Sun, 31 Jul 2005 13:56:05 +1000
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LZF Cryptoapi support.
Message-ID: <20050731035605.GB5564@gondor.apana.org.au>
References: <1121657429.13487.41.camel@localhost> <20050719135441.GB2410@elf.ucw.cz> <1121921767.2938.207.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121921767.2938.207.camel@localhost>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 02:56:07PM +1000, Nigel Cunningham wrote:
>
> +static int lzf_compress_init(void *context)
> +{
> +	struct lzf_ctx *ctx = (struct lzf_ctx *)context;
> +
> +	/* Get LZF ready to go */
> +	ctx->hbuf = vmalloc_32((1 << hlog) * sizeof(char *));

Any reason why vmalloc can't be used?

> +	/* Allocate local buffer */
> +	ctx->local_buffer = (char *)get_zeroed_page(GFP_ATOMIC);

> +	/* Allocate page buffer */
> +	ctx->page_buffer = (char *)get_zeroed_page(GFP_ATOMIC);

Where are these two buffers used anyway?

> +	if (!ctx->page_buffer) {
> +		free_page((unsigned long)ctx->local_buffer);
> +		lzf_compress_exit(ctx);

This is a double-free of local_buffer.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

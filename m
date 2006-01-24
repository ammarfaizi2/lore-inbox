Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWAXBWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWAXBWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWAXBWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:22:11 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:44305 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030280AbWAXBWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:22:09 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David H?rdeman <david@2gen.com>
Subject: Re: [PATCH 02/04] Add dsa crypto ops
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, david@2gen.com
Organization: Core
In-Reply-To: <11380489523918@2gen.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1F1Csk-0000lm-00@gondolin.me.apana.org.au>
Date: Tue, 24 Jan 2006 12:22:02 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David H?rdeman <david@2gen.com> wrote:
>
> +static int dsa_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
> +{
> +       struct dsa_ctx *dctx = ctx;
> +
> +       if (keylen != sizeof(struct key_payload_dsa *)) {
> +               printk("Invalid key size in dsa_setkey\n");
> +               return -EINVAL;
> +       }
> +
> +       dctx->key = (struct key_payload_dsa *)key;
> +       return 0;
> +}

This is bad.  You're putting a pointer to an object with an unknown
lifetime into the tfm.

Is there anything wrong with allocating the memory for it and storing
the key in the tfm like everyone else?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

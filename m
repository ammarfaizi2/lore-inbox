Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVGCLnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVGCLnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 07:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVGCLnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 07:43:17 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:1800 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261391AbVGCLl3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 07:41:29 -0400
Date: Sun, 3 Jul 2005 21:41:11 +1000
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] 1.be_le.patch
Message-ID: <20050703114111.GB4848@gondor.apana.org.au>
References: <200506201359.23211.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506201359.23211.vda@ilport.com.ua>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 01:59:23PM +0300, Denis Vlasenko wrote:
>
> @@ -265,10 +263,10 @@ aes_set_key(void *ctx_arg, const u8 *in_
>  
>  	ctx->key_length = key_len;
>  
> -	E_KEY[0] = u32_in (in_key);
> -	E_KEY[1] = u32_in (in_key + 4);
> -	E_KEY[2] = u32_in (in_key + 8);
> -	E_KEY[3] = u32_in (in_key + 12);
> +	E_KEY[0] = load_le32(in_key,0);
> +	E_KEY[1] = load_le32(in_key,1);
> +	E_KEY[2] = load_le32(in_key,2);
> +	E_KEY[3] = load_le32(in_key,3);

Please insert a space after the comma.
  
> @@ -448,4 +446,3 @@ module_exit(aes_fini);
>  
>  MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm");
>  MODULE_LICENSE("Dual BSD/GPL");
> -

Please drop unrelated hunks like this.

> @@ -1159,9 +1114,7 @@ not_weak:
>  		w  |= (b1[k[18+24]] | b0[k[19+24]]) << 4;
>  		w  |= (b1[k[20+24]] | b0[k[21+24]]) << 2;
>  		w  |=  b1[k[22+24]] | b0[k[23+24]];
> -		
> -		ROR(w, 4, 28);      /* could be eliminated */
> -		expkey[1] = w;
> +		expkey[1] = ror32(w, 4);	/* could be eliminated */

Please split the ROR => ror32 change out.

> diff -urpN linux-2.6.12.0.orig/crypto/helper.h linux-2.6.12.1.n/crypto/helper.h
> --- linux-2.6.12.0.orig/crypto/helper.h	Thu Jan  1 03:00:00 1970
> +++ linux-2.6.12.1.n/crypto/helper.h	Sun Jun 19 18:51:23 2005

This should probably be moved to include/linux.  There's crypto
stuff living under arch/ and drivers/crypto.

This patch is really good idea overall.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

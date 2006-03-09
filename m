Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWCIWKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWCIWKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWCIWKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:10:35 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:30213
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1751764AbWCIWKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:10:34 -0500
Date: Fri, 10 Mar 2006 09:10:30 +1100
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: fix unaligned access in khazad module
Message-ID: <20060309221030.GA11608@gondor.apana.org.au>
References: <20060309.122638.07642914.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309.122638.07642914.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 12:26:38PM +0900, Atsushi Nemoto wrote:
>  
> -	K2 = be64_to_cpu(key[0]);
> -	K1 = be64_to_cpu(key[1]);
> +	K2 = be64_to_cpu(get_unaligned(&key[0]));
> +	K1 = be64_to_cpu(get_unaligned(&key[1]));

How about doing two 32-bit reads:

	const __be32 *key = (const __be32 *)in_key;

	K2 = ((u64)be32_to_cpu(key[0])) << 32 + be32_to_cpu(key[1]);
	K1 = ((u64)be32_to_cpu(key[2])) << 32 + be32_to_cpu(key[3]);

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

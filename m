Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVGCLqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVGCLqc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 07:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVGCLqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 07:46:31 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:4104 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261363AbVGCLmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 07:42:43 -0400
Date: Sun, 3 Jul 2005 21:42:28 +1000
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] 2.wp.patch
Message-ID: <20050703114228.GC4848@gondor.apana.org.au>
References: <200506201400.16725.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506201400.16725.vda@ilport.com.ua>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 02:00:16PM +0300, Denis Vlasenko wrote:
>  
> +#if 1
> + #define X(a) a ^=
> + #define XEND ;
> +#else
> +/* gcc -O2 (3.4.3) optimizer bug:
> +** this will cause excessive spills (~3K stack used)
> +** See http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21141 */
> + #define X(a) ^
> + #define XEND
> +#endif

Well if we're going to work around this at all then let's
use the work around code unconditionally.  Is it that much
worse than the original?

> @@ -979,7 +989,7 @@ static void wp512_process_buffer(struct 
>  	wctx->hash[7] ^= state[7] ^ block[7];
>  }
>  
> -static void wp512_init (void *ctx) {
> +static void wp512_init(void *ctx) {
>  	int i;
>  	struct wp512_ctx *wctx = ctx;

Feel free to fix up white space problems, but do it in a separate patch.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

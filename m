Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbWDCXL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWDCXL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWDCXL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:11:26 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:50692 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751092AbWDCXLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:11:25 -0400
Date: Tue, 4 Apr 2006 09:11:22 +1000
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: fix unaligned access in khazad module
Message-ID: <20060403231122.GA32271@gondor.apana.org.au>
References: <20060309.122638.07642914.nemoto@toshiba-tops.co.jp> <20060404.000518.126141927.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404.000518.126141927.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 12:05:18AM +0900, Atsushi Nemoto wrote:
> 
> -	K2 = be64_to_cpu(key[0]);
> -	K1 = be64_to_cpu(key[1]);
> +	K2 = be64_to_cpu(get_unaligned(&key[0]));
> +	K1 = be64_to_cpu(get_unaligned(&key[1]));

Would it be possible to turn these into two 32-bit aligned reads instead?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

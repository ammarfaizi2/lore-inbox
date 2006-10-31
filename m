Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161559AbWJaBFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161559AbWJaBFZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161558AbWJaBFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:05:25 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:20495 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161559AbWJaBFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:05:23 -0500
Date: Tue, 31 Oct 2006 12:05:05 +1100
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/6] eCryptfs: Hash code to new crypto API
Message-ID: <20061031010505.GC26146@gondor.apana.org.au>
References: <20061030233209.GC3458@us.ibm.com> <20061030233529.GA21515@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030233529.GA21515@us.ibm.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 05:35:29PM -0600, Michael Halcrow wrote:
>
> +	crypto_hash_init(&desc);
> +	crypto_hash_update(&desc, &sg, len);
> +	crypto_hash_final(&desc, dst);

Whenever you do init+update+final, it's preferred that this be
changed to crypto_hash_digest as this enables future optimisations
to be made.  For instance, some hardware can only handle a full
digest rather than a partial update.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

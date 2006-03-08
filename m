Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWCHK1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWCHK1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 05:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWCHK1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 05:27:35 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:48145
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S932374AbWCHK1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 05:27:34 -0500
Date: Wed, 8 Mar 2006 21:27:31 +1100
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: alignment fixes
Message-ID: <20060308102731.GA32195@gondor.apana.org.au>
References: <20060308.160529.37994551.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308.160529.37994551.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 04:05:29PM +0900, Atsushi Nemoto wrote:
> This patch fixes some alignment problem on crypto modules.

Thanks for the patch.  Please split this up and cc
linux-crypto@vger.kernel.org.

> 1. Many cipher setkey functions load key words directly but the key
>    words might not be aligned.  Enforce correct alignment in the
>    setkey wrapper.

This isn't right.  The alignmask applies to source/destination buffers
only.  The only requirement on the key is that it must always be
32-bit aligned.

> 2. Some cipher modules lack cra_alignmask.

Good catch.

> 3. Some hash modules (and sha_transform() library function) load/store
>    data words directly.  Use get_unaligned()/put_unaligned() for them.

We should extend alignmask to cover this and handle it in the digest
layer.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

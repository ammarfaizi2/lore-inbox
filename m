Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUCIFzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 00:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbUCIFzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 00:55:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46246 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261612AbUCIFzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 00:55:01 -0500
Date: Tue, 9 Mar 2004 00:55:42 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jouni Malinen <jkmaline@cc.hut.fi>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
In-Reply-To: <20040309033758.GA3738@jm.kir.nu>
Message-ID: <Xine.LNX.4.44.0403090045390.24848-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2004, Jouni Malinen wrote:

> This would mean that the kmac_init() would need to know something about
> the used digest algorithm or we would need to have setkey handler for
> the digests (which is actually the way I implemented Michael MIC in the
> original patch).

You're correct.

> In addition, I'm not sure whether there would be another algorithm using
> this new keyed has method. HMAC and CBC-MAC (which, btw, is also on my
> list of crypto API things to do for IEEE 802.11i) are using more generic
> mechanism and can be used with multiple algorithms and are probably
> prefered for anything that requires real security.

There are several potential MAC processing modes to be added, XCBC-MAC,
OMAC, RMAC etc.  Do you know if any are likely to benefit from a setkey 
method for digests?

> If you prefer, I can make a new type crypto alg type
> (CRYPTO_ALG_TYPE_KEYED_DIGEST) and make it a clone of the
> CRYPTO_ALG_TYPE_DIGEST with the only change of adding a new callback,
> setkey, in the way I added in the patch for CRYPTO_ALG_TYPE_DIGEST. This
> would leave the digest type unmodified, but would result in copying most
> of the digest code. I do not see much benefit of this because the
> dia_setkey function pointer does not seem to change the old digest
> functionality at all since it is optional and since this function
> pointer does not even enlarge struct crypto_alg due to the cra_u union
> already being a bit larger than the current struct digest_alg.

Agreed.  I really wanted to keep digests 'pure', and not implement a 
setkey method, but it seems like the simplest way at this stage.


> would guess this would be about early 2005 or so). However, the proposal
> for Michael MIC is available from
> http://grouper.ieee.org/groups/802/11/Documents/DocumentHolder/2-020.zip.

Thanks for the pointer.


- James
-- 
James Morris
<jmorris@redhat.com>



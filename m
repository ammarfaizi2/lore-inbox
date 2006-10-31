Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161506AbWJaA4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161506AbWJaA4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161561AbWJaA4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:56:50 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:9487 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161509AbWJaA4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:56:50 -0500
Date: Tue, 31 Oct 2006 11:56:46 +1100
To: Christophe Saout <christophe@saout.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Alasdair G Kergon <agk@redhat.com>,
       linux-kernel@vger.kernel.org,
       Stefan Schmidt <stefan@datenfreihafen.org>, dm-devel@redhat.com,
       dm-crypt@saout.de, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] dmsetup table output changed from 2.6.18 to 2.6.19-rc3 and breaks yaird.
Message-ID: <20061031005646.GA26146@gondor.apana.org.au>
References: <20061030151930.GQ27337@susi> <20061030184331.GY3928@agk.surrey.redhat.com> <Pine.LNX.4.64.0610301053010.25218@g5.osdl.org> <1162237148.9415.7.camel@leto.intern.saout.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162237148.9415.7.camel@leto.intern.saout.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 08:39:08PM +0100, Christophe Saout wrote:
>
> > Herbert, the breakage _seems_ to be due to the STATUSTYPE_TABLE case 
> > change:
> > 
> > -		cipher = crypto_tfm_alg_name(cc->tfm);
> > +		cipher = crypto_blkcipher_name(cc->tfm);
> > 
> > which effectively changes "aes" into "cbc(aes)", which is wrong, since we 
> > show the chainmode separately.

Yes that's wrong.

However, the bigger problem is that dmcrypt's algorithm specification
does not allow all algorithms to be specified.  In particular, algorithms
with dashes in their names cannot be represented in an unambiguous way.

The separation of chain modes and algorithm names is in fact unnecessary
and only complicates matters.

For now it's no big deal since the algorithms people actually use
can be represented.  But it would be nice to get this fixed.
 
> ----
> 
> Fix dm-crypt after the block cipher API changes to correctly return the
> backwards compatible cipher-chainmode[-ivmode] format for "dmsetup
> table".
> 
> Signed-off-by: Christophe Saout <christophe@saout.de>

Looks good to me.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVCYH0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVCYH0t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVCYH0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:26:49 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:14095 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261238AbVCYH0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:26:45 -0500
Date: Fri, 25 Mar 2005 18:25:31 +1100
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050325072531.GA416@gondor.apana.org.au>
References: <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <1111732459.20797.16.camel@uganda> <20050325063333.GA27939@gondor.apana.org.au> <1111733958.20797.30.camel@uganda> <20050325065622.GA31127@gondor.apana.org.au> <1111735195.20797.42.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111735195.20797.42.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 10:19:55AM +0300, Evgeniy Polyakov wrote:
> 
> Noone will complain on Linux if NIC is broken and produces wrong
> checksum
> and HW checksum offloading is enabled using ethtools.

This is completely different.  The worst that can happen with checksum
offloading is that the packet is dropped.  That's something people deal
with on a daily basis since the Internet as a whole does not guarantee
the delivery of packets.

On the other hand, /dev/random is something that has always promised
to deliver random numbers that are totally unpredictable.  People out
there *depend* on this.

If that assumption is violated the result could be catastrophic.

That's why it's OK to have hardware RNG spit out unverified numbers
in /dev/hw_random, but it's absolutely unaccpetable for the same
numbers to add entropy to /dev/random without verification.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

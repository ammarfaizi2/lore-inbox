Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVC2Ke3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVC2Ke3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVC2KdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:33:20 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:50189 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262307AbVC2Kbv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:31:51 -0500
Date: Tue, 29 Mar 2005 20:30:49 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jeff Garzik <jgarzik@pobox.com>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329103049.GB19541@gondor.apana.org.au>
References: <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda> <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <20050329102104.GB6496@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050329102104.GB6496@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 12:21:04PM +0200, Pavel Machek wrote:
> 
> What catastrophic consequences? Noone is likely to even *notice*, and
> it does not help practical attack at all. Unless hardware RNGs are
> *very* flakey (like, more flakey than harddrives), this is not a problem.

The reason some people use hardware RNGs in the first place is because
they don't trust the software RNGs.  When the hardware RNG fails but
continues to send data to /dev/random, /dev/random essentially degenerates
into a software RNG.  Now granted /dev/random is a pretty good software
RNG, however, for some purposes it just isn't good enough.

Otherwise we can just do away with it and always use /dev/urandom.

Someone else raised the example of Casinos using hardware RNGs.  Some
of them are doing this to comply with government regulation.  In that
case, using data from the software RNG when the hardware has failed
would be violating the law.

> I can assure you that failing hdd will have more catastrophic
> consequences.

That's we have things like RAID and backups.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

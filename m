Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVCZAVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVCZAVC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 19:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVCZAVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 19:21:02 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:22177 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261889AbVCZAUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 19:20:46 -0500
Date: Sat, 26 Mar 2005 03:47:33 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, Kim Phillips <kim.phillips@freescale.com>,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       cryptoapi@lists.logix.cz, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
Message-ID: <20050326034733.3c532f20@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050325234745.GA22661@gondor.apana.org.au>
References: <1111737496.20797.59.camel@uganda>
	<424495A8.40804@freescale.com>
	<20050325234348.GA17411@havoc.gtf.org>
	<20050325234745.GA22661@gondor.apana.org.au>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Sat, 26 Mar 2005 03:19:56 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005 10:47:45 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Fri, Mar 25, 2005 at 06:43:49PM -0500, Jeff Garzik wrote:
> > 
> > In any case, it is the wrong solution to simply "turn on the tap" and
> > let the RNG spew data.  There needs to be a limiting factor... typically
> > rngd should figure out when /dev/random needs more entropy, or simply
> > delay a little bit between entropy collection/stuffing runs.
> 
> Completely agreed.  Having it in rngd also allows the scheduler to
> do its job.

It looks like we all misunderstand each other - 
why do you think that if there will be kernel <-> kernel
RNG dataflow, then system will continuously spent all
it's time to produce that data?
_Ability_ existence does not mean that only it must be used.
Userspace daemon should be able to turn it on or off, 
but it is too expensive to allow it to be not only dataflow
controller, but the only random numbers dataflow initiator.

I can create following patch on top of rngd - 
it will read from /dev/random, if read succeds too fast
(or even better just to check pool counts), then rngd
will turn HW RNG assist off and examine received data
to check if it is valid.
Later it can be turned on again.

> When applications need entropy from /dev/random and they can't get it,
> they'll simply block which allows rngd to run to refill the tank.

Such a blocking will be definitely a sign to turn 
HW RNG assist on.

> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt

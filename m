Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVCYXob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVCYXob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 18:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVCYXoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 18:44:30 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:1414 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261873AbVCYXoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 18:44:21 -0500
Date: Fri, 25 Mar 2005 18:43:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Kim Phillips <kim.phillips@freescale.com>
Cc: johnpol@2ka.mipt.ru, Herbert Xu <herbert@gondor.apana.org.au>,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       cryptoapi@lists.logix.cz, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050325234348.GA17411@havoc.gtf.org>
References: <1111737496.20797.59.camel@uganda> <424495A8.40804@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424495A8.40804@freescale.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 04:50:16PM -0600, Kim Phillips wrote:
> I did some tests and found that the udelay(200) call in hw_random.c is 
> not good for extreme RNG consumption.  Whether or not such extremes 
> occur in real life, on the mpc8541, /dev/hwrandom is an order of 
> magnitude slower than /dev/random, and two orders of magnitude slower 
> than /dev/urandom.  The hardware RNG is capable of exceeding software 
> /dev/random speeds plus it would alleviate the core to do other, more 
> useful things (that's being realistic).

Consider what an RNG does:  spews garbage.

In practical applications, you -do not- want to dedicate the machine to 
spewing garbage.  The vast majority of users would prefer to use their
machines for real stuff.  Thus, "extreme RNG consumption" is largely
irrelevant to sane usage.

That said, I cannot remember if the udelay() is hardcoding a policy
decision (bad), or required for the hardware.

In any case, it is the wrong solution to simply "turn on the tap" and
let the RNG spew data.  There needs to be a limiting factor... typically
rngd should figure out when /dev/random needs more entropy, or simply
delay a little bit between entropy collection/stuffing runs.

	Jeff




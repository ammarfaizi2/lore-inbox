Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVCXNYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVCXNYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 08:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVCXNYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 08:24:10 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:19342 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S262449AbVCXNYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 08:24:00 -0500
Date: Thu, 24 Mar 2005 23:23:42 +1000
From: David McCullough <davidm@snapgear.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: johnpol@2ka.mipt.ru, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050324132342.GD7115@beast>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4242B712.50004@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin Jeff Garzik lays it down ...
> Evgeniy Polyakov wrote:
> >On Thu, 2005-03-24 at 14:27 +1000, David McCullough wrote:
> >
> >>Hi all,
> >>
> >>Here is a small patch for 2.6.11 that adds a routine:
> >>
> >>	add_true_randomness(__u32 *buf, int nwords);
> >>
> >>so that true random number generator device drivers can add a entropy
> >>to the system.  Drivers that use this can be found in the latest release
> >>of ocf-linux,  an asynchronous crypto implementation for linux based on
> >>the *BSD Cryptographic Framework.
> >>
> >>	http://ocf-linux.sourceforge.net/
> >>
> >>Adding this can dramatically improve the performance of /dev/random on
> >>small embedded systems which do not generate much entropy.
> >
> >
> >People will not apply any kind of such changes.
> >Both OCF and acrypto already handle all RNG cases - no need for any kind
> >of userspace daemon or entropy (re)injection mechanism.
> >Anyone who want to use HW randomness may use OCF/acrypto mechanism.
> >For example here is patch to enable acrypto support for hw_random.c
> >It is very simple and support only upto 4 bytes request, of course it
> >is 
> >not interested for anyone, but it is only 2-minutes example:
> 
> If you want to add entropy to the kernel entropy pool from hardware RNG, 
> you should use the userland daemon, which detects non-random (broken) 
> hardware and provides throttling, so that RNG data collection does not 
> consume 100% CPU.
> 
> If you want to use the hardware RNG directly, it's simple:  just open 
> /dev/hw_random.
> 
> Hardware RNG should not go kernel->kernel without adding FIPS tests and 
> such.

For reference,  the RNG on the Safenet I am using this with is
FIPS140 certified.  I believe the HIFN part  is also but I place the doc that
says so.

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org

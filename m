Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263156AbTCLLrf>; Wed, 12 Mar 2003 06:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263158AbTCLLrf>; Wed, 12 Mar 2003 06:47:35 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:2725 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263156AbTCLLre>; Wed, 12 Mar 2003 06:47:34 -0500
Date: Wed, 12 Mar 2003 11:55:47 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [patch 3/3] add Via Nehemiah ("xstore") rng support
Message-ID: <20030312125542.GA4284@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Theodore Ts'o <tytso@mit.edu>
References: <3E6EA909.9020200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E6EA909.9020200@pobox.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 10:27:05PM -0500, Jeff Garzik wrote:

 > Review from x86 experts is especially appreciated here, as I am from an 
 > x86 expert myself.

only minor niggles.

 > diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
 > --- a/drivers/char/Kconfig	Tue Mar 11 21:37:50 2003
 > +++ b/drivers/char/Kconfig	Tue Mar 11 21:37:50 2003
 > @@ -710,7 +710,7 @@
 >  	  If you're not sure, say N.
 >  
 >  config HW_RANDOM
 > -	tristate "Intel/AMD H/W Random Number Generator support"
 > +	tristate "Intel/AMD/Via H/W Random Number Generator support"

s/Via/VIA/

 > diff -Nru a/drivers/char/hw_random.c b/drivers/char/hw_random.c
 > --- a/drivers/char/hw_random.c	Tue Mar 11 21:37:50 2003
 > +++ b/drivers/char/hw_random.c	Tue Mar 11 21:37:50 2003
 > @@ -1,5 +1,5 @@
 >  /*
 > - 	Hardware driver for the Intel/AMD Random Number Generators (RNG)
 > + 	Hardware driver for the Intel/AMD/Via Random Number Generators (RNG)

Ditto

 > +	rdmsr(MSR_VIA_RNG, lo, hi);
 > +	if ((lo & VIA_RNG_ENABLE) == 0) {
 > +		printk(KERN_ERR PFX "cannot enable Via C3 RNG, aborting\n");

Ditto.

 
 > +#define cpu_has_xstore		boot_cpu_has(X86_FEATURE_XSTORE)
 
Do we want to do this check only on VIA CPUs I wonder.
As a vendor specific extension, I'd be inclined to do that.

Niggles aside, looks good! Can't test it though, as my current
Nehemiah is pre-production, and seems to have a broken RNG.

		Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbUKTAe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUKTAe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUKTAeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:34:24 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:59556 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262848AbUKTAd0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:33:26 -0500
Date: Sat, 20 Nov 2004 01:29:46 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Dorn Hetzel <kernel@dorn.hetzel.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.cgi.com.hetzel.org,
       jgarzik@pobox.com
Subject: Re: r8169.c
Message-ID: <20041120002946.GA18059@electric-eye.fr.zoreil.com>
References: <20041119162920.GA26836@lilah.hetzel.org> <20041119201203.GA13522@electric-eye.fr.zoreil.com> <20041120003754.GA32133@lilah.hetzel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120003754.GA32133@lilah.hetzel.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dorn Hetzel <kernel@dorn.hetzel.org> :
[...]
> Thank you very much for the pointers.  I have been using Linux for
> ages (well, since 1993 anyway), but this is my first attempt at fixing
> something in the kernel.  (first time I've needed to :) )
> 
> I'm off to look for and try the -mm patchkit after I write this?
> Will it apply to 2.6.10-rc2?  (I had to get to rc2 to get my SATA controller
>  to work) :)

You have two options (or more) on top of 2.6.10-rc2:
- ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/2.6.10-rc2-mm2.bz2
- http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.10-rc2-netdev1.patch.bz2

Once you have applied one of the patch above, the patch below will improve
your "transmit timed out" (please apply in order and enable NAPI):
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.10-rc2-mm1/r8169-250.patch
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.10-rc2-mm1/r8169-255.patch

If things perform better you may want to use bigger frames and apply as
well r8169-260.patch and r8169-265.patch.
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.10-rc2-mm1/r8169-260.patch
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.10-rc2-mm1/r8169-265.patch


[...]
> with regard to the "original" version shipping with 2.6.10-rc2
> (which seems to be identical to the version in 2.6.9)...

Yes.
I hope the current set of changes in -mm/-netdev will be merged in
early post-2.6.10.

> gcc version = 2.95.4  (happy to update that if you think it will help)

You will be welcome to upgrade.

[...]
> > - realize that the so called version number in 2.6.9 has no meaning.
> >
> By this, do you mean that the comment of version number in the r8169.c
> of 2.6.9 is no longer related to the version numbers at Realtek?

Exactly.

One year ago, Realtek's driver was split and merged in the kernel. That
and the contributions of many people took several months to achieve a
(imho) decently stable driver. At the same time, no change appeared on
Realtek's side. Still some months later Realtek issues a new driver with
a rev number bump (2.2). Its code suggests that it includes a partial
merge from some of the changes made to the in-kernel driver as well as
some internal experiments (hooks for missing code).

The drivers are now quite different. A change of version number is 
included in the -mm/-netdev driver to protect the innocent but it seems
I'll have to push weirder numbers. :o)

[...]
> Yeah, I noticed just one version and no history, but to the good, it
> does work for me, at least so far, after the minor patch :)

1 - netif_stop_queue() race between the Tx xmit and the Tx IRQ handler.
2 - "entry" can overflow in rtl8169_tx_interrupt() -> read of random
    status and early free of Tx buffer.

When the in-kernel version had similar code, it translated into "r8169
hangs under load".

--
Ueimor

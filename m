Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267183AbUBSKkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267185AbUBSKkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:40:03 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:24580 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267183AbUBSKj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:39:57 -0500
Subject: Re: 2.6: No hot_UN_plugging of PCMCIA network cards
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, rmk+lkml@arm.linux.org.uk, aahrend@web.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040219015216.6055b65a.akpm@osdl.org>
References: <20040122210501.40800ea7.aahrend@web.de>
	 <20040122213757.H23535@flint.arm.linux.org.uk>
	 <20040123232025.4a128ead.aahrend@web.de>
	 <20040124004530.B25466@flint.arm.linux.org.uk> <4034016C.5070307@pobox.com>
	 <1077183550.802.3.camel@teapot.felipe-alfaro.com>
	 <20040219015216.6055b65a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1077187178.957.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 19 Feb 2004 11:39:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-19 at 10:52, Andrew Morton wrote:
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> >
> >  I've been experiencing hangs with -mm kernels and my CardBus 3Com NIC
> >  when resuming from APM suspend to disk which seem to be caused by the
> >  3c59x driver. The hang just gets resolved by unplugging, then plugging
> >  the CardBus NIC. This doesn't happen with vanilla tree, however.
> > 
> >  I've found that reverting 3c9x-enable_wol.patch fixes this situation for
> >  me.
> 
> Sigh.  Cannot you add the enable_wol module parameter?

Yup! Reapplying 3c9x-enable_wol.patch and supplying "enable_wol=1" to
3c95x.ko seems to solve the problem. It seems that 3c59x power
management is only enable if wake-on-LAN is enabled... why?

Now, dual booting between vanilla and -mm kernels causes problems when
loading the module since vanilla doesn't yet recognize "enable_wol", but
this is only a minor problem.

Thanks!


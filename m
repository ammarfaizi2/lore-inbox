Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUF3TXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUF3TXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUF3TXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:23:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30984 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261232AbUF3TXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:23:17 -0400
Date: Wed, 30 Jun 2004 20:23:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040630202313.A1496@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org> <20040630192654.B21104@flint.arm.linux.org.uk> <20040630191428.GC31064@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040630191428.GC31064@mail.shareable.org>; from jamie@shareable.org on Wed, Jun 30, 2004 at 08:14:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 08:14:28PM +0100, Jamie Lokier wrote:
> Russell King wrote:
> > We use three domains - one for user, one for kernel and one for IO.
> > Normally all three are in client mode.  However, on set_fs(KERNEL_DS)
> > we switch the kernel domain to manager mode.
> > 
> > This means that the user-mode LDR instructions (ldrt / ldrlst etc)
> > will not have their page permissions checked, and therefore the access
> > will succeed - exactly as we require.
> 
> Protection permissions (i.e. read-only, PROT_NONE) should still be
> checked after set_fs(KERNEL_DS).  It's only the kernel page vs. user
> page distinction that should be relaxed.
> 
> >From your description, it's not obvious that it'll do the right thing
> in that circumstance.

Trust me, it does.  Unless you fully understand how the MMU and domains
work on ARM, you've little chance of working it out from the code.

Really, I see its pointless trying to discuss the details of this any
further - I presently have very little time to educate people in the
details, sorry.

> Because set_fs() is rarely used, I think you can optimise getuser.S
> and putuser.S on ARM26.  Instead of comparing the address against
> TI_ADDR_LIMIT, compare it against the hard-coded userspace limit.

Wrong.  That means that if userspace passes an address above the hard
coded limit, we _WILL_ bypass all protections and access that memory.

However, ARM26 is not under my control anymore, so it isn't something
I care about, and I doubt there are many people who do.  We're talking
about a 20 year old architecture which hasn't had any conforming devices
produced for at least 10 years.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbTIJWmC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbTIJWk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:40:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23558 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265907AbTIJWkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:40:04 -0400
Date: Wed, 10 Sep 2003 23:39:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030910233951.Q30046@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <20030910210416.GA24258@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910210416.GA24258@mail.jlokier.co.uk>; from jamie@shareable.org on Wed, Sep 10, 2003 at 10:04:16PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 10:04:16PM +0100, Jamie Lokier wrote:
> Write buffers
> .............
> 
> It was a surprise to discover CPUs which have incoherent write buffers
> yet have coherent L1 caches.  (This means that a write to a virtual
> address which is read from within very few instructions returns the
> written data, completely ignoring any intervening write instructions
> which write to a different virtual address which maps to the same
> memory location.)  I didn't exect to find any of these.
> 
>     CPUs with incoherent write buffers: PA-RISC 2.0, 68040 and ARMs.

Some StrongARM CPUs seem to exhibit non-coherence in their write buffers.
I don't think we've done enough testing to make any statement like "ARMs
have uncoherent write buffers."

Tests need to be run on a larger proportion of the following:

*	ARM720
	ARM920
	ARM922
	ARM925
	ARM926
	ARM1020
	ARM1022
	ARM1026
*	StrongARM-110	(DEC/Intel)
	StrongARM-1100	(DEC/Intel)
*	StrongARM-1110	(Intel)
*	Xscale		(Intel)
	PXA		(Intel)

And so far, there are only results for 4 of these devices, with some
revisions of StrongARM-110's passing and others failing.

> Validity of SHMLBA value
> ........................
> 
>     SHMLBA not valid:		ARM, m68k
> 
> Note that "SHMLBA" is defined for some architectures on which it
> doesn't actually provide coherent virtual aliases.  On the ARM this is
> believed to be due to a chip bug, and very recent kernels may contain
> a workaround for it (disabling the write buffer for aliased pages).

Not correct.  Because of the fundamental nature of VIVT caches, there
is no "SHMLBA" value which prevents aliases occuring.  Think carefully
about the structure of a VIVT cache and how it would be searched.  This
isn't a chip bug.

The kernel works around this, but, due to some bugs on StrongARM chips
in the write buffer, it appears that we need further work-arounds, which
are already implemented.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289322AbSAOAak>; Mon, 14 Jan 2002 19:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289323AbSAOAaV>; Mon, 14 Jan 2002 19:30:21 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:7696 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S289322AbSAOAaI>;
	Mon, 14 Jan 2002 19:30:08 -0500
Date: Mon, 14 Jan 2002 17:24:54 +1100
From: Anton Blanchard <anton@samba.org>
To: davem@redhat.com, ralf@uni-koblenz.de, linux-kernel@vger.kernel.org
Subject: Re: memory-mapped i/o barrier
Message-ID: <20020114062454.GA18794@krispykreme>
In-Reply-To: <20020110134859.A729245@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110134859.A729245@sgi.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Here's a copy of a patch I just got accepted into the 2.5 patch for
> ia64, and I'm wondering if you guys will accept something similar.  On
> mips64, mmiob() could just be implemented as a 'sync', but I'm not
> sure how to do it (or if it's even necessary) on other platforms.
> Please let me know what you think.  I wrote a small documentation file
> for the macro that appears at the top of the patch.
> 
> Thanks,
> Jesse
> 
> 
> diff -Naur --exclude=*~ --exclude=TAGS linux-2.4.17-ia64/Documentation/mmio_barrier.txt linux-2.4.17-ia64-mmiob/Documentation/mmio_barrier.txt
> --- linux-2.4.17-ia64/Documentation/mmio_barrier.txt	Wed Dec 31 16:00:00 1969
> +++ linux-2.4.17-ia64-mmiob/Documentation/mmio_barrier.txt	Tue Jan  8 15:57:37 2002
> @@ -0,0 +1,15 @@
> +On some platforms, so-called memory-mapped I/O is weakly ordered.  For
> +example, the following might occur:
> +
> +CPU A writes 0x1 to Device #1
> +CPU B writes 0x2 to Device #1
> +Device #1 sees 0x2
> +Device #1 sees 0x1

Can loads/stores also complete out of order to IO? (the example just shows
a store from one cpu passing one from another cpu)

On ppc32/ppc64 this can happen, it is fixed up in the low level pci
routines. Is there a case where you cant wrap it up in the low level
routines like ppc32/ppc64?

Anton

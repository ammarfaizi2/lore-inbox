Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUFBMSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUFBMSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUFBMSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:18:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:43392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262328AbUFBMRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:17:47 -0400
Date: Wed, 2 Jun 2004 08:17:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: reg@dwf.com
cc: linux-kernel@vger.kernel.org, reg@orion.dwf.com, linux@horizon.com
Subject: Re: Intel 875 Motherboard cant use 4GB of Memory. 
In-Reply-To: <200406011956.i51JuYkD019999@orion.dwf.com>
Message-ID: <Pine.LNX.4.53.0406020812440.2552@chaos>
References: <200406011956.i51JuYkD019999@orion.dwf.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2004 reg@dwf.com wrote:

>
> > That could be PCI devices.  Some (particularly high-end video cards)
> > take up a lot of address space, which comes straight out of the available
> > 4 GB physical address space.
> >
> > Check /proc/iomem.
> >
>
> OK, that leaves me more confused, and (to me) it still looks like a
> BIOS problem rather than a greedy device.  Here is the /proc/iomem
> with some decimal annotations: (as noted, there is 4x1GB of memory installed)
>


Not just Intel motherboards. There is 32 bits of address-space.
This needs to be shared between RAM and the I/O addresses of
PCI/Bus and AGP boards. Unfortunately, the PCI/AGP specification
wastes a lot of address space because something that needs 1 megabyte
of address-space must sit on a 1 megabyte boundary.  If this
comes after something that used 128 bytes, there is nearly a megabyte
wasted to get to the next boundary. A megabyte here a megabyte there..
pretty soon you are talking about a lot of wasted address-space.

Solution: A 64 bit machine will have the same problem, you end up
wasting RAM address space if it overlays PCI/Bus space. But, you
probably would never opt for a gazzzilion bytes of RAM anyway?

	One gazzzilion = 1844 6744 0737 0955 1615  (2 ^ 64)

Just don't put 4 gigs of RAM in a 4 gig address-space and expect
to use it all. Sell the spare 2 gigs or build another PC with it!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.



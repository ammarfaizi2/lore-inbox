Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289769AbSAJXDA>; Thu, 10 Jan 2002 18:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289768AbSAJXCk>; Thu, 10 Jan 2002 18:02:40 -0500
Received: from rj.SGI.COM ([204.94.215.100]:18615 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289767AbSAJXCf>;
	Thu, 10 Jan 2002 18:02:35 -0500
Date: Thu, 10 Jan 2002 14:59:48 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davem@redhat.com, ralf@uni-koblenz.de, linux-kernel@vger.kernel.org
Subject: Re: memory-mapped i/o barrier
Message-ID: <20020110145948.A776823@sgi.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, davem@redhat.com,
	ralf@uni-koblenz.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020110134859.A729245@sgi.com> <E16OoFt-0005pt-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16OoFt-0005pt-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 11:05:04PM +0000, Alan Cox wrote:
> > ia64, and I'm wondering if you guys will accept something similar.  On
> > mips64, mmiob() could just be implemented as a 'sync', but I'm not
> > sure how to do it (or if it's even necessary) on other platforms.
> 
> Wouldn't it be wise to pass the device to this. Someone somewhere is going
> to have to read a bus dependant chipset register and need to know which
> pci_device * is involved ?

David and I went back and forth on that a little.  My hope is that
most platforms will have a reasonable way (i.e. no pci_device needed)
to ensure ordering.  I'm only aware of two platforms at the moment
that have i/o ordering issues: mips64 and ia64/sn.  On the former, a
simple 'sync' instruction is sufficient to barrier i/o, while on the
latter, a read from the local numa hub suffices.

If only a few platforms need info about which busses have outstanding
i/o, it should be possible to build a list of bridge chips or devices
and loop, reading from each (where presumably the read would act as
the barrier op).

If, OTOH, there are lots of platforms that need a pci_device so they
can read from a corresponding bridge to ensure ordering, it would be a
good idea to add an argument to the macro, as David initially
suggested.

Thoughts?

Jesse

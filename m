Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264337AbUEXREv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUEXREv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 13:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbUEXREv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 13:04:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13730 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264337AbUEXREs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 13:04:48 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: Roland Dreier <roland@topspin.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
References: <20040522013636.61efef73.akpm@osdl.org>
	<m165aorm70.fsf@ebiederm.dsl.xmission.com>
	<20040522180837.3d3cc8a9.akpm@osdl.org> <527jv4ymd4.fsf@topspin.com>
	<20040524161733.GX5414@waste.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 May 2004 11:03:11 -0600
In-Reply-To: <20040524161733.GX5414@waste.org>
Message-ID: <m17jv1n4fk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> On Sat, May 22, 2004 at 06:15:51PM -0700, Roland Dreier wrote:
> >     Andrew> I don't think we can expect all architectures to be able
> >     Andrew> to implement atomic 64-bit IO's, can we?
> > 
> >     Andrew> ergo, drivers which want to use readq and writeq should
> >     Andrew> provide the appropriate locking.
> > 
> > Perhaps we should have ARCH_HAS_ATOMIC_WRITEQ or something so that
> > drivers don't add the overhead of locking on architectures where it's
> > not necessary?
> 
> Or perhaps we just need a lockless __readq/__writeq for drivers that
> know better.

I can see implementing these emulations with a name of
readq_emulated/writeq_emulated, or readl2/writel2.  For drivers that
can stand not generating a true 64bit bus I/O cycle to the device,
that sounds helpful.

However there are and will likely continue to be devices that need a
64bit I/O cycle on the bus.  That is what writeq logically/obviously
does.  Putting an emulation in place of the real thing is likely to
cause all sorts subtle of problems. 

Having listened to this conversation for a while I strongly dislike
the atomic language because that sounds like generating the wrong bus
cycles are somehow OK, and doing what the function says it does is
somehow just an optimization.

If no hardware actually cared or someone could show me that you can't
generate a 64bit memory I/O cycle on the PCI bus that would be
interesting.  I have seen several drivers that care.  Later today
I intend to look at my pci docs and confirm that 64bit I/O cycles
do exist on the bus, even in 32bit slots.  PCI bus traffic is packet
based so I would be strongly surprised if 64bit cycles did not
exist.

Eric


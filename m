Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317960AbSGaVfy>; Wed, 31 Jul 2002 17:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317971AbSGaVfy>; Wed, 31 Jul 2002 17:35:54 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15424 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317960AbSGaVfw>; Wed, 31 Jul 2002 17:35:52 -0400
Date: Wed, 31 Jul 2002 23:40:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc3aa4
Message-ID: <20020731214022.GK11020@dualathlon.random>
References: <20020730060218.GB1181@dualathlon.random> <20020731170802.R10270@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020731170802.R10270@redhat.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 05:08:02PM -0400, Benjamin LaHaise wrote:
> On Tue, Jul 30, 2002 at 08:02:18AM +0200, Andrea Arcangeli wrote:
> > 	Merged async-io from Benjamin LaHaise after purifying it from the
> > 	/proc/libredhat.so mess that made it not binary compatible with 2.5.
> > 
> > 	While merging I did a number of cleanups and fixes, to mention a few of
> > 	them I fixed a shell root exploit in map_user_kvect by using
> > 	get_user_pages (that honours VM_MAYWRITE), it avoids corruption of
> > 	KM_IRQ0 by doing spin_lock_irq in aio_read_evt, and a number of other
> > 	minor not security and not stability related changes.  Left out the
> > 	networking async-io, it can be merged trivially at a later stage (if
> > 	needed :).
> 
> Care to explain the problem and provide a separate patch for all the 
> people who aren't using your tree of patches?  If there's a problem 

I'm sorry but I'm too busy with another thing at the moment to extract
patches, (I should have time after 13 August). In the meantime you can
see the most important changes by diffing memory.c and aio.c yourself.
The VM_MAYWRITE sec fix is the get_user_pages change in the core of
map_user_kiovec, that should be very visible, the other one was just a
missing _irq around a spinlock to protect KM_IRQ0 from irq races, that
should be very visible too by diffing aio.c against aio.c.  The other
changes should be mostly cosmetical or related to the purification from
the dyanmic syscall (ah, and I dropped the nosense _GPL,
EXPORT_SYMBOL_GPL doesn't make sense as said in one of my last emails of
such thread, I've no idea why it's not been nucked from modutils and 2.5
yet, as said either the ksyms linkage is a GPL barrier or it isn't,
there is no such intermediate thing as a EXPORT_SYMBOL_GPL non GPL
barrier).

_GPL doesn't make any sense for a very simple reason: anybody can write
a regular EXPORT_SYMBOL function that just calls your _GPL exported
function once inside the kernel to bypass the _GPL tag. And if you claim
that the wrapper is illegal then all non GPL modules are illegal in the
first place, so making the _GPL tag again a nosense.

> as you claim, then it likely affects map_user_kiobuf too.

kiobuf side in been fixed in mainline some time ago, it only affects
the map_user_kiovec in your patch as far I can tell, but it would be
nice if you could double check, thanks.

Andrea

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbSA2WZN>; Tue, 29 Jan 2002 17:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbSA2WZG>; Tue, 29 Jan 2002 17:25:06 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:38396 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S284138AbSA2WYk>;
	Tue, 29 Jan 2002 17:24:40 -0500
Date: Tue, 29 Jan 2002 15:24:26 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129152426.Z763@lynx.adilger.int>
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain.suse.lists.linux.kernel> <E16VYD8-0003ta-00@the-village.bc.nu.suse.lists.linux.kernel> <p73aduwddni.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73aduwddni.fsf@oldwotan.suse.de>; from ak@suse.de on Tue, Jan 29, 2002 at 10:56:49PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 29, 2002  22:56 +0100, Andi Kleen wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > Lots of the stuff getting missed is tiny little fixes, obvious 3 or 4
> > liners. The big stuff is not the problem most times.
>
> "Most times". For example the EA patches have badly failed so far, just
> because Linus ignored all patches to add sys call numbers for a repeatedly
> discussed  and stable API and nobody else can add syscall numbers on i386. 

But at times, keeping things external to the kernel for a good while isn't
a bad thing either.  Basically, once code is part of the kernel, the API
is much harder to change than if it was always an optional patch.

For example, the EA patches have matured a lot in the time that they have
been external to the kernel (i.e. the move towards a common API with ext2
and XFS).  Even so, the ext2 shared EA on-disk representation leaves a
bit to be desired, because it is only useful in the case of shared ACLs,
and fails if you add any other kind of EA type.  See discussions on
ext2-devel for more information.

Similarly, my ext2 online resizing code was (and is) just fine, but when
I implemented the ext3 online resizing code (not yet available) I realized
I needed to change the on-disk format of some structures and this would
be much harder to do if it was part of the official kernel.

Like Ingo was saying, having to look over your code for a while also helps
it mature, and gives you some leeway to change it.  That said, there is
also a benefit to adding code to the kernel, as it increases your user
base a LOT, and no code that is external to the kernel can be considered
as mature as that which is included into the kernel, I think.  Drivers
may be an exception, because either you need the driver or you don't,
and people have little way of testing a driver if they don't have the hw.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


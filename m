Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270464AbRIKSGp>; Tue, 11 Sep 2001 14:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270774AbRIKSG0>; Tue, 11 Sep 2001 14:06:26 -0400
Received: from ns.caldera.de ([212.34.180.1]:49282 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S270464AbRIKSGT>;
	Tue, 11 Sep 2001 14:06:19 -0400
Date: Tue, 11 Sep 2001 20:06:33 +0200
From: Christoph Hellwig <hch@caldera.de>
Cc: David Balazic <david.balazic@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: IBMs LVM ?
Message-ID: <20010911200633.A5816@caldera.de>
In-Reply-To: <3B9E255C.8943D6BB@uni-mb.si> <200109111526.f8BFQLr25266@ns.caldera.de> <20010911115713.D29347@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010911115713.D29347@turbolinux.com>; from adilger@turbolabs.com on Tue, Sep 11, 2001 at 11:57:13AM -0600
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2001 at 11:57:13AM -0600, Andreas Dilger wrote:
> On Sep 11, 2001  17:26 +0200, Christoph Hellwig wrote:
> > > I heard rumors about IBM porting their LVM code from AIX to Linux.
> > 
> > IBM has an OpenSource volume manager called evms, and although
> > it does support AIX Volumes is has it's root in IBM's OS/2

		^^^^^^^^^^^^^^^^^^

> > volume management system.  (I believe someone at IBM thinks of PCs
> > when hearing Linux so all their ports start from OS/2...)
> 
> Actually, this isn't quite correct.  Yes, the EVMS folks started with
> the LVM design from OS/2 (which was based on AIX LVM, but not compatible).
> However, IBM DID GPL the AIX 4.3 LVM code, and there IS support for AIX
> VGs under EVMS.

Where is the AIX LVM code?

> > > Will it be replaced with the one from IBM ?
> > 
> > ALthough the current LVM has its's issues I hope not so - the current
> > EVMS is the best example on hhow to not write kernel subsystems.
> 
> Do you have a specific complaint?  The current LVM kernel code isn't all
> that robust either (and the user-space code is not very pretty).

Please take a barf-bag, look at the code, look at the unneded abstrations,
look at the uneeded interfaces, look at the code-duplication, look
at the over-engineering.

IF you don't have enough read the archives of the mailinglist about
god-mode that allows even root to do anything and we come back.

> 
> I DO think that EVMS will replace the current LVM code in the kernel.  Why?
> - It already has 100% compatibility with the current LVM on-disk layout.

With _which_ LVM on-disk layout (OOPS, this was a complaint to Sistina :))

> - It already has 100% compatibility with AIX LVM code.

The code is there, yes.

> - It is already possible to do LVM autoconfig of volumes within the kernel
>   without needing an initrd to activate the volumes.

I had that for LVM 0.8 as well, that's a year ago now.

> - It removes knowlege of partitions out of the disk drivers and makes them
>   a simple form of LV.

No - it duplicates the partitions scanning code.  It does not remove the
simple partitioning code (which, BTW is not part of the drivers at all
under Linux), makeing it's copy more complicated than the original version.

> - It is already possible to use partial Linux-LVM volumes (i.e. use LVs
>   that are 100% available in a VG, even if a disk is bad/missing).  You
>   can't do that with the current LVM (sometimes you can't even do it if
>   ALL of the disks are there).

Yupp, nice thing.

> - The AIX LVM on-disk metadata layout is FAR more robust than the current
>   LVM metadata layout.  While this is supposed to be fixed for Linux-LVM
>   at some point, the previous Linux-LVM changes have been TERRIBLE with
>   respect to compatibility, while EVMS is DESIGNED to support multiple
>   on-disk metadata layouts.

Yes, because it is a Meta-LVM, not an actualy inplementation.
I _really_ want something like that in 2.5 - but not this horrible IBM
implementation.

> - It is possible (not done yet) to add things like NT Logical Disk Manager
>   (NT LVM-stuff) into EVMS.
> - It is possible (not done yet) to add HPUX LVM/veritas/OSF volume stuff.

That's the same argument as above.

> - It is possible to merge MD RAID support into EVMS also, to support all
>   of the different RAID layouts with common code*.
> 
> All in all, instead of having things like striping/RAID-1/concatenation/
> RAID-5 reimplemented in each subsystem (e.g. LDM/MD/veritas/etc) we can
> take the current MD code and make it a layer in EVMS which can handle all
> of these cases.
> 
> (*) While the exact on-disk layout of each RAID implementation may vary
> slightly (block sizes, stripe widths, etc), I'm guessing that the majority
> of it is common enough that we can re-use the existing MD code (parity
> calculation, resync, etc) to handle most kinds of RAID-0/1/5 setups.

Nope - I'm currently working on implementing VxVM support, and I have
to redo all the RAID stuff because it is so incomaptible.

If you have a design to share the RAID engine for very different layouts:
nice - but I don'T see the relation to EVMS.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.

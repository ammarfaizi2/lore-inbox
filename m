Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQKHAOg>; Tue, 7 Nov 2000 19:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbQKHAO0>; Tue, 7 Nov 2000 19:14:26 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:31239 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129477AbQKHAOO>; Tue, 7 Nov 2000 19:14:14 -0500
Message-ID: <3A0899EC.BCF17E69@timpanogas.org>
Date: Tue, 07 Nov 2000 17:10:20 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.21.0011071648100.8417-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:
> 
> Jeff, the kernel image is already pretty large. if you try and take what
> are basicly independant kernel images and put them in one file you will
> very quickly endup with something that is to large to use.
> 
> As an example a kenel for a boot floppy needs to be <1.4MB compressed,
> it's not uncommon for it to be >800K compressed as it is, how do you fit
> even two of these on a disk.
> 
> remember it's not just the start of the file that varies based on cachline
> size, it's the positioning of code and data thoughout the kernel image.
> 

Understood.  I will go off and give some thought and study and respond
later after I have a proposal on the best way to do this.   In NetWare,
we had indirections in the code all over the place.  NT just make huge
and fat programs (NTKRNLOS.DLL is absolutely huge).

Jeff

> David Lang
> 
>  On Tue, 7 Nov
> 2000, Jeff V. Merkey wrote:
> 
> > Date: Tue, 07 Nov 2000 16:47:08 -0700
> > From: Jeff V. Merkey <jmerkey@timpanogas.org>
> > To: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: Installing kernel 2.4
> >
> >
> >
> > "Jeff V. Merkey" wrote:
> > >
> > > davej@suse.de wrote:
> > > >
> > > > > There are tests for all this in the feature flags for intel and
> > > > > non-intel CPUs like AMD -- including MTRR settings.  All of this could
> > > > > be dynamic.  Here's some code that does this, and it's similiar to
> > > > > NetWare.  It detexts CPU type, feature flags, special instructions,
> > > > > etc.  All of this on x86 could be dynamically detected.
> > > >
> > > > Detecting the CPU isn't the issue (we already do all this), it's what to
> > > > do when you've figured out what the CPU is. Show me code that can
> > > > dynamically adjust the alignment of the routines/variables/structs
> > > > dependant upon cacheline size.
> >
> > ftp.timpanogas.org/manos/manos0817.tar.gz
> >
> > Look in the PE loader -- Microsoft's PE loader can do this since
> > everything is RVA based.  If you want to take the loader and put it in
> > Linux, be my guest.  You can even combine mutiple i86 segments all
> > compiled under different options (or architectures) and bundle them into
> > a single executable file -- not somthing gcc can do today -- even with
> > DLL.  This code is almost identical to the PE loader used in NT -- with
> > one exception, I omit the fs:_THREAD_DLS startup code...
> >
> > 8)
> >
> > Jeff
> >
> >
> > >
> > > If the compiler always aligned all functions and data on 16 byte
> > > boundries (NetWare)
> > > for all i386 code, it would run a lot faster.  Cache line alignment
> > > could be an option in the loader .... after all, it's hte loader that
> > > locates data in memory.  If Linux were PE based, relocation logic would
> > > be a snap with this model (like NT).
> > >
> > > Jeff
> > >
> > > >
> > > > regards,
> > > >
> > > > Davej.
> > > >
> > > > --
> > > > | Dave Jones <davej@suse.de>  http://www.suse.de/~davej
> > > > | SuSE Labs
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> >
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

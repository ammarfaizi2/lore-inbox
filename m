Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSG1ToR>; Sun, 28 Jul 2002 15:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317176AbSG1ToR>; Sun, 28 Jul 2002 15:44:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16216 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317169AbSG1ToP>; Sun, 28 Jul 2002 15:44:15 -0400
To: Anton Altaparmakov <aia21@cantab.net>
Cc: torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: [BK PATCH 2.5] fs/binfmt_aout.c: Use PAGE_ALIGN_LL() on 64-bit values
References: <E17YRsD-0006Hw-00@storm.christs.cam.ac.uk>
	<E17YRsD-0006Hw-00@storm.christs.cam.ac.uk>
	<5.1.0.14.2.20020728194633.04207dd0@pop.cus.cam.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2002 13:35:28 -0600
In-Reply-To: <5.1.0.14.2.20020728194633.04207dd0@pop.cus.cam.ac.uk>
Message-ID: <m1n0sbhchr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cantab.net> writes:

> At 18:59 28/07/02, Eric W. Biederman wrote:
> >Anton Altaparmakov <aia21@cantab.net> writes:
> > > Following from previous patch which introduced PAGE_ALIGN_LL, this
> > > one fixes a bug in fs/binfmt_aout.c which was using PAGE_ALIGN
> > > on 64-bit values... It now uses PAGE_ALIGN_LL.
> > >
> > > Patch together with the other two patches available from:
> > >
> > >       bk pull http://linux-ntfs.bkbits.net/linux-2.5-pm
> >
> >Huh?
> >
> >All virtual addresses on 32bit platforms are 32bit, as are all lengths
> >of address space.
> 
> I thought (intel) CPUs did 48-bit addressing? How do we support 32GiB of RAM?
> With pure 32-bit addressing it would be limited to 4GiB only... No? (Of course I
> 
> am probably confusing varius types of addresses...)

Hammers and Alphas have 48bit virtual and 40bit physical, in the
current implementations.  The most common 48bit address though is that
ide recently moved from 28bit sector addresses to 48bit sector addresses.
 
> >Unless you are running a 32bit kernel with a 64bit user space,
> >which is simply crazy, unless you are stuck doing it that way.
> 
> The code is still broken. The values ARE 64-bit (check the struct definitions if
> you don't believe me). 

I just did.  The values are per arch, but at least for X86 the values are
unsigned int.  Which is 32bits..

Eric

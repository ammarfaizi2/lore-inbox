Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313415AbSDJSHP>; Wed, 10 Apr 2002 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313425AbSDJSHO>; Wed, 10 Apr 2002 14:07:14 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:5648 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S313415AbSDJSHN>;
	Wed, 10 Apr 2002 14:07:13 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200204101807.g3AI79Q46938@saturn.cs.uml.edu>
Subject: Re: implementing soft-updates
To: kubla@sciobyte.de (Dominik Kubla)
Date: Wed, 10 Apr 2002 14:07:09 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        alexis@cecm.usp.br (Alexis S. L. Carvalho),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020410092807.GA4015@duron.intern.kubla.de> from "Dominik Kubla" at Apr 10, 2002 11:28:07 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla writes:
> On Tue, Apr 09, 2002 at 08:41:28PM -0400, Albert D. Cahalan wrote:

>> While ext2 fsck doesn't guarantee anything, in practice it is far
>> more reliable than ufs fsck. If you change the algorithms to be
>> like those used by BSD, then you may lose some of the ability to
>> recover. Remember, fsck isn't just for power failures. It tries
>> to piece together a filesystem that has suffered disk corruption
>> caused by attackers, kernel bugs, fdisk screwups, MS-DOS writing
>> past the end of a partition, Windows NT Disk Manager, viruses,
>> disk head crashes, and every other cause you can imagine. If you
>> change fsck to make BSD-style assumptions about write ordering,
>> you weaken the ability to deal with disasters.
>
> I disagree. In fact the current BSD softupdate code guarantees that all
> that ever happens is that freed blocks are not entered into the free
> block list. Something fsck can fix in background on a life system. See
> M. Kirk McKusicks BSDcon 02 paper 'Running fsck in background.'

Two cases:

a. proper shutdown -- somewhat OK to never fsck
b. unclean shutdown -- may involve kernel crashing

So with an unclean filesystem, _any_ avoidance of fsck is
suspect. I have a UPS; when my system boots on an unclean
filesystem it's because XFree86 thought it could run a
hardware driver in userspace.

Journalling gives you a nice list of recently-touched data
structures to examine. The phase-tree algorithm can support
low-cost incremental checksumming of the whole filesystem.
Soft-updates leave you with... well, is prayer any good?
You'd better run fsck at boot, which AFAIK is exactly what
is done; you even say "not include [...] background fsck".

> The fact that the BSD FFS in it's currently released version (which does
> not include snapshot and background fsck capability) is considered to be
> one of the more reliable file systems around, even when softupdates are
> enabled, speaks for itself. So please just as you don't want horror
> stories about Linux ext2 spread: don't do it yourself.

I'm just tired of this: "Back when I used to use Linux 2.1.44 my
disks were trashed so bad that I lost everything! So use BSD."
Last time I checked, BSD fsck didn't have a set of regression tests
like ext2 fsck does. On the BSD mailing lists you can read about
fsck getting signal 11. So it's not God's Glorious Filesystem by
any means.

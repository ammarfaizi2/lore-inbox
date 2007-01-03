Return-Path: <linux-kernel-owner+w=401wt.eu-S1750736AbXACMfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbXACMfQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 07:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbXACMfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 07:35:16 -0500
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:42270 "EHLO
	mail-gw3.sa.ew.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbXACMfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 07:35:14 -0500
To: pavel@ucw.cz
CC: bhalevy@panasas.com, arjan@infradead.org, mikulas@artax.karlin.mff.cuni.cz,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
In-reply-to: <20070103115632.GA3062@elf.ucw.cz> (message from Pavel Machek on
	Wed, 3 Jan 2007 12:56:32 +0100)
Subject: Re: Finding hardlinks
References: <20061221185850.GA16807@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org> <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu> <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu> <20070103115632.GA3062@elf.ucw.cz>
Message-Id: <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 03 Jan 2007 13:33:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > the use of a good hash function.  The chance of an accidental
> > > > collision is infinitesimally small.  For a set of 
> > > > 
> > > >          100 files: 0.00000000000003%
> > > >    1,000,000 files: 0.000003%
> > > 
> > > I do not think we want to play with probability like this. I mean...
> > > imagine 4G files, 1KB each. That's 4TB disk space, not _completely_
> > > unreasonable, and collision probability is going to be ~100% due to
> > > birthday paradox.
> > > 
> > > You'll still want to back up your 4TB server...
> > 
> > Certainly, but tar isn't going to remember all the inode numbers.
> > Even if you solve the storage requirements (not impossible) it would
> > have to do (4e9^2)/2=8e18 comparisons, which computers don't have
> > enough CPU power just yet.
> 
> Storage requirements would be 16GB of RAM... that's small enough. If
> you sort, you'll only need 32*2^32 comparisons, and that's doable.
> 
> I do not claim it is _likely_. You'd need hardlinks, as you
> noticed. But system should work, not "work with high probability", and
> I believe we should solve this in long term.

High probability is all you have.  Cosmic radiation hitting your
computer will more likly cause problems, than colliding 64bit inode
numbers ;)

But you could add a new interface for the extra paranoid.  The
proposed 'samefile(fd1, fd2)' syscall is severly limited by the heavy
weight of file descriptors.

Another idea is to export the filesystem internal ID as an arbitray
length cookie through the extended attribute interface.  That could be
stored/compared by the filesystem quite efficiently.

But I think most apps will still opt for the portable intefaces which
while not perfect, are "good enough".

Miklos

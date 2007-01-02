Return-Path: <linux-kernel-owner+w=401wt.eu-S1753742AbXABUmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbXABUmI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbXABUmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:42:07 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:53631 "EHLO
	mail-gw1.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbXABUmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:42:06 -0500
To: pavel@ucw.cz
CC: bhalevy@panasas.com, arjan@infradead.org, mikulas@artax.karlin.mff.cuni.cz,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
In-reply-to: <20070102191504.GA5276@ucw.cz> (message from Pavel Machek on Tue,
	2 Jan 2007 19:15:05 +0000)
Subject: Re: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org> <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu> <20070102191504.GA5276@ucw.cz>
Message-Id: <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 02 Jan 2007 21:41:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >> It seems like the posix idea of unique <st_dev, st_ino> doesn't
> > > >> hold water for modern file systems 
> > > > 
> > > > are you really sure?
> > > 
> > > Well Jan's example was of Coda that uses 128-bit internal file ids.
> > > 
> > > > and if so, why don't we fix *THAT* instead
> > > 
> > > Hmm, sometimes you can't fix the world, especially if the filesystem
> > > is exported over NFS and has a problem with fitting its file IDs uniquely
> > > into a 64-bit identifier.
> > 
> > Note, it's pretty easy to fit _anything_ into a 64-bit identifier with
> > the use of a good hash function.  The chance of an accidental
> > collision is infinitesimally small.  For a set of 
> > 
> >          100 files: 0.00000000000003%
> >    1,000,000 files: 0.000003%
> 
> I do not think we want to play with probability like this. I mean...
> imagine 4G files, 1KB each. That's 4TB disk space, not _completely_
> unreasonable, and collision probability is going to be ~100% due to
> birthday paradox.
> 
> You'll still want to back up your 4TB server...

Certainly, but tar isn't going to remember all the inode numbers.
Even if you solve the storage requirements (not impossible) it would
have to do (4e9^2)/2=8e18 comparisons, which computers don't have
enough CPU power just yet.

It doesn't matter if there are collisions within the filesystem, as
long as there are no collisions between the set of files an
application is working on at the same time.

Miklos

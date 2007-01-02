Return-Path: <linux-kernel-owner+w=401wt.eu-S1754958AbXABVLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbXABVLn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754964AbXABVLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:11:43 -0500
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:41913 "EHLO
	mail-gw3.sa.ew.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbXABVLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:11:41 -0500
To: mikulas@artax.karlin.mff.cuni.cz
CC: pavel@ucw.cz, bhalevy@panasas.com, arjan@infradead.org,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
In-reply-to: <Pine.LNX.4.64.0701022148340.21943@artax.karlin.mff.cuni.cz>
	(message from Mikulas Patocka on Tue, 2 Jan 2007 21:50:50 +0100 (CET))
Subject: Re: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu>
 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
 <1166869106.3281.587.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
 <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org>
 <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu>
 <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701022148340.21943@artax.karlin.mff.cuni.cz>
Message-Id: <E1H1qtW-0001yH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 02 Jan 2007 22:10:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Certainly, but tar isn't going to remember all the inode numbers.
> > Even if you solve the storage requirements (not impossible) it would
> > have to do (4e9^2)/2=8e18 comparisons, which computers don't have
> > enough CPU power just yet.
> 
> It is remembering all inode numbers with nlink > 1 and many other tools 
> are remembering all directory inode numbers (see my other post on this 
> topic).

Don't you mean they are remembering all the inode numbers of the
directories _above_ the one they are currently working on?  I'm quite
sure they aren't remembering all the directories they have processed.

> It of course doesn't compare each number with all others, it is
> using hashing.

Yes, I didn't think of that.

> > It doesn't matter if there are collisions within the filesystem, as
> > long as there are no collisions between the set of files an
> > application is working on at the same time.
> 
> --- that are all files in case of backup.

No, it's usually working with a _single_ file at a time.  It will
remember inode numbers of files with nlink > 1, but it won't remember
all the other inode numbers.

You could have a filesystem with 4billion files, each one having two
links.  Not a likely scenario though.

Miklos

Return-Path: <linux-kernel-owner+w=401wt.eu-S1161294AbXAHNle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161294AbXAHNle (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbXAHNle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:41:34 -0500
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:42847 "EHLO
	mail-gw3.sa.ew.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161290AbXAHNld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:41:33 -0500
To: mj@ucw.cz
CC: pavel@ucw.cz, mikulas@artax.karlin.mff.cuni.cz, matthew@wil.cx,
       bhalevy@panasas.com, arjan@infradead.org, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
In-reply-to: <mj+md-20070108.131932.29709.nikam@ucw.cz> (message from Martin
	Mares on Mon, 8 Jan 2007 14:26:07 +0100)
Subject: Re: Finding hardlinks
References: <20070104225929.GC8243@elf.ucw.cz> <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu> <20070105131235.GB4662@ucw.cz> <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz> <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701080652220.3506@artax.karlin.mff.cuni.cz> <E1H3qCY-0004mP-00@dorka.pomaz.szeredi.hu> <20070108112916.GB25857@elf.ucw.cz> <E1H3tAe-00052Q-00@dorka.pomaz.szeredi.hu> <mj+md-20070108.131932.29709.nikam@ucw.cz>
Message-Id: <E1H3uif-0005E2-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 08 Jan 2007 14:39:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You mean POSIX compliance is impossible?  So what?  It is possible to
> > implement an approximation that is _at least_ as good as samefile().
> > One really dumb way is to set st_ino to the 'struct inode' pointer for
> > example.  That will sure as hell fit into 64bits and will give a
> > unique (alas not stable) identifier for each file.  Opening two files,
> > doing fstat() on them and comparing st_ino will give exactly the same
> > guarantees as samefile().
> 
> Good, ... except that it doesn't work. AFAIK, POSIX mandates inodes
> to be unique until umount, not until inode cache expires :-)
> 
> IOW, if you have such implementation of st_ino, you can emulate samefile()
> with it, but you cannot have it without violating POSIX.

The whole discussion started out from the premise, that some
filesystems can't support stable unique inode numbers, i.e. they don't
conform to POSIX.

Filesystems which do conform to POSIX have _no need_ for samefile().
Ones that don't conform, can chose a scheme that is best suited to
applications need, balancing uniqueness and stability in various ways.

> > 4 billion files, each with more than one link is pretty far fetched.
> 
> Not on terabyte scale disk arrays, which are getting quite common these days.
> 
> > And anyway, filesystems can take steps to prevent collisions, as they
> > do currently for 32bit st_ino, without serious difficulties
> > apparently.
> 
> They currently do that usually by not supporting more than 4G files
> in a single FS.

And with 64bit st_ino, they'll have to live with the limitation of not
more than 2^64 files.  Tough luck ;)

Miklos

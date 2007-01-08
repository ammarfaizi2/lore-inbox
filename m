Return-Path: <linux-kernel-owner+w=401wt.eu-S1161246AbXAHMAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161246AbXAHMAq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 07:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbXAHMAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 07:00:45 -0500
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:47597 "EHLO
	mail-gw2.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161246AbXAHMAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 07:00:44 -0500
To: pavel@ucw.cz
CC: mikulas@artax.karlin.mff.cuni.cz, matthew@wil.cx, bhalevy@panasas.com,
       arjan@infradead.org, jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
In-reply-to: <20070108112916.GB25857@elf.ucw.cz> (message from Pavel Machek on
	Mon, 8 Jan 2007 12:29:16 +0100)
Subject: Re: Finding hardlinks
References: <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu> <20070104225929.GC8243@elf.ucw.cz> <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu> <20070105131235.GB4662@ucw.cz> <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz> <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701080652220.3506@artax.karlin.mff.cuni.cz> <E1H3qCY-0004mP-00@dorka.pomaz.szeredi.hu> <20070108112916.GB25857@elf.ucw.cz>
Message-Id: <E1H3tAe-00052Q-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 08 Jan 2007 13:00:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There's really no point trying to push for such an inferior interface
> > when the problems which samefile is trying to address are purely
> > theoretical.
> 
> Oh yes, there is. st_ino is powerful, *but impossible to implement*
> on many filesystems.

You mean POSIX compliance is impossible?  So what?  It is possible to
implement an approximation that is _at least_ as good as samefile().
One really dumb way is to set st_ino to the 'struct inode' pointer for
example.  That will sure as hell fit into 64bits and will give a
unique (alas not stable) identifier for each file.  Opening two files,
doing fstat() on them and comparing st_ino will give exactly the same
guarantees as samefile().

> > Currently linux is living with 32bit st_ino because of legacy apps,
> > and people are not constantly agonizing about it.  Fixing the
> > EOVERFLOW problem will enable filesystems to slowly move towards 64bit
> > st_ino, which should be more than enough.
> 
> 50% probability of false positive on 4G files seems like very ugly
> design problem to me.

4 billion files, each with more than one link is pretty far fetched.
And anyway, filesystems can take steps to prevent collisions, as they
do currently for 32bit st_ino, without serious difficulties
apparently.

Miklos

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSDBWop>; Tue, 2 Apr 2002 17:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312989AbSDBWof>; Tue, 2 Apr 2002 17:44:35 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:24568 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312980AbSDBWoR>; Tue, 2 Apr 2002 17:44:17 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 2 Apr 2002 15:42:54 -0700
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about 'Hidden' Directories in ext2
Message-ID: <20020402224254.GO4735@turbolinux.com>
Mail-Followup-To: "Calin A. Culianu" <calin@ajvar.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0204021704360.6590-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 02, 2002  17:16 -0500, Calin A. Culianu wrote:
> Ok, so some hackers broke into one of our boxes and set up an ftp site.
> They monopolized over 70gb of hard drive space with warez and porn.  We
> aren't really that upset about it, since we thought it was kind of funny.
> (Of course we don't like the idea that they are using out bandwidth and
> disk space, but we can easily remedy that).
> 
> Anyway, the weird thing is they created 2 directories, both of which were
> strangely hidden.  You can cd into them but you can't ls them.  I
> 
> /usr/lib/ypx and /usr/man/ypx were the two directories that contained both
> the ftp software and the ftp root.  When you are in /usr/man and you do an
> ls, you don't see the ypx directory (same when you are in /usr/lib).  The
> ls binary we got is right off the redhat cd so it shouldn't still be
> compromised by whatever rootkit was installed.
> 
> My question is this: can the data structures in ext2fs be somehow hacked
> so a directory can't appear in a listing but can be otherwise located for
> a stat or a chdir?  I should think no.. maybe we still haven't gotten rid
> of the rootkit...

It could be that glibc is hacked also, unless you have a
statically-linked ls command.  Try booting directly from the CD.

Yes, it is possible to hack ext2 to not show directories named "ypx" (or
whatever you want).  Non-trivial, but doable.  I had read somewhere that
"modern" linux rootkits load kernel modules, so that they intercept
kernel syscalls, like "sys_getdents()" or "sys_getdents64()" to not show
that you have been hacked.

Really, once you are compromized like this, you are better off to back
up your data and reinstall your OS (taking care that no suid binaries
exist in user home directories and such, there shouldn't normally be
any).

You should also take care that you download the latest RPM updates, and
have them available to machine before it is connected to the net again.
I have heard of machines being compromized within minutes of being
installed, before they update to secure RPMs, just because the number
of crack attempts is so high.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277529AbRJJXe7>; Wed, 10 Oct 2001 19:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277530AbRJJXet>; Wed, 10 Oct 2001 19:34:49 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:50927 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277529AbRJJXe2>; Wed, 10 Oct 2001 19:34:28 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 10 Oct 2001 17:34:49 -0600
To: Doug McNaught <doug@wireboard.com>
Cc: Lew Wolfgang <wolfgang@sweet-haven.com>, linux-kernel@vger.kernel.org
Subject: Re: Dump corrupts ext2?
Message-ID: <20011010173449.Q10443@turbolinux.com>
Mail-Followup-To: Doug McNaught <doug@wireboard.com>,
	Lew Wolfgang <wolfgang@sweet-haven.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com> <m3elob3xao.fsf@belphigor.mcnaught.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3elob3xao.fsf@belphigor.mcnaught.org>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 10, 2001  19:11 -0400, Doug McNaught wrote:
> Lew Wolfgang <wolfgang@sweet-haven.com> writes:
> > I was looking for some scripts to backup ext2 partitions
> > to multiple CDR's when I stumbled onto "cdbackup" at
> > http://www.cableone.net/ccondit/cdbackup/.
> > 
> > Alas, there is a warning saying:
> > 
> > "WARNING! When using this program under Linux, be sure not to use
> >  dump with kernels in the 2.4.x series. Using dump on an ext2
> >  filesystem has a very high potential for causing filesystem
> >  corruption.  As of kernel version 2.4.5, this has not been
> >  resolved, and it may not be for some time."
> 
> I'm pretty sure this is because dump reads the block device directly
> (which is cached in the buffer cache), while the file data for cached
> files lives in the page cache, and the two caches are no longer
> coherent (as of 2.4).

In Linus kernels 2.4.11+ the block devices and filesystems all use the
page cache, so no more coherency issues.

Also, I don't think this ever had the potential to corrupt the filesystem,
but maybe make a slightly bad backup.

> If you can find it, Linus has ranted on this list at least once about
> why you should never use 'dump'...

Yes, but the only issue is if the filesystem is busy, you may get
a bad backup for those files that have changed, but not for any files
that have not changed during the backup.

Reasons for not using tar or cpio include atime change and the fact
that an "incremental" tar can't record the deletion of a file (AFAIK).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279684AbRKAUIh>; Thu, 1 Nov 2001 15:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279688AbRKAUIc>; Thu, 1 Nov 2001 15:08:32 -0500
Received: from [63.231.122.81] ([63.231.122.81]:59948 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S279684AbRKAUIT>;
	Thu, 1 Nov 2001 15:08:19 -0500
Date: Thu, 1 Nov 2001 13:07:21 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: writing a plugin for reiserfs compression
Message-ID: <20011101130721.D16554@lynx.no>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	reiser@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111011754580.2106-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0111011754580.2106-100000@mustard.heime.net>; from roy@karlsbakk.net on Thu, Nov 01, 2001 at 06:14:11PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 01, 2001  18:14 +0100, Roy Sigurd Karlsbakk wrote:
> Novell NetWare has a feature I really like. It's a file compression
> feature they've been having since version 4.0 (or 4.10) of the OS.

Yes, there is a patch for ext2 that does this as well.

> New attributes must be added somehow. 'ls' and 'find' and perhaps other
> files must be modified to take advantage of this. The compression job can
> be a simple script with something like
> 
> 	find . -type f ! --compressed ! --dont-compress / -exec fcomp {} \;
> 
> (and check can't compress and force compression).

There already exists a patch for reiserfs which uses the same interface
to file attributes that ext2 and ext3 use.

Also, ext2 already has a "compressed", "do not compress", and "dirty"
attributes.  They are currently not all user modifyable for ext2
filesystems via chattr/lsattr, but that doesn't mean they cannot be
on reiserfs.

> There must be a way to access the compressed files directly to make
> backups more efficient - backing up already compressed files's a good
> thing.

Yes, there is also such an attribute for "raw" access I think.

Making the user-space interface and tools as compatible as possible is
a good thing, IMHO, just like "ls", "cp", etc all work regardless of
the underlying filesystem.

As a note to whoever at namesys created the reiserfs patch to add the
"notail" flag (overloading the "nodump" flag).  I would much rather
that a new "notail" flag be allocated for this.  I will contact Ted
Ted Ts'o to get a flag assigned.  This will avoid any problems in the
future, and may also be useful at some time for ext2.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


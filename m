Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280623AbRKBJcR>; Fri, 2 Nov 2001 04:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280624AbRKBJcI>; Fri, 2 Nov 2001 04:32:08 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:18180 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S280623AbRKBJbw>; Fri, 2 Nov 2001 04:31:52 -0500
From: Nikita Danilov <Nikita@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15330.26496.902280.59610@beta.reiserfs.com>
Date: Fri, 2 Nov 2001 12:29:36 +0300
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, reiser@namesys.com,
        linux-kernel@vger.kernel.org
Subject: Re: writing a plugin for reiserfs compression
In-Reply-To: <20011101130721.D16554@lynx.no>
In-Reply-To: <Pine.LNX.4.30.0111011754580.2106-100000@mustard.heime.net>
	<20011101130721.D16554@lynx.no>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
 > On Nov 01, 2001  18:14 +0100, Roy Sigurd Karlsbakk wrote:
 > > Novell NetWare has a feature I really like. It's a file compression
 > > feature they've been having since version 4.0 (or 4.10) of the OS.
 > 
 > Yes, there is a patch for ext2 that does this as well.
 > 
 > > New attributes must be added somehow. 'ls' and 'find' and perhaps other
 > > files must be modified to take advantage of this. The compression job can
 > > be a simple script with something like
 > > 
 > > 	find . -type f ! --compressed ! --dont-compress / -exec fcomp {} \;
 > > 
 > > (and check can't compress and force compression).
 > 
 > There already exists a patch for reiserfs which uses the same interface
 > to file attributes that ext2 and ext3 use.
 > 
 > Also, ext2 already has a "compressed", "do not compress", and "dirty"
 > attributes.  They are currently not all user modifyable for ext2
 > filesystems via chattr/lsattr, but that doesn't mean they cannot be
 > on reiserfs.
 > 
 > > There must be a way to access the compressed files directly to make
 > > backups more efficient - backing up already compressed files's a good
 > > thing.
 > 
 > Yes, there is also such an attribute for "raw" access I think.
 > 
 > Making the user-space interface and tools as compatible as possible is
 > a good thing, IMHO, just like "ls", "cp", etc all work regardless of
 > the underlying filesystem.
 > 
 > As a note to whoever at namesys created the reiserfs patch to add the
 > "notail" flag (overloading the "nodump" flag).  I would much rather

It was me. Agree completely that allocating new flag would be better. I
just wanted "notail" to actually work and be accessible through standard
utilities, because it's really useful. "nodump" looked like least useful
of flags for me, because dump(8) doesn't work with reiserfs (not that it
worked with ext2 reliably either). I actually tried to contact Remy Card
and Theodore Tso, to discuss how [ls|ch]attr can be modified to support
different file-systems, but to no avail.

 > that a new "notail" flag be allocated for this.  I will contact Ted
 > Ted Ts'o to get a flag assigned.  This will avoid any problems in the
 > future, and may also be useful at some time for ext2.

I would rather like to see lsattr/chattr to become file-system
independent. This requires that all file-systems use the same ioctl cmds
to set and get bitmasks associated with inodes and provide somehow a
mapping between symbolic name of an attribute and bitmask. Support for
octal bitmask (a la chmod) in chattr is also an option.

 > 
 > Cheers, Andreas

Nikita.

 > --
 > Andreas Dilger
 > http://sourceforge.net/projects/ext2resize/
 > http://www-mddsp.enel.ucalgary.ca/People/adilger/
 > 
 > -
--
I regret that you do not very much trust my signature, on the pretext
that we might be several. // J. Derrida, The Post Card.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280995AbRKGVO5>; Wed, 7 Nov 2001 16:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280989AbRKGVNm>; Wed, 7 Nov 2001 16:13:42 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:44027 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280990AbRKGVMq>;
	Wed, 7 Nov 2001 16:12:46 -0500
Date: Wed, 7 Nov 2001 14:11:57 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: James A Sutherland <jas88@cam.ac.uk>
Cc: Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107141157.L5922@lynx.no>
Mail-Followup-To: James A Sutherland <jas88@cam.ac.uk>,
	Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu> <E161Vbf-0000m9-00@lilac.csi.cam.ac.uk> <20011107213837.F26218@niksula.cs.hut.fi> <E161ZYW-0006ky-00@mauve.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E161ZYW-0006ky-00@mauve.csi.cam.ac.uk>; from jas88@cam.ac.uk on Wed, Nov 07, 2001 at 08:44:25PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  20:44 +0000, James A Sutherland wrote:
> On Wednesday 07 November 2001 7:38 pm, Ville Herva wrote:
> > On Wed, Nov 07, 2001 at 04:31:24PM +0000, you [James A Sutherland] claimed:
> > > Hm.. after a decidedly unclean shutdown, I decided to force an fsck here
> > > and my ext3 partition DID have two inode errors on fsck... (Having said
> > > that, the last entry in syslog was from the SCSI driver, and ext3's
> > > journalling probably doesn't help much when the disk it's on goes
> > > AWOL...)
> >
> > A stupid question: does ext3 replay the journal before fsck? If not, the
> > inode errors would be expected...
> 
> Yes, it does: this was AFTER the journal replay. And yes, it was ext3 not 
> ext2 mounting it (well, either that or ext2 has learned to do journal 
> replays...).

Actuall, e2fsck can also do the journal replay, so depending on whether this
is the root fs or not, it may be that you get a journal replay and still
mount it as ext2...

> So, AFTER a journal replay, there were still two damaged inodes 
> - which sounds like Anton's problem. Maybe ext3 just hates Cambridge? :-)

Well, if you had a SCSI error, then it may be that the fs marked an error
in the superblock, which would force a full fsck also.

Note also, that it is often normal to have "orphaned inodes" cleaned up when
the journal is cleaned up.  This is not an error.  I normally have these on
my system because of PCMCIA cardmgr creating device inodes in /tmp and then
unlinking them immediately after opening them.

If you have an open but unlinked file, then ext3 will delete this file at
mount/fsck time (unlike reiserfs which leaves it around wasting space).
Did you actually get files in lost+found, or only the orphaned inode
message?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281158AbRKHANy>; Wed, 7 Nov 2001 19:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKHANo>; Wed, 7 Nov 2001 19:13:44 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:37039 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281158AbRKHANg>; Wed, 7 Nov 2001 19:13:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: ext3 vs resiserfs vs xfs
Date: Thu, 8 Nov 2001 00:13:39 +0000
X-Mailer: KMail [version 1.3.1]
Cc: Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu> <E161ZYW-0006ky-00@mauve.csi.cam.ac.uk> <20011107141157.L5922@lynx.no>
In-Reply-To: <20011107141157.L5922@lynx.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E161cp0-0001e7-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 November 2001 9:11 pm, Andreas Dilger wrote:
> On Nov 07, 2001  20:44 +0000, James A Sutherland wrote:
> > On Wednesday 07 November 2001 7:38 pm, Ville Herva wrote:
> > > On Wed, Nov 07, 2001 at 04:31:24PM +0000, you [James A Sutherland] 
claimed:
> > > > Hm.. after a decidedly unclean shutdown, I decided to force an fsck
> > > > here and my ext3 partition DID have two inode errors on fsck...
> > > > (Having said that, the last entry in syslog was from the SCSI driver,
> > > > and ext3's journalling probably doesn't help much when the disk it's
> > > > on goes AWOL...)
> > >
> > > A stupid question: does ext3 replay the journal before fsck? If not,
> > > the inode errors would be expected...
> >
> > Yes, it does: this was AFTER the journal replay. And yes, it was ext3 not
> > ext2 mounting it (well, either that or ext2 has learned to do journal
> > replays...).
>
> Actuall, e2fsck can also do the journal replay, so depending on whether
> this is the root fs or not, it may be that you get a journal replay and
> still mount it as ext2...

The journal replay occurred on mount, well before fsck was invoked.

> > So, AFTER a journal replay, there were still two damaged inodes
> > - which sounds like Anton's problem. Maybe ext3 just hates Cambridge? :-)
>
> Well, if you had a SCSI error, then it may be that the fs marked an error
> in the superblock, which would force a full fsck also.
>
> Note also, that it is often normal to have "orphaned inodes" cleaned up
> when the journal is cleaned up.  This is not an error.  I normally have
> these on my system because of PCMCIA cardmgr creating device inodes in /tmp
> and then unlinking them immediately after opening them.

They were not orphaned inodes, they were inodes with incorrect size & block 
values...

> If you have an open but unlinked file, then ext3 will delete this file at
> mount/fsck time (unlike reiserfs which leaves it around wasting space).
> Did you actually get files in lost+found, or only the orphaned inode
> message?

Nothing in l&f, just the familiar (from ext2!) scenario of automatic fsck 
finding errors, then dropping me to a single-user login to run fsck manually.


James.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267778AbTCFMWS>; Thu, 6 Mar 2003 07:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267795AbTCFMWR>; Thu, 6 Mar 2003 07:22:17 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:11242 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S267778AbTCFMWQ>; Thu, 6 Mar 2003 07:22:16 -0500
Date: Thu, 6 Mar 2003 12:32:48 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <Pine.LNX.4.30.0303060716390.28143-100000@divine.city.tvnet.hu>
Message-ID: <Pine.SOL.3.96.1030306122732.1983B-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Szakacsits Szabolcs wrote:
> On Wed, 5 Mar 2003, Randy.Dunlap wrote:
> 
> > > Could you try to turn on debugging in the NTFS driver (compile option in the
> > > menus), then once ntfs module is loaded (or otherwise anytime) as root do:
> > >
> > > echo -1 > /proc/sys/fs/ntfs-debug
> > >
> > > Then mount and to the directory changes. Assuming that you get the bug again
> > > could you send me the captured kernel log output? (Note there will be
> > > massive amounts of output.)
> > >
> > > The code looks ok and I can't reproduce here so it would be helpful to see
> > > if there are any oddities on your partition. Just to make sure it is not the
> > > compiler, could you do a "make fs/ntfs/inode.S" and send me that as well?
> > >
> > > Thanks,
> >
> > Anton,
> >
> > I'll get to this in another day or so.
> >
> > The help text for NTFS_DEBUG says to use 1 to enable it
> > or 0 to disable it.  What does -1 do?
> 
> Same as 1. However I doubt NTFS_DEBUG gives any useful in your case
> and if you had some NTFS "oddities" then it would be reproducible.
> 
> What would be really useful is to disassemble __ntfs_init_inode what I
> asked 2 days ago (note, not the above 'make fs/ntfs/inode.S' because
> it will not tell what machine code you have on disk), your .config and
> exact CPU version (cat /proc/cpuinfo).

Yes it will, unless you suspect the assembler to get it wrong which is
highly unlikely. All compiler bugs I have ever seen have been quite well
visible in the .S assembler file.

The .S file is the only easy way to find out which the faulting
instruction from the oops output is and once you know the instruction you
reverse compile to know which C statement it was and once you know that
you know which variable was NULL/random value and then you can start
looking for the answer to "how the fsck did that happen?"... (-; At least
I have managed to find and fix quite a few bugs using that approach
before. But without the .S file + oops output it is impossible to do as my
compiler/.config would mean the oops output is not too useful in
combination with my own .S file...

Cheers,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


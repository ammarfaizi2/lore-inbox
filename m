Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWB0Ils@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWB0Ils (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWB0Ils
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:41:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31960 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932309AbWB0Ilr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:41:47 -0500
Subject: Re: GFS2 Filesystem [13/16]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060222185059.GC2633@ucw.cz>
References: <1140793524.6400.734.camel@quoit.chygwyn.com>
	 <20060222185059.GC2633@ucw.cz>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 27 Feb 2006 08:46:48 +0000
Message-Id: <1141030008.6400.780.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2006-02-22 at 18:50 +0000, Pavel Machek wrote:
> Hi!
> 
> >  Documentation/filesystems/gfs2.txt |   44 +++++++++++++++++++++++++++++++++++
> >  fs/Kconfig                         |    6 ++--
> >  fs/Makefile                        |    2 +
> >  fs/gfs2/Kconfig                    |   46 +++++++++++++++++++++++++++++++++++++
> >  fs/gfs2/Makefile                   |   42 +++++++++++++++++++++++++++++++++
> >  5 files changed, 137 insertions(+), 3 deletions(-)
> > 
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -883,8 +884,6 @@ config CONFIGFS_FS
> >  	  Both sysfs and configfs can and should exist together on the
> >  	  same system. One is not a replacement for the other.
> >  
> > -	  If unsure, say N.
> > -
> 
> Why? Most users probably still want configfs_fs=N.
> 
Yes, this one has crept in by mistake I think. I'll fix that right away.

> > @@ -1327,7 +1326,7 @@ config UFS_FS
> >  
> >  config UFS_FS_WRITE
> >  	bool "UFS file system write support (DANGEROUS)"
> > -	depends on UFS_FS && EXPERIMENTAL
> > +	depends on UFS_FS && EXPERIMENTAL && BROKEN
> >  	help
> 
> Well, maybe, but I thought this is gfs2 patch...
> 
Indeed. This even does not feature in any of the gfs2 patches in the git
tree. For some reason the command I used to create the diff has picked
up this change as well. I'm not entirely sure why as its in both the
gfs2 tree and the origin tree (Linus' tree).

> 
> > +To use gfs as a local file system, no external clustering systems are
> > +needed, simply:
> > +
> > +  $ mkfs -t gfs2 -p lock_nolock -j 1 /dev/block_device
> > +  $ mount -t gfs2 /dev/block_device /dir
> > +
> > +GFS2 is not on-disk compatible with previous versions of GFS.
> > +
> > +The following man pages can be found at the URL above:
> > +  gfs2_mkfs	to make a filesystem
> 
> I thought conventional name would be mkfs.gfs2 ... could you use that
> variant?
> 
> 								Pavel
Yes, you can. I just always tend to run it through the mkfs front end
rather than directly. It installs itself under mkfs.gfs2 of course and
we need up update the man page (GFS1 used to call its mkfs gfs_mkfs but
I saw no reason not to make the change to a more conventional name).

Steve.



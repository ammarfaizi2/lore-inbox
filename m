Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319149AbSIDMCc>; Wed, 4 Sep 2002 08:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319150AbSIDMCc>; Wed, 4 Sep 2002 08:02:32 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:5649 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319149AbSIDMCb>; Wed, 4 Sep 2002 08:02:31 -0400
Message-ID: <3D75F77B.9B0610F5@aitel.hist.no>
Date: Wed, 04 Sep 2002 14:07:23 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] mount flag "direct" (fwd)
References: <200209032107.g83L71h10758@oboe.it.uc3m.es> <3D75B344.66D4166@aitel.hist.no> <20020904083916.GX32468@clusterfs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Sep 04, 2002  09:16 +0200, Helge Hafting wrote:
> > Your idea about re-reading stuff over and over isn't going to help
> > because that sort of thing consumes much more bandwith. Caches help
> > because they _avoid_ data transfers.  So shared writeable data
> > will happen, and it will use some sort of cache coherency,
> > for performance reasons.
> 
> You assume too much about the applications.  For example, Oracle
> does not want _any_ cacheing to be done by the OS, because it
> manages the cache itself, and would rather allocate the full amount
> of RAM itself instead of the OS duplicating data it is cacheing
> internally.
> 
There are things like O_DIRECT for this.  A fine add-on for
some apps, and it don't break the fs for all those apps that
like caching.  

A uncached distributed fs is another story.  Having to void
all cache (or no cache at all) whenever some other machine
locks the fs might be just the ticket for some applications,
but I can't see that working for the generic case.  

Which is why
I think a special fs is in place here.  It could possibly start
off as a fork from ext2 (or ntfs or vfat or whatever seems
appropriate) but I cannot see how this sort of thing could be merged.
And why force it into _every_ existing fs?  This distributed
scheme really needs all of them?

> > I claim that making a new fs from scratch for the distributed
> > case is easier than tweaking ext2 and 10-20 other existing fs'es
> > to work in such an environment.  Making a new fs from scratch
> > isn't such a big deal after all.
> 
> The problem isn't making a new fs, the problem is making a _good_
> new fs.  It takes at least several years of development, testing,
> tuning, etc to get just a local fs right, if not longer (i.e.
> reiserfs, JFS, XFS, ext3, etc).  Add in the complexity of the
> network side of things and it just gets that much harder to do
> it all well.

Making a good new fs might take time, but changing all existing
fs'es to support "no caching when another guy has the lock"
is so invasive that I'd call it a set of new fs'es, and I think
he'll need some time to get that working _well_. 
I believe a special purpose fs for special needs is easier
in this case.
> 
> We have taken the approach that local filesystems do a good job
> with the "one node" assumption, so just use them as-is to
> do a job they are good at.  

A completely different approach, avoiding the trouble of
drastically altering something that works.

Helge Hafting

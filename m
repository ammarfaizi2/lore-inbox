Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319100AbSIDIgl>; Wed, 4 Sep 2002 04:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319102AbSIDIgl>; Wed, 4 Sep 2002 04:36:41 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:39410 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S319100AbSIDIgk>; Wed, 4 Sep 2002 04:36:40 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 4 Sep 2002 02:39:16 -0600
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mount flag "direct" (fwd)
Message-ID: <20020904083916.GX32468@clusterfs.com>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>, ptb@it.uc3m.es,
	linux-kernel@vger.kernel.org
References: <200209032107.g83L71h10758@oboe.it.uc3m.es> <3D75B344.66D4166@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D75B344.66D4166@aitel.hist.no>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 04, 2002  09:16 +0200, Helge Hafting wrote:
> Your idea about re-reading stuff over and over isn't going to help 
> because that sort of thing consumes much more bandwith. Caches help
> because they _avoid_ data transfers.  So shared writeable data
> will happen, and it will use some sort of cache coherency,
> for performance reasons.

You assume too much about the applications.  For example, Oracle
does not want _any_ cacheing to be done by the OS, because it
manages the cache itself, and would rather allocate the full amount
of RAM itself instead of the OS duplicating data it is cacheing
internally.

Similarly, there are many "write only" applications that are only
hindered by OS cache, such as any kind of high-speed data recording
(video, particle accelerators, scientific computing, etc) which is
using most of the RAM for internal structures and wants the data it
writes to go directly to disk at the highest possible speed.

> I claim that making a new fs from scratch for the distributed
> case is easier than tweaking ext2 and 10-20 other existing fs'es
> to work in such an environment.  Making a new fs from scratch
> isn't such a big deal after all.

The problem isn't making a new fs, the problem is making a _good_
new fs.  It takes at least several years of development, testing,
tuning, etc to get just a local fs right, if not longer (i.e.
reiserfs, JFS, XFS, ext3, etc).  Add in the complexity of the
network side of things and it just gets that much harder to do
it all well.

We have taken the approach that local filesystems do a good job
with the "one node" assumption, so just use them as-is to
do a job they are good at.  All of the network and locking code
for Lustre is outside of the filesystem, and the "local" filesystems
are used for storing either the directory structure + attributes
(for the metadata server), or file data (for the storage targets).

Local filesystems can do both of those jobs very well already, so
no need to re-invent the wheel.

See http://www.lustre.org/docs.html for lots of papers and
documentation on the design of Lustre.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/


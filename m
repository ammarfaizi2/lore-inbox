Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSGZRtn>; Fri, 26 Jul 2002 13:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317889AbSGZRtn>; Fri, 26 Jul 2002 13:49:43 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:31215 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317887AbSGZRtl>; Fri, 26 Jul 2002 13:49:41 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 26 Jul 2002 11:50:27 -0600
To: Kurt Garloff <garloff@suse.de>, Alexander Viro <viro@math.psu.edu>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] sd_many done right (1/5)
Message-ID: <20020726175027.GC2746@clusterfs.com>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alexander Viro <viro@math.psu.edu>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20020726154533.GD19721@nbkurt.etpnet.phys.tue.nl> <Pine.GSO.4.21.0207261245070.21586-100000@weyl.math.psu.edu> <20020726165411.GI19721@nbkurt.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726165411.GI19721@nbkurt.etpnet.phys.tue.nl>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 26, 2002  18:54 +0200, Kurt Garloff wrote:
> On Fri, Jul 26, 2002 at 12:45:41PM -0400, Alexander Viro wrote:
> > On Fri, 26 Jul 2002, Kurt Garloff wrote:
> > > The patches are all available at
> > > http://www.suse.de/~garloff/linux/scsi-many/
> > 
> > As long as you realize that it won't go in 2.5 in that form...
> 
> The sd parts can and should be ported to 2.5, I think.
> The /proc/scsi/scsi extensions and other stuff I wrote to support it, 
> won't be needed, as we have driverfs in 2.5.
> And, of course, the device number management will be solved in a more
> general way, but I do not yet see how. 

Actually, one interesting aspect of the EVMS vs. device-mapper argument
going on that has totally been missed is that EVMS can do management of
ALL disk block devices.

At startup time it "consumes" all of the disk block devices in order to
generate the various mappings (LVM, RAID, etc) and at the end it spits
out the resulting devices as EVMS major devices.  This includes devices
that have not been remapped, like hdXY or sdMN.  EVMS has facilities
to ensure that devices get repeatable major/minor numbers if needed,
but they are allocated on an as-needed basis.

Currently EVMS only has a single major number, but it is my understanding
that they could easily take over all of the IDE and SCSI major numbers.
We would not have to worry about sparse device number allocation anymore,
and could have thousands of disks/partitions without any problems.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/


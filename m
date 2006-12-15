Return-Path: <linux-kernel-owner+w=401wt.eu-S964987AbWLOVGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWLOVGP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWLOVGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:06:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44699 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964960AbWLOVGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:06:13 -0500
Date: Fri, 15 Dec 2006 13:05:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
Message-Id: <20061215130552.95860b72.akpm@osdl.org>
In-Reply-To: <17795.2681.523120.656367@cse.unsw.edu.au>
References: <20061204203410.6152efec.akpm@osdl.org>
	<17780.63770.228659.234534@cse.unsw.edu.au>
	<20061205061623.GA13749@amd64.of.nowhere>
	<20061205062142.GA14784@amd64.of.nowhere>
	<20061204224323.2e5d0494.akpm@osdl.org>
	<20061205105928.GA6482@amd64.of.nowhere>
	<17782.28505.303064.964551@cse.unsw.edu.au>
	<20061215192146.GA3616@amd64.of.nowhere>
	<17795.2681.523120.656367@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006 07:50:01 +1100
Neil Brown <neilb@suse.de> wrote:

> On Friday December 15, thunder7@xs4all.nl wrote:
> > From: Neil Brown <neilb@suse.de>
> > Date: Wed, Dec 06, 2006 at 06:20:57PM +1100
> > > i.e. current -mm is good for 2.6.20 (though I have a few other little
> > > things I'll be sending in soon, they aren't related to the raid6
> > > problem).
> > > 
> > 2.6.20-rc1-mm1 doesn't boot on my box, due to the fact that e2fsck gives
> > 
> > Buffer I/O error on device /dev/md0, logical block 0
> > 
> 
> But before that....
> > raid5: device sdh1 operational as raid disk 1
> > raid5: device sdg1 operational as raid disk 0
> > raid5: device sdf1 operational as raid disk 5
> > raid5: device sde1 operational as raid disk 6
> > raid5: device sdd1 operational as raid disk 7
> > raid5: device sdc1 operational as raid disk 3
> > raid5: device sdb1 operational as raid disk 2
> > raid5: device sda1 operational as raid disk 4
> > raid5: allocated 8462kB for md0
> > raid5: raid level 6 set md0 active with 8 out of 8 devices, algorithm 2
> > RAID5 conf printout:
> >  --- rd:8 wd:8
> >  disk 0, o:1, dev:sdg1
> >  disk 1, o:1, dev:sdh1
> >  disk 2, o:1, dev:sdb1
> >  disk 3, o:1, dev:sdc1
> >  disk 4, o:1, dev:sda1
> >  disk 5, o:1, dev:sdf1
> >  disk 6, o:1, dev:sde1
> >  disk 7, o:1, dev:sdd1
> > md0: bitmap initialized from disk: read 15/15 pages, set 1 bits, status: 0
> > created bitmap (233 pages) for device md0
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sde1, disabling device. Operation continuing on 7 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdg1, disabling device. Operation continuing on 6 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdf1, disabling device. Operation continuing on 5 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdc1, disabling device. Operation continuing on 4 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdb1, disabling device. Operation continuing on 3 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdh1, disabling device. Operation continuing on 2 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdd1, disabling device. Operation continuing on 1 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sda1, disabling device. Operation continuing on 0 devices
> 
> Oh dear, that array isn't much good any more.!
> That is the second report I have had of this with sata drives.  This
> was raid456, the other was raid1.  Two different sata drivers are
> involved (sata_nv in this case, sata_uli in the other case).
> I think something bad happened in sata land just recently.
> The device driver is returning -EIO for a write without printing any messages.
> 

OK, this is bad.  The wheels do appear to have fallen off sata in rc1-mm1.

Jeff, I shall send all the sata patches which I have at you one single time
and I shall then drop the lot.  So please don't flub them.

I'll then do a rc1-mm2 without them.

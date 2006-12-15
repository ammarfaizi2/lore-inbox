Return-Path: <linux-kernel-owner+w=401wt.eu-S965077AbWLOVQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWLOVQL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWLOVQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:16:10 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:39605 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965077AbWLOVQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:16:09 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
Date: Fri, 15 Dec 2006 22:18:32 +0100
User-Agent: KMail/1.9.1
Cc: Neil Brown <neilb@suse.de>, Jurriaan <thunder7@xs4all.nl>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
References: <20061204203410.6152efec.akpm@osdl.org> <17795.2681.523120.656367@cse.unsw.edu.au> <20061215130552.95860b72.akpm@osdl.org>
In-Reply-To: <20061215130552.95860b72.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612152218.33184.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 15 December 2006 22:05, Andrew Morton wrote:
> On Sat, 16 Dec 2006 07:50:01 +1100
> Neil Brown <neilb@suse.de> wrote:
> 
> > On Friday December 15, thunder7@xs4all.nl wrote:
> > > From: Neil Brown <neilb@suse.de>
> > > Date: Wed, Dec 06, 2006 at 06:20:57PM +1100
> > > > i.e. current -mm is good for 2.6.20 (though I have a few other little
> > > > things I'll be sending in soon, they aren't related to the raid6
> > > > problem).
> > > > 
> > > 2.6.20-rc1-mm1 doesn't boot on my box, due to the fact that e2fsck gives
> > > 
> > > Buffer I/O error on device /dev/md0, logical block 0
> > > 
> > 
> > But before that....
> > > raid5: device sdh1 operational as raid disk 1
> > > raid5: device sdg1 operational as raid disk 0
> > > raid5: device sdf1 operational as raid disk 5
> > > raid5: device sde1 operational as raid disk 6
> > > raid5: device sdd1 operational as raid disk 7
> > > raid5: device sdc1 operational as raid disk 3
> > > raid5: device sdb1 operational as raid disk 2
> > > raid5: device sda1 operational as raid disk 4
> > > raid5: allocated 8462kB for md0
> > > raid5: raid level 6 set md0 active with 8 out of 8 devices, algorithm 2
> > > RAID5 conf printout:
> > >  --- rd:8 wd:8
> > >  disk 0, o:1, dev:sdg1
> > >  disk 1, o:1, dev:sdh1
> > >  disk 2, o:1, dev:sdb1
> > >  disk 3, o:1, dev:sdc1
> > >  disk 4, o:1, dev:sda1
> > >  disk 5, o:1, dev:sdf1
> > >  disk 6, o:1, dev:sde1
> > >  disk 7, o:1, dev:sdd1
> > > md0: bitmap initialized from disk: read 15/15 pages, set 1 bits, status: 0
> > > created bitmap (233 pages) for device md0
> > > md: super_written gets error=-5, uptodate=0
> > > raid5: Disk failure on sde1, disabling device. Operation continuing on 7 devices
> > > md: super_written gets error=-5, uptodate=0
> > > raid5: Disk failure on sdg1, disabling device. Operation continuing on 6 devices
> > > md: super_written gets error=-5, uptodate=0
> > > raid5: Disk failure on sdf1, disabling device. Operation continuing on 5 devices
> > > md: super_written gets error=-5, uptodate=0
> > > raid5: Disk failure on sdc1, disabling device. Operation continuing on 4 devices
> > > md: super_written gets error=-5, uptodate=0
> > > raid5: Disk failure on sdb1, disabling device. Operation continuing on 3 devices
> > > md: super_written gets error=-5, uptodate=0
> > > raid5: Disk failure on sdh1, disabling device. Operation continuing on 2 devices
> > > md: super_written gets error=-5, uptodate=0
> > > raid5: Disk failure on sdd1, disabling device. Operation continuing on 1 devices
> > > md: super_written gets error=-5, uptodate=0
> > > raid5: Disk failure on sda1, disabling device. Operation continuing on 0 devices
> > 
> > Oh dear, that array isn't much good any more.!
> > That is the second report I have had of this with sata drives.  This
> > was raid456, the other was raid1.  Two different sata drivers are
> > involved (sata_nv in this case, sata_uli in the other case).
> > I think something bad happened in sata land just recently.
> > The device driver is returning -EIO for a write without printing any messages.
> > 
> 
> OK, this is bad.  The wheels do appear to have fallen off sata in rc1-mm1.

I think it's happened in 2.6.19-mm1 already, since that kernel breaks md RAID1
on my box (the sata_uli case above).

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312894AbSDKUQ4>; Thu, 11 Apr 2002 16:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312896AbSDKUQz>; Thu, 11 Apr 2002 16:16:55 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1531
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312894AbSDKUQy>; Thu, 11 Apr 2002 16:16:54 -0400
Date: Thu, 11 Apr 2002 13:18:59 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: RAID superblock confusion
Message-ID: <20020411201859.GM23513@matchmail.com>
Mail-Followup-To: Luigi Genoni <kernel@Expansa.sns.it>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
In-Reply-To: <15541.137.92102.72095@notabene.cse.unsw.edu.au> <Pine.LNX.4.44.0204111216300.17814-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 12:19:35PM +0200, Luigi Genoni wrote:
> > On Wednesday April 10, mfedyk@matchmail.com wrote:
> > > On Thu, Apr 11, 2002 at 11:38:19AM +1000, Neil Brown wrote:
> > > > autodetect is the other alternative.  However, as has been mentioned,
> > > > it does not and cannot work with md as a module.  This is because
> > > > devices can only be register for autodetection after md.o is loaded,
> > > > and autodetection is done at the time that md is loaded.  So
> > > > autodetection can only work if the device driver and md are loaded at
> > > > simultaneously.  i.e. they are compiled into the kernel.
> > >
> > > Ahh, but if you use initrd you can even have the ide and scsi drivers as
> > > modules.
> > >
> > > What is needed is to make the disk modules depend on the raid modules (only
> > > if the raid code is enabled of course) so that modprobe can load the raid
> > > modules first.
> you are supposing that I load md modules and raid module together, mostly

md and raid is the same and not split yet as Niel proposed.

> during boot with initrd. In the reality I have some servers with more that
> 200 days of uptime, and I have to change external disks sometime. I do
> usually have two external boxes, and something like 8/20 disks (two scsi
> controllers),  and different raid on different disks. You see, it is not
> that easy.

Currently, if you have raid compiled as modules the autodetection does not
work, and is disabled.  The issue here is enabling autodetection from the
modules, wheather that be at boot time or not.  If you use raid modules you
won't get the autodetection and the features that come with that.

When adding a new disk, you would have to add it to an array manually with
the raidtools2 anyway, so this is unchanged.

Mike

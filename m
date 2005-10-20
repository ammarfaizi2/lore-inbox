Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVJTMRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVJTMRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 08:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVJTMRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 08:17:17 -0400
Received: from mail.velocity.net ([66.211.211.55]:60825 "EHLO
	mail.velocity.net") by vger.kernel.org with ESMTP id S932091AbVJTMRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 08:17:16 -0400
X-AV-Checked: Thu Oct 20 08:17:16 2005 clean
Subject: Re: scsi disk size reporting in dmesg
From: Dale Blount <linux-kernel@dale.us>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051019220920.7c91b922.rdunlap@xenotime.net>
References: <1129577044.17327.11.camel@dale.velocity.net>
	 <20051019220920.7c91b922.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 08:17:15 -0400
Message-Id: <1129810635.22387.11.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 22:09 -0700, Randy.Dunlap wrote:
> On Mon, 17 Oct 2005 15:24:04 -0400 Dale Blount wrote:
> 
> > Hello,
> > 
> > I just added 2 external 1TB+ scsi devices to my i686 linux server
> > running 2.6.13.4 connected to external LSI MPT card.  fdisk and df both
> > show the sizes correctly (see below), but I'm worried that dmesg reports
> > them incorrectly.
> > 
> > SCSI device sda: 2460934144 512-byte hdwr sectors (160487 MB)
> > SCSI device sdb: 3790438400 512-byte hdwr sectors (841193 MB)
> > 
> > I don't think it's as simple as a variable overflow because both
> > sdkp->capacity and mb look to be cast as unsigned long longs.  I know a
> > workaround is to present less data per LUN, but I'd like to use it as
> > it's setup currently if possible.  Is this just printing incorrectly or
> > will I run into trouble when the device gets more full?
> 
> The casts to (unsigned long long) just fix the printk() args to match
> the format strings (and eliminate warnings).
> 
> Looks to me like sdkp->capacity is correct.  The <mb> value looks
> way off.  Since it's just printed here for user info, I don't see
> how it can be a problem later on.
> 

That's what I was hoping, but I didn't know for sure.  I figured I'd
better ask to make sure my data wouldn't get truncated when the disk got
fuller.  Between my first post and now, I've tested it by filling the
drive with data and testing the md5sums for each file and it seems to
work.  Other than the odd MB size reported, it seems to work just fine.

> I don't see the error just yet.  Are there any other SCSI device-
> related messages near these?  And just to confirm, but you must
> have CONFIG_LBD (Large Block Device) enabled, right?
> 

No, there are no other related messages near these other than the
standard vendor/versions.  I did not enable CONFIG_LBD since the help
says "bigger than 2TB", and I partitioned the storage system to present
disks smaller than that.

Thanks for the reply,

Dale


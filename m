Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWFWDt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWFWDt1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWFWDt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:49:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20142 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751229AbWFWDt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:49:27 -0400
Date: Thu, 22 Jun 2006 20:49:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, agk@redhat.com, mbroz@redhat.com, hch@lst.de
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
Message-Id: <20060622204907.48c0b841.akpm@osdl.org>
In-Reply-To: <200606222231.17465.kevcorry@us.ibm.com>
References: <20060621193121.GP4521@agk.surrey.redhat.com>
	<20060622151721.GT19222@agk.surrey.redhat.com>
	<20060622095551.b5c6ddce.akpm@osdl.org>
	<200606222231.17465.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 22:31:16 -0500
Kevin Corry <kevcorry@us.ibm.com> wrote:

> On Thu June 22 2006 11:55 am, Andrew Morton wrote:
> > On Thu, 22 Jun 2006 16:17:21 +0100 Alasdair G Kergon <agk@redhat.com> wrote:
> > > On Thu, Jun 22, 2006 at 01:29:57AM -0700, Andrew Morton wrote:
> > > See also block/scsi_ioctl.c:201 verify_command()  [scsi_cmd_ioctl]
> > >          * file can be NULL from ioctl_by_bdev()...
> > >
> > > Or should we be working towards eliminating interfaces that use device
> > > numbers?
> >
> > If possible.  I guess that would require DM to track the devices with
> > file*'s or inode*'s or bdev*'s.  Which, I assume, would be non-trivial.
> 
> There already is a bdev pointer available. Each "consumed" device get a struct 
> dm_dev, which has a *bdev field. From the bdev, it looks like we should be 
> able to get to the gendisk, then the block_device_operations, and then the 
> ioctl routine (if it exists). Correct?
> 

My head is spinning in a twisty maze of ioctls.  What _should_ we call? 
file_operations.foo_ioctl() or block_device_operations.foo_ioctl() or
blkdev_ioctl()?

I think as far as the user is concerned, file_operations.foo_ioctl(),
because that's what the user would end up calling against /dev/sda. 
Whether that's always, reliably, equivalent to
block_device_operations.foo_ioctl() I am presently disinclined to spare
time to discover.

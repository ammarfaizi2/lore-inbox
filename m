Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWFWDdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWFWDdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWFWDdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:33:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:38581 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932069AbWFWDdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:33:06 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
Organization: IBM
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alasdair G Kergon <agk@redhat.com>
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
Date: Thu, 22 Jun 2006 22:31:16 -0500
User-Agent: KMail/1.8.3
Cc: mbroz@redhat.com, Christoph Hellwig <hch@lst.de>
References: <20060621193121.GP4521@agk.surrey.redhat.com> <20060622151721.GT19222@agk.surrey.redhat.com> <20060622095551.b5c6ddce.akpm@osdl.org>
In-Reply-To: <20060622095551.b5c6ddce.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606222231.17465.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu June 22 2006 11:55 am, Andrew Morton wrote:
> On Thu, 22 Jun 2006 16:17:21 +0100 Alasdair G Kergon <agk@redhat.com> wrote:
> > On Thu, Jun 22, 2006 at 01:29:57AM -0700, Andrew Morton wrote:
> > See also block/scsi_ioctl.c:201 verify_command()  [scsi_cmd_ioctl]
> >          * file can be NULL from ioctl_by_bdev()...
> >
> > Or should we be working towards eliminating interfaces that use device
> > numbers?
>
> If possible.  I guess that would require DM to track the devices with
> file*'s or inode*'s or bdev*'s.  Which, I assume, would be non-trivial.

There already is a bdev pointer available. Each "consumed" device get a struct 
dm_dev, which has a *bdev field. From the bdev, it looks like we should be 
able to get to the gendisk, then the block_device_operations, and then the 
ioctl routine (if it exists). Correct?

-- 
Kevin Corry
kevcorry@us.ibm.com
http://www.ibm.com/linux/
http://evms.sourceforge.net/

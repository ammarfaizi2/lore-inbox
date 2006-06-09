Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbWFIDvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWFIDvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 23:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWFIDvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 23:51:51 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:7316 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965129AbWFIDvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 23:51:50 -0400
Subject: Re: [PATCH 2/3] SCSI core and sd: early detection of medium not
	present
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0606061126540.9182-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0606061126540.9182-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 19:57:46 -0500
Message-Id: <1149814666.3276.16.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 11:31 -0400, Alan Stern wrote:
> This patch (as695) changes the scsi_test_unit_ready() routine in the
> SCSI 
> core to set a new flag when no medium is present.  The sd driver is 
> changed to use this new flag for reporting -ENOMEDIUM in from the 
> sd_media_changed method.

This would appear to be duplicating the struct scsi_disk media_present
flag.  Moving the media_present flag from scsi_disk to scsi_device may
make a bit of sense long term ... however, there's also dupication with
the sr driver and the cdrom layer now (that stores media change at the
cdrom level), so is there an argument why it's better in scsi_device
than scsi_disk?

James



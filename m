Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWFIDvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWFIDvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 23:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWFIDvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 23:51:53 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:7060 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965126AbWFIDvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 23:51:50 -0400
Subject: Re: [PATCH 1/3] block layer: early detection of medium not present
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0606061113040.9182-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0606061113040.9182-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 20:07:09 -0500
Message-Id: <1149815229.3276.20.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 11:26 -0400, Alan Stern wrote:
> When the block layer checks for new media in a drive, it uses a two-step 
> procedure: First it checks for media change and then it revalidates the 
> disk.  When no medium is present the second step fails.
> 
> However some drivers (such as the SCSI disk driver) are capable of
> detecting medium-not-present as part of the media-changed check.  Doing so
> will reduce by a factor of 2 or more the amount of work done by tasks
> which, like hald, constantly poll empty drives.
> 
> This patch (as694) changes the block layer core to make it recognize a 
> -ENOMEDIUM error return from the media_changed method.  A follow-on patch 
> makes the sd driver return this code when no medium is present.

I'm not sure there's enough buy in to make this change yet ... our media
change handling is incredibly (and quite possibly far too) complex.

As documented in Documentation/cdrom/cdrom-standard.tex, the return
codes for media change are either 0 or 1.

Personally, I can't see a problem with overloading the true return to
have more information that the error codes provide, but before we do
this we need the buy in of the cdrom layer, since that's where this
handling came from, and we need to update the documents to reflect the
new behaviour ... someone also needs to consider what changes should be
made in the cdrom layer for this (and whether this is actually the
correct way to do this from the point of view of CDs).

James



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbTLKM40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 07:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTLKM40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 07:56:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2695 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264921AbTLKM4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 07:56:19 -0500
Date: Thu, 11 Dec 2003 13:56:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
Message-ID: <20031211125608.GG7599@suse.de>
References: <3FD444DD.4080206@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD444DD.4080206@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08 2003, Douglas Gilbert wrote:
> Yes dev=/dev/scd0 should work for "real" SCSI (and USB, IEEE1394
> and sATA [via libata] attached) cd/dvd players in lk 2.6.
> Copying the SG_IO ioctl and friends into the block
> layer isn't exactly pretty in lk 2.6. No doubt I'll be hearing from
> the author of cdrecord about some of the rough edges. Basically
> cdrecord is tricked into believing it is talking to an sg device.

It's not tricked, cdrecord should not care about device type. All it
needs to care about is SG_IO working or not.

> One rough edge is cdrecord's use of the SCSI_IOCTL_GET_IDLUN ioctl
> which encodes bus/channel/target/lun into an integer. cdrecord
> uses this for its dev=<n,m,q> notation. The drivers/block/scsi_ioctl.c
> implementation returns 0 in all cases. So if you have 2 or more
> ATAPI cd/dvd burners cdrecord's dev=<n,m,q> usage won't be able
> to differentiate.

Not sure I see any merrit in supporting that at all, but if so it would
be pretty easy to fake these.

> ide-scsi has always had problems (I spent about a week on it
> and gave up with only a few minor fixes to report) but it
> may be a useful "insurance" driver to keep around in lk 2.6 .
> [It is also needed for ATAPI tapes so its deprecatation
> warning might like to take into account the peripheral device
> type.]

It does, the 2.6 warning printed is just for CDROM devices.

> Well making the scsi layer handle some of the the most
> sophisticated storage devices and some of the most brain
> damaged at the same time is proving quite a challenge.
> With libata (and later SAS) sATA disks will be getting to
> the application space via the sd driver. And how will
> object storage devices fit into Linux's block-centric I/O
> architecture?

What makes you say that Linux has a block-centric IO architecture? 2.6
block io layer is quite happy to do byte-granularity SCSI commands for
you.

-- 
Jens Axboe


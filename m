Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbTHYMI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbTHYMI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:08:28 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:57097 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261725AbTHYMIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:08:25 -0400
Date: Mon, 25 Aug 2003 13:08:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       ballen@gravity.phys.uwm.edu
Subject: Re: [2.6.0-test4] blocking access to mounted scsi devices
Message-ID: <20030825130822.A4258@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Douglas Gilbert <dougg@torque.net>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, ballen@gravity.phys.uwm.edu
References: <3F49B515.6010107@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F49B515.6010107@torque.net>; from dougg@torque.net on Mon, Aug 25, 2003 at 05:04:53PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 05:04:53PM +1000, Douglas Gilbert wrote:
> A recent test of smartmontools on lk 2.6.0-test4 failed
> miserably on my main SCSI disk. It would seem that
> attempts to use either the:
>     SCSI_IOCTL_SEND_COMMAND
>     SG_IO
> ioctls on a mounted SCSI "block" device fail with EBUSY.
> These ioctls work fine on devices that don't have mounted
> file systems on then. If this is a new policy then it needs
> to be reconsidered. smartmontools still works ok on ATA disks
> in lk 2.6.0-test4.

That's because both mount (or e.g. volume managers) claims
devices for exclusive use, as does drivers/block/scsi_ioctl.c

> Both the ioctls in question still work via the corresponding
> scsi generic device.

Well, we either want both to work or not work.  The current
situation is inconsistant.

> Will scsi generic devices make a
> re-appearance in sysfs (as indicated by Christoph when the
> relevant code in sg was removed)?

Yeah, I still need to come up with a way for class_interfaces
like sg to have sysfs entries.  the TODO list is growing but
I'll take a look at this, promised.


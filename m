Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUEKQRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUEKQRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264818AbUEKQRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:17:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23218 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264819AbUEKQP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:15:26 -0400
Date: Tue, 11 May 2004 18:14:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kurt Garloff <garloff@suse.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Format Unit can take many hours
Message-ID: <20040511161427.GW1906@suse.de>
References: <20040511114936.GI4828@tpkurt.garloff.de> <20040511122037.GG1906@suse.de> <40A0FAE9.90900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A0FAE9.90900@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Tue, May 11 2004, Kurt Garloff wrote:
> >
> >>Hi,
> >>
> >>the timeout for FORMAT_UNIT should be much longer; I've seen 8hrs
> >>already (75Gig). I've increased the timeout from 2hrs to 12hrs.
> >>
> >>Regards,
> >>-- 
> >>Kurt Garloff  <garloff@suse.de>                            Cologne, DE 
> >>SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)
> >
> >
> >>--- linux-2.6.5.orig/drivers/scsi/scsi_ioctl.c	2004-04-04 
> >>05:38:20.000000000 +0200
> >>+++ linux-2.6.5/drivers/scsi/scsi_ioctl.c	2004-05-11 
> >>08:59:12.837421215 +0200
> >>@@ -26,12 +26,12 @@
> >>#include "scsi_logging.h"
> >>
> >>#define NORMAL_RETRIES			5
> >>-#define IOCTL_NORMAL_TIMEOUT			(10 * HZ)
> >>-#define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
> >>+#define IOCTL_NORMAL_TIMEOUT		(10 * HZ)
> >>+#define FORMAT_UNIT_TIMEOUT		(12 * 60 * 60 * HZ)
> >>#define START_STOP_TIMEOUT		(60 * HZ)
> >>#define MOVE_MEDIUM_TIMEOUT		(5 * 60 * HZ)
> >>#define READ_ELEMENT_STATUS_TIMEOUT	(5 * 60 * HZ)
> >>-#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ )  /* ZIP-250 on parallel 
> >>port takes as long! */
> >>+#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ)  /* ZIP-250 on parallel 
> >>port takes as long! */
> >>
> >>#define MAX_BUF PAGE_SIZE
> >
> >
> >block/scsi_ioctl.c should likely receive similar treatment then.
> 
> 
> This timeout is dependent on media size, I should think...
> 
> Is there any reason to think that this timeout will _not_ be continually 
> patched in the future, as larger and larger sizes are used?

I think the timeout is only used for ancient programs that use the old
sg interface. Newer programs should pass in the timeout themselves, or
set IMMED as somebody else in this thread noted.

So I do think the easiest is just to patch this define for the odd case,
and forget about it.

-- 
Jens Axboe


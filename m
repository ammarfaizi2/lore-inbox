Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTKFJ72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTKFJ72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:59:28 -0500
Received: from ns.suse.de ([195.135.220.2]:53135 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263478AbTKFJ7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 04:59:00 -0500
Date: Thu, 6 Nov 2003 10:17:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Mike Anderson <andmike@us.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Message-ID: <20031106091751.GC1379@suse.de>
References: <B179AE41C1147041AA1121F44614F0B060ED64@AVEXCH02.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B179AE41C1147041AA1121F44614F0B060ED64@AVEXCH02.qlogic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05 2003, Andrew Vasquez wrote:
> Mike,
> 
> > > A new version of the 8.x series driver for Linux 2.6.x kernels has
> > > been uploaded to SourceForge:
> > 
> > Thanks for the update.
> > 
> > Can you give more information on why clustering was turned off
> > starting in b5?
> > 
> 
> This change was part of a relatively large performance-patch that was
> originally against the 6.x series driver.  There were two main reasons
> for disabling clustering support:
> 
> 	o Given the ability of the ISP to efficiently DMA to and from
> 	  a significant number of data segment descriptors (via
> 	  command/continuation type IOCBs), there were some questions
> 	  regarding the benefits that clustering provided given the
> 	  overhead incurred by the mid-layer attempting merge the
> 	  requests.

That is valid.

> 	o Given the ISPs inability to handle data segments that cross
> 	  32-bit page boundaries, and the overhead in defensive logic
> 	  within the driver to prevent these cases (compare the 6.x
> 	  code to the 8.x code and you will see what I mean), by
> 	  disabling clustering we guarantee that a single SG element
> 	  never crosses a 4GB boundary.

That is not, however. Linux will never give you a segment crossing a 4GB
boundary, exactly because most hardware cannot handle this.

> Now, in 2.6 there are some significant changes.  For one, with the
> block layer rewrite and the ability to limit segment boundaries of a
> block queue request with the blk_queue_segment_boundary() call, a LLDD
> need not concern itself with any defensive fast-path logic to handle
> the 4GB cross.

Ditto 2.4. See BH_PHYS_4G().

> So, we're left with the benefits of the overhead of this merge process
> done by the block layer.  I'm certainly receptive to the notion of
> reexamining the use of clustering given some solid data points showing
> an (significant -- this is subjective) increase in performance and/or a
> resounding 'yeah, enable it!' from those in the block-layer 'know.'

In 2.6 clustering comes for free, so it would be silly not to enable it.

-- 
Jens Axboe


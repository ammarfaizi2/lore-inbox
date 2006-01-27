Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWA0Tsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWA0Tsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWA0Tsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:48:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56908 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932491AbWA0Tsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:48:42 -0500
Date: Fri, 27 Jan 2006 20:49:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Neil Brown <neilb@suse.de>,
       Chase Venters <chase.venters@clientec.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       a.titov@host.bg, askernel2615@dsgml.com, jamie@audible.transient.net
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
Message-ID: <20060127194927.GB9068@suse.de>
References: <200601270410.06762.chase.venters@clientec.com> <17369.65530.747867.844964@cse.unsw.edu.au> <20060127112352.GF4311@suse.de> <20060127112837.GG4311@suse.de> <43DA6F33.3070101@cs.wisc.edu> <1138389616.3293.13.camel@mulgrave> <43DA787F.4080406@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA787F.4080406@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, Mike Christie wrote:
> James Bottomley wrote:
> >On Fri, 2006-01-27 at 13:06 -0600, Mike Christie wrote:
> >
> >>It does not have anything to do with this in scsi_io_completion does it?
> >>
> >>        if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
> >>                return;
> >>
> >>For that case the scsi_cmnd does not get freed. Does it come back around 
> >>again and get released from a different path?
> >
> >
> >It looks such a likely candidate, doesn't it.  Unfortunately, Tejun Heo
> >removed that code around 6 Jan (in [BLOCK] update SCSI to use new
> >blk_ordered for barriers), so if it is that, then the latest kernels
> >should now not be leaking.
> >
> 
> Oh, I thought the reports were for 2.6.15 and below which has that 
> scsi_io_completion test. Have there been reports for this with 
> 2.6.16-rc1 too?

The reports of leaks are only with > 2.6.15, not with 2.6.15.

-- 
Jens Axboe


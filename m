Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWA0TVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWA0TVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWA0TVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:21:05 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:26305 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932436AbWA0TVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:21:03 -0500
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Jens Axboe <axboe@suse.de>, Neil Brown <neilb@suse.de>,
       Chase Venters <chase.venters@clientec.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       a.titov@host.bg, askernel2615@dsgml.com, jamie@audible.transient.net
In-Reply-To: <43DA6F33.3070101@cs.wisc.edu>
References: <200601270410.06762.chase.venters@clientec.com>
	 <17369.65530.747867.844964@cse.unsw.edu.au> <20060127112352.GF4311@suse.de>
	 <20060127112837.GG4311@suse.de>  <43DA6F33.3070101@cs.wisc.edu>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 13:20:16 -0600
Message-Id: <1138389616.3293.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-27 at 13:06 -0600, Mike Christie wrote:
> It does not have anything to do with this in scsi_io_completion does it?
> 
>          if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
>                  return;
> 
> For that case the scsi_cmnd does not get freed. Does it come back around 
> again and get released from a different path?

It looks such a likely candidate, doesn't it.  Unfortunately, Tejun Heo
removed that code around 6 Jan (in [BLOCK] update SCSI to use new
blk_ordered for barriers), so if it is that, then the latest kernels
should now not be leaking.

However, all the avaliable evidence does seem to point to the write
barrier enforcement.  I'll take another look over those code paths.

James



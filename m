Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWA0T3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWA0T3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWA0T3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:29:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1598 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932485AbWA0T3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:29:02 -0500
Date: Fri, 27 Jan 2006 20:29:46 +0100
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Mike Christie <michaelc@cs.wisc.edu>, Neil Brown <neilb@suse.de>,
       Chase Venters <chase.venters@clientec.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       a.titov@host.bg, askernel2615@dsgml.com, jamie@audible.transient.net
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
Message-ID: <20060127192946.GF6928@suse.de>
References: <200601270410.06762.chase.venters@clientec.com> <17369.65530.747867.844964@cse.unsw.edu.au> <20060127112352.GF4311@suse.de> <20060127112837.GG4311@suse.de> <43DA6F33.3070101@cs.wisc.edu> <1138389616.3293.13.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138389616.3293.13.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, James Bottomley wrote:
> On Fri, 2006-01-27 at 13:06 -0600, Mike Christie wrote:
> > It does not have anything to do with this in scsi_io_completion does it?
> > 
> >          if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
> >                  return;
> > 
> > For that case the scsi_cmnd does not get freed. Does it come back around 
> > again and get released from a different path?
> 
> It looks such a likely candidate, doesn't it.  Unfortunately, Tejun Heo
> removed that code around 6 Jan (in [BLOCK] update SCSI to use new
> blk_ordered for barriers), so if it is that, then the latest kernels
> should now not be leaking.

Ah I thought so, seems my memory wasn't totally shot (don't have the
sources with me).

> However, all the avaliable evidence does seem to point to the write
> barrier enforcement.  I'll take another look over those code paths.

The fact that it only happens with raid is very odd, though.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVDSMev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVDSMev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 08:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVDSMev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 08:34:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28891 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261235AbVDSMer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 08:34:47 -0400
Date: Tue, 19 Apr 2005 14:34:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Regarding posted scsi midlyaer patchsets
Message-ID: <20050419123436.GA2827@suse.de>
References: <20050417224101.GA2344@htj.dyndns.org> <1113833744.4998.13.camel@mulgrave> <4263CB26.2070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4263CB26.2070609@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18 2005, Tejun Heo wrote:
>  And, James, regarding REQ_SOFTBARRIER, if the REQ_SOFTBARRIER thing can
> be removed from SCSI midlayer, do you agree to change REQ_SPECIAL to
> mean special requests?  If so, I have three proposals.
> 
>  * move REQ_SOFTBARRIER setting to right after the allocation of
> scsi_cmnd in scsi_prep_fn().  This will be the only place where
> REQ_SOFTBARRIER is used in SCSI midlayer, making it less pervasive.
>  * Or, make another API which sets REQ_SOFTBARRIER on requeue.  maybe
> blk_requeue_ordered_request()?
>  * Or, make blk_insert_request() not set REQ_SPECIAL on requeue.  IMHO,
> this is a bit too subtle.
> 
>  I like #1 or #2.  Jens, what do you think?  Do you agree to remove
> requeue feature from blk_insert_request()?

#2 is the best, imho. We really want to maintain ordering on requeue
always, marking it softbarrier automatically in the block layer means
the io schedulers don't have to do anything specific to handle it.

I have no problem with removing the requeue stuff from
blk_insert_request(). That function is horribly weird as it is, it is
supposed to look generic but is really just a scsi special case.

-- 
Jens Axboe


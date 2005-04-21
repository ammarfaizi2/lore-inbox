Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVDUCQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVDUCQr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 22:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDUCQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 22:16:47 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:56489 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261163AbVDUCQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 22:16:41 -0400
Subject: Re: [PATCH scsi-misc-2.6 03/05] scsi: make scsi_queue_insert() use
	blk_requeue_request()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4266F1D0.2060003@gmail.com>
References: <20050419231435.D85F89C0@htj.dyndns.org>
	 <20050419231435.329FA30B@htj.dyndns.org>
	 <1114039446.5933.17.camel@mulgrave>  <4266F1D0.2060003@gmail.com>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 22:16:32 -0400
Message-Id: <1114049793.5000.4.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 09:20 +0900, Tejun Heo wrote:
>   Hello, James.
> 
> James Bottomley wrote:
> > On Wed, 2005-04-20 at 08:15 +0900, Tejun Heo wrote:
> > 
> >>-	 * Insert this command at the head of the queue for it's device.
> >>-	 * It will go before all other commands that are already in the queue.
> >>-	 *
> >>-	 * NOTE: there is magic here about the way the queue is plugged if
> >>-	 * we have no outstanding commands.
> >>-	 * 
> >>-	 * Although this *doesn't* plug the queue, it does call the request
> >>-	 * function.  The SCSI request function detects the blocked condition
> >>-	 * and plugs the queue appropriately.
> > 
> > 
> > This comment still looks appropriate to me ... why do you want to remove
> > it?
> > 
> 
>   Well, the thing is that we don't really care what exactly happens to 
> the queue or how the queue is plugged or not.  All we need to do are to 
> requeue the request and kick the queue in the ass.  Hmmm, maybe I should 
> keep the comment about how the request will be put at the head of the 
> queue, but the second part about plugging doesn't really belong here, I 
> think.

Really?  We do care greatly.  If you requeue with no other outstanding
commands to the device, the block queue will never restart unless it's
plugged, and the device will hang. The comment is explaining how this
happens.

>   Yes, that will be more efficient but I don't think it would make
> any 
> noticeable difference.  IMO, universally using scsi_run_queue() to
> kick 
> scsi request queues is better than mixing blk_run_queue() and 
> scsi_run_queue() for probably unnoticeable optimization.  If we start
> to 
> mix'em, we need to rationalize why specific one is chosen in specific 
> places and that's just unnecessary.

Fair enough.

James



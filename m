Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVDAESX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVDAESX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 23:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVDAESX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 23:18:23 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:49310 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262611AbVDAESM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 23:18:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=aeHNIDjhmhXTfu6m3SjHBSd+M7Y5REdGtGPvsU2dZNpVaxl8tzo02EyvVpu0Hsg5vSYnlo/PyHaTnbuPzrTZf2ll1/54A2Rq0EdfhNEh9W2hHimAfKSnbCKaGZky3RFi8hCnnEtBbx0g49X4kLeH6bNUC1pY2rohMDkZA5EB124=
Date: Fri, 1 Apr 2005 13:18:04 +0900
From: Tejun Heo <htejun@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, James.Bottomley@steeleye.com,
       axboe@suse.de, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 01/13] scsi: don't use blk_insert_request() for requeueing
Message-ID: <20050401041804.GA11318@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.BA0001D5@htj.dyndns.org> <20050331101211.GB13842@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331101211.GB13842@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 11:12:11AM +0100, Christoph Hellwig wrote:
> On Thu, Mar 31, 2005 at 06:07:55PM +0900, Tejun Heo wrote:
> > 01_scsi_no_REQ_SPECIAL_on_requeue.patch
> > 
> > 	blk_insert_request() has 'reinsert' argument, which, when set,
> > 	turns on REQ_SPECIAL and REQ_SOFTBARRIER and requeues the
> > 	request.  SCSI midlayer was the only user of this feature and
> > 	all requeued requests become special requests defeating
> > 	quiesce state.  This patch makes scsi midlayer use
> > 	blk_requeue_request() for requeueing and removes 'reinsert'
> > 	feature from blk_insert_request().
> > 
> > 	Note: In drivers/scsi/scsi_lib.c, scsi_single_lun_run() and
> > 	scsi_run_queue() are moved upward unchanged.
> 
> That lest part doesn't belong into this patch at all.

 Actually, it is, as scsi_queue_insert() is changed to call
scsi_run_queue() explicitly.  However, scsi_queue_insert() is removed
later, so the change is pretty dumb.  Maybe I'll add prototype and
remove it together later, or reorder patches.

 Thanks.

-- 
tejun


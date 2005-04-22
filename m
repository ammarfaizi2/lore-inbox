Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVDVLiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVDVLiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 07:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVDVLiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 07:38:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6098 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262004AbVDVLiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 07:38:01 -0400
Date: Fri, 22 Apr 2005 13:37:50 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Tejun Heo <htejun@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 03/05] scsi: make scsi_queue_insert() use blk_requeue_request()
Message-ID: <20050422113749.GZ9371@suse.de>
References: <20050419231435.D85F89C0@htj.dyndns.org> <20050419231435.329FA30B@htj.dyndns.org> <1114039446.5933.17.camel@mulgrave> <20050421061026.GE9371@suse.de> <1114087528.5054.2.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114087528.5054.2.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21 2005, James Bottomley wrote:
> On Thu, 2005-04-21 at 08:10 +0200, Jens Axboe wrote:
> > I wondered about this action recently myself. What is the point in
> > requeueing this request, only to call scsi_run_queue() ->
> > blk_run_queue() -> issue same request. If the point really is to reissue
> > the request immediately, I can think of many ways more efficient than
> > this :-)
> 
> Well ... that's because the logic that decides whether to plug the queue
> or simply exit is in the scsi_request_fn().  That's what the comment is
> about.  We could abstract the check into a function, but (unless you
> have any suggestions on rewording it) I thought the comment made what
> was going on reasonably clear.
> 

Looks fine, I just missed enough code context in the patch to see this.
Since requeuing probably isn't all that uncommon, it may make sense to
optimize this a little though.

-- 
Jens Axboe


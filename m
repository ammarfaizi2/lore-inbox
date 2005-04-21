Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVDUMpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVDUMpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 08:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVDUMpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 08:45:44 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:54448 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261334AbVDUMph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 08:45:37 -0400
Subject: Re: [PATCH scsi-misc-2.6 03/05] scsi: make scsi_queue_insert() use
	blk_requeue_request()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050421061026.GE9371@suse.de>
References: <20050419231435.D85F89C0@htj.dyndns.org>
	 <20050419231435.329FA30B@htj.dyndns.org>
	 <1114039446.5933.17.camel@mulgrave>  <20050421061026.GE9371@suse.de>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 08:45:28 -0400
Message-Id: <1114087528.5054.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 08:10 +0200, Jens Axboe wrote:
> I wondered about this action recently myself. What is the point in
> requeueing this request, only to call scsi_run_queue() ->
> blk_run_queue() -> issue same request. If the point really is to reissue
> the request immediately, I can think of many ways more efficient than
> this :-)

Well ... that's because the logic that decides whether to plug the queue
or simply exit is in the scsi_request_fn().  That's what the comment is
about.  We could abstract the check into a function, but (unless you
have any suggestions on rewording it) I thought the comment made what
was going on reasonably clear.

James



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVC2SvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVC2SvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 13:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVC2SvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 13:51:08 -0500
Received: from fmr24.intel.com ([143.183.121.16]:55964 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261294AbVC2Sur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 13:50:47 -0500
Message-Id: <200503291850.j2TIogg00494@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] new fifo I/O elevator that really does nothing at all
Date: Tue, 29 Mar 2005 10:50:44 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0OfI/jSfPDP9eQvG5Ixzw8fTASgAVYsIg
In-Reply-To: <20050329080559.GD16636@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28 2005, Chen, Kenneth W wrote:
> The noop elevator is still too fat for db transaction processing
> workload.  Since the db application already merged all blocks before
> sending it down, the I/O presented to the elevator are actually not
> merge-able anymore. Since I/O are also random, we don't want to sort
> them either.  However the noop elevator is still doing a linear search
> on the entire list of requests in the queue.  A noop elevator after
> all isn't really noop.
>
> We are proposing a true no-op elevator algorithm, no merge, no
> nothing. Just do first in and first out list management for the I/O
> request.  The best name I can come up with is "FIFO".  I also piggy
> backed the code onto noop-iosched.c.  I can easily pull those code
> into a separate file if people object.  Though, I hope Jens is OK with
> it.


Jens Axboe wrote on Tuesday, March 29, 2005 12:06 AM
> It's not quite ok, because you don't honor the insertion point in
> fifo_add_request.

But it is FIFO!  Honoring insertion point will break the promises this
elevator made to the user: first in first out.

OK, OK, I won't argue to the death of it :-).  I will give this a try.
Thanks.




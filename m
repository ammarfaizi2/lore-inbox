Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265957AbUGEIRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265957AbUGEIRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 04:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUGEIRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 04:17:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22193 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265957AbUGEIRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 04:17:48 -0400
Date: Mon, 5 Jul 2004 10:17:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-ID: <20040705081732.GB17112@suse.de>
References: <m2lli36ec9.fsf@telia.com> <20040704130544.GA3825@infradead.org> <m2llhz5o4o.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2llhz5o4o.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05 2004, Peter Osterlund wrote:
> > All in all I really wonder whether a separate driver is really that
> > a good fit for the functionality or whether it should be more
> > integrated with the block layer, ala drivers/block/scsi_ioctl.c
> 
> Jens is probably better suited than me to comment on that.

That would by far be the superior approach. The data gathering really
does belong in the fs (it's just a larger fs block size) and would rid
the driver of the elevator hacks it's currently using. Plus all the data
gathering code, which has been notoriously buggy and hard to get right
and deadlock free (in the past at least for 2.4, I haven't worked on
this for a long time so it's not a comment on 2.6 code quality).

That would basically allow the merge of the remaining setup code into
cdrom.c. It needs someone to do the actual UDF work though... The
upside is that you would get automatic support for other devices as
well, such as the 8KiB UDO.

Ideally, someone would add support for bigger PAGE_CACHE_SIZE :)

-- 
Jens Axboe


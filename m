Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268515AbUIXHYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268515AbUIXHYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 03:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268525AbUIXHYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 03:24:20 -0400
Received: from holomorphy.com ([207.189.100.168]:58589 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268515AbUIXHYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 03:24:18 -0400
Date: Fri, 24 Sep 2004 00:24:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040924072405.GX9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org> <20040924053031.GW9106@holomorphy.com> <20040924071123.GC3394@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924071123.GC3394@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23 2004, William Lee Irwin III wrote:
>> Sorry to bother you again. I appear to get this after a couple days of
>> uptime:
>> # ----------- [cut here ] --------- [please bite here ] ---------
>> Kernel BUG at cfq_iosched:1395

On Fri, Sep 24, 2004 at 09:11:23AM +0200, Jens Axboe wrote:
> is it the !allocated[rw] test again?

I am unfortunately completely oblivious to bdev handling code. In
2.6.9-rc2-mm1 this corresponds to (whitespace not preserved):

   1390                 BUG_ON(!hlist_unhashed(&crq->hash));
   1391
   1392                 if (crq->io_context)
   1393                         put_io_context(crq->io_context->ioc);
   1394
   1395                 BUG_ON(!cfqq->allocated[crq->is_write]);
   1396                 cfqq->allocated[crq->is_write]--;
   1397
   1398                 mempool_free(crq, cfqd->crq_pool);
   1399                 rq->elevator_private = NULL;


-- wli

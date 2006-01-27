Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWA0Txk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWA0Txk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWA0Txk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:53:40 -0500
Received: from relay03.pair.com ([209.68.5.17]:49673 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1030211AbWA0Txj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:53:39 -0500
X-pair-Authenticated: 67.163.102.102
Date: Fri, 27 Jan 2006 13:53:34 -0600 (CST)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Jens Axboe <axboe@suse.de>
cc: Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Neil Brown <neilb@suse.de>, Chase Venters <chase.venters@clientec.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       a.titov@host.bg, askernel2615@dsgml.com, jamie@audible.transient.net
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
In-Reply-To: <20060127194927.GB9068@suse.de>
Message-ID: <Pine.LNX.4.64.0601271351070.9232@turbotaz.ourhouse>
References: <200601270410.06762.chase.venters@clientec.com>
 <17369.65530.747867.844964@cse.unsw.edu.au> <20060127112352.GF4311@suse.de>
 <20060127112837.GG4311@suse.de> <43DA6F33.3070101@cs.wisc.edu>
 <1138389616.3293.13.camel@mulgrave> <43DA787F.4080406@cs.wisc.edu>
 <20060127194927.GB9068@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006, Jens Axboe wrote:

> On Fri, Jan 27 2006, Mike Christie wrote:
>> James Bottomley wrote:
>>> On Fri, 2006-01-27 at 13:06 -0600, Mike Christie wrote:
>>>
>>>> It does not have anything to do with this in scsi_io_completion does it?
>>>>
>>>>        if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
>>>>                return;
>>>>
>>>> For that case the scsi_cmnd does not get freed. Does it come back around
>>>> again and get released from a different path?
>>>
>>>
>>> It looks such a likely candidate, doesn't it.  Unfortunately, Tejun Heo
>>> removed that code around 6 Jan (in [BLOCK] update SCSI to use new
>>> blk_ordered for barriers), so if it is that, then the latest kernels
>>> should now not be leaking.
>>>
>>
>> Oh, I thought the reports were for 2.6.15 and below which has that
>> scsi_io_completion test. Have there been reports for this with
>> 2.6.16-rc1 too?
>
> The reports of leaks are only with > 2.6.15, not with 2.6.15.
>

Correction... my leak is with 2.6.15. I discovered it originally in an 
NVIDIA-tainted, sk98lin-patched 2.6.15, but my bisect was stock 2.6.15 
(bad) to 2.6.14 (good) in Linus's tree, sans any tainting or 
modifications.

I haven't actually tried building the latest Linus kernel from git. I'll 
do a pull and give it a try when I get home.

Cheers,
Chase

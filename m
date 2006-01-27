Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWA0TqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWA0TqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWA0TqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:46:25 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:15252 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S932366AbWA0TqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:46:24 -0500
Message-ID: <43DA787F.4080406@cs.wisc.edu>
Date: Fri, 27 Jan 2006 13:46:07 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Jens Axboe <axboe@suse.de>, Neil Brown <neilb@suse.de>,
       Chase Venters <chase.venters@clientec.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       a.titov@host.bg, askernel2615@dsgml.com, jamie@audible.transient.net
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
References: <200601270410.06762.chase.venters@clientec.com>	 <17369.65530.747867.844964@cse.unsw.edu.au> <20060127112352.GF4311@suse.de>	 <20060127112837.GG4311@suse.de>  <43DA6F33.3070101@cs.wisc.edu> <1138389616.3293.13.camel@mulgrave>
In-Reply-To: <1138389616.3293.13.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2006-01-27 at 13:06 -0600, Mike Christie wrote:
> 
>>It does not have anything to do with this in scsi_io_completion does it?
>>
>>         if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
>>                 return;
>>
>>For that case the scsi_cmnd does not get freed. Does it come back around 
>>again and get released from a different path?
> 
> 
> It looks such a likely candidate, doesn't it.  Unfortunately, Tejun Heo
> removed that code around 6 Jan (in [BLOCK] update SCSI to use new
> blk_ordered for barriers), so if it is that, then the latest kernels
> should now not be leaking.
> 

Oh, I thought the reports were for 2.6.15 and below which has that 
scsi_io_completion test. Have there been reports for this with 
2.6.16-rc1 too?

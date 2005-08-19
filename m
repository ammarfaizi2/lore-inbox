Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVHSSqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVHSSqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 14:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbVHSSqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 14:46:39 -0400
Received: from magic.adaptec.com ([216.52.22.17]:38593 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932699AbVHSSqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 14:46:37 -0400
Message-ID: <4306290B.6080608@adaptec.com>
Date: Fri, 19 Aug 2005 14:46:35 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata error handling
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org> <430556BF.5070004@pobox.com>
In-Reply-To: <430556BF.5070004@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2005 18:46:36.0063 (UTC) FILETIME=[5389AAF0:01C5A4EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18/05 23:49, Jeff Garzik wrote:
> 1) The fine-grained hooks of the SCSI layer are somewhat standard for 
> block devices.  The events they signify -- timeout, abort cmd, dev 
> reset, bus reset, and host reset -- map precisely to the events that we 
> must deal with at the ATA level.

"dev reset, bus reset" -- non existant, as I'm sure you're aware of,
depending on what _transport_ you use. ;-)

> 2) When libata SAT translation layer becomes optional, and libata drives 
> a "true" block device,

Yes, this will be very cool! (when (S)ATA(PI) devices become true block
devices.

> use of ->eh_strategy_handler() will actually be 
> an obstacle due to false sharing of code paths.  ->eh_strategy_handler() 

I fully agree.

> is indeed a single "do it all" EH entrypoint, but within that entrypoint 
> you must perform several SCSI-specific tasks.
> 
> 3) ->eh_strategy_handler() has continually proven to be a method of 
> error handling poorly supported by the SCSI layer.  There are many 
> assumption coded into the SCSI layer that this is -not- the path taken 
> by LLD EH code, and libata must constantly work around these assumptions.

I agree.

> 
> 4) libata is the -only- user of ->eh_strategy_handler(), and oddballs 

Not any more ;-)

Using the command time out hook and the strategy routine, gives _complete_
control over host recovery, and I really do mean _complete_.

	Luben


> must be stomped out.  It creates a maintenance burden on the SCSI layer 
> that should be eliminated.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUB0BwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUB0BwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:52:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20881 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261406AbUB0Bug
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:50:36 -0500
Message-ID: <403EA259.5050105@pobox.com>
Date: Thu, 26 Feb 2004 20:50:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: akpm@osdl.org, linus@osdl.org, anton@samba.org, paulus@samba.org,
       axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
References: <20040123163504.36582570.sfr@canb.auug.org.au>	<20040122221136.174550c3.akpm@osdl.org>	<20040226172325.3a139f73.sfr@canb.auug.org.au>	<403DA056.8030007@pobox.com> <20040227114240.6e26d870.sfr@canb.auug.org.au>
In-Reply-To: <20040227114240.6e26d870.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> On Thu, 26 Feb 2004 02:29:26 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
>>2) num_req_outstanding accessed without lock in do_viodasd_request 
>>(driver's request_fn).  all other accesses are inside spinlock.
> 
> 
> This is actually OK because:
> 	1) if we see a value too large, when it get decremented by
> 	handle_read_write, all the queue requst functions will get rerun.
> 	2) in send_request, if we get an error and decrement the count
> 	to zero, then the count could have been at most 1 (sonce sends
> 	are serialised) so in the request funtion, we would not have
> 	stopped processing requests.

That doesn't solve the race though...  IMO protect it with the spinlock 
and be done with it...


>>5) is it really OK to call viodasd_open() and viodasd_release() multiple 
>>times?  These functions do not look guarded against multiple openers.
> 
> 
> It is OK.

I need more explanation than that.

Multiple openers _are_ supported at the block layer, and this driver 
does not guard against multiple openers.

Thanks,

	Jeff




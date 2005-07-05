Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVGEOGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVGEOGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 10:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVGEOE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 10:04:28 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:7305 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261859AbVGEN40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 09:56:26 -0400
Message-ID: <42CA9188.3060500@ribosome.natur.cuni.cz>
Date: Tue, 05 Jul 2005 15:56:24 +0200
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Two 2.6.13-rc1 kernel crashes
References: <42C96047.60602@ribosome.natur.cuni.cz> <20050704180426.GS1444@suse.de>
In-Reply-To: <20050704180426.GS1444@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  it seems it has helped. ;)
Thanks!

Jens Axboe wrote:
> On Mon, Jul 04 2005, Martin Mokrejs wrote:
> 
>>Hi,
>>  I use on i686 architecture Gentoo linux with XFS filesystem.
>>Recently it happened to me 3 time that the machine locked,
>>although at least once sys-rq+b worked. Here is the log
>>from remote console. I don't remeber having such problems
>>with 2.6.12-rc6-git2, which was my previous testing kernel.
>>The problems appear under heavy load when I compile/install
>>some packages and maybe it's just a bad coincidence or not,
>>when I move my usb mouse in fvwm2 environment. The machine
>>locks.
> 
> 
> You need this fix from Hugh.
> 
> --- 2.6.13-rc1/drivers/block/ll_rw_blk.c	2005-06-29 11:54:08.000000000 +0100
> +++ linux/drivers/block/ll_rw_blk.c	2005-06-29 14:41:04.000000000 +0100
> @@ -1917,10 +1917,9 @@ get_rq:
>  	 * limit of requests, otherwise we could have thousands of requests
>  	 * allocated with any setting of ->nr_requests
>  	 */
> -	if (rl->count[rw] >= (3 * q->nr_requests / 2)) {
> -		spin_unlock_irq(q->queue_lock);
> +	if (rl->count[rw] >= (3 * q->nr_requests / 2))
>  		goto out;
> -	}
> +
> 

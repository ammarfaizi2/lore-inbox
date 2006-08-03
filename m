Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWHCX4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWHCX4B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWHCX4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:56:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63505 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932099AbWHCX4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:56:00 -0400
Date: Fri, 4 Aug 2006 01:55:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [2/2] Add the Elevator I/O scheduler
Message-ID: <20060803235556.GL25692@stusta.de>
References: <5c49b0ed0608031603v5ff6208bo63847513bee1b038@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0608031603v5ff6208bo63847513bee1b038@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:03:19PM -0700, Nate Diller wrote:
>...
> Tested and benchmarked extensively on several platforms with several
> disk controllers and multiple brands of disk.  Subsequently ported
> forward from 2.6.14, compile and boot tested on 2.6.18-rc1-mm2.
>...
> --- linux-2.6.18-rc1-mm2/block/Kconfig.iosched	2006-07-18
> 14:52:29.000000000 -0700
> +++ linux-dput/block/Kconfig.iosched	2006-08-02 17:40:01.000000000 -0700
>...
> +config IOSCHED_EL_SSTF
> +	bool "Alternate Heuristic: Shortest Seek Time First" if 
> IOSCHED_ELEVATOR
> +	default n
> +	---help---
> +	  Elevator normally uses the C-SCAN one-way elevator algorithm,
> +	  which is useful in most situations to avoid queue congestion and
> +	  request starvation.  In some cases, SSTF might be higher
> +	  performance, particularly with certain localized workloads.
> +
> +	  If you don't know that you want this, you don't.

If you want to make your scheduler tunable, this should be a run-time 
option.

>...
> choice
> 	prompt "Default I/O scheduler"
> -	default DEFAULT_CFQ
> +	default DEFAULT_AS
> 	help
> 	  Select the I/O scheduler which will be used by default for all
> 	  block devices.
> 
> 	config DEFAULT_AS
> -		bool "Anticipatory" if IOSCHED_AS=y
> +		bool "Anticipatory" if IOSCHED_AS
> 
> 	config DEFAULT_DEADLINE
> -		bool "Deadline" if IOSCHED_DEADLINE=y
> +		bool "Deadline" if IOSCHED_DEADLINE
> 
> 	config DEFAULT_CFQ
> -		bool "CFQ" if IOSCHED_CFQ=y
> +		bool "CFQ" if IOSCHED_CFQ
> +
> +	config DEFAULT_ELEVATOR
> +		bool "Elevator" if IOSCHED_ELEVATOR
> 
> 	config DEFAULT_NOOP
> 		bool "No-op"
>...

It seems something went wrong when you forward ported your patch.
 
> --- linux-2.6.18-rc1-mm2/block/ll_rw_blk.c	2006-07-18 
> 15:00:44.000000000 -0700
> +++ linux-dput/block/ll_rw_blk.c	2006-08-01 13:56:34.000000000 -0700
>...
> @@ -2951,7 +2953,7 @@ get_rq:
> 		blk_plug_device(q);
> 	add_request(q, req);
> out:
> -	if (sync)
> +/*	if (sync)*/
> 		__generic_unplug_device(q);
> 
> 	spin_unlock_irq(q->queue_lock);
>...

Why?


cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli


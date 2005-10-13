Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVJMRzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVJMRzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 13:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVJMRzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 13:55:50 -0400
Received: from xenotime.net ([66.160.160.81]:31160 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932091AbVJMRzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 13:55:50 -0400
Date: Thu, 13 Oct 2005 10:55:48 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH 1/1] indirect function calls elimination in IO eliminate
In-Reply-To: <6694B22B6436BC43B429958787E454988AA6FE@mssmsx402nb>
Message-ID: <Pine.LNX.4.58.0510131050150.2745@shark.he.net>
References: <6694B22B6436BC43B429958787E454988AA6FE@mssmsx402nb>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2005, Ananiev, Leonid I wrote:

> >From Leonid Ananiev
>
>       Fully modular io schedulers and enables online switching between
> them was introduced in Linux 2.6.10 but as a result percentage of CPU
> using by kernel was increased and performance degradation is marked on
> Itanium. A cause of degradation is in more steps for indirect IO
> scheduler type specific function calls.
>       The patch eliminates 45 indirect function calls in 16 elevator
> functions. Sysbench fileio benchmark throughput was increased at 2% for
> noop elevator after patching.
>
> Signed-off-by: Leonid Ananiev leonid.i.ananiev@intel.com

Hi-

Put <...> around the email address.

> ---

patching file drivers/block/as-iosched.c
patch: **** malformed patch at line 39:


Ugh.  Does exchange (server) add all of those extra lines?

> diff -rup linux-2.6.14-rc2/drivers/block/as-iosched.c
> linux-2.6.14-rc2elv1/drivers/block/as-iosched.c
>
> --- linux-2.6.14-rc2/drivers/block/as-iosched.c      2005-09-24
> 09:13:54.000000000 +0400
>
> +++ linux-2.6.14-rc2elv1/drivers/block/as-iosched.c  2005-10-13
> 04:18:12.000000000 +0400
>
> @@ -614,7 +614,7 @@ static void as_antic_stop(struct as_data
>
>  static void as_antic_timeout(unsigned long data)
>
>  {
>
>       struct request_queue *q = (struct request_queue *)data;
>
> -     struct as_data *ad = q->elevator->elevator_data;
>
> +     struct as_data *ad = q->elevator.elevator_data;
>
>       unsigned long flags;
>
>
>
>       spin_lock_irqsave(q->queue_lock, flags);

-- 
~Randy

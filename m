Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbULKIvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbULKIvb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 03:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbULKIvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 03:51:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15757 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261892AbULKIv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 03:51:28 -0500
Date: Sat, 11 Dec 2004 09:50:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: time slice cfq comments
Message-ID: <20041211085040.GB3033@suse.de>
References: <41BA2131.4040608@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BA2131.4040608@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11 2004, Con Kolivas wrote:
> Hi Jens
> 
> Just thought I'd make a few comments about some of the code in your time 
> sliced cfq.
> 
> +	if (p->array)
> +		return min(cpu_curr(task_cpu(p))->time_slice,
> +					(unsigned int)MAX_SLEEP_AVG);
> 
> MAX_SLEEP_AVG is basically 10 * the average time_slice so this will 
> always return task_cpu(p)->time_slice as the min value (except for the 
> race you described in your comments). What you probably want is
> 
> +		return min(cpu_curr(task_cpu(p))->time_slice,
> +					(unsigned int)DEF_TIMESLICE);
> 
> 
> Further down you do:
> +	/*
> +	 * for blocked tasks, return half of the average sleep time.
> +	 * (because this is the average sleep-time we'll see if we
> +	 * sample the period randomly.)
> +	 */
> +	return NS_TO_JIFFIES(p->sleep_avg) / 2;
> 
> unfortunately p->sleep_avg is a non-linear value (weighted upwards 
> towards MAX_SLEEP_AVG). I suspect here you want
> 
> +	return NS_TO_JIFFIES(p->sleep_avg) / MAX_BONUS;
> 
> I don't see any need for / 2.

Ingo donoted that code, perhaps he would like to comment?

-- 
Jens Axboe


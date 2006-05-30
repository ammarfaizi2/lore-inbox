Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWE3LgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWE3LgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWE3LgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:36:01 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:4741 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750905AbWE3LgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:36:01 -0400
Message-ID: <447C2E0C.3050405@de.ibm.com>
Date: Tue, 30 May 2006 13:35:40 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 5/6] statistics infrastructure
References: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <17525.25911.460120.154875@gargle.gargle.HOWL>
In-Reply-To: <17525.25911.460120.154875@gargle.gargle.HOWL>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> Martin Peschke writes:
>  > This patch adds statistics infrastructure as common code.
>  > 
> 
> [...]
> 
>  > +
>  > +static void statistic_add_util(struct statistic *stat, int cpu,
>  > +			       s64 value, u64 incr)
>  > +{
>  > +	struct statistic_entry_util *util = stat->pdata->ptrs[cpu];
>  > +	util->num += incr;
>  > +	util->acc += value * incr;
>  > +	if (unlikely(value < util->min))
>  > +		util->min = value;
>  > +	if (unlikely(value > util->max))
>  > +		util->max = value;
> 
> One useful aggregate that can be calculated here is a standard
> deviation. Something like
> 
>         util->acc_sq += value * incr * value * incr; /* sum of squares */
> 
> And in statistic_fdata_util() squared standard deviation is
> 
>         std_dev = util->acc_sq;
>         /*
>          * Difference of averaged square and squared average.
>          */
>         std_dev = do_div(std_dev, util->num) - whole * whole;
> 
>  > +}
> 
> Nikita.

Excellent idea. I will add the standard deviation.

Thanks, Martin


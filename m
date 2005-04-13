Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVDMU2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVDMU2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 16:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVDMU2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 16:28:46 -0400
Received: from fmr24.intel.com ([143.183.121.16]:44995 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261183AbVDMU2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 16:28:43 -0400
Date: Wed, 13 Apr 2005 13:28:33 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix active load balance
Message-ID: <20050413132833.B25137@unix-os.sc.intel.com>
References: <20050413120713.A25137@unix-os.sc.intel.com> <20050413200828.GB27088@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050413200828.GB27088@elte.hu>; from mingo@elte.hu on Wed, Apr 13, 2005 at 10:08:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 10:08:28PM +0200, Ingo Molnar wrote:
> 
> * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> 
> > -	for_each_domain(target_cpu, sd) {
> > +	for_each_domain(target_cpu, sd)
> >  		if ((sd->flags & SD_LOAD_BALANCE) &&
> > -			cpu_isset(busiest_cpu, sd->span)) {
> > -				sd = tmp;
> > +			cpu_isset(busiest_cpu, sd->span))
> >  				break;
> > -		}
> > -	}
> 
> hm, the right fix i think is to do:
> 
>  	for_each_domain(target_cpu, tmp) {
>   		if ((tmp->flags & SD_LOAD_BALANCE) &&
>  			cpu_isset(busiest_cpu, tmp->span)) {
>  				sd = tmp;
>   				break;
>  		}
>  	}

Your suggestion also looks similar to my patch. You are also breaking on the 
first one.

> because when balancing we want to match the widest-scope domain, not the 
> first one.

We want the first domain spanning both the cpu's. That is the domain where
normal load balance failed and we restore to active load balance.

thanks,
suresh

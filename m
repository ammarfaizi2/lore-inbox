Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVDMUJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDMUJY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 16:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDMUJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 16:09:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56978 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261170AbVDMUJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 16:09:13 -0400
Date: Wed, 13 Apr 2005 22:08:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix active load balance
Message-ID: <20050413200828.GB27088@elte.hu>
References: <20050413120713.A25137@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413120713.A25137@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> -	for_each_domain(target_cpu, sd) {
> +	for_each_domain(target_cpu, sd)
>  		if ((sd->flags & SD_LOAD_BALANCE) &&
> -			cpu_isset(busiest_cpu, sd->span)) {
> -				sd = tmp;
> +			cpu_isset(busiest_cpu, sd->span))
>  				break;
> -		}
> -	}

hm, the right fix i think is to do:

 	for_each_domain(target_cpu, tmp) {
  		if ((tmp->flags & SD_LOAD_BALANCE) &&
 			cpu_isset(busiest_cpu, tmp->span)) {
 				sd = tmp;
  				break;
 		}
 	}

because when balancing we want to match the widest-scope domain, not the 
first one. The s/tmp/sd thing was a typo i suspect.

	Ingo

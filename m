Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935457AbWK2Haw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935457AbWK2Haw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935467AbWK2Haw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:30:52 -0500
Received: from mga05.intel.com ([192.55.52.89]:47689 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S935457AbWK2Hav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:30:51 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,473,1157353200"; 
   d="scan'208"; a="170376341:sNHT31426136"
Message-ID: <456D372C.9080800@linux.intel.com>
Date: Wed, 29 Nov 2006 08:30:52 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] Mark rdtsc as sync only for netburst, not for core2
References: <1164709708.3276.72.camel@laptopd505.fenrus.org>	 <200611281136.29066.ak@suse.de> <1164774239.15257.5.camel@ymzhang>
In-Reply-To: <1164774239.15257.5.camel@ymzhang>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang, Yanmin wrote:
> If it's a single processor, the go backwards issue doesn't exist. Below is
> my patch based on Arjan's. It's against 2.6.19-rc5-mm2.
Hi,

this patch is incorrect
> --- linux-2.6.19-rc5-mm2_arjan/arch/x86_64/kernel/setup.c	2006-11-29 10:41:21.000000000 +0800
> +++ linux-2.6.19-rc5-mm2_arjan_fix/arch/x86_64/kernel/setup.c	2006-11-29 10:42:28.000000000 +0800
> @@ -861,7 +861,7 @@ static void __cpuinit init_intel(struct 
>  		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
>  	if (c->x86 == 6)
>  		set_bit(X86_FEATURE_REP_GOOD, &c->x86_capability);
> -	if (c->x86 == 15)
> +	if (c->x86 == 15 && num_possible_cpus() != 1)
>  		set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);

first of all, you probably meant "|| num_possible_cpus() == 1"

but second of all, the core2 cpus are dual core so.. .what does it 
bring you at all?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVFJTI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVFJTI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFJTI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:08:27 -0400
Received: from fsmlabs.com ([168.103.115.128]:5770 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261184AbVFJTIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:08:09 -0400
Date: Fri, 10 Jun 2005 13:11:36 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Shaohua Li <shaohua.li@intel.com>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Ashok Raj <ashok.raj@intel.com>, ak <ak@muc.de>
Subject: Re: [PATCH]x86-x86_64 flush cache for CPU hotplug
In-Reply-To: <1118374208.7510.6.camel@linux-hp.sh.intel.com>
Message-ID: <Pine.LNX.4.61.0506101310120.31175@montezuma.fsmlabs.com>
References: <1118374208.7510.6.camel@linux-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shaohua,

On Fri, 10 Jun 2005, Shaohua Li wrote:

> We should flush cache at CPU hotplug. An error has been observed data is
> corrupted after CPU hotplug in CPUs with bigger cache.
> I guess IA64 requires similar change, Ashok?

Interesting, which processor was this?

> Signed-off-by: Shaohua.li<shaohua.li@intel.com>
> ---
> 
>  linux-2.6.12-rc6-mm1-root/arch/i386/kernel/process.c   |    1 +
>  linux-2.6.12-rc6-mm1-root/arch/x86_64/kernel/process.c |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff -puN arch/i386/kernel/process.c~flush_cache_cpuhotplug arch/i386/kernel/process.c
> --- linux-2.6.12-rc6-mm1/arch/i386/kernel/process.c~flush_cache_cpuhotplug	2005-06-10 10:56:05.082247160 +0800
> +++ linux-2.6.12-rc6-mm1-root/arch/i386/kernel/process.c	2005-06-10 11:05:10.597316264 +0800
> @@ -155,6 +155,7 @@ static inline void play_dead(void)
>  {
>  	/* This must be done before dead CPU ack */
>  	cpu_exit_clear();
> +	wbinvd();
>  	mb();

We shouldn't need that mb() there anymore then, ditto for the other 
location.

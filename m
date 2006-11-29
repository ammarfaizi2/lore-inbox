Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966358AbWK2JEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966358AbWK2JEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966410AbWK2JEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:04:48 -0500
Received: from mga05.intel.com ([192.55.52.89]:59431 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S966358AbWK2JEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:04:46 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,473,1157353200"; 
   d="scan'208"; a="170406244:sNHT20851971"
Subject: Re: [patch] Mark rdtsc as sync only for netburst, not for core2
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <456D3F52.6040308@yahoo.com.au>
References: <1164709708.3276.72.camel@laptopd505.fenrus.org>
	 <200611281136.29066.ak@suse.de> <1164774239.15257.5.camel@ymzhang>
	 <456D372C.9080800@linux.intel.com>  <456D3F52.6040308@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 17:04:59 +0800
Message-Id: <1164791099.2873.3.camel@ymzhang>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 19:05 +1100, Nick Piggin wrote:
> Arjan van de Ven wrote:
> > Zhang, Yanmin wrote:
> > 
> >> If it's a single processor, the go backwards issue doesn't exist. 
> >> Below is
> >> my patch based on Arjan's. It's against 2.6.19-rc5-mm2.
> > 
> > Hi,
> > 
> > this patch is incorrect
> > 
> >> --- linux-2.6.19-rc5-mm2_arjan/arch/x86_64/kernel/setup.c    
> >> 2006-11-29 10:41:21.000000000 +0800
> >> +++ linux-2.6.19-rc5-mm2_arjan_fix/arch/x86_64/kernel/setup.c    
> >> 2006-11-29 10:42:28.000000000 +0800
> >> @@ -861,7 +861,7 @@ static void __cpuinit init_intel(struct          
> >> set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
> >>      if (c->x86 == 6)
> >>          set_bit(X86_FEATURE_REP_GOOD, &c->x86_capability);
> >> -    if (c->x86 == 15)
> >> +    if (c->x86 == 15 && num_possible_cpus() != 1)
> >>          set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
> > 
> > 
> > first of all, you probably meant "|| num_possible_cpus() == 1"
> > 
> > but second of all, the core2 cpus are dual core so.. .what does it bring 
> > you at all?
> 
> I guess you could boot with a UP kernel or maxcpus=1?
Yes, with the new patch. My reply email to Arjan was lost in LKML because
my email client was crazy to set the email as HTML format.

> 

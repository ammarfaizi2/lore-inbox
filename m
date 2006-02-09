Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422906AbWBIN5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422906AbWBIN5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 08:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422908AbWBIN5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 08:57:04 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:16321 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1422906AbWBIN5C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 08:57:02 -0500
Message-ID: <43EB49D7.8030601@cosmosbay.com>
Date: Thu, 09 Feb 2006 14:55:35 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, 76306.1226@compuserve.com, pj@sgi.com,
       wli@holomorphy.com, ak@muc.de, mingo@elte.hu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, riel@redhat.com, dada1@cosmobay.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
References: <200602090335_MC3-1-B7FA-621E@compuserve.com> <20060209010655.5cdeb192.akpm@osdl.org> <20060209011106.68aa890a.akpm@osdl.org> <20060209100834.GA9281@osiris.boeblingen.de.ibm.com> <20060209021314.23a9096f.akpm@osdl.org> <20060209102317.GA20554@osiris.boeblingen.de.ibm.com> <20060209023106.10c53c0b.akpm@osdl.org> <20060209114700.GB20554@osiris.boeblingen.de.ibm.com> <43EB39A8.2010202@cosmosbay.com> <20060209131220.GC20554@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060209131220.GC20554@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 09 Feb 2006 14:55:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens a écrit :
>> for (cpu = max_cpus ; cpu < NR_CPUS ; cpu++)
>> 	cpu_clear(cpu, cpu_possible_map);
> 
> Hmm... I don't think the semantics of cpu_possible_map allow to change it.
> Also any code that uses for_each_cpu() may allocate memory _before_
> cpu_possible_map is changed back to reflect a smaller number of cpus.
> Doesn't look like the correct way to fix this.
> Thinking a bit longer this was probably a reason why initialization of
> this map was done in smp_prepare_cpus() before it silently moved to
> setup_arch().

Hum... of course you may loose some bits of memory (percpu data for example) 
but clearing a cpu in cpu_possible_map is allowed.

See arch/alpha/kernel/process.c and arch/x86_64/kernel/smpboot.c for uses of 
cpu_clear()



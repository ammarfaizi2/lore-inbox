Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752334AbWKFTDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbWKFTDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 14:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbWKFTDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 14:03:09 -0500
Received: from mga06.intel.com ([134.134.136.21]:58259 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752334AbWKFTDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 14:03:07 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,392,1157353200"; 
   d="scan'208"; a="156912654:sNHT18344158"
Message-ID: <454F86DE.1040803@linux.intel.com>
Date: Mon, 06 Nov 2006 20:02:54 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, shaohua.li@intel.com, bunk@stusta.de
Subject: Re: [patch] Regression in 2.6.19-rc microcode driver
References: <1162822538.3138.28.camel@laptopd505.fenrus.org> <20061106110152.63ef91bc.akpm@osdl.org>
In-Reply-To: <20061106110152.63ef91bc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> --- linux-2.6.18/arch/i386/kernel/microcode.c.org	2006-11-06 14:50:37.000000000 +0100
>> +++ linux-2.6.18/arch/i386/kernel/microcode.c	2006-11-06 14:52:30.000000000 +0100
>> @@ -577,7 +577,7 @@ static void microcode_init_cpu(int cpu)
>>  	set_cpus_allowed(current, cpumask_of_cpu(cpu));
>>  	mutex_lock(&microcode_mutex);
>>  	collect_cpu_info(cpu);
>> -	if (uci->valid)
>> +	if (uci->valid && system_state==SYSTEM_RUNNING)
>>  		cpu_request_microcode(cpu);
>>  	mutex_unlock(&microcode_mutex);
>>  	set_cpus_allowed(current, old);
> 
> Can we fix this by switching to late_initcall() or something like that?

I will try but it then still runs before userspace (esp "init") is 
alive so I'm not convinced it'll do the right thing

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUF2Ksq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUF2Ksq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 06:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUF2Ksq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 06:48:46 -0400
Received: from everest.2mbit.com ([24.123.221.2]:52182 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S265691AbUF2Ksa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 06:48:30 -0400
Message-ID: <40E148EE.1090207@greatcn.org>
Date: Tue, 29 Jun 2004 18:48:14 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Coywolf Qi Hunt <coywolf@greatcn.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <40E03F71.8010902@greatcn.org> <20040628175325.B9214@flint.arm.linux.org.uk>
In-Reply-To: <20040628175325.B9214@flint.arm.linux.org.uk>
X-Scan-Signature: e39eceae6eb4554774934c39b07fdc9c
X-SA-Exim-Connect-IP: 218.24.187.61
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: [BUG FIX] [PATCH] fork_init() max_low_pfn fixes potential OOM
 bug on big highmem machine
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.187.61 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0 (built Wed, 05 May 2004 12:02:20 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Mon, Jun 28, 2004 at 11:55:29PM +0800, Coywolf Qi Hunt wrote:
>  
>
>>Hello all,
>>
>>On machine with 16G(or 8G if 4k stacks) or more memory, high max_threads 
>>could let system run out of low memory.
>>This patch decides max_threads by the amount of low memory instead of 
>>the total physical memory.
>>Systems without high memory would not be affected.
>>    
>>
>
>This is wrong - max_low_pfn can be high on systems where physical RAM
>doesn't start at address 0.  Such is very common on ARM platforms,
>where RAM is located at 0xa0000000 or 0xc0000000 physical, which
>leads to any calculation based upon max_low_pfn to believe we have
>more than 3GB of RAM when we may only have 64MB or so.
>
>I think we may need a num_lowpages for this...
>
Actually there's physical DRAM offset: PHY_OFFSET, defined on ARM only. 
max_low_pfn happens to be the same as `num_lowpages'.
These assignments seems illogical in naming. But just happen to let this 
patch work.  Other platforms may still break.

[coywolf@everest ~/linux-2.6.7/arch]$ grep max_low_pfn arm* -rn
arm/mm/init.c:235:      max_low_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);
arm26/mm/init.c:187:    max_low_pfn = memend_pfn - PFN_DOWN(PHYS_OFFSET);
arm26/mm/mm-memc.c:157: page_nr = max_low_pfn;

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWARKrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWARKrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWARKrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:47:07 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:25461 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964882AbWARKrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:47:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4i8ENvc1XgPcMadXCTsPvbG03Y/uts4i84VsQhvJ7eihg4n9rRh7GpKC1yF/4vU101AOgtbonrYiJuBzmg/eyDdh4sUKz8zQVMlPCYQecAR9hG8M/vdw06mgsPoIieAbDcZKbmeK2sagfS5ohoPezC4ce8jbc3PCXY8qflnsZz4=  ;
Message-ID: <43CE1C8B.3010802@yahoo.com.au>
Date: Wed, 18 Jan 2006 21:46:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, ntl@pobox.com, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com,
       torvalds@osdl.org
Subject: Re: [patch] turn on might_sleep() in early bootup code too
References: <200601180032.46867.michael@ellerman.id.au>	<20060117140050.GA13188@elte.hu>	<200601181119.39872.michael@ellerman.id.au>	<20060118033239.GA621@cs.umn.edu>	<20060118063732.GA21003@elte.hu>	<20060117225304.4b6dd045.akpm@osdl.org>	<20060118072815.GR2846@localhost.localdomain>	<20060117233734.506c2f2e.akpm@osdl.org>	<20060118080828.GA2324@elte.hu>	<20060118002459.3bc8f75a.akpm@osdl.org>	<20060118091834.GA21366@elte.hu> <20060118023509.50fe2701.akpm@osdl.org>
In-Reply-To: <20060118023509.50fe2701.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> 
>> enable might_sleep() checks even in early bootup code (when system_state 
>> != SYSTEM_RUNNING). There's also a new config option to turn this off:
>> CONFIG_DEBUG_SPINLOCK_SLEEP_EARLY_BOOTUP_WORKAROUND
>> while most other architectures.
> 
> 
> I get just the one on ppc64:
> 
> 
> Debug: sleeping function called from invalid context at include/asm/semaphore.h:62
> in_atomic():1, irqs_disabled():1
> Call Trace:
> [C0000000004EFD20] [C00000000000F660] .show_stack+0x5c/0x1cc (unreliable)
> [C0000000004EFDD0] [C000000000053214] .__might_sleep+0xbc/0xe0
> [C0000000004EFE60] [C000000000413D1C] .lock_kernel+0x50/0xb0
> [C0000000004EFEF0] [C0000000004AC574] .start_kernel+0x1c/0x278
> [C0000000004EFF90] [C0000000000085D4] .hmt_init+0x0/0x2c
> 
> 
> Your fault ;)

This lock_kernel should never sleep should it? Maybe it could be changed
to lock_kernel_init_locked() or something?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

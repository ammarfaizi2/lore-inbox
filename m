Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWHVILb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWHVILb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWHVILb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:11:31 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:16564 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751347AbWHVILa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:11:30 -0400
Message-Id: <44EAD869.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 22 Aug 2006 10:11:53 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: 2.6.18-rc4-mm2: x86_64 compile error
References: <20060819220008.843d2f64.akpm@osdl.org>
 <20060821212140.GN11651@stusta.de>
In-Reply-To: <20060821212140.GN11651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Adrian Bunk <bunk@stusta.de> 21.08.06 23:21 >>>
>On Sat, Aug 19, 2006 at 10:00:08PM -0700, Andrew Morton wrote:
>>...
>> Changes since 2.6.18-rc4-mm1:
>>...
>> +x86_64-mm-fix-x86-cpuid-keys-used-in-alternative_smp.patch
>>...
>>  x86_64 tree updates
>>...
>
>This patch causes the following compile error (cross compiling from i386 
>using gcc 4.1):
>
><--  snip  -->
>
>...
>  LD      .tmp_vmlinux1
>kernel/built-in.o:(.smp_altinstructions+0x10): undefined reference to `X86_FEATURE_UP'
>kernel/built-in.o:(.smp_altinstructions+0x28): undefined reference to `X86_FEATURE_UP'
>kernel/built-in.o:(.smp_altinstructions+0x40): undefined reference to `X86_FEATURE_UP'
>kernel/built-in.o:(.smp_altinstructions+0x58): undefined reference to `X86_FEATURE_UP'
>make[1]: *** [.tmp_vmlinux1] Error 1

Odd - asm/cpufeature.h is being included by asm/processor.h, which is included by
linux/sched.h, which in turn I would have assumed is included by virtually everything.
The simply solution would be to explicitly include it from asm/alternative.h - could you
give that a try? Regardless of that I'd be curious what source file under kernel/ (and
perhaps with what .config) neither includes linux/sched.h nor asm/processor.h.

Jan

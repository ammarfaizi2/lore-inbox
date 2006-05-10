Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWEJHpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWEJHpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWEJHpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:45:00 -0400
Received: from mga06.intel.com ([134.134.136.21]:7612 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S964788AbWEJHo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:44:59 -0400
X-IronPort-AV: i="4.05,108,1146466800"; 
   d="scan'208"; a="34089974:sNHT2096979486"
Message-ID: <446199CA.2030706@linux.intel.com>
Date: Wed, 10 May 2006 15:44:10 +0800
From: "bibo,mao" <bibo_mao@linux.intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jan Beulich <jbeulich@novell.com>
CC: mao bibo <bibo.mao@intel.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]x86_64 debug_stack nested patch
References: <44618C0D.6020604@intel.com> <4461AD97.76E4.0078.0@novell.com>
In-Reply-To: <4461AD97.76E4.0078.0@novell.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, EXCEPTION_STACK_ORDER + 1 is better for me.
in_exception_stack() function is to judge which IST stack by parameter 
stack value, if DEBUG_STKSZ value is set as 8K. The original function 
can not judge whether it is within DEBUG_STACK space.

Thanks
bibo,mao

Jan Beulich wrote:
> Would you mind explaining why you
> - needed to replace the handling of the DEBUG_STKSZ > EXCEPTION_STKSZ in in_exception_stack()?
> - used a hard coded 1 instead of (EXCEPTION_STACK_ORDER + 1) for defining DEBUG_STACK_ORDER?
> 
> Thanks, Jan
> 
>>>> "bibo,mao" <bibo.mao@intel.com> 10.05.06 08:45 >>>
> hi,
> In x86_64 platform, INT1 and INT3 trap stack is IST stack called 
> DEBUG_STACK, when INT1/INT3 trap happens, system will switch to 
> DEBUG_STACK by hardware. Current DEBUG_STACK size is 4K, when int1/int3 
> trap happens, kernel will minus current DEBUG_STACK IST value by 4k. But 
> if int3/int1 trap is nested, it will destroy other vector's IST stack.
> This patch modifies this, it sets DEBUG_STACK size as 8K and allows two 
> level of nested int1/int3 trap.
> Kprobe DEBUG_STACK may be nested, because kprobe hanlder may be probed 
> by other kprobes. This patch is against 2.6.17-rc3.
> 
> Signed-Off-By: bibo, mao <bibo.mao@intel.com>
> 
> Thanks
> bibo,mao
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

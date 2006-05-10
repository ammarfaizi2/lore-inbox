Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWEJI0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWEJI0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 04:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWEJI0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 04:26:40 -0400
Received: from mga05.intel.com ([192.55.52.89]:52501 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932342AbWEJI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 04:26:40 -0400
X-IronPort-AV: i="4.05,108,1146466800"; 
   d="scan'208"; a="35005337:sNHT49821436"
Message-ID: <4461A3B2.8000601@linux.intel.com>
Date: Wed, 10 May 2006 16:26:26 +0800
From: "bibo,mao" <bibo_mao@linux.intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jan Beulich <jbeulich@novell.com>
CC: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       mao bibo <bibo.mao@intel.com>, akpm@osdl.org, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]x86_64 debug_stack nested patch
References: <44618C0D.6020604@intel.com> <4461AD97.76E4.0078.0@novell.com> <446199CA.2030706@linux.intel.com> <4461B8B0.76E4.0078.0@novell.com>
In-Reply-To: <4461B8B0.76E4.0078.0@novell.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, I am wrong. And I will modify this. And then only need define 
DEBUG_STACK_ORDER as (EXCEPTION_STACK_ORDER + 1)

thanks
bibo,mao

Jan Beulich wrote:
>> in_exception_stack() function is to judge which IST stack by parameter 
>> stack value, if DEBUG_STKSZ value is set as 8K. The original function 
>> can not judge whether it is within DEBUG_STACK space.
> 
> I rather think that the new code can't work properly. Since the pointer in the TSS gets decreased while the handler is
> running, using that value is not going to tell you the end of the stack, but you'd rather get the end of the stack the
> next (nested) invocation of the handler would use. Further, treating the entire DEBUG_STKSZ range as a single piece is
> wrong, too, because it is not being used as a contiguous stack (but rather as 2 stacks EXCEPTION_STKSZ in size); the new
> code shouldn't be able to properly deal with nested invocations because of this.
> 
> Jan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

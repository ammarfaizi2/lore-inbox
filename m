Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWEJHIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWEJHIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWEJHIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:08:15 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:48419
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751241AbWEJHIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:08:15 -0400
Message-Id: <4461AD97.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 10 May 2006 09:08:39 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "mao bibo" <bibo.mao@intel.com>
Cc: "Anil S Keshavamurthy" <anil.s.keshavamurthy@intel.com>, <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]x86_64 debug_stack nested patch
References: <44618C0D.6020604@intel.com>
In-Reply-To: <44618C0D.6020604@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would you mind explaining why you
- needed to replace the handling of the DEBUG_STKSZ > EXCEPTION_STKSZ in in_exception_stack()?
- used a hard coded 1 instead of (EXCEPTION_STACK_ORDER + 1) for defining DEBUG_STACK_ORDER?

Thanks, Jan

>>> "bibo,mao" <bibo.mao@intel.com> 10.05.06 08:45 >>>
hi,
In x86_64 platform, INT1 and INT3 trap stack is IST stack called 
DEBUG_STACK, when INT1/INT3 trap happens, system will switch to 
DEBUG_STACK by hardware. Current DEBUG_STACK size is 4K, when int1/int3 
trap happens, kernel will minus current DEBUG_STACK IST value by 4k. But 
if int3/int1 trap is nested, it will destroy other vector's IST stack.
This patch modifies this, it sets DEBUG_STACK size as 8K and allows two 
level of nested int1/int3 trap.
Kprobe DEBUG_STACK may be nested, because kprobe hanlder may be probed 
by other kprobes. This patch is against 2.6.17-rc3.

Signed-Off-By: bibo, mao <bibo.mao@intel.com>

Thanks
bibo,mao

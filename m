Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbTH2CPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 22:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbTH2CPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 22:15:39 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30985 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264136AbTH2CPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 22:15:30 -0400
Date: Thu, 28 Aug 2003 22:06:42 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@osdl.org>
cc: Christopher Swingley <cswingle@iarc.uaf.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: Unable to handle kernel NULL pointer dereference
In-Reply-To: <20030828131019.69a9f3b9.akpm@osdl.org>
Message-ID: <Pine.LNX.3.96.1030828220150.466A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Aug 2003, Andrew Morton wrote:

> Christopher Swingley <cswingle@iarc.uaf.edu> wrote:
> >
> > kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > ...
> > kernel: EIP is at find_inode_fast+0x1a/0x60
> > ...
> > model name	: AMD Athlon(tm) XP 1800+
> > ...
> 
> You've been bitten by the athlon-prefetch(0)-goes-oops problem.
> 
> Nobody seems to be working this, so I'll be sending the below in to Linus.

Let's not. If this goes in the Athlon users will get bad performance,
reliable operation, and no one will blame anything but the Athlon... If
it keeps oopsing hopefully people will complain and it will get fixed.

Taking out features instead of fixing them is a bad president, this is
not a driver for an obsolete ISA card, this is a performance boost for a
very current CPU. I'm surprised AMD hasn't looked at it themselves.

> 
> --- 25/include/asm-i386/processor.h~disable-athlon-prefetch	2003-08-23 13:48:16.000000000 -0700
> +++ 25-akpm/include/asm-i386/processor.h	2003-08-23 13:48:16.000000000 -0700
> @@ -578,6 +578,8 @@ static inline void rep_nop(void)
>  #define ARCH_HAS_PREFETCH
>  extern inline void prefetch(const void *x)
>  {
> +	if (cpu_data[0].x86_vendor == X86_VENDOR_AMD)
> +		return;
>  	alternative_input(ASM_NOP4,
>  			  "prefetchnta (%1)",
>  			  X86_FEATURE_XMM,
> 
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


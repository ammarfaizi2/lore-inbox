Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUKELVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUKELVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 06:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUKELVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 06:21:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64520 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262648AbUKELU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 06:20:59 -0500
Date: Fri, 5 Nov 2004 11:20:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lorenzo Allegrucci <l_allegrucci@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105112052.C16270@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@suse.de>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it> <20041105102204.GA4730@elte.hu> <20041105110951.GA29702@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041105110951.GA29702@elte.hu>; from mingo@elte.hu on Fri, Nov 05, 2004 at 12:09:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 12:09:51PM +0100, Ingo Molnar wrote:
> due to the PML4 feature, the clear_page_tables() function changed to
> clear_page_range(), changing its (first,size) argument to (first,last). 
> Normally it's called with (0,TASK_SIZE) which normally is PML4-aligned,
> but in the (relatively rare) do_munmap() use this is not the case. We
> correctly calculate the range that could be cleared, but it's not
> PML4_SIZE aligned.

If PML4 is the outer page table (god I hate that confusing name) then
this is going to break ARM.

"first" needs to be able to handle being set to virtual address 0x8000
since, for some CPUs, it is absolutely vital that we keep the first
_page_ of memory mapped, but user executables are loaded at 0x8000.

Note that the PGD increment is 2MB on ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

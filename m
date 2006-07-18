Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWGRBah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWGRBah (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 21:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWGRBah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 21:30:37 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:16609 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751292AbWGRBag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 21:30:36 -0400
Date: Mon, 17 Jul 2006 21:22:17 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
To: Horms <horms@verge.net.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Chris Zankel <chris@zankel.net>,
       Russell King <rmk@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>, discuss@x86-64.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607172126_MC3-1-C544-E35A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <31687.FP.7244@verge.net.au>

On Mon, 17 Jul 2006 12:17:20 -0400, Horms wrote:

> This patch is part of an effort to unify the panic_on_oops behaviour
> across all architectures that implement it.
> 
> It was pointed out to me by Andi Kleen that if an oops has occured
> in interrupt context, then calling sleep() in the oops path will only cause
> a panic, and that it would be really better for it not to be in the path at
> all. 

i386 already checks in_interrupt() and panics immediately:

--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -442,11 +442,9 @@ #endif
===>    if (in_interrupt())
===>            panic("Fatal exception in interrupt");
 
-       if (panic_on_oops) {
-               printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-               ssleep(5);
-               panic("Fatal exception");
-       }
+       if (panic_on_oops)
+               panic("Fatal exception: panic_on_oops");
+
        oops_exit();
        do_exit(SIGSEGV);
 }

-- 
Chuck
And did we tell you the name of the game, boy, we call it Riding the Gravy Train.

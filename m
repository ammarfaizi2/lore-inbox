Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWERJe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWERJe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWERJe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:34:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750847AbWERJe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:34:56 -0400
Date: Thu, 18 May 2006 02:34:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] Make printk work for really early debugging
Message-Id: <20060518023449.4e697b96.akpm@osdl.org>
In-Reply-To: <20060518091410.CC527679F4@ozlabs.org>
References: <20060518091410.CC527679F4@ozlabs.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <michael@ellerman.id.au> wrote:
>
> Currently printk is no use for early debugging because it refuses to actually
>  print anything to the console unless cpu_online(smp_processor_id()) is true.
> 
>  The stated explanation is that console drivers may require per-cpu resources,
>  or otherwise barf, because the system is not yet setup correctly. Fair enough.
> 
>  However some console drivers might be quite happy running early during boot,
>  in fact we have one, and so it'd be nice if printk understood that.
> 
>  So I add a flag (which I would have called CON_BOOT, but that's taken) called
>  CON_ANYTIME, which indicates that a console is happy to be called anytime,
>  even if the cpu is not yet online.
> 
>  Tested on a Power 5 machine, with both a CON_ANYTIME driver and a bogus
>  console driver that BUG()s if called while offline. No problems AFAICT.
>  Built for i386 UP & SMP.

hm, OK.  But iirc is was just one silly ia64 console driver which had this
problem.  It might be better to make the new behaviour be the default and mark
the ia64 driver CON_NEEDS_CPU_ONLINE or something.

No?

Or go through and audit the drivers and sprinkle CON_ANYTIME in all the
safe ones, maybe.

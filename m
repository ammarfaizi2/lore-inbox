Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTLPXuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTLPXuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:50:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:49847 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264387AbTLPXut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:50:49 -0500
Subject: Re: Double Interrupt with HT
From: john stultz <johnstul@us.ibm.com>
To: Miroslaw KLABA <totoro@totoro.be>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1071615336.3fdf8d6840208@ssl0.ovh.net>
References: <20031215155843.210107b6.totoro@totoro.be>
	 <1071603069.991.194.camel@cog.beaverton.ibm.com>
	 <1071615336.3fdf8d6840208@ssl0.ovh.net>
Content-Type: text/plain
Message-Id: <1071618630.1013.11.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 16 Dec 2003 15:50:31 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-16 at 14:55, Miroslaw KLABA wrote:
> I had the problem with 2.4.22, 2.4.22-ac4, 2.4.23 and 2.4.24-pre1.

Ok, so its been around awhile. Do you remember what was the last 2.4
kernel where you did not see this problem?

> The problem is that all the kernel is working "twice the speed".
> The command "while true; do date; sleep 1; done;" shows that the date is growing
> 2 seconds per second... :/
> I found a patch for irqbalance for 2.4.23, and now I don't have the problem 
> anymore with the clock.
> http://www.hardrock.org/kernel/2.4.23/irqbalance-2.4.23-jb.patch

Hmm. Just skimming that patch, I notice it won't work on clustered apic
systems. They've dropped the following chunk from set_ioapic_affinity
and forgot to re-add it.

-	/* pick a single cpu for clustered xapics */
-	if(clustered_apic_mode == CLUSTERED_APIC_XAPIC){
-		int cpu = ffs(mask)-1;
-		mask = cpu_to_physical_apicid(cpu);
-	}

Further I can't see how it fixes the problem, but it may just be working
around the issue. I'd be interested in what the patch author thinks. 

> I think it is a bug with the via chipset, but I'm not able to get deeper in the
> kernel code.

Could be, but I suspect interrupt routing isn't happening properly at
boot time. The irqbalance code just forces it to be readjusted correctly
once your up and running. 

thanks
-john



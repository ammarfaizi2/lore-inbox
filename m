Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVB0WZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVB0WZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 17:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVB0WZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 17:25:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:28330 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261495AbVB0WYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 17:24:25 -0500
Subject: Re: [PATCH] PPC64: Generic hotplug cpu support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       nathanl@austin.ibm.com
In-Reply-To: <20050227031655.67233bb5.akpm@osdl.org>
References: <Pine.LNX.4.61.0502010009010.3010@montezuma.fsmlabs.com>
	 <20050227031655.67233bb5.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 09:22:51 +1100
Message-Id: <1109542971.14993.217.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-27 at 03:16 -0800, Andrew Morton wrote:
> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> > Patch provides a generic hotplug cpu implementation, with the only current 
> >  user being pmac.
> 
> BUG: using smp_processor_id() in preemptible [00000001] code: swapper/0
> caller is .native_idle+0x30/0x60
> 
> --- 25/arch/ppc64/kernel/idle.c~ppc64-generic-hotplug-cpu-support-fix	2005-02-27 11:12:47.000000000 -0700
> +++ 25-akpm/arch/ppc64/kernel/idle.c	2005-02-27 11:13:03.000000000 -0700
> @@ -294,7 +294,7 @@ static int native_idle(void)
>  		if (need_resched())
>  			schedule();
>  
> -		if (cpu_is_offline(smp_processor_id()) &&
> +		if (cpu_is_offline(_smp_processor_id()) &&
>  		    system_state == SYSTEM_RUNNING)
>  			cpu_die();
>  	}
> _

This is the idle loop. Is that ever supposed to be preempted ?

Ben.



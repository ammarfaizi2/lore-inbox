Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266861AbUAXFI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 00:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266862AbUAXFI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 00:08:29 -0500
Received: from dp.samba.org ([66.70.73.150]:55245 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266861AbUAXFI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 00:08:28 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Simplify net/flow.c 
In-reply-to: Your message of "Thu, 22 Jan 2004 19:51:04 -0800."
             <20040122195104.31cc2496.akpm@osdl.org> 
Date: Fri, 23 Jan 2004 17:55:28 +1100
Message-Id: <20040124050843.320902C056@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040122195104.31cc2496.akpm@osdl.org> you write:
> It doesn't link if CONFIG_SMP=n.  semaphore `cpucontrol', used in
> flow_cache_flush() is defined in kernel/cpu.c which is not included in
> uniprocessor builds.
> 
> Here's one possible fix.

....

>  	/* Don't want cpus going down or up during this, also protects
>  	 * against multiple callers. */
> -	down(&cpucontrol);
> +	down_cpucontrol();

OK.  Although I think I prefer to have down_cpucontrol() defined under
#ifdef CONFIG_HOTPLUG_CPU, and revert to using a normal sem here as
well to cover the CONFIG_HOTPLUG_CPU=n CONFIG_SMP=y case.  But I will
produce an additional patch with the hotplug cpu patches.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

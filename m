Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVB0LR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVB0LR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 06:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVB0LR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 06:17:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:11210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261351AbVB0LR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 06:17:57 -0500
Date: Sun, 27 Feb 2005 03:16:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: benh@kernel.crashing.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, nathanl@austin.ibm.com
Subject: Re: [PATCH] PPC64: Generic hotplug cpu support
Message-Id: <20050227031655.67233bb5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0502010009010.3010@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0502010009010.3010@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> Patch provides a generic hotplug cpu implementation, with the only current 
>  user being pmac.

BUG: using smp_processor_id() in preemptible [00000001] code: swapper/0
caller is .native_idle+0x30/0x60

--- 25/arch/ppc64/kernel/idle.c~ppc64-generic-hotplug-cpu-support-fix	2005-02-27 11:12:47.000000000 -0700
+++ 25-akpm/arch/ppc64/kernel/idle.c	2005-02-27 11:13:03.000000000 -0700
@@ -294,7 +294,7 @@ static int native_idle(void)
 		if (need_resched())
 			schedule();
 
-		if (cpu_is_offline(smp_processor_id()) &&
+		if (cpu_is_offline(_smp_processor_id()) &&
 		    system_state == SYSTEM_RUNNING)
 			cpu_die();
 	}
_


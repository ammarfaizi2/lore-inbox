Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVFIQfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVFIQfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVFIQfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:35:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23547 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261343AbVFIQfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:35:17 -0400
Date: Thu, 9 Jun 2005 09:34:25 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Serge Noiraud <serge.noiraud@bull.net>
cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Eugeny S. Mints" <emints@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <1118329967.10717.58.camel@ibiza.btsn.frna.bull.fr>
Message-ID: <Pine.LNX.4.44.0506090932300.27999-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2005, Serge Noiraud wrote:

> Same problem with 48-04 and 48-05
> It works great with rc6 without RT patch.
> Here is my .config
> The cmdline options at boot time are :
> #more /proc/cmdline
> BOOT_IMAGE=2.6.12rc6RTV0.7.4805 ro root=306 console=ttyS0 console=tty1 \
> acpi=force apm=smp resume=/dev/hda5



Does this patch get you any further?


Daniel

Index: linux-2.6.11/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/io_apic.c	2005-06-09 16:31:54.000000000 +0000
+++ linux-2.6.11/arch/i386/kernel/io_apic.c	2005-06-09 16:31:20.000000000 +0000
@@ -1804,8 +1804,9 @@ static void __init setup_ioapic_ids_from
  */
 static int __init timer_irq_works(void)
 {
-	unsigned long t1 = jiffies;
+	unsigned long t1 = jiffies, flags;
 
+	raw_local_save_flags(flags);
 	raw_local_irq_enable();
 	/* Let ten ticks pass... */
 	mdelay((10 * 1000) / HZ);
@@ -1820,6 +1821,7 @@ static int __init timer_irq_works(void)
 	if (jiffies - t1 > 4)
 		return 1;
 
+	raw_local_irq_restore(flags);
 	return 0;
 }
 


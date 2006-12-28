Return-Path: <linux-kernel-owner+w=401wt.eu-S964827AbWL1B2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWL1B2y (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 20:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWL1B2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 20:28:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49096 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964827AbWL1B2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 20:28:54 -0500
Date: Wed, 27 Dec 2006 17:24:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, tglx@linutronix.de,
       mingo@elte.hu, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH -mm 4/5][time][x86_64] Convert x86_64 to use
 GENERIC_TIME
Message-Id: <20061227172447.2d51eb59.akpm@osdl.org>
In-Reply-To: <20061220221009.15178.6526.sendpatchset@localhost>
References: <20061220220945.15178.2669.sendpatchset@localhost>
	<20061220221009.15178.6526.sendpatchset@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 17:13:43 -0500
john stultz <johnstul@us.ibm.com> wrote:

> This patch converts x86_64 to use the GENERIC_TIME infrastructure and 
> adds clocksource structures for both TSC and HPET (ACPI PM is shared w/ 
> i386).

printk timestamping shows a time of zero all the time, because nothing
calls set_cyc2ns_scale() any more.

I stuck it in time_init():

--- a/arch/x86_64/kernel/time.c~time-x86_64-convert-x86_64-to-use-generic_time-fix
+++ a/arch/x86_64/kernel/time.c
@@ -361,6 +361,7 @@ void __init time_init(void)
 	else
 		vgetcpu_mode = VGETCPU_LSL;
 
+	set_cyc2ns_scale(cpu_khz);
 	printk(KERN_INFO "time.c: Detected %d.%03d MHz processor.\n",
 		cpu_khz / 1000, cpu_khz % 1000);
 	setup_irq(0, &irq0);
_


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWFYKtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWFYKtf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWFYKtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:49:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24744 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932334AbWFYKte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:49:34 -0400
Date: Sun, 25 Jun 2006 03:49:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Problem with 2.6.17-mm2
Message-Id: <20060625034913.315755ae.akpm@osdl.org>
In-Reply-To: <20060625103523.GY27143@charite.de>
References: <20060625103523.GY27143@charite.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 12:35:23 +0200
Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> wrote:

> 2.6.17 and 2.6.17.1 work OK, but using -mm2 gives me two oddieties:

OK, thanks.

> 1) A lot of "unexpected IRQ trap at vector X" for X=[09,07]

hm, ack_bad_irq().  That isn't supposed to happen.

Ingo, Thomas - it's possible that -mm2's genirq is affecting x86?

> 2) A problem with the powernow_k8 driver, which makes the kernel puke upon modprobe (at the end of my dmes output).

yup, I uploaded the below for for that into the hot-fixes directory.

--- a/drivers/cpufreq/cpufreq.c~cpu-hotplug-make-cpu_notifier-related-notifier-calls-__cpuinit-only-fix-fix
+++ a/drivers/cpufreq/cpufreq.c
@@ -1551,7 +1551,7 @@ static struct notifier_block __cpuinitda
  * (and isn't unregistered in the meantime).
  *
  */
-int __cpuinit cpufreq_register_driver(struct cpufreq_driver *driver_data)
+int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 {
 	unsigned long flags;
 	int ret;
_


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVD3SIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVD3SIp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 14:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVD3SIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 14:08:45 -0400
Received: from everest.sosdg.org ([66.93.203.161]:42406 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261319AbVD3SIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 14:08:37 -0400
From: "Coywolf Qi Hunt" <coywolf@lovecn.org>
Date: Sun, 1 May 2005 02:08:23 +0800
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>,
       Adrian Bunk <bunk@stusta.de>
Message-ID: <20050430180823.GA14922@lovecn.org>
References: <20050429231653.32d2f091.akpm@osdl.org> <20050430142035.GB3571@stusta.de> <Pine.LNX.4.61.0504300940560.12903@montezuma.fsmlabs.com> <2cd57c9005043010051c6455fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c9005043010051c6455fb@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Scan-Signature: e39eceae6eb4554774934c39b07fdc9c
X-SA-Exim-Connect-IP: 66.93.203.161
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: Re: 2.6.12-rc3-mm1
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.2 (built Tue, 12 Apr 2005 17:41:13 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 01:05:52AM +0800, Coywolf Qi Hunt wrote:
... 
> I was trying to fix this too. You are quicker and better than me. In
> addition, this redundant  include should be removed.

s/redundant/duplicate/

OK, since Zwane thinks my patch is "good in that its minimal impact", here it is.
I've compile tested for SMP and UP.

This removes the compile warning: implicit declaration of function `set_irq_info' and a duplicate include line.

Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
---

diff -pruN 2.6.12-rc3-mm1/arch/i386/kernel/io_apic.c 2.6.12-rc3-mm1-cy2/arch/i386/kernel/io_apic.c
--- 2.6.12-rc3-mm1/arch/i386/kernel/io_apic.c	2005-04-30 19:15:46.000000000 +0800
+++ 2.6.12-rc3-mm1-cy2/arch/i386/kernel/io_apic.c	2005-05-01 00:49:27.000000000 +0800
@@ -32,7 +32,6 @@
 #include <linux/compiler.h>
 #include <linux/acpi.h>
 #include <linux/sysdev.h>
-#include <linux/irq.h>
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
diff -pruN 2.6.12-rc3-mm1/include/linux/irq.h 2.6.12-rc3-mm1-cy2/include/linux/irq.h
--- 2.6.12-rc3-mm1/include/linux/irq.h	2005-04-30 19:16:26.000000000 +0800
+++ 2.6.12-rc3-mm1-cy2/include/linux/irq.h	2005-05-01 00:51:31.000000000 +0800
@@ -161,6 +161,7 @@ static inline void set_irq_info(int irq,
 #else
 #define move_irq(x)
 #define move_native_irq(x)
+extern void set_irq_info(unsigned int irq, cpumask_t mask);
 #endif // CONFIG_GENERIC_PENDING_IRQ
 
 extern int no_irq_affinity;

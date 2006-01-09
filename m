Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWAIUoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWAIUoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWAIUoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:44:34 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59300
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751328AbWAIUoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:44:34 -0500
Date: Mon, 09 Jan 2006 12:44:44 -0800 (PST)
Message-Id: <20060109.124444.115603028.davem@davemloft.net>
To: mroos@linux.ee
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15+git: undefined reference to `pm_power_off'
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.SOC.4.61.0601091329540.14603@math.ut.ee>
References: <Pine.SOC.4.61.0601091329540.14603@math.ut.ee>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 9 Jan 2006 13:30:35 +0200 (EET)

> Todays git update does not link on sparc64:
> 
>    LD      .tmp_vmlinux1
> kernel/built-in.o: In function `sys_reboot': undefined reference to `pm_power_off'
> kernel/built-in.o: In function `sys_reboot': undefined reference to `pm_power_off'

I have a fix on it's way already:

diff-tree 760c6246d9bc61e2cdee828e12617ac8696d31fd (from 5367f2d67c7d0bf1faae90e6e7b4e2ac3c9b5e0f)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Sun Jan 8 22:54:39 2006 -0800

    [SPARC64]: Add needed pm_power_off symbol.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/power.c b/arch/sparc64/kernel/power.c
index 9e8362e..30bcaf5 100644
--- a/arch/sparc64/kernel/power.c
+++ b/arch/sparc64/kernel/power.c
@@ -14,6 +14,7 @@
 #include <linux/signal.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 
 #include <asm/system.h>
 #include <asm/ebus.h>
@@ -70,6 +71,9 @@ void machine_power_off(void)
 	machine_halt();
 }
 
+void (*pm_power_off)(void) = machine_power_off;
+EXPORT_SYMBOL(pm_power_off);
+
 #ifdef CONFIG_PCI
 static int powerd(void *__unused)
 {

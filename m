Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269580AbRHQDgV>; Thu, 16 Aug 2001 23:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269568AbRHQDgN>; Thu, 16 Aug 2001 23:36:13 -0400
Received: from ool-18b899e0.dyn.optonline.net ([24.184.153.224]:42485 "EHLO
	bouncybouncy") by vger.kernel.org with ESMTP id <S269549AbRHQDgD>;
	Thu, 16 Aug 2001 23:36:03 -0400
Date: Thu, 16 Aug 2001 23:36:13 -0400
From: Justin A <justin@bouncybouncy.net>
To: linux-kernel@vger.kernel.org
Subject: [PATH] Trigger OOM handler through sysrq
Message-ID: <20010816233613.B23620@bouncybouncy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below patch allows you to trigger the OOM handler rather then the
generic SAK.  This may very well be the wrong way to do things, but
I'm sure someone else will know the right way to do this.  Apply this
if you want to try another way of bringing back a thrashing system.

Thanks,
-Justin

diff -urP sysrq.c.orig sysrq.c -u
--- sysrq.c.orig        Thu Aug 16 23:22:18 2001
+++ sysrq.c     Thu Aug 16 23:24:01 2001
@@ -23,6 +23,7 @@
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/swap.h>
 
 #include <asm/ptrace.h>
 
@@ -137,6 +138,11 @@
                send_sig_all(SIGKILL, 1);
                orig_log_level = 8;
                break;
+       case 'f':                                                /* F -- Free memory by invoking the oom handler */
+               printk("Free memory -- oom_kill()\n");
+               oom_kill();
+               break;
+
        default:                                            /* Unknown: help */
                if (kbd)
                        printk("unRaw ");
@@ -147,7 +153,7 @@
                printk("Boot ");
                if (sysrq_power_off)
                        printk("Off ");
-               printk("Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL\n");
+               printk("Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL Freemem\n");
                /* Don't use 'A' as it's handled specially on the Sparc */
        }
 

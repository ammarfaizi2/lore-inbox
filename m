Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVJAXeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVJAXeR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 19:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVJAXeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 19:34:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55569 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750903AbVJAXeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 19:34:17 -0400
Date: Sun, 2 Oct 2005 01:34:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill include/linux/platform.h
Message-ID: <20051001233414.GG4212@stusta.de>
References: <20050902205204.GU3657@stusta.de> <Pine.LNX.4.50.0509291106520.29808-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0509291106520.29808-100000@monsoon.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 11:07:18AM -0700, Patrick Mochel wrote:
> 
> Sorry about the delay in responding, been traveling.
> 
> On Fri, 2 Sep 2005, Adrian Bunk wrote:
> 
> > Hi Patrick,
> >
> > it seems that exept for the default_idle() prototype, the complete
> > include/linux/platform.h is obsolete.
> >
> > Is there a reason to keep it, or should we delete this header?
> 
> Kill it, it's way old.

Patch below.

> Thanks,
> 	Patrick

cu
Adrian


<--  snip  -->


This patch removes the obsolete include/linux/platform.h header.

This patch was already ACK'ed by Patrick Mochel.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/mach-visws/reboot.c |    1 
 arch/ia64/kernel/setup.c      |    1 
 arch/sh/kernel/process.c      |    1 
 include/linux/platform.h      |   43 ----------------------------------
 4 files changed, 46 deletions(-)

--- linux-2.6.14-rc2-mm2-full/arch/i386/mach-visws/reboot.c.old	2005-10-02 01:08:55.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/i386/mach-visws/reboot.c	2005-10-02 01:09:00.000000000 +0200
@@ -1,7 +1,6 @@
 #include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/delay.h>
-#include <linux/platform.h>
 
 #include <asm/io.h>
 #include "piix4.h"
--- linux-2.6.14-rc2-mm2-full/arch/ia64/kernel/setup.c.old	2005-10-02 01:09:11.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/ia64/kernel/setup.c	2005-10-02 01:09:15.000000000 +0200
@@ -41,7 +41,6 @@
 #include <linux/serial_core.h>
 #include <linux/efi.h>
 #include <linux/initrd.h>
-#include <linux/platform.h>
 #include <linux/pm.h>
 
 #include <asm/ia32.h>
--- linux-2.6.14-rc2-mm2-full/arch/sh/kernel/process.c.old	2005-10-02 01:09:24.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/sh/kernel/process.c	2005-10-02 01:09:49.000000000 +0200
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/a.out.h>
 #include <linux/ptrace.h>
-#include <linux/platform.h>
 #include <linux/kallsyms.h>
 
 #include <asm/io.h>
--- linux-2.6.14-rc2-mm2-full/include/linux/platform.h	2005-08-29 01:41:01.000000000 +0200
+++ /dev/null	2005-04-28 03:52:17.000000000 +0200
@@ -1,43 +0,0 @@
-/*
- * include/linux/platform.h - platform driver definitions
- *
- * Because of the prolific consumerism of the average American,
- * and the dominant marketing budgets of PC OEMs, we have been
- * blessed with frequent updates of the PC architecture. 
- *
- * While most of these calls are singular per architecture, they 
- * require an extra layer of abstraction on the x86 so the right
- * subsystem gets the right call. 
- *
- * Basically, this consolidates the power off and reboot callbacks 
- * into one structure, as well as adding power management hooks.
- *
- * When adding a platform driver, please make sure all callbacks are 
- * filled. There are defaults defined below that do nothing; use those
- * if you do not support that callback.
- */ 
-
-#ifndef _PLATFORM_H_
-#define _PLATFORM_H_
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-
-struct platform_t {
-	char	* name;
-	u32	suspend_states;
-	void	(*reboot)(char * cmd);
-	void	(*halt)(void);
-	void	(*power_off)(void);
-	int	(*suspend)(int state, int flags);
-	void	(*idle)(void);
-};
-
-extern struct platform_t * platform;
-extern void default_reboot(char * cmd);
-extern void default_halt(void);
-extern int default_suspend(int state, int flags);
-extern void default_idle(void);
-
-#endif /* __KERNEL__ */
-#endif /* _PLATFORM_H */


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbULFNPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbULFNPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 08:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbULFNPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 08:15:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41738 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261244AbULFNPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 08:15:13 -0500
Date: Mon, 6 Dec 2004 14:15:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386: reboot.c cleanups
Message-ID: <20041206131509.GC7250@stusta.de>
References: <20041206004127.GH2953@stusta.de> <20041206122320.GB30348@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206122320.GB30348@pazke>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 03:23:20PM +0300, Andrey Panin wrote:
> On 341, 12 06, 2004 at 01:41:27AM +0100, Adrian Bunk wrote:
> > The partch below includes the following changes:
> > - arch/i386/kernel/reboot.c: make reboot_thru_bios static
> > - arch/i386/mach-visws/reboot.c: remove the unused reboot_thru_bios and
> >                                  reboot_smp
> > - arch/i386/mach-voyager/voyager_basic.c: remove the unused reboot_thru_bios
> > - arch/i386/mach-voyager/voyager_smp.c: remove the unused reboot_smp
> 
> Look like "i386/x86_64/parisc process.c: make hlt_counter static" patch
> attached instead of promised :)
>...

Ups, sorry.

Correct patch below.


<--  snip  -->

 
The patch below includes the following changes:
- arch/i386/kernel/reboot.c: make reboot_thru_bios static
- arch/i386/mach-visws/reboot.c: remove the unused reboot_thru_bios and
                                 reboot_smp
- arch/i386/mach-voyager/voyager_basic.c: remove the unused reboot_thru_bios
- arch/i386/mach-voyager/voyager_smp.c: remove the unused reboot_smp


diffstat output:
 arch/i386/kernel/reboot.c              |    2 +-
 arch/i386/mach-visws/reboot.c          |    3 ---
 arch/i386/mach-voyager/voyager_basic.c |    2 --
 arch/i386/mach-voyager/voyager_smp.c   |    2 --
 4 files changed, 1 insertion(+), 8 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/mach-visws/reboot.c.old	2004-12-06 01:27:17.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/mach-visws/reboot.c	2004-12-06 01:27:44.000000000 +0100
@@ -8,9 +8,6 @@
 
 void (*pm_power_off)(void);
 
-int reboot_thru_bios;
-int reboot_smp;
-
 void machine_restart(char * __unused)
 {
 #ifdef CONFIG_SMP
--- linux-2.6.10-rc2-mm4-full/arch/i386/mach-voyager/voyager_basic.c.old	2004-12-06 01:28:03.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/mach-voyager/voyager_basic.c	2004-12-06 01:28:12.000000000 +0100
@@ -36,8 +36,6 @@
  */
 void (*pm_power_off)(void);
 
-int reboot_thru_bios;
-
 int voyager_level = 0;
 
 struct voyager_SUS *voyager_SUS = NULL;
--- linux-2.6.10-rc2-mm4-full/arch/i386/mach-voyager/voyager_smp.c.old	2004-12-06 01:28:20.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/mach-voyager/voyager_smp.c	2004-12-06 01:28:25.000000000 +0100
@@ -32,8 +32,6 @@
 
 #include <linux/irq.h>
 
-int reboot_smp = 0;
-
 /* TLB state -- visible externally, indexed physically */
 DEFINE_PER_CPU(struct tlb_state, cpu_tlbstate) ____cacheline_aligned = { &init_mm, 0 };
 
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/reboot.c.old	2004-12-06 01:28:33.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/reboot.c	2004-12-06 01:28:43.000000000 +0100
@@ -20,7 +20,7 @@
 void (*pm_power_off)(void);
 
 static int reboot_mode;
-int reboot_thru_bios;
+static int reboot_thru_bios;
 
 #ifdef CONFIG_SMP
 static int reboot_cpu = -1;


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUJVUlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUJVUlk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUJVUlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:41:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42251 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267549AbUJVU2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:28:04 -0400
Date: Fri, 22 Oct 2004 22:27:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove duplicate includes
Message-ID: <20041022202731.GD22558@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran "make includecheck" against 2.6.9-mm1 and went throught the 
results.

Below is a patch that removes in cases where a file is included directly 
twice in a file the second inclusion.

In all cases where the second inclusion might have had an effect I left 
it (famous last words: I didn't miss such a case.).

For better merging, this patch includes only the parts that also apply 
against Linus' tree.


diffstat output:
 arch/alpha/kernel/setup.c                    |    1 -
 arch/arm/mach-iop3xx/common.c                |    1 -
 arch/arm/mach-iop3xx/iop331-setup.c          |    1 -
 arch/arm/mach-ixp2000/core.c                 |    2 --
 arch/arm/mach-ixp2000/enp2611.c              |    3 ---
 arch/arm/mach-ixp2000/ixdp2400.c             |    3 ---
 arch/arm/mach-ixp2000/ixdp2800.c             |    3 ---
 arch/arm/mach-ixp2000/ixdp2x00.c             |    3 ---
 arch/arm/mach-ixp2000/ixdp2x01.c             |    3 ---
 arch/arm/mach-ixp4xx/common-pci.c            |    1 -
 arch/arm/mach-lh7a40x/arch-kev7a400.c        |    1 -
 arch/arm/mach-lh7a40x/arch-lpd7a40x.c        |    1 -
 arch/arm26/kernel/ecard.c                    |    1 -
 arch/i386/kernel/cpuid.c                     |    1 -
 arch/i386/mach-voyager/voyager_smp.c         |    1 -
 arch/ia64/kernel/time.c                      |    1 -
 arch/ia64/sn/kernel/setup.c                  |    1 -
 arch/ia64/sn/pci/pcibr/pcibr_dma.c           |    1 -
 arch/m68k/q40/config.c                       |    1 -
 arch/m68knommu/platform/5206e/config.c       |    1 -
 arch/mips/au1000/csb250/init.c               |    1 -
 arch/mips/au1000/hydrogen3/init.c            |    1 -
 arch/mips/au1000/mtx-1/init.c                |    1 -
 arch/mips/mm/dma-coherent.c                  |    2 --
 arch/mips/pci/pci-lasat.c                    |    2 --
 arch/mips/pmc-sierra/yosemite/setup.c        |    1 -
 arch/parisc/kernel/signal.c                  |    1 -
 arch/parisc/kernel/smp.c                     |    3 +--
 arch/ppc/kernel/cpu_setup_6xx.S              |    1 -
 arch/ppc/kernel/cpu_setup_power4.S           |    1 -
 arch/ppc/syslib/gt64260_pic.c                |    1 -
 arch/ppc/syslib/mpc52xx_pic.c                |    1 -
 arch/ppc/xmon/start.c                        |    1 -
 arch/ppc64/kernel/btext.c                    |    1 -
 arch/ppc64/kernel/cpu_setup_power4.S         |    1 -
 arch/ppc64/kernel/iSeries_setup.c            |    1 -
 arch/ppc64/kernel/iommu.c                    |    1 -
 arch/ppc64/kernel/pSeries_lpar.c             |    1 -
 arch/ppc64/mm/hugetlbpage.c                  |    3 ---
 arch/ppc64/mm/init.c                         |    1 -
 arch/sh/kernel/sh_ksyms.c                    |    1 -
 arch/sh64/kernel/process.c                   |    1 -
 arch/sh64/kernel/setup.c                     |    4 ----
 arch/sh64/kernel/signal.c                    |    1 -
 arch/sh64/kernel/traps.c                     |    2 --
 arch/sparc/kernel/irq.c                      |    1 -
 arch/sparc64/kernel/module.c                 |    1 -
 arch/sparc64/kernel/process.c                |    1 -
 arch/sparc64/kernel/sys_sparc32.c            |    1 -
 arch/sparc64/kernel/sys_sunos32.c            |    1 -
 arch/sparc64/kernel/time.c                   |    1 -
 arch/x86_64/kernel/entry.S                   |    1 -
 arch/x86_64/kernel/module.c                  |    1 -
 arch/x86_64/kernel/setup.c                   |    1 -
 arch/x86_64/kernel/time.c                    |    1 -
 arch/x86_64/kernel/x8664_ksyms.c             |    1 -
 drivers/block/viodasd.c                      |    1 -
 drivers/char/amiserial.c                     |    1 -
 drivers/char/lcd.c                           |    1 -
 drivers/char/ppdev.c                         |    1 -
 drivers/char/synclink.c                      |    1 -
 drivers/cpufreq/cpufreq_ondemand.c           |    1 -
 drivers/i2c/chips/rtc8564.c                  |    1 -
 drivers/input/gameport/vortex.c              |    1 -
 drivers/macintosh/therm_pm72.c               |    1 -
 drivers/media/video/arv.c                    |    1 -
 drivers/media/video/zr36016.c                |    3 ---
 drivers/mtd/chips/jedec_probe.c              |    1 -
 drivers/net/gianfar.h                        |    1 -
 drivers/net/gianfar_ethtool.c                |    1 -
 drivers/net/mv643xx_eth.c                    |    1 -
 drivers/net/via-velocity.c                   |    1 -
 drivers/parisc/lasi.c                        |    1 -
 drivers/scsi/ibmmca.c                        |    1 -
 drivers/usb/serial/ipw.c                     |    1 -
 drivers/video/fbmem.c                        |    2 --
 drivers/video/tgafb.c                        |    1 -
 drivers/w1/matrox_w1.c                       |    1 -
 include/asm-ia64/pgtable.h                   |    1 -
 include/asm-ia64/unistd.h                    |    1 -
 include/asm-m32r/mmu_context.h               |    1 -
 include/asm-mips/mach-dec/mc146818rtc.h      |    1 -
 include/asm-ppc64/elf.h                      |    1 -
 include/asm-sparc/system.h                   |    2 --
 include/asm-x86_64/pci.h                     |    1 -
 include/linux/ipv6.h                         |    1 -
 include/linux/nfs_fs.h                       |    1 -
 kernel/profile.c                             |    1 -
 mm/mempolicy.c                               |    2 --
 mm/swap.c                                    |    2 --
 mm/swapfile.c                                |    1 -
 net/atm/lec.c                                |    1 -
 net/ipv4/ip_output.c                         |    1 -
 net/ipv4/ipvs/ip_vs_ctl.c                    |    1 -
 net/ipv4/netfilter/ip_conntrack_proto_icmp.c |    1 -
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c  |    1 -
 net/ipv4/netfilter/ip_conntrack_proto_udp.c  |    1 -
 net/ipv6/tcp_ipv6.c                          |    1 -
 net/sched/police.c                           |    1 -
 net/sunrpc/auth_gss/svcauth_gss.c            |    1 -
 net/wanrouter/wanmain.c                      |    1 -
 sound/oss/rme96xx.c                          |    1 -
 102 files changed, 1 insertion(+), 128 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-mm1-full/arch/alpha/kernel/setup.c.old	2004-10-22 21:37:30.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/alpha/kernel/setup.c	2004-10-22 21:38:03.000000000 +0200
@@ -55,7 +55,6 @@
 #include <asm/system.h>
 #include <asm/hwrpb.h>
 #include <asm/dma.h>
-#include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/console.h>
 
--- linux-2.6.9-mm1-full/arch/arm26/kernel/ecard.c.old	2004-10-22 21:37:30.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm26/kernel/ecard.c	2004-10-22 21:38:08.000000000 +0200
@@ -44,7 +44,6 @@
 #include <asm/irq.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
-#include <asm/irq.h>
 #include <asm/irqchip.h>
 #include <asm/tlbflush.h>
 
--- linux-2.6.9-mm1-full/arch/arm/mach-iop3xx/common.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-iop3xx/common.c	2004-10-22 21:38:48.000000000 +0200
@@ -28,7 +28,6 @@
  * Default power-off for EP80219
  */
 #include <asm/mach-types.h>
-#include <asm/hardware.h>
 
 static inline void ep80219_send_to_pic(__u8 c) {
 }
--- linux-2.6.9-mm1-full/arch/arm/mach-iop3xx/iop331-setup.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-iop3xx/iop331-setup.c	2004-10-22 21:39:01.000000000 +0200
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/device.h>
--- linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/core.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/core.c	2004-10-22 21:39:18.000000000 +0200
@@ -33,10 +33,8 @@
 #include <asm/mach-types.h>
 #include <asm/irq.h>
 #include <asm/system.h>
-#include <asm/hardware.h>
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
-#include <asm/mach-types.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
--- linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/enp2611.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/enp2611.c	2004-10-22 21:39:31.000000000 +0200
@@ -26,9 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
--- linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/ixdp2400.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/ixdp2400.c	2004-10-22 21:39:38.000000000 +0200
@@ -23,9 +23,6 @@
 #include <linux/device.h>
 #include <linux/bitops.h>
 #include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
--- linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/ixdp2800.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/ixdp2800.c	2004-10-22 21:39:44.000000000 +0200
@@ -23,9 +23,6 @@
 #include <linux/device.h>
 #include <linux/bitops.h>
 #include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
--- linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/ixdp2x00.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/ixdp2x00.c	2004-10-22 21:39:49.000000000 +0200
@@ -23,9 +23,6 @@
 #include <linux/device.h>
 #include <linux/bitops.h>
 #include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
--- linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/ixdp2x01.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-ixp2000/ixdp2x01.c	2004-10-22 21:39:57.000000000 +0200
@@ -23,9 +23,6 @@
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
--- linux-2.6.9-mm1-full/arch/arm/mach-ixp4xx/common-pci.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-ixp4xx/common-pci.c	2004-10-22 21:40:05.000000000 +0200
@@ -33,7 +33,6 @@
 #include <asm/system.h>
 #include <asm/mach/pci.h>
 #include <asm/hardware.h>
-#include <asm/sizes.h>
 
 
 /*
--- linux-2.6.9-mm1-full/arch/arm/mach-lh7a40x/arch-kev7a400.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-lh7a40x/arch-kev7a400.c	2004-10-22 21:41:20.000000000 +0200
@@ -17,7 +17,6 @@
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware.h>	/* io_p2v() */
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
--- linux-2.6.9-mm1-full/arch/arm/mach-lh7a40x/arch-lpd7a40x.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/arm/mach-lh7a40x/arch-lpd7a40x.c	2004-10-22 21:41:24.000000000 +0200
@@ -17,7 +17,6 @@
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware.h>	/* io_p2v() */
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
--- linux-2.6.9-mm1-full/arch/i386/kernel/cpuid.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/i386/kernel/cpuid.c	2004-10-22 21:41:45.000000000 +0200
@@ -35,7 +35,6 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
-#include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
--- linux-2.6.9-mm1-full/arch/i386/mach-voyager/voyager_smp.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/i386/mach-voyager/voyager_smp.c	2004-10-22 21:42:20.000000000 +0200
@@ -27,7 +27,6 @@
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/desc.h>
 #include <asm/arch_hooks.h>
 
 #include <linux/irq.h>
--- linux-2.6.9-mm1-full/arch/ia64/kernel/time.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ia64/kernel/time.c	2004-10-22 21:42:52.000000000 +0200
@@ -19,7 +19,6 @@
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/efi.h>
-#include <linux/profile.h>
 #include <linux/timex.h>
 
 #include <asm/machvec.h>
--- linux-2.6.9-mm1-full/arch/ia64/sn/kernel/setup.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ia64/sn/kernel/setup.c	2004-10-22 21:43:12.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/acpi.h>
 #include <linux/compiler.h>
-#include <linux/sched.h>
 #include <linux/root_dev.h>
 
 #include <asm/io.h>
--- linux-2.6.9-mm1-full/arch/ia64/sn/pci/pcibr/pcibr_dma.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ia64/sn/pci/pcibr/pcibr_dma.c	2004-10-22 21:43:20.000000000 +0200
@@ -17,7 +17,6 @@
 #include "pci/tiocp.h"
 #include "pci/pic.h"
 #include "pci/pcibr_provider.h"
-#include "pci/tiocp.h"
 #include "tio.h"
 #include <asm/sn/addrs.h>
 
--- linux-2.6.9-mm1-full/arch/m68knommu/platform/5206e/config.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/m68knommu/platform/5206e/config.c	2004-10-22 21:43:28.000000000 +0200
@@ -21,7 +21,6 @@
 #include <asm/mcftimer.h>
 #include <asm/mcfsim.h>
 #include <asm/mcfdma.h>
-#include <asm/irq.h>
 #include <asm/delay.h>
 
 /***************************************************************************/
--- linux-2.6.9-mm1-full/arch/m68k/q40/config.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/m68k/q40/config.c	2004-10-22 21:43:35.000000000 +0200
@@ -33,7 +33,6 @@
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
-#include <asm/rtc.h>
 #include <asm/machdep.h>
 #include <asm/q40_master.h>
 
--- linux-2.6.9-mm1-full/arch/mips/au1000/csb250/init.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/mips/au1000/csb250/init.c	2004-10-22 21:43:45.000000000 +0200
@@ -35,7 +35,6 @@
 #include <asm/bootinfo.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 
 int prom_argc;
 char **prom_argv, **prom_envp;
--- linux-2.6.9-mm1-full/arch/mips/au1000/hydrogen3/init.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/mips/au1000/hydrogen3/init.c	2004-10-22 21:43:52.000000000 +0200
@@ -37,7 +37,6 @@
 #include <linux/config.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 
 int prom_argc;
 char **prom_argv, **prom_envp;
--- linux-2.6.9-mm1-full/arch/mips/au1000/mtx-1/init.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/mips/au1000/mtx-1/init.c	2004-10-22 21:43:56.000000000 +0200
@@ -38,7 +38,6 @@
 #include <linux/config.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 
 int prom_argc;
 char **prom_argv, **prom_envp;
--- linux-2.6.9-mm1-full/arch/mips/mm/dma-coherent.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/mips/mm/dma-coherent.c	2004-10-22 21:44:10.000000000 +0200
@@ -210,8 +210,6 @@
 
 #ifdef CONFIG_PCI
 
-#include <linux/pci.h>
-
 dma64_addr_t pci_dac_page_to_dma(struct pci_dev *pdev,
 	struct page *page, unsigned long offset, int direction)
 {
--- linux-2.6.9-mm1-full/arch/mips/pci/pci-lasat.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/mips/pci/pci-lasat.c	2004-10-22 21:44:19.000000000 +0200
@@ -10,8 +10,6 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
 #include <asm/pci_channel.h>
 #include <linux/delay.h>
 #include <asm/bootinfo.h>
--- linux-2.6.9-mm1-full/arch/mips/pmc-sierra/yosemite/setup.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/mips/pmc-sierra/yosemite/setup.c	2004-10-22 21:44:31.000000000 +0200
@@ -37,7 +37,6 @@
 #include <asm/time.h>
 #include <asm/bootinfo.h>
 #include <asm/page.h>
-#include <asm/bootinfo.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/processor.h>
--- linux-2.6.9-mm1-full/arch/parisc/kernel/signal.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/parisc/kernel/signal.c	2004-10-22 21:44:41.000000000 +0200
@@ -34,7 +34,6 @@
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_COMPAT
-#include <linux/compat.h>
 #include "signal32.h"
 #endif
 
--- linux-2.6.9-mm1-full/arch/parisc/kernel/smp.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/parisc/kernel/smp.c	2004-10-22 21:45:31.000000000 +0200
@@ -39,14 +39,13 @@
 #include <asm/atomic.h>
 #include <asm/current.h>
 #include <asm/delay.h>
-#include <asm/pgalloc.h>	/* for flush_tlb_all() proto/macro */
+#include <asm/pgalloc.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>		/* for CPU_IRQ_REGION and friends */
 #include <asm/mmu_context.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
--- linux-2.6.9-mm1-full/arch/ppc64/kernel/btext.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc64/kernel/btext.c	2004-10-22 21:45:53.000000000 +0200
@@ -12,7 +12,6 @@
 #include <asm/sections.h>
 #include <asm/prom.h>
 #include <asm/btext.h>
-#include <asm/prom.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
--- linux-2.6.9-mm1-full/arch/ppc64/kernel/cpu_setup_power4.S.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc64/kernel/cpu_setup_power4.S	2004-10-22 21:45:59.000000000 +0200
@@ -14,7 +14,6 @@
 #include <asm/page.h>
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
-#include <asm/ppc_asm.h>
 #include <asm/offsets.h>
 #include <asm/cache.h>
 
--- linux-2.6.9-mm1-full/arch/ppc64/kernel/iommu.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc64/kernel/iommu.c	2004-10-22 21:46:14.000000000 +0200
@@ -32,7 +32,6 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/dma-mapping.h>
-#include <linux/init.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
 #include <asm/prom.h>
--- linux-2.6.9-mm1-full/arch/ppc64/kernel/iSeries_setup.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc64/kernel/iSeries_setup.c	2004-10-22 21:46:24.000000000 +0200
@@ -44,7 +44,6 @@
 #include "iSeries_setup.h"
 #include <asm/naca.h>
 #include <asm/paca.h>
-#include <asm/sections.h>
 #include <asm/iSeries/LparData.h>
 #include <asm/iSeries/HvCallHpt.h>
 #include <asm/iSeries/HvLpConfig.h>
--- linux-2.6.9-mm1-full/arch/ppc64/kernel/pSeries_lpar.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc64/kernel/pSeries_lpar.c	2004-10-22 21:46:32.000000000 +0200
@@ -37,7 +37,6 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/prom.h>
-#include <asm/abs_addr.h>
 #include <asm/cputable.h>
 #include <asm/plpar_wrappers.h>
 
--- linux-2.6.9-mm1-full/arch/ppc64/mm/hugetlbpage.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc64/mm/hugetlbpage.c	2004-10-22 21:47:08.000000000 +0200
@@ -23,9 +23,6 @@
 #include <asm/mmu_context.h>
 #include <asm/machdep.h>
 #include <asm/cputable.h>
-#include <asm/tlb.h>
-
-#include <linux/sysctl.h>
 
 /* HugePTE layout:
  *
--- linux-2.6.9-mm1-full/arch/ppc64/mm/init.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc64/mm/init.c	2004-10-22 21:47:17.000000000 +0200
@@ -61,7 +61,6 @@
 #include <asm/sections.h>
 #include <asm/system.h>
 #include <asm/iommu.h>
-#include <asm/abs_addr.h>
 
 int mem_init_done;
 unsigned long ioremap_bot = IMALLOC_BASE;
--- linux-2.6.9-mm1-full/arch/ppc/kernel/cpu_setup_6xx.S.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc/kernel/cpu_setup_6xx.S	2004-10-22 21:47:27.000000000 +0200
@@ -14,7 +14,6 @@
 #include <asm/page.h>
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
-#include <asm/ppc_asm.h>
 #include <asm/offsets.h>
 #include <asm/cache.h>
 
--- linux-2.6.9-mm1-full/arch/ppc/kernel/cpu_setup_power4.S.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc/kernel/cpu_setup_power4.S	2004-10-22 21:47:33.000000000 +0200
@@ -14,7 +14,6 @@
 #include <asm/page.h>
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
-#include <asm/ppc_asm.h>
 #include <asm/offsets.h>
 #include <asm/cache.h>
 
--- linux-2.6.9-mm1-full/arch/ppc/syslib/gt64260_pic.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc/syslib/gt64260_pic.c	2004-10-22 21:47:43.000000000 +0200
@@ -36,7 +36,6 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
-#include <linux/stddef.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 
--- linux-2.6.9-mm1-full/arch/ppc/syslib/mpc52xx_pic.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc/syslib/mpc52xx_pic.c	2004-10-22 21:47:46.000000000 +0200
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
-#include <linux/stddef.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 
--- linux-2.6.9-mm1-full/arch/ppc/xmon/start.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/ppc/xmon/start.c	2004-10-22 21:47:51.000000000 +0200
@@ -16,7 +16,6 @@
 #include <asm/xmon.h>
 #include <asm/prom.h>
 #include <asm/bootx.h>
-#include <asm/machdep.h>
 #include <asm/errno.h>
 #include <asm/pmac_feature.h>
 #include <asm/processor.h>
--- linux-2.6.9-mm1-full/arch/sh64/kernel/process.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sh64/kernel/process.c	2004-10-22 21:48:27.000000000 +0200
@@ -924,7 +924,6 @@
    */
 
 #if defined(CONFIG_SH64_PROC_ASIDS)
-#include <linux/init.h>
 #include <linux/proc_fs.h>
 
 static int
--- linux-2.6.9-mm1-full/arch/sh64/kernel/setup.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sh64/kernel/setup.c	2004-10-22 21:48:39.000000000 +0200
@@ -59,10 +59,6 @@
 #include <asm/setup.h>
 #include <asm/smp.h>
 
-#ifdef CONFIG_VT
-#include <linux/console.h>
-#endif
-
 struct screen_info screen_info;
 
 /* On a PC this would be initialised as a result of the BIOS detecting the
--- linux-2.6.9-mm1-full/arch/sh64/kernel/signal.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sh64/kernel/signal.c	2004-10-22 21:48:46.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
-#include <linux/personality.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- linux-2.6.9-mm1-full/arch/sh64/kernel/traps.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sh64/kernel/traps.c	2004-10-22 21:48:53.000000000 +0200
@@ -243,8 +243,6 @@
 #endif /* CONFIG_SH64_ID2815_WORKAROUND */
 
 
-#include <asm/system.h>
-
 /* Called with interrupts disabled */
 asmlinkage void do_exception_error(unsigned long ex, struct pt_regs *regs)
 {
--- linux-2.6.9-mm1-full/arch/sh/kernel/sh_ksyms.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sh/kernel/sh_ksyms.c	2004-10-22 21:49:01.000000000 +0200
@@ -19,7 +19,6 @@
 #include <asm/delay.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
-#include <asm/checksum.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
 extern int dump_fpu(struct pt_regs *, elf_fpregset_t *);
--- linux-2.6.9-mm1-full/arch/sparc64/kernel/module.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sparc64/kernel/module.c	2004-10-22 21:49:10.000000000 +0200
@@ -11,7 +11,6 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/mm.h>
 
 #include <asm/processor.h>
--- linux-2.6.9-mm1-full/arch/sparc64/kernel/process.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sparc64/kernel/process.c	2004-10-22 21:49:20.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
-#include <linux/config.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/compat.h>
--- linux-2.6.9-mm1-full/arch/sparc64/kernel/sys_sparc32.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sparc64/kernel/sys_sparc32.c	2004-10-22 21:49:39.000000000 +0200
@@ -53,7 +53,6 @@
 #include <linux/vfs.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/ptrace.h>
-#include <linux/highuid.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
--- linux-2.6.9-mm1-full/arch/sparc64/kernel/sys_sunos32.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sparc64/kernel/sys_sunos32.c	2004-10-22 21:49:46.000000000 +0200
@@ -55,7 +55,6 @@
 #include <linux/personality.h>
 
 /* For SOCKET_I */
-#include <linux/socket.h>
 #include <net/sock.h>
 #include <net/compat.h>
 
--- linux-2.6.9-mm1-full/arch/sparc64/kernel/time.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sparc64/kernel/time.c	2004-10-22 21:49:58.000000000 +0200
@@ -29,7 +29,6 @@
 #include <linux/jiffies.h>
 #include <linux/cpufreq.h>
 #include <linux/percpu.h>
-#include <linux/profile.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
--- linux-2.6.9-mm1-full/arch/sparc/kernel/irq.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/sparc/kernel/irq.c	2004-10-22 21:50:06.000000000 +0200
@@ -19,7 +19,6 @@
 #include <linux/linkage.h>
 #include <linux/kernel_stat.h>
 #include <linux/signal.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/random.h>
--- linux-2.6.9-mm1-full/arch/x86_64/kernel/entry.S.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/x86_64/kernel/entry.S	2004-10-22 21:50:19.000000000 +0200
@@ -41,7 +41,6 @@
 #include <asm/unistd.h>
 #include <asm/thread_info.h>
 #include <asm/hw_irq.h>
-#include <asm/errno.h>
 
 	.code64
 
--- linux-2.6.9-mm1-full/arch/x86_64/kernel/module.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/x86_64/kernel/module.c	2004-10-22 21:50:24.000000000 +0200
@@ -23,7 +23,6 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 
 #include <asm/system.h>
 #include <asm/page.h>
--- linux-2.6.9-mm1-full/arch/x86_64/kernel/setup.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/x86_64/kernel/setup.c	2004-10-22 21:50:31.000000000 +0200
@@ -53,7 +53,6 @@
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
 #include <asm/bootsetup.h>
-#include <asm/smp.h>
 #include <asm/proto.h>
 #include <asm/setup.h>
 
--- linux-2.6.9-mm1-full/arch/x86_64/kernel/time.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/x86_64/kernel/time.c	2004-10-22 21:50:57.000000000 +0200
@@ -1000,7 +1000,6 @@
  * For (3), we use interrupts at 64Hz or user specified periodic
  * frequency, whichever is higher.
  */
-#include <linux/mc146818rtc.h>
 #include <linux/rtc.h>
 
 extern irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
--- linux-2.6.9-mm1-full/arch/x86_64/kernel/x8664_ksyms.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/x86_64/kernel/x8664_ksyms.c	2004-10-22 21:51:04.000000000 +0200
@@ -30,7 +30,6 @@
 #include <asm/nmi.h>
 #include <asm/kdebug.h>
 #include <asm/unistd.h>
-#include <asm/delay.h>
 #include <asm/tlbflush.h>
 
 extern spinlock_t rtc_lock;
--- linux-2.6.9-mm1-full/drivers/block/viodasd.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/block/viodasd.c	2004-10-22 21:51:17.000000000 +0200
@@ -41,7 +41,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
 
 #include <asm/uaccess.h>
 #include <asm/vio.h>
--- linux-2.6.9-mm1-full/drivers/char/amiserial.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/char/amiserial.c	2004-10-22 21:51:22.000000000 +0200
@@ -84,7 +84,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/delay.h>
 #include <linux/bitops.h>
 
 #include <asm/setup.h>
--- linux-2.6.9-mm1-full/drivers/char/lcd.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/char/lcd.c	2004-10-22 21:52:12.000000000 +0200
@@ -29,7 +29,6 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
-#include <linux/delay.h>
 
 #include "lcd.h"
 
--- linux-2.6.9-mm1-full/drivers/char/ppdev.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/char/ppdev.c	2004-10-22 21:52:21.000000000 +0200
@@ -68,7 +68,6 @@
 #include <asm/uaccess.h>
 #include <linux/ppdev.h>
 #include <linux/smp_lock.h>
-#include <linux/device.h>
 
 #define PP_VERSION "ppdev: user-space parallel port driver"
 #define CHRDEV "ppdev"
--- linux-2.6.9-mm1-full/drivers/char/synclink.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/char/synclink.c	2004-10-22 21:52:27.000000000 +0200
@@ -90,7 +90,6 @@
 #include <linux/init.h>
 #include <asm/serial.h>
 
-#include <linux/delay.h>
 #include <linux/ioctl.h>
 
 #include <asm/system.h>
--- linux-2.6.9-mm1-full/drivers/cpufreq/cpufreq_ondemand.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/cpufreq/cpufreq_ondemand.c	2004-10-22 21:52:35.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/kmod.h>
 #include <linux/workqueue.h>
 #include <linux/jiffies.h>
-#include <linux/config.h>
 #include <linux/kernel_stat.h>
 #include <linux/percpu.h>
 
--- linux-2.6.9-mm1-full/drivers/i2c/chips/rtc8564.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/i2c/chips/rtc8564.c	2004-10-22 21:52:40.000000000 +0200
@@ -19,7 +19,6 @@
 #include <linux/string.h>
 #include <linux/rtc.h>		/* get the user-level API */
 #include <linux/init.h>
-#include <linux/init.h>
 
 #include "rtc8564.h"
 
--- linux-2.6.9-mm1-full/drivers/input/gameport/vortex.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/input/gameport/vortex.c	2004-10-22 21:52:47.000000000 +0200
@@ -40,7 +40,6 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
 #include <linux/gameport.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
--- linux-2.6.9-mm1-full/drivers/macintosh/therm_pm72.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/macintosh/therm_pm72.c	2004-10-22 21:53:36.000000000 +0200
@@ -102,7 +102,6 @@
 #include <linux/wait.h>
 #include <linux/reboot.h>
 #include <linux/kmod.h>
-#include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
--- linux-2.6.9-mm1-full/drivers/media/video/arv.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/media/video/arv.c	2004-10-22 21:53:40.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
--- linux-2.6.9-mm1-full/drivers/media/video/zr36016.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/media/video/zr36016.c	2004-10-22 21:53:54.000000000 +0200
@@ -35,9 +35,6 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 
-/* includes for structures and defines regarding video 
-   #include<linux/videodev.h> */
-
 /* I/O commands, error codes */
 #include<asm/io.h>
 //#include<errno.h>
--- linux-2.6.9-mm1-full/drivers/mtd/chips/jedec_probe.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/mtd/chips/jedec_probe.c	2004-10-22 21:53:58.000000000 +0200
@@ -18,7 +18,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/init.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
--- linux-2.6.9-mm1-full/drivers/net/gianfar_ethtool.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/net/gianfar_ethtool.c	2004-10-22 21:54:04.000000000 +0200
@@ -37,7 +37,6 @@
 #include <linux/version.h>
 #include <linux/crc32.h>
 #include <asm/types.h>
-#include <asm/uaccess.h>
 #include <linux/ethtool.h>
 
 #include "gianfar.h"
--- linux-2.6.9-mm1-full/drivers/net/gianfar.h.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/net/gianfar.h	2004-10-22 21:54:09.000000000 +0200
@@ -46,7 +46,6 @@
 #include <linux/crc32.h>
 #include <linux/workqueue.h>
 #include <linux/ethtool.h>
-#include <linux/netdevice.h>
 #include <asm/ocp.h>
 #include "gianfar_phy.h"
 
--- linux-2.6.9-mm1-full/drivers/net/mv643xx_eth.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/net/mv643xx_eth.c	2004-10-22 21:54:21.000000000 +0200
@@ -28,7 +28,6 @@
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <linux/fcntl.h>
--- linux-2.6.9-mm1-full/drivers/net/via-velocity.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/net/via-velocity.c	2004-10-22 21:54:25.000000000 +0200
@@ -66,7 +66,6 @@
 #include <linux/wait.h>
 #include <asm/io.h>
 #include <linux/if.h>
-#include <linux/config.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
 #include <linux/inetdevice.h>
--- linux-2.6.9-mm1-full/drivers/parisc/lasi.c.old	2004-10-22 21:37:33.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/parisc/lasi.c	2004-10-22 21:54:32.000000000 +0200
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/pm.h>
-#include <linux/slab.h>
 #include <linux/types.h>
 
 #include <asm/io.h>
--- linux-2.6.9-mm1-full/drivers/scsi/ibmmca.c.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/scsi/ibmmca.c	2004-10-22 21:55:28.000000000 +0200
@@ -36,7 +36,6 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/mca.h>
-#include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/mca-legacy.h>
--- linux-2.6.9-mm1-full/drivers/usb/serial/ipw.c.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/usb/serial/ipw.c	2004-10-22 21:56:33.000000000 +0200
@@ -46,7 +46,6 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/usb.h>
-#include <linux/usb.h>
 #include <asm/uaccess.h>
 #include "usb-serial.h"
 
--- linux-2.6.9-mm1-full/drivers/video/fbmem.c.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/video/fbmem.c	2004-10-22 21:57:07.000000000 +0200
@@ -33,7 +33,6 @@
 #endif
 #include <linux/devfs_fs_kernel.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/device.h>
 
 #if defined(__mc68000__) || defined(CONFIG_APUS)
@@ -205,7 +204,6 @@
 }
 
 #ifdef CONFIG_LOGO
-#include <linux/linux_logo.h>
 
 static inline unsigned safe_shift(unsigned d, int n)
 {
--- linux-2.6.9-mm1-full/drivers/video/tgafb.c.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/video/tgafb.c	2004-10-22 21:57:12.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/selection.h>
 #include <asm/io.h>
 #include <video/tgafb.h>
-#include <linux/selection.h>
 
 /*
  * Local functions.
--- linux-2.6.9-mm1-full/drivers/w1/matrox_w1.c.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/w1/matrox_w1.c	2004-10-22 21:57:17.000000000 +0200
@@ -33,7 +33,6 @@
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/pci.h>
-#include <linux/timer.h>
 
 #include "w1.h"
 #include "w1_int.h"
--- linux-2.6.9-mm1-full/include/asm-ia64/pgtable.h.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/include/asm-ia64/pgtable.h	2004-10-22 21:58:19.000000000 +0200
@@ -130,7 +130,6 @@
 #include <asm/bitops.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
-#include <asm/processor.h>
 
 /*
  * Next come the mappings that determine how mmap() protection bits
--- linux-2.6.9-mm1-full/include/asm-ia64/unistd.h.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/include/asm-ia64/unistd.h	2004-10-22 21:58:33.000000000 +0200
@@ -289,7 +289,6 @@
 
 #ifdef __KERNEL_SYSCALLS__
 
-#include <linux/compiler.h>
 #include <linux/string.h>
 #include <linux/signal.h>
 #include <asm/ptrace.h>
--- linux-2.6.9-mm1-full/include/asm-m32r/mmu_context.h.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/include/asm-m32r/mmu_context.h	2004-10-22 21:58:48.000000000 +0200
@@ -15,7 +15,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/config.h>
 #include <asm/atomic.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu.h>
--- linux-2.6.9-mm1-full/include/asm-mips/mach-dec/mc146818rtc.h.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/include/asm-mips/mach-dec/mc146818rtc.h	2004-10-22 21:58:56.000000000 +0200
@@ -29,7 +29,6 @@
 
 #include <linux/mc146818rtc.h>
 #include <linux/module.h>
-#include <linux/types.h>
 
 static inline unsigned char CMOS_READ(unsigned long addr)
 {
--- linux-2.6.9-mm1-full/include/asm-ppc64/elf.h.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/include/asm-ppc64/elf.h	2004-10-22 21:59:17.000000000 +0200
@@ -85,7 +85,6 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-#include <asm/ptrace.h>
 
 #define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
 #define ELF_NFPREG	33	/* includes fpscr */
--- linux-2.6.9-mm1-full/include/asm-sparc/system.h.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/include/asm-sparc/system.h	2004-10-22 22:00:14.000000000 +0200
@@ -1,6 +1,4 @@
 /* $Id: system.h,v 1.86 2001/10/30 04:57:10 davem Exp $ */
-#include <linux/config.h>
-
 #ifndef __SPARC_SYSTEM_H
 #define __SPARC_SYSTEM_H
 
--- linux-2.6.9-mm1-full/include/asm-x86_64/pci.h.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/include/asm-x86_64/pci.h	2004-10-22 22:00:25.000000000 +0200
@@ -41,7 +41,6 @@
 #include <linux/slab.h>
 #include <asm/scatterlist.h>
 #include <linux/string.h>
-#include <asm/io.h>
 #include <asm/page.h>
 
 extern int iommu_setup(char *opt);
--- linux-2.6.9-mm1-full/include/linux/ipv6.h.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/include/linux/ipv6.h	2004-10-22 22:01:15.000000000 +0200
@@ -171,7 +171,6 @@
 };
 
 #ifdef __KERNEL__
-#include <linux/in6.h>          /* struct sockaddr_in6 */
 #include <linux/icmpv6.h>
 #include <net/if_inet6.h>       /* struct ipv6_mc_socklist */
 #include <linux/tcp.h>
--- linux-2.6.9-mm1-full/include/linux/nfs_fs.h.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/include/linux/nfs_fs.h	2004-10-22 22:01:23.000000000 +0200
@@ -28,7 +28,6 @@
 #include <linux/nfs3.h>
 #include <linux/nfs4.h>
 #include <linux/nfs_xdr.h>
-#include <linux/rwsem.h>
 #include <linux/workqueue.h>
 
 /*
--- linux-2.6.9-mm1-full/kernel/profile.c.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/kernel/profile.c	2004-10-22 22:01:31.000000000 +0200
@@ -21,7 +21,6 @@
 #include <linux/mm.h>
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
-#include <linux/profile.h>
 #include <linux/highmem.h>
 #include <asm/sections.h>
 #include <asm/semaphore.h>
--- linux-2.6.9-mm1-full/mm/mempolicy.c.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/mm/mempolicy.c	2004-10-22 22:01:49.000000000 +0200
@@ -65,7 +65,6 @@
 #include <linux/hugetlb.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/mm.h>
 #include <linux/nodemask.h>
 #include <linux/cpuset.h>
 #include <linux/gfp.h>
@@ -75,7 +74,6 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/compat.h>
-#include <linux/mempolicy.h>
 #include <asm/uaccess.h>
 
 static kmem_cache_t *policy_cache;
--- linux-2.6.9-mm1-full/mm/swap.c.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/mm/swap.c	2004-10-22 22:02:09.000000000 +0200
@@ -24,12 +24,10 @@
 #include <linux/module.h>
 #include <linux/mm_inline.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page() */
-#include <linux/module.h>
 #include <linux/percpu_counter.h>
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
-#include <linux/init.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
--- linux-2.6.9-mm1-full/mm/swapfile.c.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/mm/swapfile.c	2004-10-22 22:02:23.000000000 +0200
@@ -1075,7 +1075,6 @@
 }
 
 #if 0	/* We don't need this yet */
-#include <linux/backing-dev.h>
 int page_queue_congested(struct page *page)
 {
 	struct backing_dev_info *bdi;
--- linux-2.6.9-mm1-full/net/atm/lec.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/net/atm/lec.c	2004-10-22 22:02:31.000000000 +0200
@@ -21,7 +21,6 @@
 #include <net/dst.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
 /* TokenRing if needed */
--- linux-2.6.9-mm1-full/net/ipv4/ip_output.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/net/ipv4/ip_output.c	2004-10-22 22:02:39.000000000 +0200
@@ -78,7 +78,6 @@
 #include <net/raw.h>
 #include <net/checksum.h>
 #include <net/inetpeer.h>
-#include <net/checksum.h>
 #include <linux/igmp.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_bridge.h>
--- linux-2.6.9-mm1-full/net/ipv4/ipvs/ip_vs_ctl.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/net/ipv4/ipvs/ip_vs_ctl.c	2004-10-22 22:02:48.000000000 +0200
@@ -28,7 +28,6 @@
 #include <linux/proc_fs.h>
 #include <linux/workqueue.h>
 #include <linux/swap.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
 #include <linux/netfilter.h>
--- linux-2.6.9-mm1-full/net/ipv4/netfilter/ip_conntrack_proto_icmp.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/net/ipv4/netfilter/ip_conntrack_proto_icmp.c	2004-10-22 22:02:53.000000000 +0200
@@ -15,7 +15,6 @@
 #include <linux/seq_file.h>
 #include <net/ip.h>
 #include <net/checksum.h>
-#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
 #include <linux/netfilter_ipv4/ip_conntrack_core.h>
--- linux-2.6.9-mm1-full/net/ipv4/netfilter/ip_conntrack_proto_tcp.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	2004-10-22 22:02:56.000000000 +0200
@@ -32,7 +32,6 @@
 
 #include <net/tcp.h>
 
-#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
 #include <linux/netfilter_ipv4/ip_conntrack_protocol.h>
--- linux-2.6.9-mm1-full/net/ipv4/netfilter/ip_conntrack_proto_udp.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/net/ipv4/netfilter/ip_conntrack_proto_udp.c	2004-10-22 22:03:01.000000000 +0200
@@ -14,7 +14,6 @@
 #include <linux/udp.h>
 #include <linux/seq_file.h>
 #include <net/checksum.h>
-#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack_protocol.h>
 
--- linux-2.6.9-mm1-full/net/ipv6/tcp_ipv6.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/net/ipv6/tcp_ipv6.c	2004-10-22 22:03:11.000000000 +0200
@@ -55,7 +55,6 @@
 #include <net/inet_ecn.h>
 #include <net/protocol.h>
 #include <net/xfrm.h>
-#include <net/addrconf.h>
 #include <net/snmp.h>
 #include <net/dsfield.h>
 
--- linux-2.6.9-mm1-full/net/sched/police.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/net/sched/police.c	2004-10-22 22:03:17.000000000 +0200
@@ -27,7 +27,6 @@
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
-#include <linux/module.h>
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
 #include <net/sock.h>
--- linux-2.6.9-mm1-full/net/sunrpc/auth_gss/svcauth_gss.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/net/sunrpc/auth_gss/svcauth_gss.c	2004-10-22 22:03:27.000000000 +0200
@@ -44,7 +44,6 @@
 #include <linux/sunrpc/auth_gss.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/gss_err.h>
-#include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/cache.h>
 
--- linux-2.6.9-mm1-full/net/wanrouter/wanmain.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/net/wanrouter/wanmain.c	2004-10-22 22:03:34.000000000 +0200
@@ -57,7 +57,6 @@
 
 #include <linux/vmalloc.h>	/* vmalloc, vfree */
 #include <asm/uaccess.h>        /* copy_to/from_user */
-#include <linux/init.h>         /* __initfunc et al. */
 #include <net/syncppp.h>
 
 #define KMEM_SAFETYZONE 8
--- linux-2.6.9-mm1-full/sound/oss/rme96xx.c.old	2004-10-22 21:37:35.000000000 +0200
+++ linux-2.6.9-mm1-full/sound/oss/rme96xx.c	2004-10-22 22:04:03.000000000 +0200
@@ -56,7 +56,6 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/wait.h>
 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVLPXOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVLPXOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVLPXOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:14:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37084 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964819AbVLPXN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:26 -0500
Date: Fri, 16 Dec 2005 23:13:07 GMT
Message-Id: <200512162313.jBGND7xV019627@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 3/12]: MUTEX: Rename DECLARE_MUTEX for arch/ dir
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames DECLARE_MUTEX*() to DECLARE_SEM_MUTEX*() for the
rest of the arch/ directory.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-arch-2615rc5-2.diff
 arch/arm/common/rtctime.c                    |    2 +-
 arch/arm/kernel/ecard.c                      |    2 +-
 arch/arm/kernel/irq.c                        |    2 +-
 arch/arm/mach-aaec2000/clock.c               |    2 +-
 arch/arm/mach-integrator/clock.c             |    2 +-
 arch/arm/mach-pxa/ssp.c                      |    2 +-
 arch/arm/mach-realview/clock.c               |    2 +-
 arch/arm/mach-s3c2410/clock.c                |    2 +-
 arch/arm/mach-versatile/clock.c              |    2 +-
 arch/arm/plat-omap/clock.c                   |    2 +-
 arch/arm26/kernel/traps.c                    |    2 +-
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c   |    2 +-
 arch/i386/kernel/cpu/mtrr/main.c             |    2 +-
 arch/i386/kernel/microcode.c                 |    2 +-
 arch/i386/mach-voyager/voyager_thread.c      |    2 +-
 arch/ia64/hp/sim/simserial.c                 |    2 +-
 arch/ia64/ia32/sys_ia32.c                    |    2 +-
 arch/ia64/sn/kernel/mca.c                    |    2 +-
 arch/ia64/sn/kernel/sn2/sn_hwperf.c          |    2 +-
 arch/ia64/sn/kernel/xpc_main.c               |    4 ++--
 arch/mips/lasat/picvue.c                     |    2 +-
 arch/mips/lasat/sysctl.c                     |    2 +-
 arch/powerpc/kernel/kprobes.c                |    2 +-
 arch/powerpc/mm/imalloc.c                    |    2 +-
 arch/powerpc/platforms/iseries/viopath.c     |    2 +-
 arch/powerpc/platforms/powermac/cpufreq_64.c |    2 +-
 arch/ppc/4xx_io/serial_sicc.c                |    2 +-
 arch/ppc/syslib/mv64x60.c                    |    2 +-
 arch/s390/kernel/debug.c                     |    2 +-
 arch/um/drivers/port_kern.c                  |    2 +-
 arch/x86_64/Kconfig                          |    4 ++++
 arch/x86_64/kernel/kprobes.c                 |    2 +-
 arch/x86_64/kernel/mce.c                     |    2 +-
 33 files changed, 37 insertions(+), 33 deletions(-)

diff -uNrp linux-2.6.15-rc5/arch/arm/common/rtctime.c linux-2.6.15-rc5-mutex/arch/arm/common/rtctime.c
--- linux-2.6.15-rc5/arch/arm/common/rtctime.c	2005-06-22 13:51:23.000000000 +0100
+++ linux-2.6.15-rc5-mutex/arch/arm/common/rtctime.c	2005-12-15 17:14:56.000000000 +0000
@@ -34,7 +34,7 @@ static unsigned long rtc_irq_data;
 /*
  * rtc_sem protects rtc_inuse and rtc_ops
  */
-static DECLARE_MUTEX(rtc_sem);
+static DECLARE_SEM_MUTEX(rtc_sem);
 static unsigned long rtc_inuse;
 static struct rtc_ops *rtc_ops;
 
diff -uNrp linux-2.6.15-rc5/arch/arm/kernel/ecard.c linux-2.6.15-rc5-mutex/arch/arm/kernel/ecard.c
--- linux-2.6.15-rc5/arch/arm/kernel/ecard.c	2005-11-01 13:18:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/arm/kernel/ecard.c	2005-12-15 17:14:56.000000000 +0000
@@ -206,7 +206,7 @@ static void ecard_task_readbytes(struct 
 
 static DECLARE_WAIT_QUEUE_HEAD(ecard_wait);
 static struct ecard_request *ecard_req;
-static DECLARE_MUTEX(ecard_sem);
+static DECLARE_SEM_MUTEX(ecard_sem);
 
 /*
  * Set up the expansion card daemon's page tables.
diff -uNrp linux-2.6.15-rc5/arch/arm/kernel/irq.c linux-2.6.15-rc5-mutex/arch/arm/kernel/irq.c
--- linux-2.6.15-rc5/arch/arm/kernel/irq.c	2005-12-08 16:23:32.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/arm/kernel/irq.c	2005-12-15 17:14:56.000000000 +0000
@@ -821,7 +821,7 @@ void free_irq(unsigned int irq, void *de
 
 EXPORT_SYMBOL(free_irq);
 
-static DECLARE_MUTEX(probe_sem);
+static DECLARE_SEM_MUTEX(probe_sem);
 
 /* Start the interrupt probing.  Unlike other architectures,
  * we don't return a mask of interrupts from probe_irq_on,
diff -uNrp linux-2.6.15-rc5/arch/arm/mach-aaec2000/clock.c linux-2.6.15-rc5-mutex/arch/arm/mach-aaec2000/clock.c
--- linux-2.6.15-rc5/arch/arm/mach-aaec2000/clock.c	2005-12-08 16:23:32.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/arm/mach-aaec2000/clock.c	2005-12-15 17:14:56.000000000 +0000
@@ -22,7 +22,7 @@
 #include "clock.h"
 
 static LIST_HEAD(clocks);
-static DECLARE_MUTEX(clocks_sem);
+static DECLARE_SEM_MUTEX(clocks_sem);
 
 struct clk *clk_get(struct device *dev, const char *id)
 {
diff -uNrp linux-2.6.15-rc5/arch/arm/mach-integrator/clock.c linux-2.6.15-rc5-mutex/arch/arm/mach-integrator/clock.c
--- linux-2.6.15-rc5/arch/arm/mach-integrator/clock.c	2005-12-08 16:23:32.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/arm/mach-integrator/clock.c	2005-12-15 17:14:56.000000000 +0000
@@ -22,7 +22,7 @@
 #include "clock.h"
 
 static LIST_HEAD(clocks);
-static DECLARE_MUTEX(clocks_sem);
+static DECLARE_SEM_MUTEX(clocks_sem);
 
 struct clk *clk_get(struct device *dev, const char *id)
 {
diff -uNrp linux-2.6.15-rc5/arch/arm/mach-pxa/ssp.c linux-2.6.15-rc5-mutex/arch/arm/mach-pxa/ssp.c
--- linux-2.6.15-rc5/arch/arm/mach-pxa/ssp.c	2005-12-08 16:23:32.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/arm/mach-pxa/ssp.c	2005-12-15 17:14:56.000000000 +0000
@@ -59,7 +59,7 @@ static const struct ssp_info_ ssp_info[P
 #endif
 };
 
-static DECLARE_MUTEX(sem);
+static DECLARE_SEM_MUTEX(sem);
 static int use_count[PXA_SSP_PORTS] = {0, 0, 0};
 
 static irqreturn_t ssp_interrupt(int irq, void *dev_id, struct pt_regs *regs)
diff -uNrp linux-2.6.15-rc5/arch/arm/mach-realview/clock.c linux-2.6.15-rc5-mutex/arch/arm/mach-realview/clock.c
--- linux-2.6.15-rc5/arch/arm/mach-realview/clock.c	2005-12-08 16:23:32.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/arm/mach-realview/clock.c	2005-12-15 17:14:56.000000000 +0000
@@ -21,7 +21,7 @@
 #include "clock.h"
 
 static LIST_HEAD(clocks);
-static DECLARE_MUTEX(clocks_sem);
+static DECLARE_SEM_MUTEX(clocks_sem);
 
 struct clk *clk_get(struct device *dev, const char *id)
 {
diff -uNrp linux-2.6.15-rc5/arch/arm/mach-s3c2410/clock.c linux-2.6.15-rc5-mutex/arch/arm/mach-s3c2410/clock.c
--- linux-2.6.15-rc5/arch/arm/mach-s3c2410/clock.c	2005-12-08 16:23:32.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/arm/mach-s3c2410/clock.c	2005-12-15 17:14:56.000000000 +0000
@@ -52,7 +52,7 @@
 /* clock information */
 
 static LIST_HEAD(clocks);
-static DECLARE_MUTEX(clocks_sem);
+static DECLARE_SEM_MUTEX(clocks_sem);
 
 /* old functions */
 
diff -uNrp linux-2.6.15-rc5/arch/arm/mach-versatile/clock.c linux-2.6.15-rc5-mutex/arch/arm/mach-versatile/clock.c
--- linux-2.6.15-rc5/arch/arm/mach-versatile/clock.c	2005-12-08 16:23:32.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/arm/mach-versatile/clock.c	2005-12-15 17:14:56.000000000 +0000
@@ -22,7 +22,7 @@
 #include "clock.h"
 
 static LIST_HEAD(clocks);
-static DECLARE_MUTEX(clocks_sem);
+static DECLARE_SEM_MUTEX(clocks_sem);
 
 struct clk *clk_get(struct device *dev, const char *id)
 {
diff -uNrp linux-2.6.15-rc5/arch/arm/plat-omap/clock.c linux-2.6.15-rc5-mutex/arch/arm/plat-omap/clock.c
--- linux-2.6.15-rc5/arch/arm/plat-omap/clock.c	2005-12-08 16:23:32.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/arm/plat-omap/clock.c	2005-12-15 17:14:56.000000000 +0000
@@ -27,7 +27,7 @@
 #include <asm/arch/clock.h>
 
 LIST_HEAD(clocks);
-static DECLARE_MUTEX(clocks_sem);
+static DECLARE_SEM_MUTEX(clocks_sem);
 DEFINE_SPINLOCK(clockfw_lock);
 
 static struct clk_functions *arch_clock;
diff -uNrp linux-2.6.15-rc5/arch/arm26/kernel/traps.c linux-2.6.15-rc5-mutex/arch/arm26/kernel/traps.c
--- linux-2.6.15-rc5/arch/arm26/kernel/traps.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/arm26/kernel/traps.c	2005-12-15 17:14:56.000000000 +0000
@@ -207,7 +207,7 @@ void die_if_kernel(const char *str, stru
     	die(str, regs, err);
 }
 
-static DECLARE_MUTEX(undef_sem);
+static DECLARE_SEM_MUTEX(undef_sem);
 static int (*undef_hook)(struct pt_regs *);
 
 int request_undef_hook(int (*fn)(struct pt_regs *))
diff -uNrp linux-2.6.15-rc5/arch/i386/kernel/cpu/cpufreq/powernow-k8.c linux-2.6.15-rc5-mutex/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- linux-2.6.15-rc5/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-12-08 16:23:33.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-12-15 17:14:56.000000000 +0000
@@ -49,7 +49,7 @@
 #include "powernow-k8.h"
 
 /* serialize freq changes  */
-static DECLARE_MUTEX(fidvid_sem);
+static DECLARE_SEM_MUTEX(fidvid_sem);
 
 static struct powernow_k8_data *powernow_data[NR_CPUS];
 
diff -uNrp linux-2.6.15-rc5/arch/i386/kernel/cpu/mtrr/main.c linux-2.6.15-rc5-mutex/arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.6.15-rc5/arch/i386/kernel/cpu/mtrr/main.c	2005-12-08 16:23:33.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/i386/kernel/cpu/mtrr/main.c	2005-12-15 17:14:56.000000000 +0000
@@ -49,7 +49,7 @@
 u32 num_var_ranges = 0;
 
 unsigned int *usage_table;
-static DECLARE_MUTEX(main_lock);
+static DECLARE_SEM_MUTEX(main_lock);
 
 u32 size_or_mask, size_and_mask;
 
diff -uNrp linux-2.6.15-rc5/arch/i386/kernel/microcode.c linux-2.6.15-rc5-mutex/arch/i386/kernel/microcode.c
--- linux-2.6.15-rc5/arch/i386/kernel/microcode.c	2005-11-01 13:18:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/i386/kernel/microcode.c	2005-12-15 17:14:56.000000000 +0000
@@ -112,7 +112,7 @@ MODULE_LICENSE("GPL");
 static DEFINE_SPINLOCK(microcode_update_lock);
 
 /* no concurrent ->write()s are allowed on /dev/cpu/microcode */
-static DECLARE_MUTEX(microcode_sem);
+static DECLARE_SEM_MUTEX(microcode_sem);
 
 static void __user *user_buffer;	/* user area microcode data buffer */
 static unsigned int user_buffer_size;	/* it's size */
diff -uNrp linux-2.6.15-rc5/arch/i386/mach-voyager/voyager_thread.c linux-2.6.15-rc5-mutex/arch/i386/mach-voyager/voyager_thread.c
--- linux-2.6.15-rc5/arch/i386/mach-voyager/voyager_thread.c	2005-11-01 13:18:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/i386/mach-voyager/voyager_thread.c	2005-12-15 17:14:56.000000000 +0000
@@ -35,7 +35,7 @@
 
 /* external variables */
 int kvoyagerd_running = 0;
-DECLARE_MUTEX_LOCKED(kvoyagerd_sem);
+DECLARE_SEM_MUTEX_LOCKED(kvoyagerd_sem);
 
 static int thread(void *);
 
diff -uNrp linux-2.6.15-rc5/arch/ia64/hp/sim/simserial.c linux-2.6.15-rc5-mutex/arch/ia64/hp/sim/simserial.c
--- linux-2.6.15-rc5/arch/ia64/hp/sim/simserial.c	2005-12-08 16:23:33.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/ia64/hp/sim/simserial.c	2005-12-15 17:14:56.000000000 +0000
@@ -107,7 +107,7 @@ static struct async_struct *IRQ_ports[NR
 static struct console *console;
 
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 extern struct console *console_drivers; /* from kernel/printk.c */
 
diff -uNrp linux-2.6.15-rc5/arch/ia64/ia32/sys_ia32.c linux-2.6.15-rc5-mutex/arch/ia64/ia32/sys_ia32.c
--- linux-2.6.15-rc5/arch/ia64/ia32/sys_ia32.c	2005-12-08 16:23:33.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/ia64/ia32/sys_ia32.c	2005-12-15 17:14:56.000000000 +0000
@@ -85,7 +85,7 @@
  * while doing so.
  */
 /* XXX make per-mm: */
-static DECLARE_MUTEX(ia32_mmap_sem);
+static DECLARE_SEM_MUTEX(ia32_mmap_sem);
 
 asmlinkage long
 sys32_execve (char __user *name, compat_uptr_t __user *argv, compat_uptr_t __user *envp,
diff -uNrp linux-2.6.15-rc5/arch/ia64/sn/kernel/mca.c linux-2.6.15-rc5-mutex/arch/ia64/sn/kernel/mca.c
--- linux-2.6.15-rc5/arch/ia64/sn/kernel/mca.c	2005-06-22 13:51:32.000000000 +0100
+++ linux-2.6.15-rc5-mutex/arch/ia64/sn/kernel/mca.c	2005-12-15 17:14:56.000000000 +0000
@@ -27,7 +27,7 @@ void sn_init_cpei_timer(void);
 /* Printing oemdata from mca uses data that is not passed through SAL, it is
  * global.  Only one user at a time.
  */
-static DECLARE_MUTEX(sn_oemdata_mutex);
+static DECLARE_SEM_MUTEX(sn_oemdata_mutex);
 static u8 **sn_oemdata;
 static u64 *sn_oemdata_size, sn_oemdata_bufsize;
 
diff -uNrp linux-2.6.15-rc5/arch/ia64/sn/kernel/sn2/sn_hwperf.c linux-2.6.15-rc5-mutex/arch/ia64/sn/kernel/sn2/sn_hwperf.c
--- linux-2.6.15-rc5/arch/ia64/sn/kernel/sn2/sn_hwperf.c	2005-12-08 16:23:33.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/ia64/sn/kernel/sn2/sn_hwperf.c	2005-12-15 17:14:56.000000000 +0000
@@ -49,7 +49,7 @@ static void *sn_hwperf_salheap = NULL;
 static int sn_hwperf_obj_cnt = 0;
 static nasid_t sn_hwperf_master_nasid = INVALID_NASID;
 static int sn_hwperf_init(void);
-static DECLARE_MUTEX(sn_hwperf_init_mutex);
+static DECLARE_SEM_MUTEX(sn_hwperf_init_mutex);
 
 static int sn_hwperf_enum_objects(int *nobj, struct sn_hwperf_object_info **ret)
 {
diff -uNrp linux-2.6.15-rc5/arch/ia64/sn/kernel/xpc_main.c linux-2.6.15-rc5-mutex/arch/ia64/sn/kernel/xpc_main.c
--- linux-2.6.15-rc5/arch/ia64/sn/kernel/xpc_main.c	2005-12-08 16:23:33.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/ia64/sn/kernel/xpc_main.c	2005-12-15 17:14:56.000000000 +0000
@@ -172,10 +172,10 @@ static DECLARE_WAIT_QUEUE_HEAD(xpc_act_I
 static unsigned long xpc_hb_check_timeout;
 
 /* notification that the xpc_hb_checker thread has exited */
-static DECLARE_MUTEX_LOCKED(xpc_hb_checker_exited);
+static DECLARE_SEM_MUTEX_LOCKED(xpc_hb_checker_exited);
 
 /* notification that the xpc_discovery thread has exited */
-static DECLARE_MUTEX_LOCKED(xpc_discovery_exited);
+static DECLARE_SEM_MUTEX_LOCKED(xpc_discovery_exited);
 
 
 static struct timer_list xpc_hb_timer;
diff -uNrp linux-2.6.15-rc5/arch/mips/lasat/picvue.c linux-2.6.15-rc5-mutex/arch/mips/lasat/picvue.c
--- linux-2.6.15-rc5/arch/mips/lasat/picvue.c	2005-11-01 13:18:59.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/mips/lasat/picvue.c	2005-12-15 17:14:56.000000000 +0000
@@ -22,7 +22,7 @@
 
 struct pvc_defs *picvue = NULL;
 
-DECLARE_MUTEX(pvc_sem);
+DECLARE_SEM_MUTEX(pvc_sem);
 
 static void pvc_reg_write(u32 val)
 {
diff -uNrp linux-2.6.15-rc5/arch/mips/lasat/sysctl.c linux-2.6.15-rc5-mutex/arch/mips/lasat/sysctl.c
--- linux-2.6.15-rc5/arch/mips/lasat/sysctl.c	2005-11-01 13:18:59.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/mips/lasat/sysctl.c	2005-12-15 17:14:56.000000000 +0000
@@ -35,7 +35,7 @@
 #include "sysctl.h"
 #include "ds1603.h"
 
-static DECLARE_MUTEX(lasat_info_sem);
+static DECLARE_SEM_MUTEX(lasat_info_sem);
 
 /* Strategy function to write EEPROM after changing string entry */
 int sysctl_lasatstring(ctl_table *table, int *name, int nlen,
diff -uNrp linux-2.6.15-rc5/arch/powerpc/kernel/kprobes.c linux-2.6.15-rc5-mutex/arch/powerpc/kernel/kprobes.c
--- linux-2.6.15-rc5/arch/powerpc/kernel/kprobes.c	2005-12-08 16:23:35.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/powerpc/kernel/kprobes.c	2005-12-15 17:14:56.000000000 +0000
@@ -35,7 +35,7 @@
 #include <asm/kdebug.h>
 #include <asm/sstep.h>
 
-static DECLARE_MUTEX(kprobe_mutex);
+static DECLARE_SEM_MUTEX(kprobe_mutex);
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
diff -uNrp linux-2.6.15-rc5/arch/powerpc/mm/imalloc.c linux-2.6.15-rc5-mutex/arch/powerpc/mm/imalloc.c
--- linux-2.6.15-rc5/arch/powerpc/mm/imalloc.c	2005-12-08 16:23:35.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/powerpc/mm/imalloc.c	2005-12-15 17:14:56.000000000 +0000
@@ -18,7 +18,7 @@
 
 #include "mmu_decl.h"
 
-static DECLARE_MUTEX(imlist_sem);
+static DECLARE_SEM_MUTEX(imlist_sem);
 struct vm_struct * imlist = NULL;
 
 static int get_free_im_addr(unsigned long size, unsigned long *im_addr)
diff -uNrp linux-2.6.15-rc5/arch/powerpc/platforms/iseries/viopath.c linux-2.6.15-rc5-mutex/arch/powerpc/platforms/iseries/viopath.c
--- linux-2.6.15-rc5/arch/powerpc/platforms/iseries/viopath.c	2005-12-08 16:23:35.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/powerpc/platforms/iseries/viopath.c	2005-12-15 17:14:56.000000000 +0000
@@ -115,7 +115,7 @@ static int proc_viopath_show(struct seq_
 	u16 vlanMap;
 	dma_addr_t handle;
 	HvLpEvent_Rc hvrc;
-	DECLARE_MUTEX_LOCKED(Semaphore);
+	DECLARE_SEM_MUTEX_LOCKED(Semaphore);
 
 	buf = kmalloc(HW_PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
diff -uNrp linux-2.6.15-rc5/arch/powerpc/platforms/powermac/cpufreq_64.c linux-2.6.15-rc5-mutex/arch/powerpc/platforms/powermac/cpufreq_64.c
--- linux-2.6.15-rc5/arch/powerpc/platforms/powermac/cpufreq_64.c	2005-12-08 16:23:35.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/powerpc/platforms/powermac/cpufreq_64.c	2005-12-15 17:14:56.000000000 +0000
@@ -85,7 +85,7 @@ static u32 *g5_pmode_data;
 static int g5_pmode_max;
 static int g5_pmode_cur;
 
-static DECLARE_MUTEX(g5_switch_mutex);
+static DECLARE_SEM_MUTEX(g5_switch_mutex);
 
 
 static struct smu_sdbp_fvt *g5_fvt_table;	/* table of op. points */
diff -uNrp linux-2.6.15-rc5/arch/ppc/4xx_io/serial_sicc.c linux-2.6.15-rc5-mutex/arch/ppc/4xx_io/serial_sicc.c
--- linux-2.6.15-rc5/arch/ppc/4xx_io/serial_sicc.c	2005-12-08 16:23:35.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/ppc/4xx_io/serial_sicc.c	2005-12-15 17:14:56.000000000 +0000
@@ -214,7 +214,7 @@ static struct tty_driver *siccnormal_dri
  * memory if large numbers of serial ports are open.
  */
 static u_char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 #define HIGH_BITS_OFFSET    ((sizeof(long)-sizeof(int))*8)
 
diff -uNrp linux-2.6.15-rc5/arch/ppc/syslib/mv64x60.c linux-2.6.15-rc5-mutex/arch/ppc/syslib/mv64x60.c
--- linux-2.6.15-rc5/arch/ppc/syslib/mv64x60.c	2005-12-08 16:23:36.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/ppc/syslib/mv64x60.c	2005-12-15 17:14:56.000000000 +0000
@@ -2355,7 +2355,7 @@ mv64460_chip_specific_init(struct mv64x6
 /* Export the hotswap register via sysfs for enum event monitoring */
 #define	VAL_LEN_MAX	11 /* 32-bit hex or dec stringified number + '\n' */
 
-DECLARE_MUTEX(mv64xxx_hs_lock);
+DECLARE_SEM_MUTEX(mv64xxx_hs_lock);
 
 static ssize_t
 mv64xxx_hs_reg_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
diff -uNrp linux-2.6.15-rc5/arch/s390/kernel/debug.c linux-2.6.15-rc5-mutex/arch/s390/kernel/debug.c
--- linux-2.6.15-rc5/arch/s390/kernel/debug.c	2005-12-08 16:23:37.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/s390/kernel/debug.c	2005-12-15 17:14:56.000000000 +0000
@@ -164,7 +164,7 @@ unsigned int debug_feature_version = __D
 
 static debug_info_t *debug_area_first = NULL;
 static debug_info_t *debug_area_last = NULL;
-DECLARE_MUTEX(debug_lock);
+DECLARE_SEM_MUTEX(debug_lock);
 
 static int initialized;
 
diff -uNrp linux-2.6.15-rc5/arch/um/drivers/port_kern.c linux-2.6.15-rc5-mutex/arch/um/drivers/port_kern.c
--- linux-2.6.15-rc5/arch/um/drivers/port_kern.c	2005-11-01 13:19:03.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/um/drivers/port_kern.c	2005-12-15 17:14:56.000000000 +0000
@@ -129,7 +129,7 @@ static int port_accept(struct port_list 
 	return(ret);
 } 
 
-DECLARE_MUTEX(ports_sem);
+DECLARE_SEM_MUTEX(ports_sem);
 struct list_head ports = LIST_HEAD_INIT(ports);
 
 void port_work_proc(void *unused)
diff -uNrp linux-2.6.15-rc5/arch/x86_64/Kconfig linux-2.6.15-rc5-mutex/arch/x86_64/Kconfig
--- linux-2.6.15-rc5/arch/x86_64/Kconfig	2005-12-08 16:23:37.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/x86_64/Kconfig	2005-12-15 16:46:18.000000000 +0000
@@ -28,6 +28,10 @@ config SEMAPHORE_SLEEPERS
 	bool
 	default y
 
+config ARCH_CMPXCHG_MUTEX
+	bool
+	default y
+
 config MMU
 	bool
 	default y
diff -uNrp linux-2.6.15-rc5/arch/x86_64/kernel/kprobes.c linux-2.6.15-rc5-mutex/arch/x86_64/kernel/kprobes.c
--- linux-2.6.15-rc5/arch/x86_64/kernel/kprobes.c	2005-12-08 16:23:37.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/x86_64/kernel/kprobes.c	2005-12-15 17:14:56.000000000 +0000
@@ -42,7 +42,7 @@
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
 
-static DECLARE_MUTEX(kprobe_mutex);
+static DECLARE_SEM_MUTEX(kprobe_mutex);
 void jprobe_return_end(void);
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
diff -uNrp linux-2.6.15-rc5/arch/x86_64/kernel/mce.c linux-2.6.15-rc5-mutex/arch/x86_64/kernel/mce.c
--- linux-2.6.15-rc5/arch/x86_64/kernel/mce.c	2005-12-08 16:23:37.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/x86_64/kernel/mce.c	2005-12-15 17:14:56.000000000 +0000
@@ -400,7 +400,7 @@ static void collect_tscs(void *data) 
 static ssize_t mce_read(struct file *filp, char __user *ubuf, size_t usize, loff_t *off)
 {
 	unsigned long *cpu_tsc;
-	static DECLARE_MUTEX(mce_read_sem);
+	static DECLARE_SEM_MUTEX(mce_read_sem);
 	unsigned next;
 	char __user *buf = ubuf;
 	int i, err;

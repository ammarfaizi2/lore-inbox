Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291123AbSBMAVq>; Tue, 12 Feb 2002 19:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291268AbSBMAVa>; Tue, 12 Feb 2002 19:21:30 -0500
Received: from gwyn.tux.org ([207.96.122.8]:13022 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id <S291123AbSBMAVQ>;
	Tue, 12 Feb 2002 19:21:16 -0500
Date: Tue, 12 Feb 2002 19:21:15 -0500
From: Timothy Ball <timball@tux.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk
Subject: [Patch] #define foo(a) do { ... } while; typo fix for 2.4.18-pre9-ac1
Message-ID: <20020213002115.GB22307@gwyn.tux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch for 2.4.18-pre9-ac1 that fixes the small do { ... }
while(0); typo that may make some macros incorrectly parse. I've sent
individual emails to several authors already and they have accepted it.
But for completeness sake please apply this. 

Some more of these meanies seemed to have snuck in, and I'm guess it 
has to do w/ some vm code... but anyways here's the fix. 

--timball

--snip--snip--snip--
diff -ruN linux/arch/ia64/kernel/perfmon.c linux-2.4-18-pre9-ac1.fixed/arch/ia64/kernel/perfmon.c
--- linux/arch/ia64/kernel/perfmon.c	Fri Nov  9 17:26:17 2001
+++ linux-2.4-18-pre9-ac1.fixed/arch/ia64/kernel/perfmon.c	Tue Feb 12 18:40:57 2002
@@ -251,7 +251,7 @@
 #define DBprintk(a) \
 	do { \
 		if (pfm_debug >0) { printk(__FUNCTION__" %d: ", __LINE__); printk a; } \
-	} while (0);
+	} while (0)
 
 static void ia64_reset_pmu(void);
 
@@ -282,7 +282,7 @@
 /* 
  * helper macros
  */
-#define SET_PMU_OWNER(t)	do { pmu_owners[smp_processor_id()].owner = (t); } while(0);
+#define SET_PMU_OWNER(t)	do { pmu_owners[smp_processor_id()].owner = (t); } while(0)
 #define PMU_OWNER()		pmu_owners[smp_processor_id()].owner
 
 #ifdef CONFIG_SMP
diff -ruN linux/arch/mips/kernel/signal.c linux-2.4-18-pre9-ac1.fixed/arch/mips/kernel/signal.c
--- linux/arch/mips/kernel/signal.c	Sun Sep  9 12:43:01 2001
+++ linux-2.4-18-pre9-ac1.fixed/arch/mips/kernel/signal.c	Tue Feb 12 18:40:57 2002
@@ -204,7 +204,7 @@
 #define restore_gp_reg(i) do {						\
 	err |= __get_user(reg, &sc->sc_regs[i]);			\
 	regs->regs[i] = reg;						\
-} while(0);
+} while(0)
 	restore_gp_reg( 1); restore_gp_reg( 2); restore_gp_reg( 3);
 	restore_gp_reg( 4); restore_gp_reg( 5); restore_gp_reg( 6);
 	restore_gp_reg( 7); restore_gp_reg( 8); restore_gp_reg( 9);
diff -ruN linux/arch/mips/sni/pci.c linux-2.4-18-pre9-ac1.fixed/arch/mips/sni/pci.c
--- linux/arch/mips/sni/pci.c	Sun Sep  9 12:43:02 2001
+++ linux-2.4-18-pre9-ac1.fixed/arch/mips/sni/pci.c	Tue Feb 12 18:40:57 2002
@@ -25,7 +25,7 @@
 		 ((dev->bus->number    & 0xff) << 0x10) |                    \
 	         ((dev->devfn & 0xff) << 0x08) |                             \
 	         (where  & 0xfc);                                            \
-} while(0);
+} while(0)
 
 #if 0
 /* To do:  Bring this uptodate ...  */
diff -ruN linux/arch/ppc/math-emu/op-4.h linux-2.4-18-pre9-ac1.fixed/arch/ppc/math-emu/op-4.h
--- linux/arch/ppc/math-emu/op-4.h	Mon May 21 19:04:47 2001
+++ linux-2.4-18-pre9-ac1.fixed/arch/ppc/math-emu/op-4.h	Tue Feb 12 18:40:57 2002
@@ -279,7 +279,7 @@
     X##_f[1] = (rsize <= _FP_W_TYPE_SIZE ? 0 : r >> _FP_W_TYPE_SIZE);   \
     X##_f[2] = (rsize <= 2*_FP_W_TYPE_SIZE ? 0 : r >> 2*_FP_W_TYPE_SIZE); \
     X##_f[3] = (rsize <= 3*_FP_W_TYPE_SIZE ? 0 : r >> 3*_FP_W_TYPE_SIZE); \
-  } while (0);
+  } while (0)
 
 #define _FP_FRAC_CONV_4_1(dfs, sfs, D, S)                               \
    do {                                                                 \
diff -ruN linux/arch/sparc/mm/srmmu.c linux-2.4-18-pre9-ac1.fixed/arch/sparc/mm/srmmu.c
--- linux/arch/sparc/mm/srmmu.c	Tue Nov 13 12:16:05 2001
+++ linux-2.4-18-pre9-ac1.fixed/arch/sparc/mm/srmmu.c	Tue Feb 12 18:40:57 2002
@@ -1957,7 +1957,7 @@
 		iaddr = &(insn); \
 		daddr = &(dest); \
 		*iaddr = SPARC_BRANCH((unsigned long) daddr, (unsigned long) iaddr); \
-	} while(0);
+	} while(0)
 
 static void __init patch_window_trap_handlers(void)
 {
diff -ruN linux/arch/sparc/mm/sun4c.c linux-2.4-18-pre9-ac1.fixed/arch/sparc/mm/sun4c.c
--- linux/arch/sparc/mm/sun4c.c	Tue Nov 13 12:16:05 2001
+++ linux-2.4-18-pre9-ac1.fixed/arch/sparc/mm/sun4c.c	Tue Feb 12 18:40:57 2002
@@ -425,7 +425,7 @@
 		daddr = &(dst);		\
 		iaddr = &(src);		\
 		*daddr = *iaddr;	\
-	} while (0);
+	} while (0)
 
 static void patch_kernel_fault_handler(void)
 {
diff -ruN linux/arch/sparc64/kernel/binfmt_elf32.c linux-2.4-18-pre9-ac1.fixed/arch/sparc64/kernel/binfmt_elf32.c
--- linux/arch/sparc64/kernel/binfmt_elf32.c	Tue Jul 11 21:02:37 2000
+++ linux-2.4-18-pre9-ac1.fixed/arch/sparc64/kernel/binfmt_elf32.c	Tue Feb 12 18:40:57 2002
@@ -43,7 +43,7 @@
 	dest[34] = (unsigned int) src->tnpc;		\
 	dest[35] = src->y;				\
 	dest[36] = dest[37] = 0; /* XXX */		\
-} while(0);
+} while(0)
 
 typedef struct {
 	union {
diff -ruN linux/drivers/char/applicom.c linux-2.4-18-pre9-ac1.fixed/drivers/char/applicom.c
--- linux/drivers/char/applicom.c	Thu Oct 25 15:53:47 2001
+++ linux-2.4-18-pre9-ac1.fixed/drivers/char/applicom.c	Tue Feb 12 18:40:57 2002
@@ -36,7 +36,7 @@
 
 #if LINUX_VERSION_CODE < 0x20300 
 /* These probably want adding to <linux/compatmac.h> */
-#define init_waitqueue_head(x) do { *(x) = NULL; } while (0);
+#define init_waitqueue_head(x) do { *(x) = NULL; } while (0)
 #define PCI_BASE_ADDRESS(dev) (dev->base_address[0])
 #define DECLARE_WAIT_QUEUE_HEAD(x) struct wait_queue *x
 #define __setup(x,y) /* */
diff -ruN linux/drivers/char/drm/i810_dma.c linux-2.4-18-pre9-ac1.fixed/drivers/char/drm/i810_dma.c
--- linux/drivers/char/drm/i810_dma.c	Tue Feb 12 18:31:10 2002
+++ linux-2.4-18-pre9-ac1.fixed/drivers/char/drm/i810_dma.c	Tue Feb 12 18:40:57 2002
@@ -74,7 +74,7 @@
 	*(volatile unsigned int *)(virt + outring) = n;			\
 	outring += 4;							\
 	outring &= ringmask;						\
-} while (0);
+} while (0)
 
 static inline void i810_print_status_page(drm_device_t *dev)
 {
diff -ruN linux/drivers/char/drm-4.0/i810_dma.c linux-2.4-18-pre9-ac1.fixed/drivers/char/drm-4.0/i810_dma.c
--- linux/drivers/char/drm-4.0/i810_dma.c	Tue Feb 12 18:31:10 2002
+++ linux-2.4-18-pre9-ac1.fixed/drivers/char/drm-4.0/i810_dma.c	Tue Feb 12 18:59:21 2002
@@ -83,7 +83,7 @@
 	*(volatile unsigned int *)(virt + outring) = n;			\
 	outring += 4;							\
 	outring &= ringmask;						\
-} while (0);
+} while (0)
 
 static inline void i810_print_status_page(drm_device_t *dev)
 {
diff -ruN linux/drivers/isdn/avmb1/kcapi.c linux-2.4-18-pre9-ac1.fixed/drivers/isdn/avmb1/kcapi.c
--- linux/drivers/isdn/avmb1/kcapi.c	Fri Dec 21 12:41:54 2001
+++ linux-2.4-18-pre9-ac1.fixed/drivers/isdn/avmb1/kcapi.c	Tue Feb 12 18:40:57 2002
@@ -103,8 +103,8 @@
 #define APPL(a)		   (&applications[(a)-1])
 #define	VALID_APPLID(a)	   ((a) && (a) <= CAPI_MAXAPPL && APPL(a)->applid == a)
 #define APPL_IS_FREE(a)    (APPL(a)->applid == 0)
-#define APPL_MARK_FREE(a)  do{ APPL(a)->applid=0; MOD_DEC_USE_COUNT; }while(0);
-#define APPL_MARK_USED(a)  do{ APPL(a)->applid=(a); MOD_INC_USE_COUNT; }while(0);
+#define APPL_MARK_FREE(a)  do{ APPL(a)->applid=0; MOD_DEC_USE_COUNT; }while(0)
+#define APPL_MARK_USED(a)  do{ APPL(a)->applid=(a); MOD_INC_USE_COUNT; }while(0)
 
 #define NCCI2CTRL(ncci)    (((ncci) >> 24) & 0x7f)
 
diff -ruN linux/drivers/mtd/ftl.c linux-2.4-18-pre9-ac1.fixed/drivers/mtd/ftl.c
--- linux/drivers/mtd/ftl.c	Thu Oct 25 15:58:35 2001
+++ linux-2.4-18-pre9-ac1.fixed/drivers/mtd/ftl.c	Tue Feb 12 19:00:47 2002
@@ -87,7 +87,7 @@
 #define register_disk(dev, drive, minors, ops, size) \
     do { (dev)->part[(drive)*(minors)].nr_sects = size; \
         if (size == 0) (dev)->part[(drive)*(minors)].start_sect = -1; \
-        resetup_one_dev(dev, drive); } while (0);
+        resetup_one_dev(dev, drive); } while (0)
 #endif
 
 #if (LINUX_VERSION_CODE < 0x20320)
diff -ruN linux/drivers/net/acenic.c linux-2.4-18-pre9-ac1.fixed/drivers/net/acenic.c
--- linux/drivers/net/acenic.c	Tue Feb 12 18:30:56 2002
+++ linux-2.4-18-pre9-ac1.fixed/drivers/net/acenic.c	Tue Feb 12 18:40:57 2002
@@ -166,12 +166,12 @@
 #endif
 
 #ifndef SET_MODULE_OWNER
-#define SET_MODULE_OWNER(dev)		{do{} while(0);}
+#define SET_MODULE_OWNER(dev)		do { } while(0)
 #define ACE_MOD_INC_USE_COUNT		MOD_INC_USE_COUNT
 #define ACE_MOD_DEC_USE_COUNT		MOD_DEC_USE_COUNT
 #else
-#define ACE_MOD_INC_USE_COUNT		{do{} while(0);}
-#define ACE_MOD_DEC_USE_COUNT		{do{} while(0);}
+#define ACE_MOD_INC_USE_COUNT		do { } while(0)
+#define ACE_MOD_DEC_USE_COUNT		do { } while(0)
 #endif
 
 
@@ -252,7 +252,7 @@
 #define dev_kfree_skb_irq(a)			dev_kfree_skb(a)
 #define netif_wake_queue(dev)			clear_bit(0, &dev->tbusy)
 #define netif_stop_queue(dev)			set_bit(0, &dev->tbusy)
-#define late_stop_netif_stop_queue(dev)		{do{} while(0);}
+#define late_stop_netif_stop_queue(dev)		do { } while(0)
 #define early_stop_netif_stop_queue(dev)	test_and_set_bit(0,&dev->tbusy)
 #define early_stop_netif_wake_queue(dev)	netif_wake_queue(dev)
 
@@ -266,7 +266,7 @@
 #define ace_mark_net_bh()			mark_bh(NET_BH)
 #define netif_queue_stopped(dev)		dev->tbusy
 #define netif_running(dev)			dev->start
-#define ace_if_down(dev)			{do{dev->start = 0;} while(0);}
+#define ace_if_down(dev)			do { dev->start = 0; } while(0)
 
 #define tasklet_struct				tq_struct
 static inline void tasklet_schedule(struct tasklet_struct *tasklet)
@@ -284,13 +284,13 @@
 	tasklet->routine = (void (*)(void *))func;
 	tasklet->data = (void *)data;
 }
-#define tasklet_kill(tasklet)			{do{} while(0);}
+#define tasklet_kill(tasklet)			do { } while(0)
 #else
 #define late_stop_netif_stop_queue(dev)		netif_stop_queue(dev)
 #define early_stop_netif_stop_queue(dev)	0
-#define early_stop_netif_wake_queue(dev)	{do{} while(0);}
-#define ace_mark_net_bh()			{do{} while(0);}
-#define ace_if_down(dev)			{do{} while(0);}
+#define early_stop_netif_wake_queue(dev)	do { } while(0)
+#define ace_mark_net_bh()			do { } while(0)
+#define ace_if_down(dev)			do { } while(0)
 #endif
 
 #if (LINUX_VERSION_CODE >= 0x02031b)
@@ -306,7 +306,7 @@
 
 #ifndef ARCH_HAS_PREFETCHW
 #ifndef prefetchw
-#define prefetchw(x)				{do{} while(0);}
+#define prefetchw(x)				do { } while(0)
 #endif
 #endif
 
diff -ruN linux/drivers/net/at1700.c linux-2.4-18-pre9-ac1.fixed/drivers/net/at1700.c
--- linux/drivers/net/at1700.c	Thu Oct 11 01:24:09 2001
+++ linux-2.4-18-pre9-ac1.fixed/drivers/net/at1700.c	Tue Feb 12 18:40:57 2002
@@ -464,7 +464,7 @@
 #define EE_DATA_READ	0x80	/* EEPROM chip data out, in reg. 17. */
 
 /* Delay between EEPROM clock transitions. */
-#define eeprom_delay()	do {} while (0);
+#define eeprom_delay()	do { } while (0)
 
 /* The EEPROM commands include the alway-set leading bit. */
 #define EE_WRITE_CMD	(5 << 6)
diff -ruN linux/drivers/net/pppoe.c linux-2.4-18-pre9-ac1.fixed/drivers/net/pppoe.c
--- linux/drivers/net/pppoe.c	Fri Nov  9 17:02:24 2001
+++ linux-2.4-18-pre9-ac1.fixed/drivers/net/pppoe.c	Tue Feb 12 18:40:57 2002
@@ -86,11 +86,11 @@
 
 
 #if 0
-#define CHECKPTR(x,y) { if (!(x) && pppoe_debug &7 ){ printk(KERN_CRIT "PPPoE Invalid pointer : %s , %p\n",#x,(x)); error=-EINVAL; goto y; }}
-#define DEBUG(s,args...) if( pppoe_debug & (s) ) printk(KERN_CRIT args );
+#define CHECKPTR(x,y) do { if (!(x) && pppoe_debug &7 ){ printk(KERN_CRIT "PPPoE Invalid pointer : %s , %p\n",#x,(x)); error=-EINVAL; goto y; }} while (0)
+#define DEBUG(s,args...) do { if( pppoe_debug & (s) ) printk(KERN_CRIT args ); } while (0)
 #else
-#define CHECKPTR(x,y) do {} while (0);
-#define DEBUG(s,args...) do { } while (0);
+#define CHECKPTR(x,y) do { } while (0)
+#define DEBUG(s,args...) do { } while (0)
 #endif
 
 
diff -ruN linux/drivers/net/rrunner.c linux-2.4-18-pre9-ac1.fixed/drivers/net/rrunner.c
--- linux/drivers/net/rrunner.c	Tue Feb 12 18:31:11 2002
+++ linux-2.4-18-pre9-ac1.fixed/drivers/net/rrunner.c	Tue Feb 12 18:40:57 2002
@@ -73,13 +73,13 @@
 #define rr_mark_net_bh(foo) mark_bh(foo)
 #define rr_if_busy(dev)     dev->tbusy
 #define rr_if_running(dev)  dev->start /* Currently unused. */
-#define rr_if_down(dev)     {do{dev->start = 0;}while (0);}
+#define rr_if_down(dev)     do { dev->start = 0; } while (0)
 #else
 #define NET_BH              0
-#define rr_mark_net_bh(foo) {do{} while(0);}
+#define rr_mark_net_bh(foo) do { } while(0)
 #define rr_if_busy(dev)     netif_queue_stopped(dev)
 #define rr_if_running(dev)  netif_running(dev)
-#define rr_if_down(dev)     {do{} while(0);}
+#define rr_if_down(dev)     do { } while(0)
 #endif
 
 #include "rrunner.h"
diff -ruN linux/drivers/net/wan/lmc/lmc_var.h linux-2.4-18-pre9-ac1.fixed/drivers/net/wan/lmc/lmc_var.h
--- linux/drivers/net/wan/lmc/lmc_var.h	Tue Mar  6 22:44:36 2001
+++ linux-2.4-18-pre9-ac1.fixed/drivers/net/wan/lmc/lmc_var.h	Tue Feb 12 18:40:57 2002
@@ -87,7 +87,7 @@
 		lmc_delay(); \
 		LMC_CSR_WRITE((sc), csr_9, 0x30000); \
                 lmc_delay(); \
-		n--; }} while(0);
+		n--; }} while(0)
 
 struct lmc_regfile_t {
     lmc_csrptr_t csr_busmode;                  /* CSR0 */
diff -ruN linux/drivers/s390/block/dasd_int.h linux-2.4-18-pre9-ac1.fixed/drivers/s390/block/dasd_int.h
--- linux/drivers/s390/block/dasd_int.h	Tue Feb 12 18:30:56 2002
+++ linux-2.4-18-pre9-ac1.fixed/drivers/s390/block/dasd_int.h	Tue Feb 12 18:59:57 2002
@@ -203,14 +203,14 @@
         debug_sprintf_event(d_device->debug_area,d_level,\
                     DASD_DEVICE_FORMAT_STRING d_str "\n",\
                     d_device, d_data);\
-} while(0);
+} while(0)
 #define DASD_DEVICE_DEBUG_EXCEPTION(d_level, d_device, d_str, d_data...)\
 do {\
         if ( d_device->debug_area != NULL )\
         debug_sprintf_exception(d_device->debug_area,d_level,\
                         DASD_DEVICE_FORMAT_STRING d_str "\n",\
                         d_device, d_data);\
-} while(0);
+} while(0)
 
 #define DASD_DRIVER_FORMAT_STRING "Driver: <[%p]>"
 #define DASD_DRIVER_DEBUG_EVENT(d_level, d_fn, d_str, d_data...)\
@@ -219,14 +219,14 @@
         debug_sprintf_event(dasd_debug_area, d_level,\
                     DASD_DRIVER_FORMAT_STRING #d_fn ":" d_str "\n",\
                     d_fn, d_data);\
-} while(0);
+} while(0)
 #define DASD_DRIVER_DEBUG_EXCEPTION(d_level, d_fn, d_str, d_data...)\
 do {\
         if ( dasd_debug_area != NULL )\
         debug_sprintf_exception(dasd_debug_area, d_level,\
                         DASD_DRIVER_FORMAT_STRING #d_fn ":" d_str "\n",\
                         d_fn, d_data);\
-} while(0);
+} while(0)
 
 struct dasd_device_t;
 struct request;
diff -ruN linux/drivers/scsi/3w-xxxx.h linux-2.4-18-pre9-ac1.fixed/drivers/scsi/3w-xxxx.h
--- linux/drivers/scsi/3w-xxxx.h	Tue Feb 12 18:30:56 2002
+++ linux-2.4-18-pre9-ac1.fixed/drivers/scsi/3w-xxxx.h	Tue Feb 12 18:40:57 2002
@@ -213,7 +213,7 @@
 #ifdef TW_DEBUG
 #define dprintk(msg...) printk(msg)
 #else
-#define dprintk(msg...) do { } while(0);
+#define dprintk(msg...) do { } while(0)
 #endif
 
 /* Scatter Gather List Entry */
diff -ruN linux/drivers/telephony/ixj.c linux-2.4-18-pre9-ac1.fixed/drivers/telephony/ixj.c
--- linux/drivers/telephony/ixj.c	Thu Oct 25 15:53:52 2001
+++ linux-2.4-18-pre9-ac1.fixed/drivers/telephony/ixj.c	Tue Feb 12 18:40:57 2002
@@ -387,7 +387,7 @@
 #ifdef PERFMON_STATS
 #define ixj_perfmon(x)	((x)++)
 #else
-#define ixj_perfmon(x)	do {} while(0);
+#define ixj_perfmon(x)	do { } while(0)
 #endif
 
 static int ixj_convert_loaded;
diff -ruN linux/drivers/video/chipsfb.c linux-2.4-18-pre9-ac1.fixed/drivers/video/chipsfb.c
--- linux/drivers/video/chipsfb.c	Thu Sep 13 18:04:43 2001
+++ linux-2.4-18-pre9-ac1.fixed/drivers/video/chipsfb.c	Tue Feb 12 18:40:57 2002
@@ -79,7 +79,7 @@
 } while (0)
 #define read_ind(num, var, ap, dp)	do { \
 	outb((num), (ap)); var = inb((dp)); \
-} while (0);
+} while (0)
 
 /* extension registers */
 #define write_xr(num, val)	write_ind(num, val, 0x3d6, 0x3d7)
diff -ruN linux/drivers/video/fbcon-cfb24.c linux-2.4-18-pre9-ac1.fixed/drivers/video/fbcon-cfb24.c
--- linux/drivers/video/fbcon-cfb24.c	Mon Oct 15 15:47:13 2001
+++ linux-2.4-18-pre9-ac1.fixed/drivers/video/fbcon-cfb24.c	Tue Feb 12 18:40:57 2002
@@ -76,14 +76,14 @@
 	out1 = (in1<<8)  | (in2>>16); \
 	out2 = (in2<<16) | (in3>>8); \
 	out3 = (in3<<24) | in4; \
-    } while (0);
+    } while (0)
 #elif defined(__LITTLE_ENDIAN)
 #define convert4to3(in1, in2, in3, in4, out1, out2, out3) \
     do { \
 	out1 = in1       | (in2<<24); \
 	out2 = (in2>> 8) | (in3<<16); \
 	out3 = (in3>>16) | (in4<< 8); \
-    } while (0);
+    } while (0)
 #else
 #error FIXME: No endianness??
 #endif
diff -ruN linux/drivers/video/virgefb.c linux-2.4-18-pre9-ac1.fixed/drivers/video/virgefb.c
--- linux/drivers/video/virgefb.c	Wed Nov 14 17:52:20 2001
+++ linux-2.4-18-pre9-ac1.fixed/drivers/video/virgefb.c	Tue Feb 12 18:40:57 2002
@@ -670,12 +670,10 @@
  */
 
 #define Cyber3D_WaitQueue(v) \
-{ \
-	 do { \
+	do { \
 		while ((rl_3d(0x8504) & 0x1f00) < (((v)+2) << 8)); \
-	 } \
-	while (0); \
-}
+	} \
+	while (0)
 
 static inline void Cyber3D_WaitBusy(void)
 {
diff -ruN linux/fs/vfat/namei.c linux-2.4-18-pre9-ac1.fixed/fs/vfat/namei.c
--- linux/fs/vfat/namei.c	Thu Oct 25 02:02:26 2001
+++ linux-2.4-18-pre9-ac1.fixed/fs/vfat/namei.c	Tue Feb 12 19:01:07 2002
@@ -446,7 +446,7 @@
 	(x)->lower = 1;				\
 	(x)->upper = 1;				\
 	(x)->valid = 1;				\
-} while (0);
+} while (0)
 
 static inline unsigned char
 shortname_info_to_lcase(struct shortname_info *base,
diff -ruN linux/include/asm-arm/arch-cl7500/system.h linux-2.4-18-pre9-ac1.fixed/include/asm-arm/arch-cl7500/system.h
--- linux/include/asm-arm/arch-cl7500/system.h	Thu Apr 12 14:20:31 2001
+++ linux-2.4-18-pre9-ac1.fixed/include/asm-arm/arch-cl7500/system.h	Tue Feb 12 18:40:57 2002
@@ -18,6 +18,6 @@
 	do {					\
 		iomd_writeb(0, IOMD_ROMCR0);	\
 		cpu_reset(0);			\
-	} while (0);
+	} while (0)
 
 #endif
diff -ruN linux/include/asm-arm/arch-sa1100/keyboard.h linux-2.4-18-pre9-ac1.fixed/include/asm-arm/arch-sa1100/keyboard.h
--- linux/include/asm-arm/arch-sa1100/keyboard.h	Thu Oct 25 15:53:54 2001
+++ linux-2.4-18-pre9-ac1.fixed/include/asm-arm/arch-sa1100/keyboard.h	Tue Feb 12 18:40:57 2002
@@ -10,8 +10,8 @@
 #include <asm/mach-types.h>
 #include <asm/arch/assabet.h>
 
-#define kbd_disable_irq()	do { } while(0);
-#define kbd_enable_irq()	do { } while(0);
+#define kbd_disable_irq()	do { } while(0)
+#define kbd_enable_irq()	do { } while(0)
 
 extern void sa1111_kbd_init_hw(void);
 extern void gc_kbd_init_hw(void);
diff -ruN linux/include/asm-mips/spinlock.h linux-2.4-18-pre9-ac1.fixed/include/asm-mips/spinlock.h
--- linux/include/asm-mips/spinlock.h	Mon Jul  2 15:56:40 2001
+++ linux-2.4-18-pre9-ac1.fixed/include/asm-mips/spinlock.h	Tue Feb 12 18:40:57 2002
@@ -19,10 +19,10 @@
 
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
 
-#define spin_lock_init(x)	do { (x)->lock = 0; } while(0);
+#define spin_lock_init(x)	do { (x)->lock = 0; } while(0)
 
 #define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	({ do { barrier(); } while ((x)->lock); })
+#define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
diff -ruN linux/include/asm-mips64/spinlock.h linux-2.4-18-pre9-ac1.fixed/include/asm-mips64/spinlock.h
--- linux/include/asm-mips64/spinlock.h	Wed Nov 29 00:42:04 2000
+++ linux-2.4-18-pre9-ac1.fixed/include/asm-mips64/spinlock.h	Tue Feb 12 18:40:57 2002
@@ -19,10 +19,10 @@
 
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
 
-#define spin_lock_init(x)	do { (x)->lock = 0; } while(0);
+#define spin_lock_init(x)	do { (x)->lock = 0; } while(0)
 
 #define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	({ do { barrier(); } while ((x)->lock); })
+#define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
diff -ruN linux/include/asm-parisc/pgalloc.h linux-2.4-18-pre9-ac1.fixed/include/asm-parisc/pgalloc.h
--- linux/include/asm-parisc/pgalloc.h	Mon Apr 23 17:28:07 2001
+++ linux-2.4-18-pre9-ac1.fixed/include/asm-parisc/pgalloc.h	Tue Feb 12 18:40:57 2002
@@ -120,7 +120,7 @@
 #define flush_tlb() do { \
         flush_data_tlb(); \
 	flush_instruction_tlb(); \
-} while(0);
+} while(0)
 
 #define flush_tlb_all() 	flush_tlb()	/* XXX p[id]tlb */
 
diff -ruN linux/include/asm-sparc/elf.h linux-2.4-18-pre9-ac1.fixed/include/asm-sparc/elf.h
--- linux/include/asm-sparc/elf.h	Tue Jul 11 21:02:37 2000
+++ linux-2.4-18-pre9-ac1.fixed/include/asm-sparc/elf.h	Tue Feb 12 18:40:57 2002
@@ -41,7 +41,7 @@
 	dest[34] = src->npc;				\
 	dest[35] = src->y;				\
 	dest[36] = dest[37] = 0; /* XXX */		\
-} while(0);
+} while(0)
 
 typedef struct {
 	union {
diff -ruN linux/include/linux/mtd/compatmac.h linux-2.4-18-pre9-ac1.fixed/include/linux/mtd/compatmac.h
--- linux/include/linux/mtd/compatmac.h	Mon Dec 11 16:16:42 2000
+++ linux-2.4-18-pre9-ac1.fixed/include/linux/mtd/compatmac.h	Tue Feb 12 18:40:57 2002
@@ -190,8 +190,8 @@
 
 #if LINUX_VERSION_CODE < 0x20300
 #include <linux/interrupt.h>
-#define spin_lock_bh(lock) do {start_bh_atomic();spin_lock(lock);}while(0);
-#define spin_unlock_bh(lock) do {spin_unlock(lock);end_bh_atomic();}while(0);
+#define spin_lock_bh(lock) do {start_bh_atomic();spin_lock(lock);} while(0)
+#define spin_unlock_bh(lock) do {spin_unlock(lock);end_bh_atomic();} while(0)
 #else
 #include <asm/softirq.h>
 #include <linux/spinlock.h>
diff -ruN linux/include/linux/rtnetlink.h linux-2.4-18-pre9-ac1.fixed/include/linux/rtnetlink.h
--- linux/include/linux/rtnetlink.h	Tue Feb 12 18:30:58 2002
+++ linux-2.4-18-pre9-ac1.fixed/include/linux/rtnetlink.h	Tue Feb 12 18:40:57 2002
@@ -587,7 +587,7 @@
 
 #define ASSERT_RTNL() do { if (down_trylock(&rtnl_sem) == 0)  { up(&rtnl_sem); \
 printk("RTNL: assertion failed at " __FILE__ "(%d)\n", __LINE__); } \
-		   } while(0);
+		   } while(0)
 #define BUG_TRAP(x) if (!(x)) { printk("KERNEL: assertion (" #x ") failed at " __FILE__ "(%d)\n", __LINE__); }
 
 
diff -ruN linux/include/math-emu/op-4.h linux-2.4-18-pre9-ac1.fixed/include/math-emu/op-4.h
--- linux/include/math-emu/op-4.h	Tue Feb 12 18:30:58 2002
+++ linux-2.4-18-pre9-ac1.fixed/include/math-emu/op-4.h	Tue Feb 12 18:40:57 2002
@@ -645,7 +645,7 @@
     X##_f[1] = (rsize <= _FP_W_TYPE_SIZE ? 0 : r >> _FP_W_TYPE_SIZE);	\
     X##_f[2] = (rsize <= 2*_FP_W_TYPE_SIZE ? 0 : r >> 2*_FP_W_TYPE_SIZE); \
     X##_f[3] = (rsize <= 3*_FP_W_TYPE_SIZE ? 0 : r >> 3*_FP_W_TYPE_SIZE); \
-  } while (0);
+  } while (0)
 
 #define _FP_FRAC_CONV_4_1(dfs, sfs, D, S)				\
    do {									\
diff -ruN linux/include/net/sock.h linux-2.4-18-pre9-ac1.fixed/include/net/sock.h
--- linux/include/net/sock.h	Fri Dec 21 12:42:04 2001
+++ linux-2.4-18-pre9-ac1.fixed/include/net/sock.h	Tue Feb 12 18:40:57 2002
@@ -484,7 +484,7 @@
 do {	spin_lock_init(&((__sk)->lock.slock)); \
 	(__sk)->lock.users = 0; \
 	init_waitqueue_head(&((__sk)->lock.wq)); \
-} while(0);
+} while(0)
 
 struct sock {
 	/* Socket demultiplex comparisons on incoming packets. */
diff -ruN linux/include/net/tcp.h linux-2.4-18-pre9-ac1.fixed/include/net/tcp.h
--- linux/include/net/tcp.h	Thu Nov 22 14:47:22 2001
+++ linux-2.4-18-pre9-ac1.fixed/include/net/tcp.h	Tue Feb 12 18:40:57 2002
@@ -1825,6 +1825,6 @@
 	return 1;
 }
 
-#define TCP_CHECK_TIMER(sk) do { } while (0);
+#define TCP_CHECK_TIMER(sk) do { } while (0)
 
 #endif	/* _TCP_H */
diff -ruN linux/net/ipv4/netfilter/ip_fw_compat_redir.c linux-2.4-18-pre9-ac1.fixed/net/ipv4/netfilter/ip_fw_compat_redir.c
--- linux/net/ipv4/netfilter/ip_fw_compat_redir.c	Tue Feb 12 18:30:59 2002
+++ linux-2.4-18-pre9-ac1.fixed/net/ipv4/netfilter/ip_fw_compat_redir.c	Tue Feb 12 18:40:57 2002
@@ -43,7 +43,7 @@
 		   netplay... */					 \
 		printk("ASSERT: %s:%i(%s)\n",				 \
 		       __FILE__, __LINE__, __FUNCTION__);		 \
-} while(0);
+} while(0)
 #else
 #define IP_NF_ASSERT(x)
 #endif
diff -ruN linux/net/ipv4/netfilter/ip_queue.c linux-2.4-18-pre9-ac1.fixed/net/ipv4/netfilter/ip_queue.c
--- linux/net/ipv4/netfilter/ip_queue.c	Tue Feb 12 18:30:59 2002
+++ linux-2.4-18-pre9-ac1.fixed/net/ipv4/netfilter/ip_queue.c	Tue Feb 12 18:40:57 2002
@@ -464,7 +464,7 @@
 	return netlink_unicast(nfnl, skb, nlq->peer.pid, MSG_DONTWAIT);
 }
 
-#define RCV_SKB_FAIL(err) do { netlink_ack(skb, nlh, (err)); return; } while (0);
+#define RCV_SKB_FAIL(err) do { netlink_ack(skb, nlh, (err)); return; } while (0)
 
 static __inline__ void netlink_receive_user_skb(struct sk_buff *skb)
 {
diff -ruN linux/net/ipv4/netfilter/ipt_ULOG.c linux-2.4-18-pre9-ac1.fixed/net/ipv4/netfilter/ipt_ULOG.c
--- linux/net/ipv4/netfilter/ipt_ULOG.c	Tue Feb 12 18:30:59 2002
+++ linux-2.4-18-pre9-ac1.fixed/net/ipv4/netfilter/ipt_ULOG.c	Tue Feb 12 18:40:57 2002
@@ -61,7 +61,7 @@
 #define DEBUGP(format, args...)
 #endif
 
-#define PRINTR(format, args...) do { if (net_ratelimit()) printk(format, ## args); } while (0);
+#define PRINTR(format, args...) do { if (net_ratelimit()) printk(format, ## args); } while (0)
 
 MODULE_AUTHOR("Harald Welte <laforge@gnumonks.org>");
 MODULE_DESCRIPTION("IP tables userspace logging module");
diff -ruN linux/net/ipv6/netfilter/ip6_queue.c linux-2.4-18-pre9-ac1.fixed/net/ipv6/netfilter/ip6_queue.c
--- linux/net/ipv6/netfilter/ip6_queue.c	Tue Feb 12 18:30:59 2002
+++ linux-2.4-18-pre9-ac1.fixed/net/ipv6/netfilter/ip6_queue.c	Tue Feb 12 18:40:57 2002
@@ -518,7 +518,7 @@
 	return netlink_unicast(nfnl, skb, nlq6->peer.pid, MSG_DONTWAIT);
 }
 
-#define RCV_SKB_FAIL(err) do { netlink_ack(skb, nlh, (err)); return; } while (0);
+#define RCV_SKB_FAIL(err) do { netlink_ack(skb, nlh, (err)); return; } while (0)
 
 static __inline__ void netlink_receive_user_skb(struct sk_buff *skb)
 {

-- 
	GPG key available on pgpkeys.mit.edu
pub  1024D/511FBD54 2001-07-23 Timothy Lu Hu Ball <timball@tux.org>
Key fingerprint = B579 29B0 F6C8 C7AA 3840  E053 FE02 BB97 511F BD54

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbWJFUll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWJFUll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWJFUll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:41:41 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:12237 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S932628AbWJFUlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:41:37 -0400
Date: Fri, 6 Oct 2006 22:34:34 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>, Paul Mackeras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] powerpc: fixup after irq changes
Message-ID: <20061006203434.GA7932@aepfle.de>
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


remove struct pt_regs * from all handlers.
compile tested with arch/powerpc/config/* and
arch/ppc/configs/prep_defconfig

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---

xmon needs some attention



 arch/powerpc/kernel/ibmebus.c                     |    2 +-
 arch/powerpc/kernel/irq.c                         |    2 +-
 arch/powerpc/kernel/time.c                        |    2 +-
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |    5 ++---
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    5 ++---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    7 ++++---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    5 ++---
 arch/powerpc/platforms/cell/interrupt.c           |    5 ++---
 arch/powerpc/platforms/chrp/setup.c               |    7 +++----
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    5 ++---
 arch/powerpc/platforms/iseries/irq.c              |   14 +++++++-------
 arch/powerpc/platforms/iseries/irq.h              |    2 +-
 arch/powerpc/platforms/iseries/lpevents.c         |    4 ++--
 arch/powerpc/platforms/iseries/mf.c               |    4 ++--
 arch/powerpc/platforms/iseries/smp.c              |    4 ++--
 arch/powerpc/platforms/iseries/viopath.c          |    2 +-
 arch/powerpc/platforms/powermac/pic.c             |   12 ++++++------
 arch/powerpc/platforms/powermac/pic.h             |    4 ++--
 arch/powerpc/platforms/powermac/smp.c             |    8 ++++----
 arch/powerpc/platforms/pseries/setup.c            |    2 +-
 arch/powerpc/platforms/pseries/xics.c             |    4 ++--
 arch/powerpc/sysdev/cpm2_pic.c                    |    2 +-
 arch/powerpc/sysdev/cpm2_pic.h                    |    2 +-
 arch/powerpc/sysdev/i8259.c                       |    2 +-
 arch/powerpc/sysdev/ipic.c                        |    2 +-
 arch/powerpc/sysdev/mpic.c                        |    6 +++---
 arch/powerpc/sysdev/qe_lib/qe_ic.c                |   14 ++++++--------
 arch/powerpc/sysdev/tsi108_pci.c                  |    3 +--
 arch/ppc/kernel/time.c                            |    2 +-
 arch/ppc/platforms/85xx/mpc8560_ads.c             |    6 +++---
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c      |    6 +++---
 arch/ppc/platforms/85xx/stx_gp3.c                 |    6 +++---
 arch/ppc/platforms/85xx/tqm85xx.c                 |    6 +++---
 arch/ppc/syslib/i8259.c                           |    2 +-
 drivers/char/viocons.c                            |    2 +-
 include/asm-powerpc/i8259.h                       |    4 ++--
 include/asm-powerpc/ibmebus.h                     |    2 +-
 include/asm-powerpc/ipic.h                        |    4 ++--
 include/asm-powerpc/iseries/hv_lp_event.h         |    2 +-
 include/asm-powerpc/iseries/it_lp_queue.h         |    2 +-
 include/asm-powerpc/machdep.h                     |    2 +-
 include/asm-powerpc/mpic.h                        |    4 ++--
 include/asm-ppc/floppy.h                          |    6 +++---
 include/asm-ppc/machdep.h                         |    2 +-
 44 files changed, 93 insertions(+), 101 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/iseries/irq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/irq.c
+++ linux-2.6/arch/powerpc/platforms/iseries/irq.c
@@ -45,7 +45,7 @@
 #include "call_pci.h"
 
 #if defined(CONFIG_SMP)
-extern void iSeries_smp_message_recv(struct pt_regs *);
+extern void iSeries_smp_message_recv(void);
 #endif
 
 #ifdef CONFIG_PCI
@@ -88,7 +88,7 @@ static DEFINE_SPINLOCK(pending_irqs_lock
 static int num_pending_irqs;
 static int pending_irqs[NR_IRQS];
 
-static void int_received(struct pci_event *event, struct pt_regs *regs)
+static void int_received(struct pci_event *event)
 {
 	int irq;
 
@@ -146,11 +146,11 @@ static void int_received(struct pci_even
 	}
 }
 
-static void pci_event_handler(struct HvLpEvent *event, struct pt_regs *regs)
+static void pci_event_handler(struct HvLpEvent *event)
 {
 	if (event && (event->xType == HvLpEvent_Type_PciIo)) {
 		if (hvlpevent_is_int(event))
-			int_received((struct pci_event *)event, regs);
+			int_received((struct pci_event *)event);
 		else
 			printk(KERN_ERR
 				"pci_event_handler: unexpected ack received\n");
@@ -308,18 +308,18 @@ int __init iSeries_allocate_IRQ(HvBusNum
 /*
  * Get the next pending IRQ.
  */
-unsigned int iSeries_get_irq(struct pt_regs *regs)
+unsigned int iSeries_get_irq(void)
 {
 	int irq = NO_IRQ_IGNORE;
 
 #ifdef CONFIG_SMP
 	if (get_lppaca()->int_dword.fields.ipi_cnt) {
 		get_lppaca()->int_dword.fields.ipi_cnt = 0;
-		iSeries_smp_message_recv(regs);
+		iSeries_smp_message_recv();
 	}
 #endif /* CONFIG_SMP */
 	if (hvlpevent_is_pending())
-		process_hvlpevents(regs);
+		process_hvlpevents();
 
 #ifdef CONFIG_PCI
 	if (num_pending_irqs) {
Index: linux-2.6/arch/powerpc/platforms/iseries/irq.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/irq.h
+++ linux-2.6/arch/powerpc/platforms/iseries/irq.h
@@ -4,6 +4,6 @@
 extern void iSeries_init_IRQ(void);
 extern int  iSeries_allocate_IRQ(HvBusNumber, HvSubBusNumber, u32);
 extern void iSeries_activate_IRQs(void);
-extern unsigned int iSeries_get_irq(struct pt_regs *);
+extern unsigned int iSeries_get_irq(void);
 
 #endif /* _ISERIES_IRQ_H */
Index: linux-2.6/arch/powerpc/platforms/iseries/lpevents.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/lpevents.c
+++ linux-2.6/arch/powerpc/platforms/iseries/lpevents.c
@@ -116,7 +116,7 @@ static void hvlpevent_clear_valid(struct
 	hvlpevent_invalidate(event);
 }
 
-void process_hvlpevents(struct pt_regs *regs)
+void process_hvlpevents(void)
 {
 	struct HvLpEvent * event;
 
@@ -144,7 +144,7 @@ void process_hvlpevents(struct pt_regs *
 				__get_cpu_var(hvlpevent_counts)[event->xType]++;
 			if (event->xType < HvLpEvent_Type_NumTypes &&
 					lpEventHandler[event->xType])
-				lpEventHandler[event->xType](event, regs);
+				lpEventHandler[event->xType](event);
 			else
 				printk(KERN_INFO "Unexpected Lp Event type=%d\n", event->xType );
 
Index: linux-2.6/arch/powerpc/platforms/iseries/mf.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/mf.c
+++ linux-2.6/arch/powerpc/platforms/iseries/mf.c
@@ -513,7 +513,7 @@ static void handle_ack(struct io_mf_lp_e
  * parse it enough to know if it is an interrupt or an
  * acknowledge.
  */
-static void hv_handler(struct HvLpEvent *event, struct pt_regs *regs)
+static void hv_handler(struct HvLpEvent *event)
 {
 	if ((event != NULL) && (event->xType == HvLpEvent_Type_MachineFac)) {
 		if (hvlpevent_is_ack(event))
@@ -847,7 +847,7 @@ static int mf_get_boot_rtc(struct rtc_ti
 	/* We need to poll here as we are not yet taking interrupts */
 	while (rtc_data.busy) {
 		if (hvlpevent_is_pending())
-			process_hvlpevents(NULL);
+			process_hvlpevents();
 	}
 	return rtc_set_tm(rtc_data.rc, rtc_data.ce_msg.ce_msg, tm);
 }
Index: linux-2.6/arch/powerpc/platforms/iseries/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/smp.c
+++ linux-2.6/arch/powerpc/platforms/iseries/smp.c
@@ -45,7 +45,7 @@
 
 static unsigned long iSeries_smp_message[NR_CPUS];
 
-void iSeries_smp_message_recv(struct pt_regs *regs)
+void iSeries_smp_message_recv(void)
 {
 	int cpu = smp_processor_id();
 	int msg;
@@ -55,7 +55,7 @@ void iSeries_smp_message_recv(struct pt_
 
 	for (msg = 0; msg < 4; msg++)
 		if (test_and_clear_bit(msg, &iSeries_smp_message[cpu]))
-			smp_message_recv(msg, regs);
+			smp_message_recv(msg);
 }
 
 static inline void smp_iSeries_do_message(int cpu, int msg)
Index: linux-2.6/arch/powerpc/platforms/iseries/viopath.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/viopath.c
+++ linux-2.6/arch/powerpc/platforms/iseries/viopath.c
@@ -378,7 +378,7 @@ void vio_set_hostlp(void)
 }
 EXPORT_SYMBOL(vio_set_hostlp);
 
-static void vio_handleEvent(struct HvLpEvent *event, struct pt_regs *regs)
+static void vio_handleEvent(struct HvLpEvent *event)
 {
 	HvLpIndex remoteLp;
 	int subtype = (event->xSubtype & VIOMAJOR_SUBTYPE_MASK)
Index: linux-2.6/arch/powerpc/kernel/ibmebus.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/ibmebus.c
+++ linux-2.6/arch/powerpc/kernel/ibmebus.c
@@ -319,7 +319,7 @@ EXPORT_SYMBOL(ibmebus_unregister_driver)
 
 int ibmebus_request_irq(struct ibmebus_dev *dev,
 			u32 ist, 
-			irqreturn_t (*handler)(int, void*, struct pt_regs *),
+			irqreturn_t (*handler)(int, void*),
 			unsigned long irq_flags, const char * devname,
 			void *dev_id)
 {
Index: linux-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ linux-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -384,8 +384,7 @@ struct hw_interrupt_type m82xx_pci_ic = 
 };
 
 static void
-m82xx_pci_irq_demux(unsigned int irq, struct irq_desc *desc,
-		    struct pt_regs *regs)
+m82xx_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned long stat, mask, pend;
 	int bit;
@@ -398,7 +397,7 @@ m82xx_pci_irq_demux(unsigned int irq, st
 			break;
 		for (bit = 0; pend != 0; ++bit, pend <<= 1) {
 			if (pend & 0x80000000)
-				__do_IRQ(pci_int_base + bit, regs);
+				__do_IRQ(pci_int_base + bit);
 		}
 	}
 }
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -66,12 +66,11 @@ mpc85xx_pcibios_fixup(void)
 
 #ifdef CONFIG_CPM2
 
-static void cpm2_cascade(unsigned int irq, struct irq_desc *desc,
-			 struct pt_regs *regs)
+static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	int cascade_irq;
 
-	while ((cascade_irq = cpm2_get_irq(regs)) >= 0) {
+	while ((cascade_irq = cpm2_get_irq()) >= 0) {
 		generic_handle_irq(cascade_irq);
 	}
 	desc->chip->eoi(irq);
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -132,10 +132,9 @@ mpc85xx_cds_pcibios_fixup(void)
 
 #ifdef CONFIG_PPC_I8259
 #warning The i8259 PIC support is currently broken
-static void mpc85xx_8259_cascade(unsigned int irq, struct
-		irq_desc *desc, struct pt_regs *regs)
+static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	unsigned int cascade_irq = i8259_irq(regs);
+	unsigned int cascade_irq = i8259_irq();
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
@@ -150,8 +149,10 @@ void __init mpc85xx_cds_pic_init(void)
 	struct mpic *mpic;
 	struct resource r;
 	struct device_node *np = NULL;
+#ifdef CONFIG_PPC_I8259
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
+#endif
 
 	np = of_find_node_by_type(np, "open-pic");
 
Index: linux-2.6/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ linux-2.6/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -53,10 +53,9 @@ unsigned long pci_dram_offset = 0;
 
 
 #ifdef CONFIG_PCI
-static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc,
-				 struct pt_regs *regs)
+static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	unsigned int cascade_irq = i8259_irq(regs);
+	unsigned int cascade_irq = i8259_irq();
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 	desc->chip->eoi(irq);
Index: linux-2.6/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6/arch/powerpc/platforms/cell/interrupt.c
@@ -98,8 +98,7 @@ static void iic_ioexc_eoi(unsigned int i
 {
 }
 
-static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc,
-			    struct pt_regs *regs)
+static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	struct cbe_iic_regs __iomem *node_iic = (void __iomem *)desc->handler_data;
 	unsigned int base = (irq & 0xffffff00) | IIC_IRQ_TYPE_IOEXC;
@@ -140,7 +139,7 @@ static struct irq_chip iic_ioexc_chip = 
 };
 
 /* Get an IRQ number from the pending state register of the IIC */
-static unsigned int iic_get_irq(struct pt_regs *regs)
+static unsigned int iic_get_irq(void)
 {
 	struct cbe_iic_pending_bits pending;
 	struct iic *iic;
Index: linux-2.6/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/chrp/setup.c
+++ linux-2.6/arch/powerpc/platforms/chrp/setup.c
@@ -70,7 +70,7 @@ unsigned long event_scan_interval;
  * has to include <linux/interrupt.h> (to get irqreturn_t), which
  * causes all sorts of problems.  -- paulus
  */
-extern irqreturn_t xmon_irq(int, void *, struct pt_regs *);
+extern irqreturn_t xmon_irq(int, void *);
 
 extern unsigned long loops_per_jiffy;
 
@@ -335,10 +335,9 @@ chrp_event_scan(unsigned long unused)
 		  jiffies + event_scan_interval);
 }
 
-static void chrp_8259_cascade(unsigned int irq, struct irq_desc *desc,
-			      struct pt_regs *regs)
+static void chrp_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	unsigned int cascade_irq = i8259_irq(regs);
+	unsigned int cascade_irq = i8259_irq();
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 	desc->chip->eoi(irq);
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -61,8 +61,7 @@ pci_dram_offset = MPC7448_HPC2_PCI_MEM_O
 extern int tsi108_setup_pci(struct device_node *dev);
 extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
 extern void tsi108_pci_int_init(void);
-extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc,
-			    struct pt_regs *regs);
+extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
 
 int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
 {
@@ -200,7 +199,7 @@ static void __init mpc7448_hpc2_init_IRQ
 	tsi_pic = of_find_node_by_type(NULL, "open-pic");
 	if (tsi_pic) {
 		unsigned int size;
-		void *prop = get_property(tsi_pic, "reg", &size);
+		const void *prop = get_property(tsi_pic, "reg", &size);
 		mpic_paddr = of_translate_address(tsi_pic, prop);
 	}
 
Index: linux-2.6/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/pic.c
+++ linux-2.6/arch/powerpc/platforms/powermac/pic.c
@@ -42,7 +42,7 @@
  * has to include <linux/interrupt.h> (to get irqreturn_t), which
  * causes all sorts of problems.  -- paulus
  */
-extern irqreturn_t xmon_irq(int, void *, struct pt_regs *);
+extern irqreturn_t xmon_irq(int, void *);
 
 #ifdef CONFIG_PPC32
 struct pmac_irq_hw {
@@ -210,7 +210,7 @@ static struct irq_chip pmac_pic = {
 	.retrigger	= pmac_retrigger,
 };
 
-static irqreturn_t gatwick_action(int cpl, void *dev_id, struct pt_regs *regs)
+static irqreturn_t gatwick_action(int cpl, void *dev_id)
 {
 	unsigned long flags;
 	int irq, bits;
@@ -235,18 +235,18 @@ static irqreturn_t gatwick_action(int cp
 	return rc;
 }
 
-static unsigned int pmac_pic_get_irq(struct pt_regs *regs)
+static unsigned int pmac_pic_get_irq(void)
 {
 	int irq;
 	unsigned long bits = 0;
 	unsigned long flags;
 
 #ifdef CONFIG_SMP
-	void psurge_smp_message_recv(struct pt_regs *);
+	void psurge_smp_message_recv(void);
 
        	/* IPI's are a hack on the powersurge -- Cort */
        	if ( smp_processor_id() != 0 ) {
-		psurge_smp_message_recv(regs);
+		psurge_smp_message_recv();
 		return NO_IRQ_IGNORE;	/* ignore, already handled */
         }
 #endif /* CONFIG_SMP */
@@ -444,7 +444,7 @@ static void pmac_u3_cascade(unsigned int
 {
 	struct mpic *mpic = desc->handler_data;
 
-	unsigned int cascade_irq = mpic_get_one_irq(mpic, get_irq_regs());
+	unsigned int cascade_irq = mpic_get_one_irq(mpic);
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 	desc->chip->eoi(irq);
Index: linux-2.6/arch/powerpc/platforms/powermac/pic.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/pic.h
+++ linux-2.6/arch/powerpc/platforms/powermac/pic.h
@@ -5,7 +5,7 @@
 
 extern struct hw_interrupt_type pmac_pic;
 
-void pmac_pic_init(void);
-int pmac_get_irq(struct pt_regs *regs);
+extern void pmac_pic_init(void);
+extern int pmac_get_irq(void);
 
 #endif /* __PPC_PLATFORMS_PMAC_PIC_H */
Index: linux-2.6/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/smp.c
+++ linux-2.6/arch/powerpc/platforms/powermac/smp.c
@@ -160,7 +160,7 @@ static inline void psurge_clr_ipi(int cp
  */
 static unsigned long psurge_smp_message[NR_CPUS];
 
-void psurge_smp_message_recv(struct pt_regs *regs)
+void psurge_smp_message_recv(void)
 {
 	int cpu = smp_processor_id();
 	int msg;
@@ -174,12 +174,12 @@ void psurge_smp_message_recv(struct pt_r
 	/* make sure there is a message there */
 	for (msg = 0; msg < 4; msg++)
 		if (test_and_clear_bit(msg, &psurge_smp_message[cpu]))
-			smp_message_recv(msg, regs);
+			smp_message_recv(msg);
 }
 
-irqreturn_t psurge_primary_intr(int irq, void *d, struct pt_regs *regs)
+irqreturn_t psurge_primary_intr(int irq, void *d)
 {
-	psurge_smp_message_recv(regs);
+	psurge_smp_message_recv();
 	return IRQ_HANDLED;
 }
 
Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.c
@@ -308,14 +308,14 @@ static inline unsigned int xics_remap_ir
 	return NO_IRQ;
 }
 
-static unsigned int xics_get_irq_direct(struct pt_regs *regs)
+static unsigned int xics_get_irq_direct(void)
 {
 	unsigned int cpu = smp_processor_id();
 
 	return xics_remap_irq(direct_xirr_info_get(cpu));
 }
 
-static unsigned int xics_get_irq_lpar(struct pt_regs *regs)
+static unsigned int xics_get_irq_lpar(void)
 {
 	unsigned int cpu = smp_processor_id();
 
Index: linux-2.6/arch/powerpc/sysdev/cpm2_pic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/cpm2_pic.c
+++ linux-2.6/arch/powerpc/sysdev/cpm2_pic.c
@@ -147,7 +147,7 @@ static struct irq_chip cpm2_pic = {
 	.end = cpm2_end_irq,
 };
 
-unsigned int cpm2_get_irq(struct pt_regs *regs)
+unsigned int cpm2_get_irq(void)
 {
 	int irq;
 	unsigned long bits;
Index: linux-2.6/arch/powerpc/sysdev/cpm2_pic.h
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/cpm2_pic.h
+++ linux-2.6/arch/powerpc/sysdev/cpm2_pic.h
@@ -3,7 +3,7 @@
 
 extern intctl_cpm2_t *cpm2_intctl;
 
-extern unsigned int cpm2_get_irq(struct pt_regs *regs);
+extern unsigned int cpm2_get_irq(void);
 
 extern void cpm2_pic_init(struct device_node*);
 
Index: linux-2.6/arch/powerpc/sysdev/i8259.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/i8259.c
+++ linux-2.6/arch/powerpc/sysdev/i8259.c
@@ -34,7 +34,7 @@ static struct irq_host *i8259_host;
  * which is called.  It should be noted that polling is broken on some
  * IBM and Motorola PReP boxes so we must use the int-ack feature on them.
  */
-unsigned int i8259_irq(struct pt_regs *regs)
+unsigned int i8259_irq(void)
 {
 	int irq;
 	int lock = 0;
Index: linux-2.6/arch/powerpc/sysdev/ipic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/ipic.c
+++ linux-2.6/arch/powerpc/sysdev/ipic.c
@@ -709,7 +709,7 @@ void ipic_clear_mcp_status(u32 mask)
 }
 
 /* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
-unsigned int ipic_get_irq(struct pt_regs *regs)
+unsigned int ipic_get_irq(void)
 {
 	int irq;
 
Index: linux-2.6/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mpic.c
+++ linux-2.6/arch/powerpc/sysdev/mpic.c
@@ -1217,7 +1217,7 @@ void mpic_send_ipi(unsigned int ipi_no, 
 		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
 }
 
-unsigned int mpic_get_one_irq(struct mpic *mpic, struct pt_regs *regs)
+unsigned int mpic_get_one_irq(struct mpic *mpic)
 {
 	u32 src;
 
@@ -1230,13 +1230,13 @@ unsigned int mpic_get_one_irq(struct mpi
 	return irq_linear_revmap(mpic->irqhost, src);
 }
 
-unsigned int mpic_get_irq(struct pt_regs *regs)
+unsigned int mpic_get_irq(void)
 {
 	struct mpic *mpic = mpic_primary;
 
 	BUG_ON(mpic == NULL);
 
-	return mpic_get_one_irq(mpic, regs);
+	return mpic_get_one_irq(mpic);
 }
 
 
Index: linux-2.6/arch/powerpc/sysdev/qe_lib/qe_ic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ linux-2.6/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -300,7 +300,7 @@ static struct irq_host_ops qe_ic_host_op
 };
 
 /* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
-unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic, struct pt_regs *regs)
+unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 {
 	int irq;
 
@@ -316,7 +316,7 @@ unsigned int qe_ic_get_low_irq(struct qe
 }
 
 /* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
-unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic, struct pt_regs *regs)
+unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 {
 	int irq;
 
@@ -333,13 +333,12 @@ unsigned int qe_ic_get_high_irq(struct q
 
 /* FIXME: We mask all the QE Low interrupts while handling.  We should
  * let other interrupt come in, but BAD interrupts are generated */
-void fastcall qe_ic_cascade_low(unsigned int irq, struct irq_desc *desc,
-				struct pt_regs *regs)
+void fastcall qe_ic_cascade_low(unsigned int irq, struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = desc->handler_data;
 	struct irq_chip *chip = irq_desc[irq].chip;
 
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic, regs);
+	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
 
 	chip->mask_ack(irq);
 	if (cascade_irq != NO_IRQ)
@@ -349,13 +348,12 @@ void fastcall qe_ic_cascade_low(unsigned
 
 /* FIXME: We mask all the QE High interrupts while handling.  We should
  * let other interrupt come in, but BAD interrupts are generated */
-void fastcall qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc,
-				 struct pt_regs *regs)
+void fastcall qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = desc->handler_data;
 	struct irq_chip *chip = irq_desc[irq].chip;
 
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic, regs);
+	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
 
 	chip->mask_ack(irq);
 	if (cascade_irq != NO_IRQ)
Index: linux-2.6/arch/powerpc/sysdev/tsi108_pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/tsi108_pci.c
+++ linux-2.6/arch/powerpc/sysdev/tsi108_pci.c
@@ -405,8 +405,7 @@ void __init tsi108_pci_int_init(void)
 	init_pci_source();
 }
 
-void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc,
-			    struct pt_regs *regs)
+void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int cascade_irq = get_pci_source();
 	if (cascade_irq != NO_IRQ)
Index: linux-2.6/arch/ppc/platforms/85xx/mpc8560_ads.c
===================================================================
--- linux-2.6.orig/arch/ppc/platforms/85xx/mpc8560_ads.c
+++ linux-2.6/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -211,10 +211,10 @@ mpc8560ads_setup_arch(void)
 #endif
 }
 
-static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t cpm2_cascade(int irq, void *dev_id)
 {
-	while ((irq = cpm2_get_irq(regs)) >= 0)
-		__do_IRQ(irq, regs);
+	while ((irq = cpm2_get_irq()) >= 0)
+		__do_IRQ(irq);
 	return IRQ_HANDLED;
 }
 
Index: linux-2.6/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- linux-2.6.orig/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ linux-2.6/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -127,10 +127,10 @@ mpc85xx_cds_show_cpuinfo(struct seq_file
 }
 
 #ifdef CONFIG_CPM2
-static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t cpm2_cascade(int irq, void *dev_id)
 {
-	while((irq = cpm2_get_irq(regs)) >= 0)
-		__do_IRQ(irq, regs);
+	while((irq = cpm2_get_irq()) >= 0)
+		__do_IRQ(irq);
 	return IRQ_HANDLED;
 }
 
Index: linux-2.6/arch/ppc/platforms/85xx/stx_gp3.c
===================================================================
--- linux-2.6.orig/arch/ppc/platforms/85xx/stx_gp3.c
+++ linux-2.6/arch/ppc/platforms/85xx/stx_gp3.c
@@ -156,10 +156,10 @@ gp3_setup_arch(void)
 	printk ("bi_immr_base = %8.8lx\n", binfo->bi_immr_base);
 }
 
-static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t cpm2_cascade(int irq, void *dev_id)
 {
-	while ((irq = cpm2_get_irq(regs)) >= 0)
-		__do_IRQ(irq, regs);
+	while ((irq = cpm2_get_irq()) >= 0)
+		__do_IRQ(irq);
 
 	return IRQ_HANDLED;
 }
Index: linux-2.6/arch/ppc/platforms/85xx/tqm85xx.c
===================================================================
--- linux-2.6.orig/arch/ppc/platforms/85xx/tqm85xx.c
+++ linux-2.6/arch/ppc/platforms/85xx/tqm85xx.c
@@ -181,10 +181,10 @@ tqm85xx_setup_arch(void)
 }
 
 #ifdef CONFIG_MPC8560
-static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t cpm2_cascade(int irq, void *dev_id)
 {
-	while ((irq = cpm2_get_irq(regs)) >= 0)
-		__do_IRQ(irq, regs);
+	while ((irq = cpm2_get_irq()) >= 0)
+		__do_IRQ(irq);
 	return IRQ_HANDLED;
 }
 
Index: linux-2.6/include/asm-powerpc/ibmebus.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/ibmebus.h
+++ linux-2.6/include/asm-powerpc/ibmebus.h
@@ -65,7 +65,7 @@ void ibmebus_unregister_driver(struct ib
 
 int ibmebus_request_irq(struct ibmebus_dev *dev,
 			u32 ist, 
-			irqreturn_t (*handler)(int, void*, struct pt_regs *),
+			irqreturn_t (*handler)(int, void*),
 			unsigned long irq_flags, const char * devname,
 			void *dev_id);
 void ibmebus_free_irq(struct ibmebus_dev *dev, u32 ist, void *dev_id);
Index: linux-2.6/include/asm-powerpc/machdep.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/machdep.h
+++ linux-2.6/include/asm-powerpc/machdep.h
@@ -97,7 +97,7 @@ struct machdep_calls {
 	void		(*show_percpuinfo)(struct seq_file *m, int i);
 
 	void		(*init_IRQ)(void);
-	unsigned int	(*get_irq)(struct pt_regs *);
+	unsigned int	(*get_irq)(void);
 #ifdef CONFIG_KEXEC
 	void		(*kexec_cpu_down)(int crash_shutdown, int secondary);
 #endif
Index: linux-2.6/include/asm-powerpc/i8259.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/i8259.h
+++ linux-2.6/include/asm-powerpc/i8259.h
@@ -6,10 +6,10 @@
 
 #ifdef CONFIG_PPC_MERGE
 extern void i8259_init(struct device_node *node, unsigned long intack_addr);
-extern unsigned int i8259_irq(struct pt_regs *regs);
+extern unsigned int i8259_irq(void);
 #else
 extern void i8259_init(unsigned long intack_addr, int offset);
-extern int i8259_irq(struct pt_regs *regs);
+extern int i8259_irq(void);
 #endif
 
 #endif /* __KERNEL__ */
Index: linux-2.6/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6/arch/powerpc/kernel/irq.c
@@ -217,7 +217,7 @@ void do_IRQ(struct pt_regs *regs)
 	 * The value -2 is for buggy hardware and means that this IRQ
 	 * has already been handled. -- Tom
 	 */
-	irq = ppc_md.get_irq(regs);
+	irq = ppc_md.get_irq();
 
 	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE) {
 #ifdef CONFIG_IRQSTACKS
Index: linux-2.6/include/asm-powerpc/mpic.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/mpic.h
+++ linux-2.6/include/asm-powerpc/mpic.h
@@ -409,9 +409,9 @@ extern void mpic_send_ipi(unsigned int i
 void smp_mpic_message_pass(int target, int msg);
 
 /* Fetch interrupt from a given mpic */
-extern unsigned int mpic_get_one_irq(struct mpic *mpic, struct pt_regs *regs);
+extern unsigned int mpic_get_one_irq(struct mpic *mpic);
 /* This one gets to the primary mpic */
-extern unsigned int mpic_get_irq(struct pt_regs *regs);
+extern unsigned int mpic_get_irq(void);
 
 /* Set the EPIC clock ratio */
 void mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio);
Index: linux-2.6/include/asm-powerpc/iseries/it_lp_queue.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/iseries/it_lp_queue.h
+++ linux-2.6/include/asm-powerpc/iseries/it_lp_queue.h
@@ -72,7 +72,7 @@ struct hvlpevent_queue {
 extern struct hvlpevent_queue hvlpevent_queue;
 
 extern int hvlpevent_is_pending(void);
-extern void process_hvlpevents(struct pt_regs *);
+extern void process_hvlpevents(void);
 extern void setup_hvlpevent_queue(void);
 
 #endif /* _ASM_POWERPC_ISERIES_IT_LP_QUEUE_H */
Index: linux-2.6/include/asm-powerpc/iseries/hv_lp_event.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/iseries/hv_lp_event.h
+++ linux-2.6/include/asm-powerpc/iseries/hv_lp_event.h
@@ -50,7 +50,7 @@ struct HvLpEvent {
 	u64	xCorrelationToken;	/* Unique value for source/type x10-x17 */
 };
 
-typedef void (*LpEventHandler)(struct HvLpEvent *, struct pt_regs *);
+typedef void (*LpEventHandler)(struct HvLpEvent *);
 
 /* Register a handler for an event type - returns 0 on success */
 extern int HvLpEvent_registerHandler(HvLpEvent_Type eventType,
Index: linux-2.6/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/time.c
+++ linux-2.6/arch/powerpc/kernel/time.c
@@ -706,7 +706,7 @@ void timer_interrupt(struct pt_regs * re
 
 #ifdef CONFIG_PPC_ISERIES
 	if (hvlpevent_is_pending())
-		process_hvlpevents(regs);
+		process_hvlpevents();
 #endif
 
 #ifdef CONFIG_PPC64
Index: linux-2.6/drivers/char/viocons.c
===================================================================
--- linux-2.6.orig/drivers/char/viocons.c
+++ linux-2.6/drivers/char/viocons.c
@@ -947,7 +947,7 @@ static void vioHandleData(struct HvLpEve
 				 */
 				continue;
 			} else if (vio_sysrq_pressed) {
-				handle_sysrq(cevent->data[index], NULL, tty);
+				handle_sysrq(cevent->data[index], tty);
 				vio_sysrq_pressed = 0;
 				/*
 				 * continue because we don't want to add
Index: linux-2.6/arch/ppc/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/time.c
+++ linux-2.6/arch/ppc/kernel/time.c
@@ -142,7 +142,7 @@ void timer_interrupt(struct pt_regs * re
 	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) <= 0) {
 		jiffy_stamp += tb_ticks_per_jiffy;
 		
-		profile_tick(CPU_PROFILING, regs);
+		profile_tick(CPU_PROFILING);
 		update_process_times(user_mode(regs));
 
 	  	if (smp_processor_id())
Index: linux-2.6/include/asm-ppc/floppy.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/floppy.h
+++ linux-2.6/include/asm-ppc/floppy.h
@@ -38,14 +38,14 @@ static int virtual_dma_mode;
 static int doing_vdma;
 static struct fd_dma_ops *fd_ops;
 
-static irqreturn_t floppy_hardint(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t floppy_hardint(int irq, void *dev_id)
 {
 	unsigned char st;
 	int lcount;
 	char *lptr;
 
 	if (!doing_vdma)
-		return floppy_interrupt(irq, dev_id, regs);
+		return floppy_interrupt(irq, dev_id);
 
 
 	st = 1;
@@ -69,7 +69,7 @@ static irqreturn_t floppy_hardint(int ir
 		virtual_dma_residue += virtual_dma_count;
 		virtual_dma_count=0;
 		doing_vdma = 0;
-		floppy_interrupt(irq, dev_id, regs);
+		floppy_interrupt(irq, dev_id);
 		return IRQ_HANDLED;
 	}
 	return IRQ_HANDLED;
Index: linux-2.6/include/asm-ppc/machdep.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/machdep.h
+++ linux-2.6/include/asm-ppc/machdep.h
@@ -43,7 +43,7 @@ struct machdep_calls {
 	/* Optional, may be NULL. */
 	unsigned int	(*irq_canonicalize)(unsigned int irq);
 	void		(*init_IRQ)(void);
-	int		(*get_irq)(struct pt_regs *);
+	int		(*get_irq)(void);
 	
 	/* A general init function, called by ppc_init in init/main.c.
 	   May be NULL. DEPRECATED ! */
Index: linux-2.6/arch/ppc/syslib/i8259.c
===================================================================
--- linux-2.6.orig/arch/ppc/syslib/i8259.c
+++ linux-2.6/arch/ppc/syslib/i8259.c
@@ -28,7 +28,7 @@ static int i8259_pic_irq_offset;
  * which is called.  It should be noted that polling is broken on some
  * IBM and Motorola PReP boxes so we must use the int-ack feature on them.
  */
-int i8259_irq(struct pt_regs *regs)
+int i8259_irq(void)
 {
 	int irq;
 
Index: linux-2.6/include/asm-powerpc/ipic.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/ipic.h
+++ linux-2.6/include/asm-powerpc/ipic.h
@@ -79,12 +79,12 @@ extern void ipic_clear_mcp_status(u32 ma
 
 #ifdef CONFIG_PPC_MERGE
 extern void ipic_init(struct device_node *node, unsigned int flags);
-extern unsigned int ipic_get_irq(struct pt_regs *regs);
+extern unsigned int ipic_get_irq(void);
 #else
 extern void ipic_init(phys_addr_t phys_addr, unsigned int flags,
 		unsigned int irq_offset,
 		unsigned char *senses, unsigned int senses_count);
-extern int ipic_get_irq(struct pt_regs *regs);
+extern int ipic_get_irq(void);
 #endif
 
 #endif /* __ASM_IPIC_H__ */
Index: linux-2.6/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux-2.6/arch/powerpc/platforms/pseries/setup.c
@@ -123,7 +123,7 @@ static void __init fwnmi_init(void)
 
 void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	unsigned int cascade_irq = i8259_irq(get_irq_regs());
+	unsigned int cascade_irq = i8259_irq();
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 	desc->chip->eoi(irq);

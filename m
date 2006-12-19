Return-Path: <linux-kernel-owner+w=401wt.eu-S932517AbWLSApD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWLSApD (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWLSApB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:45:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53703 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932517AbWLSAo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:44:59 -0500
Date: Mon, 18 Dec 2006 16:49:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.18.6
Message-ID: <20061219004922.GO10475@sequoia.sous-sol.org>
References: <20061219004824.GN10475@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219004824.GN10475@sequoia.sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 85d8009..c8b2f7e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 18
-EXTRAVERSION = .5
+EXTRAVERSION = .6
 NAME=Avast! A bilge rat!
 
 # *DOCUMENTATION*
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 3173924..e8f7436 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -331,6 +331,19 @@
 		CALL(sys_mbind)
 /* 320 */	CALL(sys_get_mempolicy)
 		CALL(sys_set_mempolicy)
+		CALL(sys_openat)
+		CALL(sys_mkdirat)
+		CALL(sys_mknodat)
+/* 325 */	CALL(sys_fchownat)
+		CALL(sys_futimesat)
+		CALL(sys_fstatat64)
+		CALL(sys_unlinkat)
+		CALL(sys_renameat)
+/* 330 */	CALL(sys_linkat)
+		CALL(sys_symlinkat)
+		CALL(sys_readlinkat)
+		CALL(sys_fchmodat)
+		CALL(sys_faccessat)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
diff --git a/arch/m32r/kernel/entry.S b/arch/m32r/kernel/entry.S
index ac6d840..5b01fd2 100644
--- a/arch/m32r/kernel/entry.S
+++ b/arch/m32r/kernel/entry.S
@@ -23,35 +23,35 @@
  *	updated in fork.c:copy_thread, signal.c:do_signal,
  *	ptrace.c and ptrace.h
  *
- * M32Rx/M32R2				M32R
- *       @(sp)      - r4		ditto
- *       @(0x04,sp) - r5		ditto
- *       @(0x08,sp) - r6		ditto
- *       @(0x0c,sp) - *pt_regs		ditto
- *       @(0x10,sp) - r0		ditto
- *       @(0x14,sp) - r1		ditto
- *       @(0x18,sp) - r2		ditto
- *       @(0x1c,sp) - r3		ditto
- *       @(0x20,sp) - r7		ditto
- *       @(0x24,sp) - r8		ditto
- *       @(0x28,sp) - r9		ditto
- *       @(0x2c,sp) - r10		ditto
- *       @(0x30,sp) - r11		ditto
- *       @(0x34,sp) - r12		ditto
- *       @(0x38,sp) - syscall_nr	ditto
- *       @(0x3c,sp) - acc0h		@(0x3c,sp) - acch
- *       @(0x40,sp) - acc0l		@(0x40,sp) - accl
- *       @(0x44,sp) - acc1h		@(0x44,sp) - dummy_acc1h
- *       @(0x48,sp) - acc1l		@(0x48,sp) - dummy_acc1l
- *       @(0x4c,sp) - psw		ditto
- *       @(0x50,sp) - bpc		ditto
- *       @(0x54,sp) - bbpsw		ditto
- *       @(0x58,sp) - bbpc		ditto
- *       @(0x5c,sp) - spu (cr3)		ditto
- *       @(0x60,sp) - fp (r13)		ditto
- *       @(0x64,sp) - lr (r14)		ditto
- *       @(0x68,sp) - spi (cr2)		ditto
- *       @(0x6c,sp) - orig_r0		ditto
+ * M32R/M32Rx/M32R2
+ *       @(sp)      - r4
+ *       @(0x04,sp) - r5
+ *       @(0x08,sp) - r6
+ *       @(0x0c,sp) - *pt_regs
+ *       @(0x10,sp) - r0
+ *       @(0x14,sp) - r1
+ *       @(0x18,sp) - r2
+ *       @(0x1c,sp) - r3
+ *       @(0x20,sp) - r7
+ *       @(0x24,sp) - r8
+ *       @(0x28,sp) - r9
+ *       @(0x2c,sp) - r10
+ *       @(0x30,sp) - r11
+ *       @(0x34,sp) - r12
+ *       @(0x38,sp) - syscall_nr
+ *       @(0x3c,sp) - acc0h
+ *       @(0x40,sp) - acc0l
+ *       @(0x44,sp) - acc1h		; ISA_DSP_LEVEL2 only
+ *       @(0x48,sp) - acc1l		; ISA_DSP_LEVEL2 only
+ *       @(0x4c,sp) - psw
+ *       @(0x50,sp) - bpc
+ *       @(0x54,sp) - bbpsw
+ *       @(0x58,sp) - bbpc
+ *       @(0x5c,sp) - spu (cr3)
+ *       @(0x60,sp) - fp (r13)
+ *       @(0x64,sp) - lr (r14)
+ *       @(0x68,sp) - spi (cr2)
+ *       @(0x6c,sp) - orig_r0
  */
 
 #include <linux/linkage.h>
@@ -95,17 +95,10 @@
 #define R11(reg)		@(0x30,reg)
 #define R12(reg)		@(0x34,reg)
 #define SYSCALL_NR(reg)		@(0x38,reg)
-#if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 #define ACC0H(reg)		@(0x3C,reg)
 #define ACC0L(reg)		@(0x40,reg)
 #define ACC1H(reg)		@(0x44,reg)
 #define ACC1L(reg)		@(0x48,reg)
-#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
-#define ACCH(reg)		@(0x3C,reg)
-#define ACCL(reg)		@(0x40,reg)
-#else
-#error unknown isa configuration
-#endif
 #define PSW(reg)		@(0x4C,reg)
 #define BPC(reg)		@(0x50,reg)
 #define BBPSW(reg)		@(0x54,reg)
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index 34afad7..ffcb9e4 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -1010,7 +1010,10 @@ static void __cpuinit init_intel(struct cpuinfo_x86 *c)
 	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
 	    (c->x86 == 0x6 && c->x86_model >= 0x0e))
 		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
-	set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
+	if (c->x86 == 15)
+		set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
+	else
+		clear_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
  	c->x86_max_cores = intel_num_cpu_cores(c);
 
 	srat_detect_node();
diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index 448df27..ab5a6b5 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -3218,6 +3218,19 @@ static int __devinit ohci1394_pci_probe(struct pci_dev *dev,
 	struct ti_ohci *ohci;	/* shortcut to currently handled device */
 	resource_size_t ohci_base;
 
+#ifdef CONFIG_PPC_PMAC
+	/* Necessary on some machines if ohci1394 was loaded/ unloaded before */
+	if (machine_is(powermac)) {
+		struct device_node *of_node = pci_device_to_OF_node(dev);
+
+		if (of_node) {
+			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, of_node,
+					  0, 1);
+			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 1);
+		}
+	}
+#endif /* CONFIG_PPC_PMAC */
+
         if (pci_enable_device(dev))
 		FAIL(-ENXIO, "Failed to enable OHCI hardware");
         pci_set_master(dev);
@@ -3506,11 +3519,9 @@ static void ohci1394_pci_remove(struct pci_dev *pdev)
 #endif
 
 #ifdef CONFIG_PPC_PMAC
-	/* On UniNorth, power down the cable and turn off the chip
-	 * clock when the module is removed to save power on
-	 * laptops. Turning it back ON is done by the arch code when
-	 * pci_enable_device() is called */
-	{
+	/* On UniNorth, power down the cable and turn off the chip clock
+	 * to save power on laptops */
+	if (machine_is(powermac)) {
 		struct device_node* of_node;
 
 		of_node = pci_device_to_OF_node(ohci->dev);
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 6022ed1..31e498f 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -717,13 +717,15 @@ static int crypt_endio(struct bio *bio, unsigned int done, int error)
 	if (bio->bi_size)
 		return 1;
 
+	if (!bio_flagged(bio, BIO_UPTODATE) && !error)
+		error = -EIO;
+
 	bio_put(bio);
 
 	/*
 	 * successful reads are decrypted by the worker thread
 	 */
-	if ((bio_data_dir(bio) == READ)
-	    && bio_flagged(bio, BIO_UPTODATE)) {
+	if (bio_data_dir(io->bio) == READ && !error) {
 		kcryptd_queue_io(io);
 		return 0;
 	}
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 1d0fafd..6578b26 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -691,6 +691,7 @@ static void pending_complete(struct pending_exception *pe, int success)
 
 		free_exception(e);
 
+		remove_exception(&pe->e);
 		error_snapshot_bios(pe);
 		goto out;
 	}
diff --git a/drivers/media/dvb/frontends/lgdt330x.c b/drivers/media/dvb/frontends/lgdt330x.c
index 9a35470..467f199 100644
--- a/drivers/media/dvb/frontends/lgdt330x.c
+++ b/drivers/media/dvb/frontends/lgdt330x.c
@@ -435,9 +435,6 @@ static int lgdt3302_read_status(struct dvb_frontend* fe, fe_status_t* status)
 		/* Test signal does not exist flag */
 		/* as well as the AGC lock flag.   */
 		*status |= FE_HAS_SIGNAL;
-	} else {
-		/* Without a signal all other status bits are meaningless */
-		return 0;
 	}
 
 	/*
@@ -500,9 +497,6 @@ static int lgdt3303_read_status(struct dvb_frontend* fe, fe_status_t* status)
 		/* Test input signal does not exist flag */
 		/* as well as the AGC lock flag.   */
 		*status |= FE_HAS_SIGNAL;
-	} else {
-		/* Without a signal all other status bits are meaningless */
-		return 0;
 	}
 
 	/* Carrier Recovery Lock Status Register */
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index abe37cf..a17cc8e 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -108,6 +108,7 @@ static int tuner_stereo(struct i2c_client *c)
 		case TUNER_PHILIPS_FM1216ME_MK3:
 		case TUNER_PHILIPS_FM1236_MK3:
 		case TUNER_PHILIPS_FM1256_IH3:
+		case TUNER_LG_NTSC_TAPE:
 			stereo = ((status & TUNER_SIGNAL) == TUNER_STEREO_MK3);
 			break;
 		default:
@@ -419,6 +420,7 @@ static void default_set_radio_freq(struct i2c_client *c, unsigned int freq)
 	case TUNER_PHILIPS_FM1216ME_MK3:
 	case TUNER_PHILIPS_FM1236_MK3:
 	case TUNER_PHILIPS_FMD1216ME_MK3:
+	case TUNER_LG_NTSC_TAPE:
 		buffer[3] = 0x19;
 		break;
 	case TUNER_TNF_5335MF:
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index 8b54259..c371159 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -671,16 +671,6 @@ static struct tuner_params tuner_panasonic_vp27_params[] = {
 	},
 };
 
-/* ------------ TUNER_LG_NTSC_TAPE - LGINNOTEK NTSC ------------ */
-
-static struct tuner_params tuner_lg_ntsc_tape_params[] = {
-	{
-		.type   = TUNER_PARAM_TYPE_NTSC,
-		.ranges = tuner_fm1236_mk3_ntsc_ranges,
-		.count  = ARRAY_SIZE(tuner_fm1236_mk3_ntsc_ranges),
-	},
-};
-
 /* ------------ TUNER_TNF_8831BGFF - Philips PAL ------------ */
 
 static struct tuner_range tuner_tnf_8831bgff_pal_ranges[] = {
@@ -1331,8 +1321,8 @@ struct tunertype tuners[] = {
 	},
 	[TUNER_LG_NTSC_TAPE] = { /* LGINNOTEK NTSC */
 		.name   = "LG NTSC (TAPE series)",
-		.params = tuner_lg_ntsc_tape_params,
-		.count  = ARRAY_SIZE(tuner_lg_ntsc_tape_params),
+		.params = tuner_fm1236_mk3_params,
+		.count  = ARRAY_SIZE(tuner_fm1236_mk3_params),
 	},
 	[TUNER_TNF_8831BGFF] = { /* Philips PAL */
 		.name   = "Tenna TNF 8831 BGFF)",
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8b95123..0ece819 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3547,7 +3547,7 @@ static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd
 			mii->val_out = 0;
 			read_lock_bh(&bond->lock);
 			read_lock(&bond->curr_slave_lock);
-			if (bond->curr_active_slave) {
+			if (netif_carrier_ok(bond->dev)) {
 				mii->val_out = BMSR_LSTATUS;
 			}
 			read_unlock(&bond->curr_slave_lock);
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index 11b8f1b..bacd25f 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -2692,11 +2692,13 @@ static int nv_request_irq(struct net_device *dev, int intr_test)
 	}
 	if (ret != 0 && np->msi_flags & NV_MSI_CAPABLE) {
 		if ((ret = pci_enable_msi(np->pci_dev)) == 0) {
+			pci_intx(np->pci_dev, 0);
 			np->msi_flags |= NV_MSI_ENABLED;
 			if ((!intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq, IRQF_SHARED, dev->name, dev) != 0) ||
 			    (intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq_test, IRQF_SHARED, dev->name, dev) != 0)) {
 				printk(KERN_INFO "forcedeth: request_irq failed %d\n", ret);
 				pci_disable_msi(np->pci_dev);
+				pci_intx(np->pci_dev, 1);
 				np->msi_flags &= ~NV_MSI_ENABLED;
 				goto out_err;
 			}
@@ -2739,6 +2741,7 @@ static void nv_free_irq(struct net_device *dev)
 		free_irq(np->pci_dev->irq, dev);
 		if (np->msi_flags & NV_MSI_ENABLED) {
 			pci_disable_msi(np->pci_dev);
+			pci_intx(np->pci_dev, 1);
 			np->msi_flags &= ~NV_MSI_ENABLED;
 		}
 	}
diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index c6f5bc3..3bbf0c8 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -3012,6 +3012,11 @@ static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
 #endif
 
 	err = -ENODEV;
+
+	if (pci_enable_device(pdev))
+		goto err_out;
+	pci_set_master(pdev);
+
 	if (!strcmp(prom_name, "SUNW,qfe") || !strcmp(prom_name, "qfe")) {
 		qp = quattro_pci_find(pdev);
 		if (qp == NULL)
diff --git a/fs/compat.c b/fs/compat.c
index e31e9cf..f8c5213 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -873,7 +873,7 @@ asmlinkage long compat_sys_mount(char __user * dev_name, char __user * dir_name,
 
 	retval = -EINVAL;
 
-	if (type_page) {
+	if (type_page && data_page) {
 		if (!strcmp((char *)type_page, SMBFS_NAME)) {
 			do_smb_super_data_conv((void *)data_page);
 		} else if (!strcmp((char *)type_page, NCPFS_NAME)) {
diff --git a/include/asm-arm/unistd.h b/include/asm-arm/unistd.h
index 1e891f8..188e24b 100644
--- a/include/asm-arm/unistd.h
+++ b/include/asm-arm/unistd.h
@@ -347,6 +347,19 @@
 #define __NR_mbind			(__NR_SYSCALL_BASE+319)
 #define __NR_get_mempolicy		(__NR_SYSCALL_BASE+320)
 #define __NR_set_mempolicy		(__NR_SYSCALL_BASE+321)
+#define __NR_openat			(__NR_SYSCALL_BASE+322)
+#define __NR_mkdirat			(__NR_SYSCALL_BASE+323)
+#define __NR_mknodat			(__NR_SYSCALL_BASE+324)
+#define __NR_fchownat			(__NR_SYSCALL_BASE+325)
+#define __NR_futimesat			(__NR_SYSCALL_BASE+326)
+#define __NR_fstatat64			(__NR_SYSCALL_BASE+327)
+#define __NR_unlinkat			(__NR_SYSCALL_BASE+328)
+#define __NR_renameat			(__NR_SYSCALL_BASE+329)
+#define __NR_linkat			(__NR_SYSCALL_BASE+330)
+#define __NR_symlinkat			(__NR_SYSCALL_BASE+331)
+#define __NR_readlinkat			(__NR_SYSCALL_BASE+332)
+#define __NR_fchmodat			(__NR_SYSCALL_BASE+333)
+#define __NR_faccessat			(__NR_SYSCALL_BASE+334)
 
 /*
  * The following SWIs are ARM private.
diff --git a/include/asm-m32r/ptrace.h b/include/asm-m32r/ptrace.h
index 2d2a6c9..632b4ce 100644
--- a/include/asm-m32r/ptrace.h
+++ b/include/asm-m32r/ptrace.h
@@ -33,21 +33,10 @@
 #define PT_R15		PT_SP
 
 /* processor status and miscellaneous context registers.  */
-#if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 #define PT_ACC0H	15
 #define PT_ACC0L	16
-#define PT_ACC1H	17
-#define PT_ACC1L	18
-#define PT_ACCH		PT_ACC0H
-#define PT_ACCL		PT_ACC0L
-#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
-#define PT_ACCH		15
-#define PT_ACCL		16
-#define PT_DUMMY_ACC1H	17
-#define PT_DUMMY_ACC1L	18
-#else
-#error unknown isa conifiguration
-#endif
+#define PT_ACC1H	17	/* ISA_DSP_LEVEL2 only */
+#define PT_ACC1L	18	/* ISA_DSP_LEVEL2 only */
 #define PT_PSW		19
 #define PT_BPC		20
 #define PT_BBPSW	21
@@ -103,19 +92,10 @@ struct pt_regs {
 	long syscall_nr;
 
 	/* Saved main processor status and miscellaneous context registers. */
-#if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 	unsigned long acc0h;
 	unsigned long acc0l;
-	unsigned long acc1h;
-	unsigned long acc1l;
-#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
-	unsigned long acch;
-	unsigned long accl;
-	unsigned long dummy_acc1h;
-	unsigned long dummy_acc1l;
-#else
-#error unknown isa configuration
-#endif
+	unsigned long acc1h;	/* ISA_DSP_LEVEL2 only */
+	unsigned long acc1l;	/* ISA_DSP_LEVEL2 only */
 	unsigned long psw;
 	unsigned long bpc;		/* saved PC for TRAP syscalls */
 	unsigned long bbpsw;
diff --git a/include/asm-m32r/sigcontext.h b/include/asm-m32r/sigcontext.h
index 73025c0..62537dc 100644
--- a/include/asm-m32r/sigcontext.h
+++ b/include/asm-m32r/sigcontext.h
@@ -23,19 +23,10 @@ struct sigcontext {
 	unsigned long sc_r12;
 
 	/* Saved main processor status and miscellaneous context registers. */
-#if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 	unsigned long sc_acc0h;
 	unsigned long sc_acc0l;
-	unsigned long sc_acc1h;
-	unsigned long sc_acc1l;
-#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
-	unsigned long sc_acch;
-	unsigned long sc_accl;
-	unsigned long sc_dummy_acc1h;
-	unsigned long sc_dummy_acc1l;
-#else
-#error unknown isa configuration
-#endif
+	unsigned long sc_acc1h;	/* ISA_DSP_LEVEL2 only */
+	unsigned long sc_acc1l;	/* ISA_DSP_LEVEL2 only */
 	unsigned long sc_psw;
 	unsigned long sc_bpc;		/* saved PC for TRAP syscalls */
 	unsigned long sc_bbpsw;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 3789ca9..aee8b98 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -574,8 +574,6 @@ static int __cpuinit cpu_callback(struct notifier_block *nfb,
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
-		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
 		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index be04e9f..ab166b4 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -196,6 +196,9 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 
 	switch (CAPIMSG_SUBCOMMAND(skb->data)) {
 	case CAPI_CONF:
+		if (skb->len < CAPI_MSG_BASELEN + 10)
+			break;
+
 		func = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 5);
 		info = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 8);
 
@@ -226,6 +229,9 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			break;
 
 		case CAPI_FUNCTION_GET_PROFILE:
+			if (skb->len < CAPI_MSG_BASELEN + 11 + sizeof(capi_profile))
+				break;
+
 			controller = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 11);
 			msgnum = CAPIMSG_MSGID(skb->data);
 
@@ -246,17 +252,26 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			break;
 
 		case CAPI_FUNCTION_GET_MANUFACTURER:
+			if (skb->len < CAPI_MSG_BASELEN + 15)
+				break;
+
 			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 10);
 
 			if (!info && ctrl) {
+				int len = min_t(uint, CAPI_MANUFACTURER_LEN,
+						skb->data[CAPI_MSG_BASELEN + 14]);
+
+				memset(ctrl->manu, 0, CAPI_MANUFACTURER_LEN);
 				strncpy(ctrl->manu,
-					skb->data + CAPI_MSG_BASELEN + 15,
-					skb->data[CAPI_MSG_BASELEN + 14]);
+					skb->data + CAPI_MSG_BASELEN + 15, len);
 			}
 
 			break;
 
 		case CAPI_FUNCTION_GET_VERSION:
+			if (skb->len < CAPI_MSG_BASELEN + 32)
+				break;
+
 			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 12);
 
 			if (!info && ctrl) {
@@ -269,13 +284,18 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			break;
 
 		case CAPI_FUNCTION_GET_SERIAL_NUMBER:
+			if (skb->len < CAPI_MSG_BASELEN + 17)
+				break;
+
 			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 12);
 
 			if (!info && ctrl) {
+				int len = min_t(uint, CAPI_SERIAL_LEN,
+						skb->data[CAPI_MSG_BASELEN + 16]);
+
 				memset(ctrl->serial, 0, CAPI_SERIAL_LEN);
 				strncpy(ctrl->serial,
-					skb->data + CAPI_MSG_BASELEN + 17,
-					skb->data[CAPI_MSG_BASELEN + 16]);
+					skb->data + CAPI_MSG_BASELEN + 17, len);
 			}
 
 			break;
@@ -284,14 +304,18 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 		break;
 
 	case CAPI_IND:
+		if (skb->len < CAPI_MSG_BASELEN + 6)
+			break;
+
 		func = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 3);
 
 		if (func == CAPI_FUNCTION_LOOPBACK) {
+			int len = min_t(uint, skb->len - CAPI_MSG_BASELEN - 6,
+						skb->data[CAPI_MSG_BASELEN + 5]);
 			appl = CAPIMSG_APPID(skb->data);
 			msgnum = CAPIMSG_MSGID(skb->data);
 			cmtp_send_interopmsg(session, CAPI_RESP, appl, msgnum, func,
-						skb->data + CAPI_MSG_BASELEN + 6,
-						skb->data[CAPI_MSG_BASELEN + 5]);
+						skb->data + CAPI_MSG_BASELEN + 6, len);
 		}
 
 		break;
@@ -309,6 +333,9 @@ void cmtp_recv_capimsg(struct cmtp_session *session, struct sk_buff *skb)
 
 	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
 
+	if (skb->len < CAPI_MSG_BASELEN)
+		return;
+
 	if (CAPIMSG_COMMAND(skb->data) == CAPI_INTEROPERABILITY) {
 		cmtp_recv_interopmsg(session, skb);
 		return;
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 3a13ed6..1969658 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -360,10 +360,11 @@ ebt_check_match(struct ebt_entry_match *m, struct ebt_entry *e,
    const char *name, unsigned int hookmask, unsigned int *cnt)
 {
 	struct ebt_match *match;
+	size_t left = ((char *)e + e->watchers_offset) - (char *)m;
 	int ret;
 
-	if (((char *)m) + m->match_size + sizeof(struct ebt_entry_match) >
-	   ((char *)e) + e->watchers_offset)
+	if (left < sizeof(struct ebt_entry_match) ||
+	    left - sizeof(struct ebt_entry_match) < m->match_size)
 		return -EINVAL;
 	match = find_match_lock(m->u.name, &ret, &ebt_mutex);
 	if (!match)
@@ -389,10 +390,11 @@ ebt_check_watcher(struct ebt_entry_watcher *w, struct ebt_entry *e,
    const char *name, unsigned int hookmask, unsigned int *cnt)
 {
 	struct ebt_watcher *watcher;
+	size_t left = ((char *)e + e->target_offset) - (char *)w;
 	int ret;
 
-	if (((char *)w) + w->watcher_size + sizeof(struct ebt_entry_watcher) >
-	   ((char *)e) + e->target_offset)
+	if (left < sizeof(struct ebt_entry_watcher) ||
+	   left - sizeof(struct ebt_entry_watcher) < w->watcher_size)
 		return -EINVAL;
 	watcher = find_watcher_lock(w->u.name, &ret, &ebt_mutex);
 	if (!watcher)
@@ -423,19 +425,23 @@ ebt_check_entry_size_and_hooks(struct ebt_entry *e,
    struct ebt_entries **hook_entries, unsigned int *n, unsigned int *cnt,
    unsigned int *totalcnt, unsigned int *udc_cnt, unsigned int valid_hooks)
 {
+	unsigned int offset = (char *)e - newinfo->entries;
+	size_t left = (limit - base) - offset;
 	int i;
 
+	if (left < sizeof(unsigned int))
+		goto Esmall;
+
 	for (i = 0; i < NF_BR_NUMHOOKS; i++) {
 		if ((valid_hooks & (1 << i)) == 0)
 			continue;
-		if ( (char *)hook_entries[i] - base ==
-		   (char *)e - newinfo->entries)
+		if ((char *)hook_entries[i] == base + offset)
 			break;
 	}
 	/* beginning of a new chain
 	   if i == NF_BR_NUMHOOKS it must be a user defined chain */
 	if (i != NF_BR_NUMHOOKS || !(e->bitmask & EBT_ENTRY_OR_ENTRIES)) {
-		if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) != 0) {
+		if (e->bitmask != 0) {
 			/* we make userspace set this right,
 			   so there is no misunderstanding */
 			BUGPRINT("EBT_ENTRY_OR_ENTRIES shouldn't be set "
@@ -450,11 +456,8 @@ ebt_check_entry_size_and_hooks(struct ebt_entry *e,
 			return -EINVAL;
 		}
 		/* before we look at the struct, be sure it is not too big */
-		if ((char *)hook_entries[i] + sizeof(struct ebt_entries)
-		   > limit) {
-			BUGPRINT("entries_size too small\n");
-			return -EINVAL;
-		}
+		if (left < sizeof(struct ebt_entries))
+			goto Esmall;
 		if (((struct ebt_entries *)e)->policy != EBT_DROP &&
 		   ((struct ebt_entries *)e)->policy != EBT_ACCEPT) {
 			/* only RETURN from udc */
@@ -477,6 +480,8 @@ ebt_check_entry_size_and_hooks(struct ebt_entry *e,
 		return 0;
 	}
 	/* a plain old entry, heh */
+	if (left < sizeof(struct ebt_entry))
+		goto Esmall;
 	if (sizeof(struct ebt_entry) > e->watchers_offset ||
 	   e->watchers_offset > e->target_offset ||
 	   e->target_offset >= e->next_offset) {
@@ -488,10 +493,16 @@ ebt_check_entry_size_and_hooks(struct ebt_entry *e,
 		BUGPRINT("target size too small\n");
 		return -EINVAL;
 	}
+	if (left < e->next_offset)
+		goto Esmall;
 
 	(*cnt)++;
 	(*totalcnt)++;
 	return 0;
+
+Esmall:
+	BUGPRINT("entries_size too small\n");
+	return -EINVAL;
 }
 
 struct ebt_cl_stack
@@ -513,7 +524,7 @@ ebt_get_udc_positions(struct ebt_entry *e, struct ebt_table_info *newinfo,
 	int i;
 
 	/* we're only interested in chain starts */
-	if (e->bitmask & EBT_ENTRY_OR_ENTRIES)
+	if (e->bitmask)
 		return 0;
 	for (i = 0; i < NF_BR_NUMHOOKS; i++) {
 		if ((valid_hooks & (1 << i)) == 0)
@@ -563,7 +574,7 @@ ebt_cleanup_entry(struct ebt_entry *e, unsigned int *cnt)
 {
 	struct ebt_entry_target *t;
 
-	if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) == 0)
+	if (e->bitmask == 0)
 		return 0;
 	/* we're done */
 	if (cnt && (*cnt)-- == 0)
@@ -586,10 +597,11 @@ ebt_check_entry(struct ebt_entry *e, struct ebt_table_info *newinfo,
 	struct ebt_entry_target *t;
 	struct ebt_target *target;
 	unsigned int i, j, hook = 0, hookmask = 0;
+	size_t gap = e->next_offset - e->target_offset;
 	int ret;
 
 	/* don't mess with the struct ebt_entries */
-	if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) == 0)
+	if (e->bitmask == 0)
 		return 0;
 
 	if (e->bitmask & ~EBT_F_MASK) {
@@ -647,8 +659,7 @@ ebt_check_entry(struct ebt_entry *e, struct ebt_table_info *newinfo,
 
 	t->u.target = target;
 	if (t->u.target == &ebt_standard_target) {
-		if (e->target_offset + sizeof(struct ebt_standard_target) >
-		   e->next_offset) {
+		if (gap < sizeof(struct ebt_standard_target)) {
 			BUGPRINT("Standard target size too big\n");
 			ret = -EFAULT;
 			goto cleanup_watchers;
@@ -659,8 +670,7 @@ ebt_check_entry(struct ebt_entry *e, struct ebt_table_info *newinfo,
 			ret = -EFAULT;
 			goto cleanup_watchers;
 		}
-	} else if ((e->target_offset + t->target_size +
-	   sizeof(struct ebt_entry_target) > e->next_offset) ||
+	} else if (t->target_size > gap - sizeof(struct ebt_entry_target) ||
 	   (t->u.target->check &&
 	   t->u.target->check(name, hookmask, e, t->data, t->target_size) != 0)){
 		module_put(t->u.target->me);
@@ -730,7 +740,9 @@ static int check_chainloops(struct ebt_entries *chain, struct ebt_cl_stack *cl_s
 				BUGPRINT("loop\n");
 				return -1;
 			}
-			/* this can't be 0, so the above test is correct */
+			if (cl_s[i].hookmask & (1 << hooknr))
+				goto letscontinue;
+			/* this can't be 0, so the loop test is correct */
 			cl_s[i].cs.n = pos + 1;
 			pos = 0;
 			cl_s[i].cs.e = ((void *)e + e->next_offset);
@@ -1307,7 +1319,7 @@ static inline int ebt_make_names(struct ebt_entry *e, char *base, char *ubase)
 	char *hlp;
 	struct ebt_entry_target *t;
 
-	if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) == 0)
+	if (e->bitmask == 0)
 		return 0;
 
 	hlp = ubase - base + (char *)e + e->target_offset;
diff --git a/net/ieee80211/softmac/ieee80211softmac_scan.c b/net/ieee80211/softmac/ieee80211softmac_scan.c
index d31cf77..ad67368 100644
--- a/net/ieee80211/softmac/ieee80211softmac_scan.c
+++ b/net/ieee80211/softmac/ieee80211softmac_scan.c
@@ -47,7 +47,6 @@ ieee80211softmac_start_scan(struct ieee80211softmac_device *sm)
 	sm->scanning = 1;
 	spin_unlock_irqrestore(&sm->lock, flags);
 
-	netif_tx_disable(sm->ieee->dev);
 	ret = sm->start_scan(sm->dev);
 	if (ret) {
 		spin_lock_irqsave(&sm->lock, flags);
@@ -248,7 +247,6 @@ void ieee80211softmac_scan_finished(struct ieee80211softmac_device *sm)
 		if (net)
 			sm->set_channel(sm->dev, net->channel);
 	}
-	netif_wake_queue(sm->ieee->dev);
 	ieee80211softmac_call_events(sm, IEEE80211SOFTMAC_EVENT_SCAN_FINISHED, NULL);
 }
 EXPORT_SYMBOL_GPL(ieee80211softmac_scan_finished);
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index e964436..a560c55 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1989,6 +1989,8 @@ compat_get_entries(struct compat_ipt_get_entries __user *uptr, int *len)
 	return ret;
 }
 
+static int do_ipt_get_ctl(struct sock *, int, void __user *, int *);
+
 static int
 compat_do_ipt_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 {
@@ -2005,8 +2007,7 @@ compat_do_ipt_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 		ret = compat_get_entries(user, len);
 		break;
 	default:
-		duprintf("compat_do_ipt_get_ctl: unknown request %i\n", cmd);
-		ret = -EINVAL;
+		ret = do_ipt_get_ctl(sk, cmd, user, len);
 	}
 	return ret;
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b873cbc..c7a806b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1775,7 +1775,7 @@ static inline int __mkroute_input(struct sk_buff *skb,
 #endif
 	if (in_dev->cnf.no_policy)
 		rth->u.dst.flags |= DST_NOPOLICY;
-	if (in_dev->cnf.no_xfrm)
+	if (out_dev->cnf.no_xfrm)
 		rth->u.dst.flags |= DST_NOXFRM;
 	rth->fl.fl4_dst	= daddr;
 	rth->rt_dst	= daddr;
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 8f50eae..eae687d 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -252,6 +252,8 @@ static void xfrm4_dst_destroy(struct dst_entry *dst)
 
 	if (likely(xdst->u.rt.idev))
 		in_dev_put(xdst->u.rt.idev);
+	if (likely(xdst->u.rt.peer))
+		inet_putpeer(xdst->u.rt.peer);
 	xfrm_dst_destroy(xdst);
 }
 
diff --git a/net/irda/irttp.c b/net/irda/irttp.c
index 42acf1c..be0d8fa 100644
--- a/net/irda/irttp.c
+++ b/net/irda/irttp.c
@@ -1098,7 +1098,7 @@ int irttp_connect_request(struct tsap_cb *self, __u8 dtsap_sel,
 			return -ENOMEM;
 
 		/* Reserve space for MUX_CONTROL and LAP header */
-		skb_reserve(tx_skb, TTP_MAX_HEADER);
+		skb_reserve(tx_skb, TTP_MAX_HEADER + TTP_SAR_HEADER);
 	} else {
 		tx_skb = userdata;
 		/*
@@ -1346,7 +1346,7 @@ int irttp_connect_response(struct tsap_cb *self, __u32 max_sdu_size,
 			return -ENOMEM;
 
 		/* Reserve space for MUX_CONTROL and LAP header */
-		skb_reserve(tx_skb, TTP_MAX_HEADER);
+		skb_reserve(tx_skb, TTP_MAX_HEADER + TTP_SAR_HEADER);
 	} else {
 		tx_skb = userdata;
 		/*
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index e75a147..a29d0f6 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -54,14 +54,14 @@ static DEFINE_RWLOCK(gact_lock);
 #ifdef CONFIG_GACT_PROB
 static int gact_net_rand(struct tcf_gact *p)
 {
-	if (net_random()%p->pval)
+	if (!p->pval || net_random()%p->pval)
 		return p->action;
 	return p->paction;
 }
 
 static int gact_determ(struct tcf_gact *p)
 {
-	if (p->bstats.packets%p->pval)
+	if (!p->pval || p->bstats.packets%p->pval)
 		return p->action;
 	return p->paction;
 }
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index da905d7..930e010 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -44,6 +44,18 @@ static struct tcf_police *tcf_police_ht[MY_TAB_SIZE];
 /* Policer hash table lock */
 static DEFINE_RWLOCK(police_lock);
 
+/* old policer structure from before tc actions */
+struct tc_police_compat
+{
+	u32			index;
+	int			action;
+	u32			limit;
+	u32			burst;
+	u32			mtu;
+	struct tc_ratespec	rate;
+	struct tc_ratespec	peakrate;
+};
+
 /* Each policer is serialized by its individual spinlock */
 
 static __inline__ unsigned tcf_police_hash(u32 index)
@@ -169,12 +181,15 @@ static int tcf_act_police_locate(struct rtattr *rta, struct rtattr *est,
 	struct tc_police *parm;
 	struct tcf_police *p;
 	struct qdisc_rate_table *R_tab = NULL, *P_tab = NULL;
+	int size;
 
 	if (rta == NULL || rtattr_parse_nested(tb, TCA_POLICE_MAX, rta) < 0)
 		return -EINVAL;
 
-	if (tb[TCA_POLICE_TBF-1] == NULL ||
-	    RTA_PAYLOAD(tb[TCA_POLICE_TBF-1]) != sizeof(*parm))
+	if (tb[TCA_POLICE_TBF-1] == NULL)
+		return -EINVAL;
+	size = RTA_PAYLOAD(tb[TCA_POLICE_TBF-1]);
+	if (size != sizeof(*parm) && size != sizeof(struct tc_police_compat))
 		return -EINVAL;
 	parm = RTA_DATA(tb[TCA_POLICE_TBF-1]);
 
@@ -413,12 +428,15 @@ struct tcf_police * tcf_police_locate(struct rtattr *rta, struct rtattr *est)
 	struct tcf_police *p;
 	struct rtattr *tb[TCA_POLICE_MAX];
 	struct tc_police *parm;
+	int size;
 
 	if (rtattr_parse_nested(tb, TCA_POLICE_MAX, rta) < 0)
 		return NULL;
 
-	if (tb[TCA_POLICE_TBF-1] == NULL ||
-	    RTA_PAYLOAD(tb[TCA_POLICE_TBF-1]) != sizeof(*parm))
+	if (tb[TCA_POLICE_TBF-1] == NULL)
+		return NULL;
+	size = RTA_PAYLOAD(tb[TCA_POLICE_TBF-1]);
+	if (size != sizeof(*parm) && size != sizeof(struct tc_police_compat))
 		return NULL;
 
 	parm = RTA_DATA(tb[TCA_POLICE_TBF-1]);

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284731AbRLJVdA>; Mon, 10 Dec 2001 16:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286396AbRLJVcw>; Mon, 10 Dec 2001 16:32:52 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:14335 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286394AbRLJVcT>; Mon, 10 Dec 2001 16:32:19 -0500
Date: Mon, 10 Dec 2001 13:32:17 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
Message-Id: <200112102132.fBALWHf12372@localhost.localdomain>
To: torvalds@transmeta.com
Subject: [PATCH] making some more global spinlocks static
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
 This patch makes several spinlocks static.  These are either locks that have appeared in the last few versions of 2.4, or older locks where the maintainers never passed the patch along.  Most of them are for new locks.  The patch applies against 2.5.1-pre6.
diff -ur linux-2.5.1-pre6-clean/arch/alpha/kernel/irq_i8259.c linux/arch/alpha/kernel/irq_i8259.c
--- linux-2.5.1-pre6-clean/arch/alpha/kernel/irq_i8259.c	Mon Jun 19 17:59:32 2000
+++ linux/arch/alpha/kernel/irq_i8259.c	Fri Dec  7 10:23:36 2001
@@ -22,7 +22,7 @@
 
 /* Note mask bit is true for DISABLED irqs.  */
 static unsigned int cached_irq_mask = 0xffff;
-spinlock_t i8259_irq_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t i8259_irq_lock = SPIN_LOCK_UNLOCKED;
 
 static inline void
 i8259_update_irq_hw(unsigned int irq, unsigned long mask)
diff -ur linux-2.5.1-pre6-clean/arch/ia64/kernel/efivars.c linux/arch/ia64/kernel/efivars.c
--- linux-2.5.1-pre6-clean/arch/ia64/kernel/efivars.c	Fri Nov  9 14:26:17 2001
+++ linux/arch/ia64/kernel/efivars.c	Fri Dec  7 10:27:56 2001
@@ -100,7 +100,7 @@
 	struct list_head        list;
 } efivar_entry_t;
 
-spinlock_t efivars_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t efivars_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(efivar_list);
 static struct proc_dir_entry *efi_vars_dir = NULL;
 
diff -ur linux-2.5.1-pre6-clean/arch/ia64/kernel/pci.c linux/arch/ia64/kernel/pci.c
--- linux-2.5.1-pre6-clean/arch/ia64/kernel/pci.c	Fri Nov  9 14:26:17 2001
+++ linux/arch/ia64/kernel/pci.c	Fri Dec  7 10:24:07 2001
@@ -46,7 +46,7 @@
  * This interrupt-safe spinlock protects all accesses to PCI
  * configuration space.
  */
-spinlock_t pci_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t pci_lock = SPIN_LOCK_UNLOCKED;
 
 struct pci_fixup pcibios_fixups[] = {
 	{ 0 }
diff -ur linux-2.5.1-pre6-clean/arch/ia64/sn/io/hubspc.c linux/arch/ia64/sn/io/hubspc.c
--- linux-2.5.1-pre6-clean/arch/ia64/sn/io/hubspc.c	Thu Apr  5 12:51:47 2001
+++ linux/arch/ia64/sn/io/hubspc.c	Fri Dec  7 10:25:25 2001
@@ -61,7 +61,7 @@
 }cpuprom_info_t;
 
 static cpuprom_info_t	*cpuprom_head;
-spinlock_t	cpuprom_spinlock;
+static spinlock_t	cpuprom_spinlock;
 #define	PROM_LOCK()	mutex_spinlock(&cpuprom_spinlock)
 #define	PROM_UNLOCK(s)	mutex_spinunlock(&cpuprom_spinlock, (s))
 
diff -ur linux-2.5.1-pre6-clean/arch/ppc/kernel/i8259.c linux/arch/ppc/kernel/i8259.c
--- linux-2.5.1-pre6-clean/arch/ppc/kernel/i8259.c	Mon May 21 17:04:47 2001
+++ linux/arch/ppc/kernel/i8259.c	Fri Dec  7 10:29:12 2001
@@ -13,7 +13,7 @@
 #define cached_A1 (cached_8259[0])
 #define cached_21 (cached_8259[1])
 
-spinlock_t i8259_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t i8259_lock = SPIN_LOCK_UNLOCKED;
 
 int i8259_pic_irq_offset;
 
diff -ur linux-2.5.1-pre6-clean/arch/ppc/kernel/pmac_pic.c linux/arch/ppc/kernel/pmac_pic.c
--- linux-2.5.1-pre6-clean/arch/ppc/kernel/pmac_pic.c	Sat Sep  8 12:38:42 2001
+++ linux/arch/ppc/kernel/pmac_pic.c	Fri Dec  7 10:29:29 2001
@@ -36,7 +36,7 @@
 static int max_irqs;
 static int max_real_irqs;
 
-spinlock_t pmac_pic_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t pmac_pic_lock = SPIN_LOCK_UNLOCKED;
 
 
 #define GATWICK_IRQ_POOL_SIZE        10
diff -ur linux-2.5.1-pre6-clean/arch/ppc/kernel/prom.c linux/arch/ppc/kernel/prom.c
--- linux-2.5.1-pre6-clean/arch/ppc/kernel/prom.c	Sat Sep  8 12:38:42 2001
+++ linux/arch/ppc/kernel/prom.c	Fri Dec  7 10:29:05 2001
@@ -1928,7 +1928,7 @@
 }
 #endif
 
-spinlock_t rtas_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t rtas_lock = SPIN_LOCK_UNLOCKED;
 
 /* this can be called after setup -- Cort */
 int __openfirmware
diff -ur linux-2.5.1-pre6-clean/arch/sparc64/solaris/timod.c linux/arch/sparc64/solaris/timod.c
--- linux-2.5.1-pre6-clean/arch/sparc64/solaris/timod.c	Thu Sep 20 14:11:57 2001
+++ linux/arch/sparc64/solaris/timod.c	Fri Dec  7 10:30:52 2001
@@ -33,7 +33,7 @@
 	u32 arg);
 asmlinkage int solaris_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 
-spinlock_t timod_pagelock = SPIN_LOCK_UNLOCKED;
+static spinlock_t timod_pagelock = SPIN_LOCK_UNLOCKED;
 static char * page = NULL ;
 
 #ifndef DEBUG_SOLARIS_KMALLOC
diff -ur linux-2.5.1-pre6-clean/drivers/char/sysrq.c linux/drivers/char/sysrq.c
--- linux-2.5.1-pre6-clean/drivers/char/sysrq.c	Tue Oct  2 09:20:37 2001
+++ linux/drivers/char/sysrq.c	Thu Dec  6 16:27:31 2001
@@ -336,7 +336,7 @@
 
 
 /* Key Operations table and lock */
-spinlock_t sysrq_key_table_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t sysrq_key_table_lock = SPIN_LOCK_UNLOCKED;
 #define SYSRQ_KEY_TABLE_LENGTH 36
 static struct sysrq_key_op *sysrq_key_table[SYSRQ_KEY_TABLE_LENGTH] = {
 /* 0 */	&sysrq_loglevel_op,

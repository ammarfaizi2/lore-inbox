Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSFIS5O>; Sun, 9 Jun 2002 14:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSFIS5N>; Sun, 9 Jun 2002 14:57:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56583 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314500AbSFIS5H>; Sun, 9 Jun 2002 14:57:07 -0400
Date: Sun, 9 Jun 2002 19:57:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] CONFIG_GENERIC_ISA_DMA
Message-ID: <20020609195700.D8761@flint.arm.linux.org.uk>
In-Reply-To: <20020605170234.D10293@flint.arm.linux.org.uk> <20020605194007.J10293@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, lkml,

The following patch adds support for CONFIG_GENERIC_ISA_DMA, which went
into the 2.4-ac kernel series prior to 2.5 happening.

The following patch allows architectures to decide whether they want
the generic ISA DMA functionality provided by kernel/dma.c and other
supporting files.

In addition, we move the procfs "/proc/dma" support code out of fs/proc
into kernel/dma.c, and adapt it to use the new seq_file code.

This patch is against 2.5.21.

--- orig/arch/alpha/config.in	Wed May 29 23:56:58 2002
+++ linux/arch/alpha/config.in	Wed May 29 21:55:08 2002
@@ -7,6 +7,7 @@
 define_bool CONFIG_UID16 n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
--- orig/arch/i386/config.in	Wed Jun  5 10:08:22 2002
+++ linux/arch/i386/config.in	Sat May 25 10:25:43 2002
@@ -9,6 +9,7 @@
 define_bool CONFIG_SBUS n
 
 define_bool CONFIG_UID16 y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
--- orig/arch/m68k/config.in	Sat May 25 11:09:21 2002
+++ linux/arch/m68k/config.in	Mon May 13 10:16:01 2002
@@ -6,6 +6,7 @@
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 mainmenu_name "Linux/68k Kernel Configuration"
 
--- orig/arch/mips/config.in	Sat May 25 11:09:28 2002
+++ linux/arch/mips/config.in	Wed Apr 24 19:32:40 2002
@@ -4,6 +4,7 @@
 #
 define_bool CONFIG_MIPS y
 define_bool CONFIG_SMP n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 mainmenu_name "Linux Kernel Configuration"
 
--- orig/arch/mips64/config.in	Sat May 25 11:09:34 2002
+++ linux/arch/mips64/config.in	Wed Apr 24 19:32:40 2002
@@ -26,6 +26,7 @@
 
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 #
 # Select some configuration options automatically based on user selections
--- orig/arch/parisc/config.in	Sat May 25 11:09:39 2002
+++ linux/arch/parisc/config.in	Sun Feb 24 16:46:01 2002
@@ -9,6 +9,7 @@
 define_bool CONFIG_UID16 n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
--- orig/arch/ppc/config.in	Wed May 29 23:57:00 2002
+++ linux/arch/ppc/config.in	Wed May 29 21:55:14 2002
@@ -7,6 +7,7 @@
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 define_bool CONFIG_HAVE_DEC_LOCK y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 mainmenu_name "Linux/PowerPC Kernel Configuration"
 
--- orig/arch/sh/config.in	Sat May 25 11:09:56 2002
+++ linux/arch/sh/config.in	Sat Mar 23 23:09:17 2002
@@ -9,6 +9,7 @@
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
--- orig/arch/sparc/config.in	Sat May 25 11:09:59 2002
+++ linux/arch/sparc/config.in	Fri May  3 10:39:16 2002
@@ -6,6 +6,7 @@
 
 define_bool CONFIG_UID16 y
 define_bool CONFIG_HIGHMEM y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
--- orig/arch/sparc64/config.in	Sat May 25 11:10:04 2002
+++ linux/arch/sparc64/config.in	Mon May  6 16:42:10 2002
@@ -26,6 +26,7 @@
 define_bool CONFIG_HAVE_DEC_LOCK y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+define_bool CONFIG_GENERIC_ISA_DMA y
 define_bool CONFIG_ISA n
 define_bool CONFIG_ISAPNP n
 define_bool CONFIG_EISA n
--- linux-tolinus/kernel/Makefile	Wed Jun  5 10:08:25 2002
+++ linux/kernel/Makefile	Wed Jun  5 18:38:14 2002
@@ -10,13 +10,14 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o
+		printk.o platform.o suspend.o dma.o
 
-obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
+obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o platform.o
 
+obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
--- linux-tolinus/kernel/dma.c	Sat May 25 11:13:57 2002
+++ linux/kernel/dma.c	Wed Jun  5 19:26:12 2002
@@ -9,11 +9,14 @@
  *   [It also happened to remove the sizeof(char *) == sizeof(int)
  *   assumption introduced because of those /proc/dma patches. -- Hennus]
  */
-
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
 #include <asm/dma.h>
 #include <asm/system.h>
 
@@ -65,20 +68,6 @@
 	{ 0, 0 }
 };
 
-int get_dma_list(char *buf)
-{
-	int i, len = 0;
-
-	for (i = 0 ; i < MAX_DMA_CHANNELS ; i++) {
-		if (dma_chan_busy[i].lock) {
-		    len += sprintf(buf+len, "%2d: %s\n",
-				   i,
-				   dma_chan_busy[i].device_id);
-		}
-	}
-	return len;
-} /* get_dma_list */
-
 
 int request_dma(unsigned int dmanr, const char * device_id)
 {
@@ -109,6 +98,19 @@
 
 } /* free_dma */
 
+static int proc_dma_show(struct seq_file *m, void *v)
+{
+	int i;
+
+	for (i = 0 ; i < MAX_DMA_CHANNELS ; i++) {
+		if (dma_chan_busy[i].lock) {
+		    seq_printf(m, "%2d: %s\n", i,
+			       dma_chan_busy[i].device_id);
+		}
+	}
+	return 0;
+}
+
 #else
 
 int request_dma(unsigned int dmanr, const char *device_id)
@@ -120,9 +122,52 @@
 {
 }
 
-int get_dma_list(char *buf)
-{	
-	strcpy(buf, "No DMA\n");
-	return 7;
+static int proc_dma_show(struct seq_file *m, void *v)
+{
+	seq_puts(m, "No DMA\n");
+	return 0;
 }
+
 #endif
+
+static int proc_dma_open(struct inode *inode, struct file *file)
+{
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	struct seq_file *m;
+	int res;
+
+	if (!buf)
+		return -ENOMEM;
+	res = single_open(file, proc_dma_show, NULL);
+	if (!res) {
+		m = file->private_data;
+		m->buf = buf;
+		m->size = PAGE_SIZE;
+	} else
+		kfree(buf);
+	return res;
+}
+
+static struct file_operations proc_dma_operations = {
+	open:		proc_dma_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	single_release,
+};
+
+static int __init proc_dma_init(void)
+{
+	struct proc_dir_entry *e;
+
+	e = create_proc_entry("dma", 0, NULL);
+	if (e)
+		e->proc_fops = &proc_dma_operations;
+
+	return 0;
+}
+
+__initcall(proc_dma_init);
+
+EXPORT_SYMBOL(request_dma);
+EXPORT_SYMBOL(free_dma);
+EXPORT_SYMBOL(dma_spin_lock);
--- linux-tolinus/kernel/ksyms.c	Wed Jun  5 10:08:25 2002
+++ linux/kernel/ksyms.c	Wed Jun  5 18:48:44 2002
@@ -63,9 +63,6 @@
 extern void *sys_call_table;
 
 extern struct timezone sys_tz;
-extern int request_dma(unsigned int dmanr, const char * deviceID);
-extern void free_dma(unsigned int dmanr);
-extern spinlock_t dma_spin_lock;
 
 #ifdef CONFIG_MODVERSIONS
 const struct module_symbol __export_Using_Versions
@@ -434,10 +432,6 @@
 EXPORT_SYMBOL(brw_kiovec);
 EXPORT_SYMBOL(kiobuf_wait_for_io);
 
-/* dma handling */
-EXPORT_SYMBOL(request_dma);
-EXPORT_SYMBOL(free_dma);
-EXPORT_SYMBOL(dma_spin_lock);
 #ifdef HAVE_DISABLE_HLT
 EXPORT_SYMBOL(disable_hlt);
 EXPORT_SYMBOL(enable_hlt);
--- linux-tolinus/fs/proc/proc_misc.c	Wed May 29 23:57:09 2002
+++ linux/fs/proc/proc_misc.c	Wed Jun  5 19:17:51 2002
@@ -394,13 +394,6 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-static int dma_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_dma_list(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
 static int ioports_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -553,7 +546,6 @@
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
 		{"filesystems",	filesystems_read_proc},
-		{"dma",		dma_read_proc},
 		{"ioports",	ioports_read_proc},
 		{"cmdline",	cmdline_read_proc},
 #ifdef CONFIG_SGI_DS1286

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


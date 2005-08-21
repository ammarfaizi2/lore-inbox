Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVHUXyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVHUXyw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVHUXyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 19:54:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48903 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750738AbVHUXyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 19:54:51 -0400
Date: Mon, 22 Aug 2005 01:54:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: starvik@axis.com
Cc: dev-etrax@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] cris: "extern inline" -> "static inline"
Message-ID: <20050821235446.GF5726@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/cris/arch-v10/README.mm            |    6 +--
 arch/cris/arch-v10/kernel/signal.c      |    2 -
 arch/cris/arch-v32/kernel/signal.c      |    2 -
 arch/cris/mm/ioremap.c                  |    2 -
 include/asm-cris/arch-v10/byteorder.h   |    4 +-
 include/asm-cris/arch-v10/checksum.h    |    2 -
 include/asm-cris/arch-v10/delay.h       |    2 -
 include/asm-cris/arch-v10/ide.h         |    8 ++--
 include/asm-cris/arch-v10/system.h      |    8 ++--
 include/asm-cris/arch-v10/thread_info.h |    2 -
 include/asm-cris/arch-v10/timex.h       |    2 -
 include/asm-cris/arch-v10/uaccess.h     |    4 +-
 include/asm-cris/arch-v32/bitops.h      |   10 ++---
 include/asm-cris/arch-v32/byteorder.h   |    4 +-
 include/asm-cris/arch-v32/checksum.h    |    2 -
 include/asm-cris/arch-v32/delay.h       |    2 -
 include/asm-cris/arch-v32/ide.h         |    4 +-
 include/asm-cris/arch-v32/io.h          |    6 +--
 include/asm-cris/arch-v32/system.h      |    6 +--
 include/asm-cris/arch-v32/thread_info.h |    2 -
 include/asm-cris/arch-v32/timex.h       |    2 -
 include/asm-cris/arch-v32/uaccess.h     |    4 +-
 include/asm-cris/atomic.h               |   22 ++++++------
 include/asm-cris/bitops.h               |   18 ++++-----
 include/asm-cris/checksum.h             |    8 ++--
 include/asm-cris/current.h              |    2 -
 include/asm-cris/delay.h                |    2 -
 include/asm-cris/io.h                   |    6 +--
 include/asm-cris/irq.h                  |    2 -
 include/asm-cris/pgalloc.h              |   12 +++---
 include/asm-cris/pgtable.h              |   44 ++++++++++++------------
 include/asm-cris/processor.h            |    4 +-
 include/asm-cris/semaphore-helper.h     |    8 ++--
 include/asm-cris/semaphore.h            |   14 +++----
 include/asm-cris/system.h               |    2 -
 include/asm-cris/timex.h                |    2 -
 include/asm-cris/tlbflush.h             |    4 +-
 include/asm-cris/uaccess.h              |   24 ++++++-------
 include/asm-cris/unistd.h               |   20 +++++-----
 39 files changed, 140 insertions(+), 140 deletions(-)

--- linux-2.6.13-rc6-mm1-full/arch/cris/arch-v10/README.mm.old	2005-08-22 01:38:14.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/arch/cris/arch-v10/README.mm	2005-08-22 01:38:36.000000000 +0200
@@ -177,7 +177,7 @@
 Given the top-level Page Directory, the offset in that directory is calculated
 using the upper 8 bits:
 
-extern inline pgd_t * pgd_offset(struct mm_struct * mm, unsigned long address)
+static inline pgd_t * pgd_offset(struct mm_struct * mm, unsigned long address)
 {
 	return mm->pgd + (address >> PGDIR_SHIFT);
 }
@@ -190,14 +190,14 @@
 
 Since the Middle Directory does not exist, it is a unity mapping:
 
-extern inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
+static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
 {
 	return (pmd_t *) dir;
 }
 
 The Page Table provides the final lookup by using bits 13 to 23 as index:
 
-extern inline pte_t * pte_offset(pmd_t * dir, unsigned long address)
+static inline pte_t * pte_offset(pmd_t * dir, unsigned long address)
 {
 	return (pte_t *) pmd_page(*dir) + ((address >> PAGE_SHIFT) &
 					   (PTRS_PER_PTE - 1));
--- linux-2.6.13-rc6-mm1-full/arch/cris/arch-v10/kernel/signal.c.old	2005-08-22 01:38:45.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/arch/cris/arch-v10/kernel/signal.c	2005-08-22 01:38:54.000000000 +0200
@@ -476,7 +476,7 @@
  * OK, we're invoking a handler
  */	
 
-extern inline void
+static inline void
 handle_signal(int canrestart, unsigned long sig,
 	      siginfo_t *info, struct k_sigaction *ka,
               sigset_t *oldset, struct pt_regs * regs)
--- linux-2.6.13-rc6-mm1-full/arch/cris/arch-v32/kernel/signal.c.old	2005-08-22 01:39:03.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/arch/cris/arch-v32/kernel/signal.c	2005-08-22 01:39:09.000000000 +0200
@@ -513,7 +513,7 @@
 }
 
 /* Invoke a singal handler to, well, handle the signal. */
-extern inline void
+static inline void
 handle_signal(int canrestart, unsigned long sig,
 	      siginfo_t *info, struct k_sigaction *ka,
               sigset_t *oldset, struct pt_regs * regs)
--- linux-2.6.13-rc6-mm1-full/arch/cris/mm/ioremap.c.old	2005-08-22 01:39:18.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/arch/cris/mm/ioremap.c	2005-08-22 01:39:23.000000000 +0200
@@ -16,7 +16,7 @@
 #include <asm/tlbflush.h>
 #include <asm/arch/memmap.h>
 
-extern inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
+static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
 	unsigned long phys_addr, pgprot_t prot)
 {
 	unsigned long end;
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/byteorder.h.old	2005-08-22 01:40:18.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/byteorder.h	2005-08-22 01:40:37.000000000 +0200
@@ -9,14 +9,14 @@
  * them together into ntohl etc.
  */
 
-extern __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
+static inline __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 	__asm__ ("swapwb %0" : "=r" (x) : "0" (x));
   
 	return(x);
 }
 
-extern __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
+static inline __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__ ("swapb %0" : "=r" (x) : "0" (x));
 	
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/checksum.h.old	2005-08-22 01:40:49.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/checksum.h	2005-08-22 01:40:54.000000000 +0200
@@ -8,7 +8,7 @@
  * to split all of those into 16-bit components, then add.
  */
 
-extern inline unsigned int
+static inline unsigned int
 csum_tcpudp_nofold(unsigned long saddr, unsigned long daddr, unsigned short len,
 		   unsigned short proto, unsigned int sum)
 {
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/delay.h.old	2005-08-22 01:41:04.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/delay.h	2005-08-22 01:41:10.000000000 +0200
@@ -1,7 +1,7 @@
 #ifndef _CRIS_ARCH_DELAY_H
 #define _CRIS_ARCH_DELAY_H
 
-extern __inline__ void __delay(int loops)
+static inline void __delay(int loops)
 {
 	__asm__ __volatile__ (
 			      "move.d %0,$r9\n\t"
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/ide.h.old	2005-08-22 01:41:19.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/ide.h	2005-08-22 01:41:26.000000000 +0200
@@ -25,7 +25,7 @@
 
 #define MAX_HWIFS	4
 
-extern __inline__ int ide_default_irq(unsigned long base)
+static inline int ide_default_irq(unsigned long base)
 {
 	/* all IDE busses share the same IRQ, number 4.
 	 * this has the side-effect that ide-probe.c will cluster our 4 interfaces
@@ -35,7 +35,7 @@
 	return 4;
 }
 
-extern __inline__ unsigned long ide_default_io_base(int index)
+static inline unsigned long ide_default_io_base(int index)
 {
 	/* we have no real I/O base address per interface, since all go through the
 	 * same register. but in a bitfield in that register, we have the i/f number.
@@ -54,7 +54,7 @@
  * of the ide_default_io_base call above. ctrl_port will be 0, but that is don't care for us.
  */
 
-extern __inline__ void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port, unsigned long ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port, unsigned long ctrl_port, int *irq)
 {
 	int i;
 
@@ -77,7 +77,7 @@
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-extern __inline__ void ide_init_default_hwifs(void)
+static inline void ide_init_default_hwifs(void)
 {
 	hw_regs_t hw;
 	int index;
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/system.h.old	2005-08-22 01:41:34.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/system.h	2005-08-22 01:41:38.000000000 +0200
@@ -5,7 +5,7 @@
 
 /* read the CPU version register */
 
-extern inline unsigned long rdvr(void) { 
+static inline unsigned long rdvr(void) { 
 	unsigned char vr;
 	__asm__ volatile ("move $vr,%0" : "=rm" (vr));
 	return vr;
@@ -15,7 +15,7 @@
 
 /* read/write the user-mode stackpointer */
 
-extern inline unsigned long rdusp(void) {
+static inline unsigned long rdusp(void) {
 	unsigned long usp;
 	__asm__ __volatile__("move $usp,%0" : "=rm" (usp));
 	return usp;
@@ -26,13 +26,13 @@
 
 /* read the current stackpointer */
 
-extern inline unsigned long rdsp(void) {
+static inline unsigned long rdsp(void) {
 	unsigned long sp;
 	__asm__ __volatile__("move.d $sp,%0" : "=rm" (sp));
 	return sp;
 }
 
-extern inline unsigned long _get_base(char * addr)
+static inline unsigned long _get_base(char * addr)
 {
   return 0;
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/thread_info.h.old	2005-08-22 01:41:47.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/thread_info.h	2005-08-22 01:41:52.000000000 +0200
@@ -2,7 +2,7 @@
 #define _ASM_ARCH_THREAD_INFO_H
 
 /* how to get the thread information struct from C */
-extern inline struct thread_info *current_thread_info(void)
+static inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
         __asm__("and.d $sp,%0; ":"=r" (ti) : "0" (~8191UL));
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/timex.h.old	2005-08-22 01:42:00.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/timex.h	2005-08-22 01:42:04.000000000 +0200
@@ -22,7 +22,7 @@
 
 unsigned long get_ns_in_jiffie(void);
 
-extern inline unsigned long get_us_in_jiffie_highres(void)
+static inline unsigned long get_us_in_jiffie_highres(void)
 {
 	return get_ns_in_jiffie()/1000;
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/uaccess.h.old	2005-08-22 01:42:12.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v10/uaccess.h	2005-08-22 01:42:17.000000000 +0200
@@ -87,7 +87,7 @@
  * bytes copied		if we hit a null byte
  * (without the null byte)
  */
-extern inline long         
+static inline long         
 __do_strncpy_from_user(char *dst, const char *src, long count)
 {
 	long res;
@@ -602,7 +602,7 @@
  * or 0 for error.  Return a value greater than N if too long.
  */
 
-extern inline long
+static inline long
 strnlen_user(const char *s, long n)
 {
 	long res, tmp1;
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/bitops.h.old	2005-08-22 01:42:27.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/bitops.h	2005-08-22 01:42:33.000000000 +0200
@@ -8,7 +8,7 @@
  * inverts all bits in the input.
  */
 
-extern inline unsigned long
+static inline unsigned long
 cris_swapnwbrlz(unsigned long w)
 {
 	unsigned long res;
@@ -20,7 +20,7 @@
 	return res;
 }
 
-extern inline unsigned long
+static inline unsigned long
 cris_swapwbrlz(unsigned long w)
 {
 	unsigned long res;
@@ -36,7 +36,7 @@
  * Find First Zero in word. Undefined if no zero exist, so the caller should
  * check against ~0 first.
  */
-extern inline unsigned long
+static inline unsigned long
 ffz(unsigned long w)
 {
 	return cris_swapnwbrlz(w);
@@ -46,7 +46,7 @@
  * Find First Set bit in word. Undefined if no 1 exist, so the caller
  * should check against 0 first.
  */
-extern inline unsigned long
+static inline unsigned long
 __ffs(unsigned long w)
 {
 	return cris_swapnwbrlz(~w);
@@ -55,7 +55,7 @@
 /*
  * Find First Bit that is set.
  */
-extern inline unsigned long
+static inline unsigned long
 kernel_ffs(unsigned long w)
 {
 	return w ? cris_swapwbrlz (w) + 1 : 0;
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/byteorder.h.old	2005-08-22 01:42:44.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/byteorder.h	2005-08-22 01:42:48.000000000 +0200
@@ -3,14 +3,14 @@
 
 #include <asm/types.h>
 
-extern __inline__ __const__ __u32
+static inline __const__ __u32
 ___arch__swab32(__u32 x)
 {
 	__asm__ __volatile__ ("swapwb %0" : "=r" (x) : "0" (x));
 	return (x);
 }
 
-extern __inline__ __const__ __u16
+static inline __const__ __u16
 ___arch__swab16(__u16 x)
 {
 	__asm__ __volatile__ ("swapb %0" : "=r" (x) : "0" (x));
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/checksum.h.old	2005-08-22 01:42:59.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/checksum.h	2005-08-22 01:43:05.000000000 +0200
@@ -9,7 +9,7 @@
  * checksum. Which means it would be necessary to split all those into
  * 16-bit components and then add.
  */
-extern inline unsigned int
+static inline unsigned int
 csum_tcpudp_nofold(unsigned long saddr, unsigned long daddr,
 		   unsigned short len, unsigned short proto, unsigned int sum)
 {
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/delay.h.old	2005-08-22 01:43:54.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/delay.h	2005-08-22 01:43:59.000000000 +0200
@@ -1,7 +1,7 @@
 #ifndef _ASM_CRIS_ARCH_DELAY_H
 #define _ASM_CRIS_ARCH_DELAY_H
 
-extern __inline__ void
+static inline void
 __delay(int loops)
 {
 	__asm__ __volatile__ (
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/ide.h.old	2005-08-22 01:44:08.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/ide.h	2005-08-22 01:44:13.000000000 +0200
@@ -26,7 +26,7 @@
 
 #define MAX_HWIFS	4
 
-extern __inline__ int ide_default_irq(unsigned long base)
+static inline int ide_default_irq(unsigned long base)
 {
 	/* all IDE busses share the same IRQ,
 	 * this has the side-effect that ide-probe.c will cluster our 4 interfaces
@@ -36,7 +36,7 @@
 	return ATA_INTR_VECT;
 }
 
-extern __inline__ unsigned long ide_default_io_base(int index)
+static inline unsigned long ide_default_io_base(int index)
 {
 	reg_ata_rw_ctrl2 ctrl2 = {.sel = index};
 	/* we have no real I/O base address per interface, since all go through the
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/io.h.old	2005-08-22 01:44:22.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/io.h	2005-08-22 01:44:25.000000000 +0200
@@ -35,7 +35,7 @@
 extern struct crisv32_iopin crisv32_led3_green;
 extern struct crisv32_iopin crisv32_led3_red;
 
-extern inline void crisv32_io_set(struct crisv32_iopin* iopin,
+static inline void crisv32_io_set(struct crisv32_iopin* iopin,
 			   int val)
 {
 	if (val)
@@ -44,7 +44,7 @@
 		*iopin->port->data &= ~iopin->bit;
 }
 
-extern inline void crisv32_io_set_dir(struct crisv32_iopin* iopin,
+static inline void crisv32_io_set_dir(struct crisv32_iopin* iopin,
 			       enum crisv32_io_dir dir)
 {
 	if (dir == crisv32_io_dir_in)
@@ -53,7 +53,7 @@
 		*iopin->port->oe |= iopin->bit;
 }
 
-extern inline int crisv32_io_rd(struct crisv32_iopin* iopin)
+static inline int crisv32_io_rd(struct crisv32_iopin* iopin)
 {
 	return ((*iopin->port->data_in & iopin->bit) ? 1 : 0);
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/system.h.old	2005-08-22 01:44:35.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/system.h	2005-08-22 01:44:40.000000000 +0200
@@ -4,7 +4,7 @@
 #include <linux/config.h>
 
 /* Read the CPU version register. */
-extern inline unsigned long rdvr(void)
+static inline unsigned long rdvr(void)
 {
 	unsigned char vr;
 
@@ -15,7 +15,7 @@
 #define cris_machine_name "crisv32"
 
 /* Read the user-mode stack pointer. */
-extern inline unsigned long rdusp(void)
+static inline unsigned long rdusp(void)
 {
 	unsigned long usp;
 
@@ -24,7 +24,7 @@
 }
 
 /* Read the current stack pointer. */
-extern inline unsigned long rdsp(void)
+static inline unsigned long rdsp(void)
 {
 	unsigned long sp;
 
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/thread_info.h.old	2005-08-22 01:44:48.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/thread_info.h	2005-08-22 01:44:52.000000000 +0200
@@ -2,7 +2,7 @@
 #define _ASM_CRIS_ARCH_THREAD_INFO_H
 
 /* Return a thread_info struct. */
-extern inline struct thread_info *current_thread_info(void)
+static inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
 
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/timex.h.old	2005-08-22 01:45:00.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/timex.h	2005-08-22 01:45:05.000000000 +0200
@@ -22,7 +22,7 @@
 
 extern unsigned long get_ns_in_jiffie(void);
 
-extern inline unsigned long get_us_in_jiffie_highres(void)
+static inline unsigned long get_us_in_jiffie_highres(void)
 {
 	return get_ns_in_jiffie() / 1000;
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/uaccess.h.old	2005-08-22 01:45:12.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/arch-v32/uaccess.h	2005-08-22 01:45:16.000000000 +0200
@@ -93,7 +93,7 @@
  * bytes copied		if we hit a null byte
  * (without the null byte)
  */
-extern inline long
+static inline long
 __do_strncpy_from_user(char *dst, const char *src, long count)
 {
 	long res;
@@ -695,7 +695,7 @@
  * or 0 for error.  Return a value greater than N if too long.
  */
 
-extern inline long
+static inline long
 strnlen_user(const char *s, long n)
 {
 	long res, tmp1;
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/atomic.h.old	2005-08-22 01:45:25.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/atomic.h	2005-08-22 01:45:30.000000000 +0200
@@ -20,7 +20,7 @@
 
 /* These should be written in asm but we do it in C for now. */
 
-extern __inline__ void atomic_add(int i, volatile atomic_t *v)
+static inline void atomic_add(int i, volatile atomic_t *v)
 {
 	unsigned long flags;
 	cris_atomic_save(v, flags);
@@ -28,7 +28,7 @@
 	cris_atomic_restore(v, flags);
 }
 
-extern __inline__ void atomic_sub(int i, volatile atomic_t *v)
+static inline void atomic_sub(int i, volatile atomic_t *v)
 {
 	unsigned long flags;
 	cris_atomic_save(v, flags);
@@ -36,7 +36,7 @@
 	cris_atomic_restore(v, flags);
 }
 
-extern __inline__ int atomic_add_return(int i, volatile atomic_t *v)
+static inline int atomic_add_return(int i, volatile atomic_t *v)
 {
 	unsigned long flags;
 	int retval;
@@ -48,7 +48,7 @@
 
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
 
-extern __inline__ int atomic_sub_return(int i, volatile atomic_t *v)
+static inline int atomic_sub_return(int i, volatile atomic_t *v)
 {
 	unsigned long flags;
 	int retval;
@@ -58,7 +58,7 @@
 	return retval;
 }
 
-extern __inline__ int atomic_sub_and_test(int i, volatile atomic_t *v)
+static inline int atomic_sub_and_test(int i, volatile atomic_t *v)
 {
 	int retval;
 	unsigned long flags;
@@ -68,7 +68,7 @@
 	return retval;
 }
 
-extern __inline__ void atomic_inc(volatile atomic_t *v)
+static inline void atomic_inc(volatile atomic_t *v)
 {
 	unsigned long flags;
 	cris_atomic_save(v, flags);
@@ -76,7 +76,7 @@
 	cris_atomic_restore(v, flags);
 }
 
-extern __inline__ void atomic_dec(volatile atomic_t *v)
+static inline void atomic_dec(volatile atomic_t *v)
 {
 	unsigned long flags;
 	cris_atomic_save(v, flags);
@@ -84,7 +84,7 @@
 	cris_atomic_restore(v, flags);
 }
 
-extern __inline__ int atomic_inc_return(volatile atomic_t *v)
+static inline int atomic_inc_return(volatile atomic_t *v)
 {
 	unsigned long flags;
 	int retval;
@@ -94,7 +94,7 @@
 	return retval;
 }
 
-extern __inline__ int atomic_dec_return(volatile atomic_t *v)
+static inline int atomic_dec_return(volatile atomic_t *v)
 {
 	unsigned long flags;
 	int retval;
@@ -103,7 +103,7 @@
 	cris_atomic_restore(v, flags);
 	return retval;
 }
-extern __inline__ int atomic_dec_and_test(volatile atomic_t *v)
+static inline int atomic_dec_and_test(volatile atomic_t *v)
 {
 	int retval;
 	unsigned long flags;
@@ -113,7 +113,7 @@
 	return retval;
 }
 
-extern __inline__ int atomic_inc_and_test(volatile atomic_t *v)
+static inline int atomic_inc_and_test(volatile atomic_t *v)
 {
 	int retval;
 	unsigned long flags;
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/bitops.h.old	2005-08-22 01:45:40.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/bitops.h	2005-08-22 01:45:44.000000000 +0200
@@ -89,7 +89,7 @@
  * It also implies a memory barrier.
  */
 
-extern inline int test_and_set_bit(int nr, volatile unsigned long *addr)
+static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned long flags;
@@ -105,7 +105,7 @@
 	return retval;
 }
 
-extern inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
+static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned int *adr = (unsigned int *)addr;
@@ -132,7 +132,7 @@
  * It also implies a memory barrier.
  */
 
-extern inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned long flags;
@@ -157,7 +157,7 @@
  * but actually fail.  You must protect multiple accesses with a lock.
  */
 
-extern inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned int *adr = (unsigned int *)addr;
@@ -177,7 +177,7 @@
  * It also implies a memory barrier.
  */
 
-extern inline int test_and_change_bit(int nr, volatile unsigned long *addr)
+static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned long flags;
@@ -193,7 +193,7 @@
 
 /* WARNING: non atomic and it can be reordered! */
 
-extern inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
+static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned int *adr = (unsigned int *)addr;
@@ -214,7 +214,7 @@
  * This routine doesn't need to be atomic.
  */
 
-extern inline int test_bit(int nr, const volatile unsigned long *addr)
+static inline int test_bit(int nr, const volatile unsigned long *addr)
 {
 	unsigned int mask;
 	unsigned int *adr = (unsigned int *)addr;
@@ -258,7 +258,7 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-extern inline int find_next_zero_bit (const unsigned long * addr, int size, int offset)
+static inline int find_next_zero_bit (const unsigned long * addr, int size, int offset)
 {
 	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
 	unsigned long result = offset & ~31UL;
@@ -366,7 +366,7 @@
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
-extern inline int sched_find_first_bit(const unsigned long *b)
+static inline int sched_find_first_bit(const unsigned long *b)
 {
 	if (unlikely(b[0]))
 		return __ffs(b[0]);
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/checksum.h.old	2005-08-22 01:45:57.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/checksum.h	2005-08-22 01:46:02.000000000 +0200
@@ -34,7 +34,7 @@
  *	Fold a partial checksum into a word
  */
 
-extern inline unsigned int csum_fold(unsigned int sum)
+static inline unsigned int csum_fold(unsigned int sum)
 {
 	/* the while loop is unnecessary really, it's always enough with two
 	   iterations */
@@ -55,7 +55,7 @@
  *
  */
 
-extern inline unsigned short ip_fast_csum(unsigned char * iph,
+static inline unsigned short ip_fast_csum(unsigned char * iph,
 					  unsigned int ihl)
 {
 	return csum_fold(csum_partial(iph, ihl * 4, 0));
@@ -66,7 +66,7 @@
  * returns a 16-bit checksum, already complemented
  */
 
-extern inline unsigned short int csum_tcpudp_magic(unsigned long saddr,
+static inline unsigned short int csum_tcpudp_magic(unsigned long saddr,
 						   unsigned long daddr,
 						   unsigned short len,
 						   unsigned short proto,
@@ -80,7 +80,7 @@
  * in icmp.c
  */
 
-extern inline unsigned short ip_compute_csum(unsigned char * buff, int len) {
+static inline unsigned short ip_compute_csum(unsigned char * buff, int len) {
 	return csum_fold (csum_partial(buff, len, 0));
 }
 
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/current.h.old	2005-08-22 01:46:11.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/current.h	2005-08-22 01:46:24.000000000 +0200
@@ -5,7 +5,7 @@
 
 struct task_struct;
 
-extern inline struct task_struct * get_current(void)
+static inline struct task_struct * get_current(void)
 {
         return current_thread_info()->task;
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/delay.h.old	2005-08-22 01:46:32.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/delay.h	2005-08-22 01:46:37.000000000 +0200
@@ -13,7 +13,7 @@
 
 extern unsigned long loops_per_usec; /* arch/cris/mm/init.c */
 
-extern __inline__ void udelay(unsigned long usecs)
+static inline void udelay(unsigned long usecs)
 {
 	__delay(usecs * loops_per_usec);
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/io.h.old	2005-08-22 01:46:45.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/io.h	2005-08-22 01:46:51.000000000 +0200
@@ -23,12 +23,12 @@
  * Change virtual addresses to physical addresses and vv.
  */
 
-extern inline unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(volatile void * address)
 {
 	return __pa(address);
 }
 
-extern inline void * phys_to_virt(unsigned long address)
+static inline void * phys_to_virt(unsigned long address)
 {
 	return __va(address);
 }
@@ -36,7 +36,7 @@
 extern void __iomem * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
 extern void __iomem * __ioremap_prot(unsigned long phys_addr, unsigned long size, pgprot_t prot);
 
-extern inline void __iomem * ioremap (unsigned long offset, unsigned long size)
+static inline void __iomem * ioremap (unsigned long offset, unsigned long size)
 {
 	return __ioremap(offset, size, 0);
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/irq.h.old	2005-08-22 01:47:01.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/irq.h	2005-08-22 01:47:07.000000000 +0200
@@ -8,7 +8,7 @@
 
 #include <asm/arch/irq.h>
 
-extern __inline__ int irq_canonicalize(int irq)
+static inline int irq_canonicalize(int irq)
 {  
   return irq; 
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/pgalloc.h.old	2005-08-22 01:47:17.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/pgalloc.h	2005-08-22 01:47:23.000000000 +0200
@@ -11,35 +11,35 @@
  * Allocate and free page tables.
  */
 
-extern inline pgd_t *pgd_alloc (struct mm_struct *mm)
+static inline pgd_t *pgd_alloc (struct mm_struct *mm)
 {
 	return (pgd_t *)get_zeroed_page(GFP_KERNEL);
 }
 
-extern inline void pgd_free (pgd_t *pgd)
+static inline void pgd_free (pgd_t *pgd)
 {
 	free_page((unsigned long)pgd);
 }
 
-extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
   	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
  	return pte;
 }
 
-extern inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *pte;
 	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 	return pte;
 }
 
-extern inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-extern inline void pte_free(struct page *pte)
+static inline void pte_free(struct page *pte)
 {
 	__free_page(pte);
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/pgtable.h.old	2005-08-22 01:47:32.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/pgtable.h	2005-08-22 01:47:37.000000000 +0200
@@ -112,44 +112,44 @@
  * Undefined behaviour if not..
  */
 
-extern inline int pte_read(pte_t pte)           { return pte_val(pte) & _PAGE_READ; }
-extern inline int pte_write(pte_t pte)          { return pte_val(pte) & _PAGE_WRITE; }
-extern inline int pte_exec(pte_t pte)           { return pte_val(pte) & _PAGE_READ; }
-extern inline int pte_dirty(pte_t pte)          { return pte_val(pte) & _PAGE_MODIFIED; }
-extern inline int pte_young(pte_t pte)          { return pte_val(pte) & _PAGE_ACCESSED; }
-extern inline int pte_file(pte_t pte)           { return pte_val(pte) & _PAGE_FILE; }
+static inline int pte_read(pte_t pte)           { return pte_val(pte) & _PAGE_READ; }
+static inline int pte_write(pte_t pte)          { return pte_val(pte) & _PAGE_WRITE; }
+static inline int pte_exec(pte_t pte)           { return pte_val(pte) & _PAGE_READ; }
+static inline int pte_dirty(pte_t pte)          { return pte_val(pte) & _PAGE_MODIFIED; }
+static inline int pte_young(pte_t pte)          { return pte_val(pte) & _PAGE_ACCESSED; }
+static inline int pte_file(pte_t pte)           { return pte_val(pte) & _PAGE_FILE; }
 
-extern inline pte_t pte_wrprotect(pte_t pte)
+static inline pte_t pte_wrprotect(pte_t pte)
 {
         pte_val(pte) &= ~(_PAGE_WRITE | _PAGE_SILENT_WRITE);
         return pte;
 }
 
-extern inline pte_t pte_rdprotect(pte_t pte)
+static inline pte_t pte_rdprotect(pte_t pte)
 {
         pte_val(pte) &= ~(_PAGE_READ | _PAGE_SILENT_READ);
 	return pte;
 }
 
-extern inline pte_t pte_exprotect(pte_t pte)
+static inline pte_t pte_exprotect(pte_t pte)
 {
         pte_val(pte) &= ~(_PAGE_READ | _PAGE_SILENT_READ);
 	return pte;
 }
 
-extern inline pte_t pte_mkclean(pte_t pte)
+static inline pte_t pte_mkclean(pte_t pte)
 {
 	pte_val(pte) &= ~(_PAGE_MODIFIED | _PAGE_SILENT_WRITE); 
 	return pte; 
 }
 
-extern inline pte_t pte_mkold(pte_t pte)
+static inline pte_t pte_mkold(pte_t pte)
 {
 	pte_val(pte) &= ~(_PAGE_ACCESSED | _PAGE_SILENT_READ);
 	return pte;
 }
 
-extern inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte)
 {
         pte_val(pte) |= _PAGE_WRITE;
         if (pte_val(pte) & _PAGE_MODIFIED)
@@ -157,7 +157,7 @@
         return pte;
 }
 
-extern inline pte_t pte_mkread(pte_t pte)
+static inline pte_t pte_mkread(pte_t pte)
 {
         pte_val(pte) |= _PAGE_READ;
         if (pte_val(pte) & _PAGE_ACCESSED)
@@ -165,7 +165,7 @@
         return pte;
 }
 
-extern inline pte_t pte_mkexec(pte_t pte)
+static inline pte_t pte_mkexec(pte_t pte)
 {
         pte_val(pte) |= _PAGE_READ;
         if (pte_val(pte) & _PAGE_ACCESSED)
@@ -173,7 +173,7 @@
         return pte;
 }
 
-extern inline pte_t pte_mkdirty(pte_t pte)
+static inline pte_t pte_mkdirty(pte_t pte)
 {
         pte_val(pte) |= _PAGE_MODIFIED;
         if (pte_val(pte) & _PAGE_WRITE)
@@ -181,7 +181,7 @@
         return pte;
 }
 
-extern inline pte_t pte_mkyoung(pte_t pte)
+static inline pte_t pte_mkyoung(pte_t pte)
 {
         pte_val(pte) |= _PAGE_ACCESSED;
         if (pte_val(pte) & _PAGE_READ)
@@ -205,7 +205,7 @@
  * addresses (the 0xc0xxxxxx's) goes as void *'s.
  */
 
-extern inline pte_t __mk_pte(void * page, pgprot_t pgprot)
+static inline pte_t __mk_pte(void * page, pgprot_t pgprot)
 {
 	pte_t pte;
 	/* the PTE needs a physical address */
@@ -223,7 +223,7 @@
         __pte;                                                          \
 })
 
-extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 { pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot); return pte; }
 
 
@@ -232,7 +232,7 @@
  * pte_pagenr refers to the page-number counted starting from the virtual DRAM start
  */
 
-extern inline unsigned long __pte_page(pte_t pte)
+static inline unsigned long __pte_page(pte_t pte)
 {
 	/* the PTE contains a physical address */
 	return (unsigned long)__va(pte_val(pte) & PAGE_MASK);
@@ -250,7 +250,7 @@
  * don't need the __pa and __va transformations.
  */
 
-extern inline void pmd_set(pmd_t * pmdp, pte_t * ptep)
+static inline void pmd_set(pmd_t * pmdp, pte_t * ptep)
 { pmd_val(*pmdp) = _PAGE_TABLE | (unsigned long) ptep; }
 
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
@@ -260,7 +260,7 @@
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 
 /* to find an entry in a page-table-directory */
-extern inline pgd_t * pgd_offset(struct mm_struct * mm, unsigned long address)
+static inline pgd_t * pgd_offset(struct mm_struct * mm, unsigned long address)
 {
 	return mm->pgd + pgd_index(address);
 }
@@ -296,7 +296,7 @@
  * 
  * Actually I am not sure on what this could be used for.
  */
-extern inline void update_mmu_cache(struct vm_area_struct * vma,
+static inline void update_mmu_cache(struct vm_area_struct * vma,
 	unsigned long address, pte_t pte)
 {
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/processor.h.old	2005-08-22 01:47:47.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/processor.h	2005-08-22 01:47:52.000000000 +0200
@@ -45,7 +45,7 @@
 
 #define current_regs() user_regs(current->thread_info)
 
-extern inline void prepare_to_copy(struct task_struct *tsk)
+static inline void prepare_to_copy(struct task_struct *tsk)
 {
 }
 
@@ -58,7 +58,7 @@
 extern unsigned long thread_saved_pc(struct task_struct *tsk);
 
 /* Free all resources held by a thread. */
-extern inline void release_thread(struct task_struct *dead_task)
+static inline void release_thread(struct task_struct *dead_task)
 {
         /* Nothing needs to be done.  */
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/semaphore-helper.h.old	2005-08-22 01:48:01.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/semaphore-helper.h	2005-08-22 01:48:04.000000000 +0200
@@ -20,12 +20,12 @@
 /*
  * These two _must_ execute atomically wrt each other.
  */
-extern inline void wake_one_more(struct semaphore * sem)
+static inline void wake_one_more(struct semaphore * sem)
 {
 	atomic_inc(&sem->waking);
 }
 
-extern inline int waking_non_zero(struct semaphore *sem)
+static inline int waking_non_zero(struct semaphore *sem)
 {
 	unsigned long flags;
 	int ret = 0;
@@ -40,7 +40,7 @@
 	return ret;
 }
 
-extern inline int waking_non_zero_interruptible(struct semaphore *sem,
+static inline int waking_non_zero_interruptible(struct semaphore *sem,
 						struct task_struct *tsk)
 {
 	int ret = 0;
@@ -59,7 +59,7 @@
 	return ret;
 }
 
-extern inline int waking_non_zero_trylock(struct semaphore *sem)
+static inline int waking_non_zero_trylock(struct semaphore *sem)
 {
         int ret = 1;
 	unsigned long flags;
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/semaphore.h.old	2005-08-22 01:48:12.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/semaphore.h	2005-08-22 01:48:17.000000000 +0200
@@ -42,17 +42,17 @@
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-extern inline void sema_init(struct semaphore *sem, int val)
+static inline void sema_init(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }
 
-extern inline void init_MUTEX (struct semaphore *sem)
+static inline void init_MUTEX (struct semaphore *sem)
 {
         sema_init(sem, 1);
 }
 
-extern inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_MUTEX_LOCKED (struct semaphore *sem)
 {
         sema_init(sem, 0);
 }
@@ -64,7 +64,7 @@
 
 /* notice - we probably can do cli/sti here instead of saving */
 
-extern inline void down(struct semaphore * sem)
+static inline void down(struct semaphore * sem)
 {
 	unsigned long flags;
 	int failed;
@@ -86,7 +86,7 @@
  * returns negative for signalled and zero for semaphore acquired.
  */
 
-extern inline int down_interruptible(struct semaphore * sem)
+static inline int down_interruptible(struct semaphore * sem)
 {
 	unsigned long flags;
 	int failed;
@@ -102,7 +102,7 @@
 	return(failed);
 }
 
-extern inline int down_trylock(struct semaphore * sem)
+static inline int down_trylock(struct semaphore * sem)
 {
 	unsigned long flags;
 	int failed;
@@ -122,7 +122,7 @@
  * The default case (no contention) will result in NO
  * jumps for both down() and up().
  */
-extern inline void up(struct semaphore * sem)
+static inline void up(struct semaphore * sem)
 {  
 	unsigned long flags;
 	int wakeup;
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/system.h.old	2005-08-22 01:48:25.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/system.h	2005-08-22 01:48:28.000000000 +0200
@@ -41,7 +41,7 @@
 void disable_hlt(void);
 void enable_hlt(void);
 
-extern inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
+static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
 {
   /* since Etrax doesn't have any atomic xchg instructions, we need to disable
      irq's (if enabled) and do it with move.d's */
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/timex.h.old	2005-08-22 01:48:35.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/timex.h	2005-08-22 01:48:38.000000000 +0200
@@ -16,7 +16,7 @@
 
 typedef unsigned long long cycles_t;
 
-extern inline cycles_t get_cycles(void)
+static inline cycles_t get_cycles(void)
 {
         return 0;
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/tlbflush.h.old	2005-08-22 01:48:46.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/tlbflush.h	2005-08-22 01:48:49.000000000 +0200
@@ -39,14 +39,14 @@
 	flush_tlb_mm(vma->vm_mm);
 }
 
-extern inline void flush_tlb_pgtables(struct mm_struct *mm,
+static inline void flush_tlb_pgtables(struct mm_struct *mm,
                                       unsigned long start, unsigned long end)
 {
         /* CRIS does not keep any page table caches in TLB */
 }
 
 
-extern inline void flush_tlb(void) 
+static inline void flush_tlb(void) 
 {
 	flush_tlb_mm(current->mm);
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/uaccess.h.old	2005-08-22 01:48:58.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/uaccess.h	2005-08-22 01:49:03.000000000 +0200
@@ -92,7 +92,7 @@
 #define access_ok(type,addr,size) __access_ok((unsigned long)(addr),(size))
 
 /* this function will go away soon - use access_ok() instead */
-extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
+static inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
@@ -220,7 +220,7 @@
 extern unsigned long __copy_user_zeroing(void *to, const void *from, unsigned long n);
 extern unsigned long __do_clear_user(void *to, unsigned long n);
 
-extern inline unsigned long
+static inline unsigned long
 __generic_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	if (access_ok(VERIFY_WRITE, to, n))
@@ -228,7 +228,7 @@
 	return n;
 }
 
-extern inline unsigned long
+static inline unsigned long
 __generic_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	if (access_ok(VERIFY_READ, from, n))
@@ -236,7 +236,7 @@
 	return n;
 }
 
-extern inline unsigned long
+static inline unsigned long
 __generic_clear_user(void __user *to, unsigned long n)
 {
 	if (access_ok(VERIFY_WRITE, to, n))
@@ -244,13 +244,13 @@
 	return n;
 }
 
-extern inline long
+static inline long
 __strncpy_from_user(char *dst, const char __user *src, long count)
 {
 	return __do_strncpy_from_user(dst, src, count);
 }
 
-extern inline long
+static inline long
 strncpy_from_user(char *dst, const char __user *src, long count)
 {
 	long res = -EFAULT;
@@ -263,7 +263,7 @@
 /* Note that if these expand awfully if made into switch constructs, so
    don't do that.  */
 
-extern inline unsigned long
+static inline unsigned long
 __constant_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long ret = 0;
@@ -313,7 +313,7 @@
 
 /* Ditto, don't make a switch out of this.  */
 
-extern inline unsigned long
+static inline unsigned long
 __constant_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	unsigned long ret = 0;
@@ -363,7 +363,7 @@
 
 /* No switch, please.  */
 
-extern inline unsigned long
+static inline unsigned long
 __constant_clear_user(void __user *to, unsigned long n)
 {
 	unsigned long ret = 0;
@@ -413,19 +413,19 @@
  * used in fast paths and have only a small space overhead.
  */
 
-extern inline unsigned long
+static inline unsigned long
 __generic_copy_from_user_nocheck(void *to, const void *from, unsigned long n)
 {
 	return __copy_user_zeroing(to,from,n);
 }
 
-extern inline unsigned long
+static inline unsigned long
 __generic_copy_to_user_nocheck(void *to, const void *from, unsigned long n)
 {
 	return __copy_user(to,from,n);
 }
 
-extern inline unsigned long
+static inline unsigned long
 __generic_clear_user_nocheck(void *to, unsigned long n)
 {
 	return __do_clear_user(to,n);
--- linux-2.6.13-rc6-mm1-full/include/asm-cris/unistd.h.old	2005-08-22 01:49:10.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-cris/unistd.h	2005-08-22 01:50:37.000000000 +0200
@@ -343,14 +343,14 @@
  * some others too.
  */
 #define __NR__exit __NR_exit
-extern inline _syscall0(pid_t,setsid)
-extern inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
-extern inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
-extern inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
-extern inline _syscall1(int,dup,int,fd)
-extern inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
-extern inline _syscall3(int,open,const char *,file,int,flag,int,mode)
-extern inline _syscall1(int,close,int,fd)
+static inline _syscall0(pid_t,setsid)
+static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
+static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
+static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
+static inline _syscall1(int,dup,int,fd)
+static inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
+static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
+static inline _syscall1(int,close,int,fd)
 
 struct pt_regs;
 asmlinkage long sys_mmap2(
@@ -383,8 +383,8 @@
 #ifdef __KERNEL__
 #define _exit kernel_syscall_exit
 #endif
-extern inline _syscall1(int,_exit,int,exitcode)
-extern inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
+static inline _syscall1(int,_exit,int,exitcode)
+static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
 #endif
 
 


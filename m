Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWF2UcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWF2UcY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWF2UcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:32:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932422AbWF2UcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:32:22 -0400
Subject: [patch] make more file_operation structs static
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Date: Thu, 29 Jun 2006 22:32:18 +0200
Message-Id: <1151613138.3122.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch marks the static struct file_operations in drivers/char as
const. Making them const prevents accidental bugs, and moves them to
the .rodata section so that they no longer do any false sharing; in
addition with the proper debug option they are then protected against
corruption..


Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 drivers/char/agp/frontend.c             |    2 +-
 drivers/char/applicom.c                 |    2 +-
 drivers/char/cs5535_gpio.c              |    2 +-
 drivers/char/ds1286.c                   |    2 +-
 drivers/char/ds1302.c                   |    2 +-
 drivers/char/ds1620.c                   |    2 +-
 drivers/char/dsp56k.c                   |    2 +-
 drivers/char/dtlk.c                     |    2 +-
 drivers/char/efirtc.c                   |    2 +-
 drivers/char/ftape/zftape/zftape-init.c |    2 +-
 drivers/char/generic_nvram.c            |    2 +-
 drivers/char/genrtc.c                   |    2 +-
 drivers/char/hpet.c                     |    2 +-
 drivers/char/hw_random/core.c           |    2 +-
 drivers/char/i8k.c                      |    2 +-
 drivers/char/ip2/ip2main.c              |    2 +-
 drivers/char/ip27-rtc.c                 |    2 +-
 drivers/char/ipmi/ipmi_devintf.c        |    2 +-
 drivers/char/ipmi/ipmi_watchdog.c       |    2 +-
 drivers/char/istallion.c                |    2 +-
 drivers/char/ite_gpio.c                 |    2 +-
 drivers/char/lcd.c                      |    2 +-
 drivers/char/lp.c                       |    2 +-
 drivers/char/mbcs.c                     |    2 +-
 drivers/char/mem.c                      |   18 +++++++++---------
 drivers/char/misc.c                     |    4 ++--
 drivers/char/mmtimer.c                  |    2 +-
 drivers/char/mwave/mwavedd.c            |    2 +-
 drivers/char/nvram.c                    |    2 +-
 drivers/char/nwbutton.c                 |    2 +-
 drivers/char/nwflash.c                  |    2 +-
 drivers/char/pc8736x_gpio.c             |    2 +-
 drivers/char/pcmcia/cm4000_cs.c         |    2 +-
 drivers/char/pcmcia/cm4040_cs.c         |    2 +-
 drivers/char/ppdev.c                    |    2 +-
 drivers/char/qtronix.c                  |    2 +-
 drivers/char/raw.c                      |    4 ++--
 drivers/char/rio/rio_linux.c            |    2 +-
 drivers/char/rtc.c                      |    4 ++--
 drivers/char/scx200_gpio.c              |    2 +-
 drivers/char/snsc.c                     |    2 +-
 drivers/char/sonypi.c                   |    2 +-
 drivers/char/stallion.c                 |    2 +-
 drivers/char/sx.c                       |    2 +-
 drivers/char/tb0219.c                   |    2 +-
 drivers/char/tipar.c                    |    2 +-
 drivers/char/tlclk.c                    |    2 +-
 drivers/char/toshiba.c                  |    2 +-
 drivers/char/tpm/tpm_atmel.c            |    2 +-
 drivers/char/tpm/tpm_bios.c             |    4 ++--
 drivers/char/tpm/tpm_infineon.c         |    2 +-
 drivers/char/tpm/tpm_nsc.c              |    2 +-
 drivers/char/tpm/tpm_tis.c              |    2 +-
 drivers/char/tty_io.c                   |    8 ++++----
 drivers/char/vc_screen.c                |    2 +-
 drivers/char/viotape.c                  |    4 ++--
 drivers/char/vr41xx_giu.c               |    2 +-
 drivers/char/watchdog/acquirewdt.c      |    2 +-
 drivers/char/watchdog/advantechwdt.c    |    2 +-
 drivers/char/watchdog/alim1535_wdt.c    |    2 +-
 drivers/char/watchdog/alim7101_wdt.c    |    2 +-
 drivers/char/watchdog/at91_wdt.c        |    2 +-
 drivers/char/watchdog/booke_wdt.c       |    2 +-
 drivers/char/watchdog/cpu5wdt.c         |    2 +-
 drivers/char/watchdog/ep93xx_wdt.c      |    2 +-
 drivers/char/watchdog/eurotechwdt.c     |    2 +-
 drivers/char/watchdog/i6300esb.c        |    2 +-
 drivers/char/watchdog/i8xx_tco.c        |    2 +-
 drivers/char/watchdog/ib700wdt.c        |    2 +-
 drivers/char/watchdog/ibmasr.c          |    2 +-
 drivers/char/watchdog/indydog.c         |    2 +-
 drivers/char/watchdog/ixp2000_wdt.c     |    2 +-
 drivers/char/watchdog/ixp4xx_wdt.c      |    2 +-
 drivers/char/watchdog/machzwd.c         |    2 +-
 drivers/char/watchdog/mixcomwd.c        |    2 +-
 drivers/char/watchdog/mpc83xx_wdt.c     |    2 +-
 drivers/char/watchdog/mpc8xx_wdt.c      |    2 +-
 drivers/char/watchdog/mpcore_wdt.c      |    2 +-
 drivers/char/watchdog/mv64x60_wdt.c     |    2 +-
 drivers/char/watchdog/pcwd.c            |    4 ++--
 drivers/char/watchdog/pcwd_pci.c        |    4 ++--
 drivers/char/watchdog/pcwd_usb.c        |    4 ++--
 drivers/char/watchdog/s3c2410_wdt.c     |    2 +-
 drivers/char/watchdog/sa1100_wdt.c      |    2 +-
 drivers/char/watchdog/sbc60xxwdt.c      |    2 +-
 drivers/char/watchdog/sbc8360.c         |    2 +-
 drivers/char/watchdog/sbc_epx_c3.c      |    2 +-
 drivers/char/watchdog/sc1200wdt.c       |    2 +-
 drivers/char/watchdog/sc520_wdt.c       |    2 +-
 drivers/char/watchdog/scx200_wdt.c      |    2 +-
 drivers/char/watchdog/shwdt.c           |    2 +-
 drivers/char/watchdog/softdog.c         |    2 +-
 drivers/char/watchdog/w83627hf_wdt.c    |    2 +-
 drivers/char/watchdog/w83877f_wdt.c     |    2 +-
 drivers/char/watchdog/w83977f_wdt.c     |    2 +-
 drivers/char/watchdog/wafer5823wdt.c    |    2 +-
 drivers/char/watchdog/wdrtas.c          |    4 ++--
 drivers/char/watchdog/wdt.c             |    4 ++--
 drivers/char/watchdog/wdt285.c          |    2 +-
 drivers/char/watchdog/wdt977.c          |    2 +-
 drivers/char/watchdog/wdt_pci.c         |    4 ++--
 101 files changed, 123 insertions(+), 123 deletions(-)

Index: linux-2.6.17-mm4/drivers/char/agp/frontend.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/agp/frontend.c
+++ linux-2.6.17-mm4/drivers/char/agp/frontend.c
@@ -1059,7 +1059,7 @@ ioctl_out:
 	return ret_val;
 }
 
-static struct file_operations agp_fops =
+static const struct file_operations agp_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6.17-mm4/drivers/char/applicom.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/applicom.c
+++ linux-2.6.17-mm4/drivers/char/applicom.c
@@ -112,7 +112,7 @@ static int ac_ioctl(struct inode *, stru
 		    unsigned long);
 static irqreturn_t ac_interrupt(int, void *, struct pt_regs *);
 
-static struct file_operations ac_fops = {
+static const struct file_operations ac_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.read = ac_read,
Index: linux-2.6.17-mm4/drivers/char/cs5535_gpio.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/cs5535_gpio.c
+++ linux-2.6.17-mm4/drivers/char/cs5535_gpio.c
@@ -158,7 +158,7 @@ static int cs5535_gpio_open(struct inode
 	return nonseekable_open(inode, file);
 }
 
-static struct file_operations cs5535_gpio_fops = {
+static const struct file_operations cs5535_gpio_fops = {
 	.owner	= THIS_MODULE,
 	.write	= cs5535_gpio_write,
 	.read	= cs5535_gpio_read,
Index: linux-2.6.17-mm4/drivers/char/ds1286.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/ds1286.c
+++ linux-2.6.17-mm4/drivers/char/ds1286.c
@@ -281,7 +281,7 @@ static unsigned int ds1286_poll(struct f
  *	The various file operations we support.
  */
 
-static struct file_operations ds1286_fops = {
+static const struct file_operations ds1286_fops = {
 	.llseek		= no_llseek,
 	.read		= ds1286_read,
 	.poll		= ds1286_poll,
Index: linux-2.6.17-mm4/drivers/char/ds1302.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/ds1302.c
+++ linux-2.6.17-mm4/drivers/char/ds1302.c
@@ -283,7 +283,7 @@ get_rtc_status(char *buf)
 
 /* The various file operations we support. */
 
-static struct file_operations rtc_fops = {
+static const struct file_operations rtc_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= rtc_ioctl,
 };
Index: linux-2.6.17-mm4/drivers/char/ds1620.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/ds1620.c
+++ linux-2.6.17-mm4/drivers/char/ds1620.c
@@ -337,7 +337,7 @@ proc_therm_ds1620_read(char *buf, char *
 static struct proc_dir_entry *proc_therm_ds1620;
 #endif
 
-static struct file_operations ds1620_fops = {
+static const struct file_operations ds1620_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nonseekable_open,
 	.read		= ds1620_read,
Index: linux-2.6.17-mm4/drivers/char/dsp56k.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/dsp56k.c
+++ linux-2.6.17-mm4/drivers/char/dsp56k.c
@@ -484,7 +484,7 @@ static int dsp56k_release(struct inode *
 	return 0;
 }
 
-static struct file_operations dsp56k_fops = {
+static const struct file_operations dsp56k_fops = {
 	.owner		= THIS_MODULE,
 	.read		= dsp56k_read,
 	.write		= dsp56k_write,
Index: linux-2.6.17-mm4/drivers/char/dtlk.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/dtlk.c
+++ linux-2.6.17-mm4/drivers/char/dtlk.c
@@ -95,7 +95,7 @@ static int dtlk_release(struct inode *, 
 static int dtlk_ioctl(struct inode *inode, struct file *file,
 		      unsigned int cmd, unsigned long arg);
 
-static struct file_operations dtlk_fops =
+static const struct file_operations dtlk_fops =
 {
 	.owner		= THIS_MODULE,
 	.read		= dtlk_read,
Index: linux-2.6.17-mm4/drivers/char/efirtc.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/efirtc.c
+++ linux-2.6.17-mm4/drivers/char/efirtc.c
@@ -285,7 +285,7 @@ efi_rtc_close(struct inode *inode, struc
  *	The various file operations we support.
  */
 
-static struct file_operations efi_rtc_fops = {
+static const struct file_operations efi_rtc_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= efi_rtc_ioctl,
 	.open		= efi_rtc_open,
Index: linux-2.6.17-mm4/drivers/char/ftape/zftape/zftape-init.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/ftape/zftape/zftape-init.c
+++ linux-2.6.17-mm4/drivers/char/ftape/zftape/zftape-init.c
@@ -88,7 +88,7 @@ static ssize_t zft_read (struct file *fp
 static ssize_t zft_write(struct file *fp, const char __user *buff,
 			 size_t req_len, loff_t *ppos);
 
-static struct file_operations zft_cdev =
+static const struct file_operations zft_cdev =
 {
 	.owner		= THIS_MODULE,
 	.read		= zft_read,
Index: linux-2.6.17-mm4/drivers/char/genrtc.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/genrtc.c
+++ linux-2.6.17-mm4/drivers/char/genrtc.c
@@ -483,7 +483,7 @@ static inline int gen_rtc_proc_init(void
  *	The various file operations we support.
  */
 
-static struct file_operations gen_rtc_fops = {
+static const struct file_operations gen_rtc_fops = {
 	.owner		= THIS_MODULE,
 #ifdef CONFIG_GEN_RTC_X
 	.read		= gen_rtc_read,
Index: linux-2.6.17-mm4/drivers/char/hpet.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/hpet.c
+++ linux-2.6.17-mm4/drivers/char/hpet.c
@@ -554,7 +554,7 @@ hpet_ioctl_common(struct hpet_dev *devp,
 	return err;
 }
 
-static struct file_operations hpet_fops = {
+static const struct file_operations hpet_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.read = hpet_read,
Index: linux-2.6.17-mm4/drivers/char/hw_random/core.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/hw_random/core.c
+++ linux-2.6.17-mm4/drivers/char/hw_random/core.c
@@ -149,7 +149,7 @@ out:
 }
 
 
-static struct file_operations rng_chrdev_ops = {
+static const struct file_operations rng_chrdev_ops = {
 	.owner		= THIS_MODULE,
 	.open		= rng_dev_open,
 	.read		= rng_dev_read,
Index: linux-2.6.17-mm4/drivers/char/i8k.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/i8k.c
+++ linux-2.6.17-mm4/drivers/char/i8k.c
@@ -80,7 +80,7 @@ static int i8k_open_fs(struct inode *ino
 static int i8k_ioctl(struct inode *, struct file *, unsigned int,
 		     unsigned long);
 
-static struct file_operations i8k_fops = {
+static const struct file_operations i8k_fops = {
 	.open		= i8k_open_fs,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6.17-mm4/drivers/char/ip2/ip2main.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/ip2/ip2main.c
+++ linux-2.6.17-mm4/drivers/char/ip2/ip2main.c
@@ -235,7 +235,7 @@ static void  *DevTableMem[IP2_MAX_BOARDS
 /* This is the driver descriptor for the ip2ipl device, which is used to
  * download the loadware to the boards.
  */
-static struct file_operations ip2_ipl = {
+static const struct file_operations ip2_ipl = {
 	.owner		= THIS_MODULE,
 	.read		= ip2_ipl_read,
 	.write		= ip2_ipl_write,
Index: linux-2.6.17-mm4/drivers/char/ip27-rtc.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/ip27-rtc.c
+++ linux-2.6.17-mm4/drivers/char/ip27-rtc.c
@@ -196,7 +196,7 @@ static int rtc_release(struct inode *ino
  *	The various file operations we support.
  */
 
-static struct file_operations rtc_fops = {
+static const struct file_operations rtc_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= rtc_ioctl,
 	.open		= rtc_open,
Index: linux-2.6.17-mm4/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.17-mm4/drivers/char/ipmi/ipmi_devintf.c
@@ -767,7 +767,7 @@ static long compat_ipmi_ioctl(struct fil
 }
 #endif
 
-static struct file_operations ipmi_fops = {
+static const struct file_operations ipmi_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= ipmi_ioctl,
 #ifdef CONFIG_COMPAT
Index: linux-2.6.17-mm4/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.17-mm4/drivers/char/ipmi/ipmi_watchdog.c
@@ -808,7 +808,7 @@ static int ipmi_close(struct inode *ino,
 	return 0;
 }
 
-static struct file_operations ipmi_wdog_fops = {
+static const struct file_operations ipmi_wdog_fops = {
 	.owner   = THIS_MODULE,
 	.read    = ipmi_read,
 	.poll    = ipmi_poll,
Index: linux-2.6.17-mm4/drivers/char/istallion.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/istallion.c
+++ linux-2.6.17-mm4/drivers/char/istallion.c
@@ -759,7 +759,7 @@ static int	stli_initpcibrd(int brdtype, 
  *	will give access to the shared memory on the Stallion intelligent
  *	board. This is also a very useful debugging tool.
  */
-static struct file_operations	stli_fsiomem = {
+static const struct file_operations	stli_fsiomem = {
 	.owner		= THIS_MODULE,
 	.read		= stli_memread,
 	.write		= stli_memwrite,
Index: linux-2.6.17-mm4/drivers/char/ite_gpio.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/ite_gpio.c
+++ linux-2.6.17-mm4/drivers/char/ite_gpio.c
@@ -357,7 +357,7 @@ DEB(printk("interrupt 0x%x %d\n",ITE_GPA
 	}
 }
 
-static struct file_operations ite_gpio_fops = {
+static const struct file_operations ite_gpio_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= ite_gpio_ioctl,
 	.open		= ite_gpio_open,
Index: linux-2.6.17-mm4/drivers/char/lcd.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/lcd.c
+++ linux-2.6.17-mm4/drivers/char/lcd.c
@@ -599,7 +599,7 @@ static ssize_t lcd_read(struct file *fil
  *	The various file operations we support.
  */
 
-static struct file_operations lcd_fops = {
+static const struct file_operations lcd_fops = {
 	.read = lcd_read,
 	.ioctl = lcd_ioctl,
 	.open = lcd_open,
Index: linux-2.6.17-mm4/drivers/char/lp.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/lp.c
+++ linux-2.6.17-mm4/drivers/char/lp.c
@@ -668,7 +668,7 @@ static int lp_ioctl(struct inode *inode,
 	return retval;
 }
 
-static struct file_operations lp_fops = {
+static const struct file_operations lp_fops = {
 	.owner		= THIS_MODULE,
 	.write		= lp_write,
 	.ioctl		= lp_ioctl,
Index: linux-2.6.17-mm4/drivers/char/mem.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/mem.c
+++ linux-2.6.17-mm4/drivers/char/mem.c
@@ -778,7 +778,7 @@ static int open_port(struct inode * inod
 #define open_kmem	open_mem
 #define open_oldmem	open_mem
 
-static struct file_operations mem_fops = {
+static const struct file_operations mem_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_mem,
 	.write		= write_mem,
@@ -786,7 +786,7 @@ static struct file_operations mem_fops =
 	.open		= open_mem,
 };
 
-static struct file_operations kmem_fops = {
+static const struct file_operations kmem_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_kmem,
 	.write		= write_kmem,
@@ -794,7 +794,7 @@ static struct file_operations kmem_fops 
 	.open		= open_kmem,
 };
 
-static struct file_operations null_fops = {
+static const struct file_operations null_fops = {
 	.llseek		= null_lseek,
 	.read		= read_null,
 	.write		= write_null,
@@ -802,7 +802,7 @@ static struct file_operations null_fops 
 };
 
 #if defined(CONFIG_ISA) || !defined(__mc68000__)
-static struct file_operations port_fops = {
+static const struct file_operations port_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_port,
 	.write		= write_port,
@@ -810,7 +810,7 @@ static struct file_operations port_fops 
 };
 #endif
 
-static struct file_operations zero_fops = {
+static const struct file_operations zero_fops = {
 	.llseek		= zero_lseek,
 	.read		= read_zero,
 	.write		= write_zero,
@@ -821,14 +821,14 @@ static struct backing_dev_info zero_bdi 
 	.capabilities	= BDI_CAP_MAP_COPY,
 };
 
-static struct file_operations full_fops = {
+static const struct file_operations full_fops = {
 	.llseek		= full_lseek,
 	.read		= read_full,
 	.write		= write_full,
 };
 
 #ifdef CONFIG_CRASH_DUMP
-static struct file_operations oldmem_fops = {
+static const struct file_operations oldmem_fops = {
 	.read	= read_oldmem,
 	.open	= open_oldmem,
 };
@@ -855,7 +855,7 @@ static ssize_t kmsg_write(struct file * 
 	return ret;
 }
 
-static struct file_operations kmsg_fops = {
+static const struct file_operations kmsg_fops = {
 	.write =	kmsg_write,
 };
 
@@ -905,7 +905,7 @@ static int memory_open(struct inode * in
 	return 0;
 }
 
-static struct file_operations memory_fops = {
+static const struct file_operations memory_fops = {
 	.open		= memory_open,	/* just a selector for the real open */
 };
 
Index: linux-2.6.17-mm4/drivers/char/misc.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/misc.c
+++ linux-2.6.17-mm4/drivers/char/misc.c
@@ -115,7 +115,7 @@ static int misc_seq_open(struct inode *i
 	return seq_open(file, &misc_seq_ops);
 }
 
-static struct file_operations misc_proc_fops = {
+static const struct file_operations misc_proc_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = misc_seq_open,
 	.read    = seq_read,
@@ -178,7 +178,7 @@ fail:
  */
 static struct class *misc_class;
 
-static struct file_operations misc_fops = {
+static const struct file_operations misc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= misc_open,
 };
Index: linux-2.6.17-mm4/drivers/char/mmtimer.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/mmtimer.c
+++ linux-2.6.17-mm4/drivers/char/mmtimer.c
@@ -64,7 +64,7 @@ static int mmtimer_mmap(struct file *fil
  */
 static unsigned long mmtimer_femtoperiod = 0;
 
-static struct file_operations mmtimer_fops = {
+static const struct file_operations mmtimer_fops = {
 	.owner =	THIS_MODULE,
 	.mmap =		mmtimer_mmap,
 	.ioctl =	mmtimer_ioctl,
Index: linux-2.6.17-mm4/drivers/char/mwave/mwavedd.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/mwave/mwavedd.c
+++ linux-2.6.17-mm4/drivers/char/mwave/mwavedd.c
@@ -454,7 +454,7 @@ static int register_serial_portandirq(un
 }
 
 
-static struct file_operations mwave_fops = {
+static const struct file_operations mwave_fops = {
 	.owner		= THIS_MODULE,
 	.read		= mwave_read,
 	.write		= mwave_write,
Index: linux-2.6.17-mm4/drivers/char/nvram.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/nvram.c
+++ linux-2.6.17-mm4/drivers/char/nvram.c
@@ -438,7 +438,7 @@ nvram_read_proc(char *buffer, char **sta
 
 #endif /* CONFIG_PROC_FS */
 
-static struct file_operations nvram_fops = {
+static const struct file_operations nvram_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= nvram_llseek,
 	.read		= nvram_read,
Index: linux-2.6.17-mm4/drivers/char/nwbutton.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/nwbutton.c
+++ linux-2.6.17-mm4/drivers/char/nwbutton.c
@@ -184,7 +184,7 @@ static int button_read (struct file *fil
  * attempts to perform these operations on the device.
  */
 
-static struct file_operations button_fops = {
+static const struct file_operations button_fops = {
 	.owner		= THIS_MODULE,
 	.read		= button_read,
 };
Index: linux-2.6.17-mm4/drivers/char/nwflash.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/nwflash.c
+++ linux-2.6.17-mm4/drivers/char/nwflash.c
@@ -642,7 +642,7 @@ static void kick_open(void)
 	udelay(25);
 }
 
-static struct file_operations flash_fops =
+static const struct file_operations flash_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= flash_llseek,
Index: linux-2.6.17-mm4/drivers/char/pc8736x_gpio.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/pc8736x_gpio.c
+++ linux-2.6.17-mm4/drivers/char/pc8736x_gpio.c
@@ -236,7 +236,7 @@ static int pc8736x_gpio_open(struct inod
 	return nonseekable_open(inode, file);
 }
 
-static struct file_operations pc8736x_gpio_fops = {
+static const struct file_operations pc8736x_gpio_fops = {
 	.owner	= THIS_MODULE,
 	.open	= pc8736x_gpio_open,
 	.write	= nsc_gpio_write,
Index: linux-2.6.17-mm4/drivers/char/pcmcia/cm4000_cs.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/pcmcia/cm4000_cs.c
+++ linux-2.6.17-mm4/drivers/char/pcmcia/cm4000_cs.c
@@ -1918,7 +1918,7 @@ static void cm4000_detach(struct pcmcia_
 	return;
 }
 
-static struct file_operations cm4000_fops = {
+static const struct file_operations cm4000_fops = {
 	.owner	= THIS_MODULE,
 	.read	= cmm_read,
 	.write	= cmm_write,
Index: linux-2.6.17-mm4/drivers/char/pcmcia/cm4040_cs.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/pcmcia/cm4040_cs.c
+++ linux-2.6.17-mm4/drivers/char/pcmcia/cm4040_cs.c
@@ -668,7 +668,7 @@ static void reader_detach(struct pcmcia_
 	return;
 }
 
-static struct file_operations reader_fops = {
+static const struct file_operations reader_fops = {
 	.owner		= THIS_MODULE,
 	.read		= cm4040_read,
 	.write		= cm4040_write,
Index: linux-2.6.17-mm4/drivers/char/ppdev.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/ppdev.c
+++ linux-2.6.17-mm4/drivers/char/ppdev.c
@@ -740,7 +740,7 @@ static unsigned int pp_poll (struct file
 
 static struct class *ppdev_class;
 
-static struct file_operations pp_fops = {
+static const struct file_operations pp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= pp_read,
Index: linux-2.6.17-mm4/drivers/char/raw.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/raw.c
+++ linux-2.6.17-mm4/drivers/char/raw.c
@@ -262,7 +262,7 @@ static ssize_t raw_file_aio_write(struct
 }
 
 
-static struct file_operations raw_fops = {
+static const struct file_operations raw_fops = {
 	.read	=	generic_file_read,
 	.aio_read = 	generic_file_aio_read,
 	.write	=	raw_file_write,
@@ -275,7 +275,7 @@ static struct file_operations raw_fops =
 	.owner	=	THIS_MODULE,
 };
 
-static struct file_operations raw_ctl_fops = {
+static const struct file_operations raw_ctl_fops = {
 	.ioctl	=	raw_ctl_ioctl,
 	.open	=	raw_open,
 	.owner	=	THIS_MODULE,
Index: linux-2.6.17-mm4/drivers/char/rio/rio_linux.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/rio/rio_linux.c
+++ linux-2.6.17-mm4/drivers/char/rio/rio_linux.c
@@ -244,7 +244,7 @@ static struct real_driver rio_real_drive
  *
  */
 
-static struct file_operations rio_fw_fops = {
+static const struct file_operations rio_fw_fops = {
 	.owner = THIS_MODULE,
 	.ioctl = rio_fw_ioctl,
 };
Index: linux-2.6.17-mm4/drivers/char/rtc.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/rtc.c
+++ linux-2.6.17-mm4/drivers/char/rtc.c
@@ -878,7 +878,7 @@ int rtc_control(rtc_task_t *task, unsign
  *	The various file operations we support.
  */
 
-static struct file_operations rtc_fops = {
+static const struct file_operations rtc_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= rtc_read,
@@ -897,7 +897,7 @@ static struct miscdevice rtc_dev = {
 	.fops		= &rtc_fops,
 };
 
-static struct file_operations rtc_proc_fops = {
+static const struct file_operations rtc_proc_fops = {
 	.owner = THIS_MODULE,
 	.open = rtc_proc_open,
 	.read  = seq_read,
Index: linux-2.6.17-mm4/drivers/char/scx200_gpio.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/scx200_gpio.c
+++ linux-2.6.17-mm4/drivers/char/scx200_gpio.c
@@ -63,7 +63,7 @@ static int scx200_gpio_release(struct in
 }
 
 
-static struct file_operations scx200_gpio_fops = {
+static const struct file_operations scx200_gpio_fops = {
 	.owner   = THIS_MODULE,
 	.write   = nsc_gpio_write,
 	.read    = nsc_gpio_read,
Index: linux-2.6.17-mm4/drivers/char/snsc.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/snsc.c
+++ linux-2.6.17-mm4/drivers/char/snsc.c
@@ -347,7 +347,7 @@ scdrv_poll(struct file *file, struct pol
 	return mask;
 }
 
-static struct file_operations scdrv_fops = {
+static const struct file_operations scdrv_fops = {
 	.owner =	THIS_MODULE,
 	.read =		scdrv_read,
 	.write =	scdrv_write,
Index: linux-2.6.17-mm4/drivers/char/sonypi.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/sonypi.c
+++ linux-2.6.17-mm4/drivers/char/sonypi.c
@@ -1107,7 +1107,7 @@ static int sonypi_misc_ioctl(struct inod
 	return ret;
 }
 
-static struct file_operations sonypi_misc_fops = {
+static const struct file_operations sonypi_misc_fops = {
 	.owner		= THIS_MODULE,
 	.read		= sonypi_misc_read,
 	.poll		= sonypi_misc_poll,
Index: linux-2.6.17-mm4/drivers/char/stallion.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/stallion.c
+++ linux-2.6.17-mm4/drivers/char/stallion.c
@@ -709,7 +709,7 @@ static unsigned int	sc26198_baudtable[] 
  *	Define the driver info for a user level control device. Used mainly
  *	to get at port stats - only not using the port device itself.
  */
-static struct file_operations	stl_fsiomem = {
+static const struct file_operations	stl_fsiomem = {
 	.owner		= THIS_MODULE,
 	.ioctl		= stl_memioctl,
 };
Index: linux-2.6.17-mm4/drivers/char/sx.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/sx.c
+++ linux-2.6.17-mm4/drivers/char/sx.c
@@ -410,7 +410,7 @@ static struct real_driver sx_real_driver
  *
  */
 
-static struct file_operations sx_fw_fops = {
+static const struct file_operations sx_fw_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= sx_fw_ioctl,
 };
Index: linux-2.6.17-mm4/drivers/char/tb0219.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/tb0219.c
+++ linux-2.6.17-mm4/drivers/char/tb0219.c
@@ -255,7 +255,7 @@ static int tanbac_tb0219_release(struct 
 	return 0;
 }
 
-static struct file_operations tb0219_fops = {
+static const struct file_operations tb0219_fops = {
 	.owner		= THIS_MODULE,
 	.read		= tanbac_tb0219_read,
 	.write		= tanbac_tb0219_write,
Index: linux-2.6.17-mm4/drivers/char/tipar.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/tipar.c
+++ linux-2.6.17-mm4/drivers/char/tipar.c
@@ -383,7 +383,7 @@ tipar_ioctl(struct inode *inode, struct 
 
 /* ----- kernel module registering ------------------------------------ */
 
-static struct file_operations tipar_fops = {
+static const struct file_operations tipar_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.read = tipar_read,
Index: linux-2.6.17-mm4/drivers/char/tlclk.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/tlclk.c
+++ linux-2.6.17-mm4/drivers/char/tlclk.c
@@ -248,7 +248,7 @@ static ssize_t tlclk_write(struct file *
 	return 0;
 }
 
-static struct file_operations tlclk_fops = {
+static const struct file_operations tlclk_fops = {
 	.read = tlclk_read,
 	.write = tlclk_write,
 	.open = tlclk_open,
Index: linux-2.6.17-mm4/drivers/char/toshiba.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/toshiba.c
+++ linux-2.6.17-mm4/drivers/char/toshiba.c
@@ -92,7 +92,7 @@ static int tosh_ioctl(struct inode *, st
 	unsigned long);
 
 
-static struct file_operations tosh_fops = {
+static const struct file_operations tosh_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= tosh_ioctl,
 };
Index: linux-2.6.17-mm4/drivers/char/tpm/tpm_atmel.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/tpm/tpm_atmel.c
+++ linux-2.6.17-mm4/drivers/char/tpm/tpm_atmel.c
@@ -116,7 +116,7 @@ static u8 tpm_atml_status(struct tpm_chi
 	return ioread8(chip->vendor.iobase + 1);
 }
 
-static struct file_operations atmel_ops = {
+static const struct file_operations atmel_ops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.open = tpm_open,
Index: linux-2.6.17-mm4/drivers/char/tpm/tpm_infineon.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/tpm/tpm_infineon.c
+++ linux-2.6.17-mm4/drivers/char/tpm/tpm_infineon.c
@@ -338,7 +338,7 @@ static struct attribute *inf_attrs[] = {
 
 static struct attribute_group inf_attr_grp = {.attrs = inf_attrs };
 
-static struct file_operations inf_ops = {
+static const struct file_operations inf_ops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.open = tpm_open,
Index: linux-2.6.17-mm4/drivers/char/tpm/tpm_nsc.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/tpm/tpm_nsc.c
+++ linux-2.6.17-mm4/drivers/char/tpm/tpm_nsc.c
@@ -226,7 +226,7 @@ static u8 tpm_nsc_status(struct tpm_chip
 	return inb(chip->vendor.base + NSC_STATUS);
 }
 
-static struct file_operations nsc_ops = {
+static const struct file_operations nsc_ops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.open = tpm_open,
Index: linux-2.6.17-mm4/drivers/char/tpm/tpm_tis.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/tpm/tpm_tis.c
+++ linux-2.6.17-mm4/drivers/char/tpm/tpm_tis.c
@@ -330,7 +330,7 @@ out_err:
 	return rc;
 }
 
-static struct file_operations tis_ops = {
+static const struct file_operations tis_ops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.open = tpm_open,
Index: linux-2.6.17-mm4/drivers/char/tty_io.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/tty_io.c
+++ linux-2.6.17-mm4/drivers/char/tty_io.c
@@ -914,7 +914,7 @@ static int hung_up_tty_ioctl(struct inod
 	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
 }
 
-static struct file_operations tty_fops = {
+static const struct file_operations tty_fops = {
 	.llseek		= no_llseek,
 	.read		= tty_read,
 	.write		= tty_write,
@@ -926,7 +926,7 @@ static struct file_operations tty_fops =
 };
 
 #ifdef CONFIG_UNIX98_PTYS
-static struct file_operations ptmx_fops = {
+static const struct file_operations ptmx_fops = {
 	.llseek		= no_llseek,
 	.read		= tty_read,
 	.write		= tty_write,
@@ -938,7 +938,7 @@ static struct file_operations ptmx_fops 
 };
 #endif
 
-static struct file_operations console_fops = {
+static const struct file_operations console_fops = {
 	.llseek		= no_llseek,
 	.read		= tty_read,
 	.write		= redirected_tty_write,
@@ -949,7 +949,7 @@ static struct file_operations console_fo
 	.fasync		= tty_fasync,
 };
 
-static struct file_operations hung_up_tty_fops = {
+static const struct file_operations hung_up_tty_fops = {
 	.llseek		= no_llseek,
 	.read		= hung_up_tty_read,
 	.write		= hung_up_tty_write,
Index: linux-2.6.17-mm4/drivers/char/vc_screen.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/vc_screen.c
+++ linux-2.6.17-mm4/drivers/char/vc_screen.c
@@ -467,7 +467,7 @@ vcs_open(struct inode *inode, struct fil
 	return 0;
 }
 
-static struct file_operations vcs_fops = {
+static const struct file_operations vcs_fops = {
 	.llseek		= vcs_lseek,
 	.read		= vcs_read,
 	.write		= vcs_write,
Index: linux-2.6.17-mm4/drivers/char/viotape.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/viotape.c
+++ linux-2.6.17-mm4/drivers/char/viotape.c
@@ -295,7 +295,7 @@ static int proc_viotape_open(struct inod
 	return single_open(file, proc_viotape_show, NULL);
 }
 
-static struct file_operations proc_viotape_operations = {
+static const struct file_operations proc_viotape_operations = {
 	.open		= proc_viotape_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6.17-mm4/drivers/char/vr41xx_giu.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/vr41xx_giu.c
+++ linux-2.6.17-mm4/drivers/char/vr41xx_giu.c
@@ -605,7 +605,7 @@ static int gpio_release(struct inode *in
 	return 0;
 }
 
-static struct file_operations gpio_fops = {
+static const struct file_operations gpio_fops = {
 	.owner		= THIS_MODULE,
 	.read		= gpio_read,
 	.write		= gpio_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/acquirewdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/acquirewdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/acquirewdt.c
@@ -231,7 +231,7 @@ static int acq_notify_sys(struct notifie
  *	Kernel Interfaces
  */
 
-static struct file_operations acq_fops = {
+static const struct file_operations acq_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= acq_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/advantechwdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/advantechwdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/advantechwdt.c
@@ -227,7 +227,7 @@ advwdt_notify_sys(struct notifier_block 
  *	Kernel Interfaces
  */
 
-static struct file_operations advwdt_fops = {
+static const struct file_operations advwdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= advwdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/alim1535_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/alim1535_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/alim1535_wdt.c
@@ -362,7 +362,7 @@ static int __init ali_find_watchdog(void
  *	Kernel Interfaces
  */
 
-static struct file_operations ali_fops = {
+static const struct file_operations ali_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.write =	ali_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/alim7101_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/alim7101_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/alim7101_wdt.c
@@ -281,7 +281,7 @@ static int fop_ioctl(struct inode *inode
 	}
 }
 
-static struct file_operations wdt_fops = {
+static const struct file_operations wdt_fops = {
 	.owner=		THIS_MODULE,
 	.llseek=	no_llseek,
 	.write=		fop_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/at91_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/at91_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/at91_wdt.c
@@ -184,7 +184,7 @@ static ssize_t at91_wdt_write(struct fil
 
 /* ......................................................................... */
 
-static struct file_operations at91wdt_fops = {
+static const struct file_operations at91wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.ioctl		= at91_wdt_ioctl,
Index: linux-2.6.17-mm4/drivers/char/watchdog/booke_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/booke_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/booke_wdt.c
@@ -146,7 +146,7 @@ static int booke_wdt_open (struct inode 
 	return 0;
 }
 
-static struct file_operations booke_wdt_fops = {
+static const struct file_operations booke_wdt_fops = {
   .owner = THIS_MODULE,
   .llseek = no_llseek,
   .write = booke_wdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/cpu5wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/cpu5wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/cpu5wdt.c
@@ -198,7 +198,7 @@ static ssize_t cpu5wdt_write(struct file
 	return count;
 }
 
-static struct file_operations cpu5wdt_fops = {
+static const struct file_operations cpu5wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.ioctl		= cpu5wdt_ioctl,
Index: linux-2.6.17-mm4/drivers/char/watchdog/ep93xx_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/ep93xx_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/ep93xx_wdt.c
@@ -187,7 +187,7 @@ static int ep93xx_wdt_release(struct ino
 	return 0;
 }
 
-static struct file_operations ep93xx_wdt_fops = {
+static const struct file_operations ep93xx_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.write		= ep93xx_wdt_write,
 	.ioctl		= ep93xx_wdt_ioctl,
Index: linux-2.6.17-mm4/drivers/char/watchdog/eurotechwdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/eurotechwdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/eurotechwdt.c
@@ -357,7 +357,7 @@ static int eurwdt_notify_sys(struct noti
  */
 
 
-static struct file_operations eurwdt_fops = {
+static const struct file_operations eurwdt_fops = {
 	.owner	= THIS_MODULE,
 	.llseek	= no_llseek,
 	.write	= eurwdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/i6300esb.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/i6300esb.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/i6300esb.c
@@ -337,7 +337,7 @@ static int esb_notify_sys (struct notifi
  *      Kernel Interfaces
  */
 
-static struct file_operations esb_fops = {
+static const struct file_operations esb_fops = {
         .owner =        THIS_MODULE,
         .llseek =       no_llseek,
         .write =        esb_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/i8xx_tco.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/i8xx_tco.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/i8xx_tco.c
@@ -378,7 +378,7 @@ static int i8xx_tco_notify_sys (struct n
  *	Kernel Interfaces
  */
 
-static struct file_operations i8xx_tco_fops = {
+static const struct file_operations i8xx_tco_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.write =	i8xx_tco_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/ib700wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/ib700wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/ib700wdt.c
@@ -256,7 +256,7 @@ ibwdt_notify_sys(struct notifier_block *
  *	Kernel Interfaces
  */
 
-static struct file_operations ibwdt_fops = {
+static const struct file_operations ibwdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= ibwdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/ibmasr.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/ibmasr.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/ibmasr.c
@@ -323,7 +323,7 @@ static int asr_release(struct inode *ino
 	return 0;
 }
 
-static struct file_operations asr_fops = {
+static const struct file_operations asr_fops = {
 	.owner =	THIS_MODULE,
 	.llseek	=	no_llseek,
 	.write =	asr_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/indydog.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/indydog.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/indydog.c
@@ -155,7 +155,7 @@ static int indydog_notify_sys(struct not
 	return NOTIFY_DONE;
 }
 
-static struct file_operations indydog_fops = {
+static const struct file_operations indydog_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= indydog_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/ixp2000_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/ixp2000_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/ixp2000_wdt.c
@@ -169,7 +169,7 @@ ixp2000_wdt_release(struct inode *inode,
 }
 
 
-static struct file_operations ixp2000_wdt_fops =
+static const struct file_operations ixp2000_wdt_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6.17-mm4/drivers/char/watchdog/ixp4xx_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/ixp4xx_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/ixp4xx_wdt.c
@@ -163,7 +163,7 @@ ixp4xx_wdt_release(struct inode *inode, 
 }
 
 
-static struct file_operations ixp4xx_wdt_fops =
+static const struct file_operations ixp4xx_wdt_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6.17-mm4/drivers/char/watchdog/machzwd.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/machzwd.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/machzwd.c
@@ -389,7 +389,7 @@ static int zf_notify_sys(struct notifier
 
 
 
-static struct file_operations zf_fops = {
+static const struct file_operations zf_fops = {
 	.owner          = THIS_MODULE,
 	.llseek         = no_llseek,
 	.write          = zf_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/mixcomwd.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/mixcomwd.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/mixcomwd.c
@@ -191,7 +191,7 @@ static int mixcomwd_ioctl(struct inode *
 	return 0;
 }
 
-static struct file_operations mixcomwd_fops=
+static const struct file_operations mixcomwd_fops=
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6.17-mm4/drivers/char/watchdog/mpc83xx_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/mpc83xx_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/mpc83xx_wdt.c
@@ -130,7 +130,7 @@ static int mpc83xx_wdt_ioctl(struct inod
 	}
 }
 
-static struct file_operations mpc83xx_wdt_fops = {
+static const struct file_operations mpc83xx_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= mpc83xx_wdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/mpc8xx_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/mpc8xx_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/mpc8xx_wdt.c
@@ -133,7 +133,7 @@ static int mpc8xx_wdt_ioctl(struct inode
 	return 0;
 }
 
-static struct file_operations mpc8xx_wdt_fops = {
+static const struct file_operations mpc8xx_wdt_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.write = mpc8xx_wdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/mpcore_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/mpcore_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/mpcore_wdt.c
@@ -298,7 +298,7 @@ static void mpcore_wdt_shutdown(struct p
 /*
  *	Kernel Interfaces
  */
-static struct file_operations mpcore_wdt_fops = {
+static const struct file_operations mpcore_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= mpcore_wdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/mv64x60_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/mv64x60_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/mv64x60_wdt.c
@@ -167,7 +167,7 @@ static int mv64x60_wdt_ioctl(struct inod
 	return 0;
 }
 
-static struct file_operations mv64x60_wdt_fops = {
+static const struct file_operations mv64x60_wdt_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.write = mv64x60_wdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/pcwd.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/pcwd.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/pcwd.c
@@ -740,7 +740,7 @@ static int pcwd_notify_sys(struct notifi
  *	Kernel Interfaces
  */
 
-static struct file_operations pcwd_fops = {
+static const struct file_operations pcwd_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= pcwd_write,
@@ -755,7 +755,7 @@ static struct miscdevice pcwd_miscdev = 
 	.fops =		&pcwd_fops,
 };
 
-static struct file_operations pcwd_temp_fops = {
+static const struct file_operations pcwd_temp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= pcwd_temp_read,
Index: linux-2.6.17-mm4/drivers/char/watchdog/pcwd_pci.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/pcwd_pci.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/pcwd_pci.c
@@ -625,7 +625,7 @@ static int pcipcwd_notify_sys(struct not
  *	Kernel Interfaces
  */
 
-static struct file_operations pcipcwd_fops = {
+static const struct file_operations pcipcwd_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.write =	pcipcwd_write,
@@ -640,7 +640,7 @@ static struct miscdevice pcipcwd_miscdev
 	.fops =		&pcipcwd_fops,
 };
 
-static struct file_operations pcipcwd_temp_fops = {
+static const struct file_operations pcipcwd_temp_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.read =		pcipcwd_temp_read,
Index: linux-2.6.17-mm4/drivers/char/watchdog/pcwd_usb.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/pcwd_usb.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/pcwd_usb.c
@@ -524,7 +524,7 @@ static int usb_pcwd_notify_sys(struct no
  *	Kernel Interfaces
  */
 
-static struct file_operations usb_pcwd_fops = {
+static const struct file_operations usb_pcwd_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.write =	usb_pcwd_write,
@@ -539,7 +539,7 @@ static struct miscdevice usb_pcwd_miscde
 	.fops =		&usb_pcwd_fops,
 };
 
-static struct file_operations usb_pcwd_temperature_fops = {
+static const struct file_operations usb_pcwd_temperature_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.read =		usb_pcwd_temperature_read,
Index: linux-2.6.17-mm4/drivers/char/watchdog/s3c2410_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/s3c2410_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/s3c2410_wdt.c
@@ -320,7 +320,7 @@ static int s3c2410wdt_ioctl(struct inode
 
 /* kernel interface */
 
-static struct file_operations s3c2410wdt_fops = {
+static const struct file_operations s3c2410wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= s3c2410wdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/sa1100_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/sa1100_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/sa1100_wdt.c
@@ -136,7 +136,7 @@ static int sa1100dog_ioctl(struct inode 
 	return ret;
 }
 
-static struct file_operations sa1100dog_fops =
+static const struct file_operations sa1100dog_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6.17-mm4/drivers/char/watchdog/sbc60xxwdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/sbc60xxwdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/sbc60xxwdt.c
@@ -282,7 +282,7 @@ static int fop_ioctl(struct inode *inode
 	}
 }
 
-static struct file_operations wdt_fops = {
+static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= fop_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/sbc8360.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/sbc8360.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/sbc8360.c
@@ -306,7 +306,7 @@ static int sbc8360_notify_sys(struct not
  *	Kernel Interfaces
  */
 
-static struct file_operations sbc8360_fops = {
+static const struct file_operations sbc8360_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.write = sbc8360_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/sbc_epx_c3.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/sbc_epx_c3.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/sbc_epx_c3.c
@@ -155,7 +155,7 @@ static int epx_c3_notify_sys(struct noti
 	return NOTIFY_DONE;
 }
 
-static struct file_operations epx_c3_fops = {
+static const struct file_operations epx_c3_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= epx_c3_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/sc1200wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/sc1200wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/sc1200wdt.c
@@ -293,7 +293,7 @@ static struct notifier_block sc1200wdt_n
 	.notifier_call =	sc1200wdt_notify_sys,
 };
 
-static struct file_operations sc1200wdt_fops =
+static const struct file_operations sc1200wdt_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6.17-mm4/drivers/char/watchdog/sc520_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/sc520_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/sc520_wdt.c
@@ -336,7 +336,7 @@ static int fop_ioctl(struct inode *inode
 	}
 }
 
-static struct file_operations wdt_fops = {
+static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= fop_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/scx200_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/scx200_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/scx200_wdt.c
@@ -195,7 +195,7 @@ static int scx200_wdt_ioctl(struct inode
 	}
 }
 
-static struct file_operations scx200_wdt_fops = {
+static const struct file_operations scx200_wdt_fops = {
 	.owner	 = THIS_MODULE,
 	.llseek	 = no_llseek,
 	.write   = scx200_wdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/shwdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/shwdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/shwdt.c
@@ -345,7 +345,7 @@ static int sh_wdt_notify_sys(struct noti
 	return NOTIFY_DONE;
 }
 
-static struct file_operations sh_wdt_fops = {
+static const struct file_operations sh_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= sh_wdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/softdog.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/softdog.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/softdog.c
@@ -244,7 +244,7 @@ static int softdog_notify_sys(struct not
  *	Kernel Interfaces
  */
 
-static struct file_operations softdog_fops = {
+static const struct file_operations softdog_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= softdog_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/w83627hf_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/w83627hf_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/w83627hf_wdt.c
@@ -274,7 +274,7 @@ wdt_notify_sys(struct notifier_block *th
  *	Kernel Interfaces
  */
 
-static struct file_operations wdt_fops = {
+static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= wdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/w83877f_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/w83877f_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/w83877f_wdt.c
@@ -299,7 +299,7 @@ static int fop_ioctl(struct inode *inode
 	}
 }
 
-static struct file_operations wdt_fops = {
+static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= fop_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/w83977f_wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/w83977f_wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/w83977f_wdt.c
@@ -450,7 +450,7 @@ static int wdt_notify_sys(struct notifie
 	return NOTIFY_DONE;
 }
 
-static struct file_operations wdt_fops=
+static const struct file_operations wdt_fops=
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6.17-mm4/drivers/char/watchdog/wafer5823wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/wafer5823wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/wafer5823wdt.c
@@ -222,7 +222,7 @@ static int wafwdt_notify_sys(struct noti
  *	Kernel Interfaces
  */
 
-static struct file_operations wafwdt_fops = {
+static const struct file_operations wafwdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= wafwdt_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/wdrtas.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/wdrtas.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/wdrtas.c
@@ -521,7 +521,7 @@ wdrtas_reboot(struct notifier_block *thi
 
 /*** initialization stuff */
 
-static struct file_operations wdrtas_fops = {
+static const struct file_operations wdrtas_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= wdrtas_write,
@@ -536,7 +536,7 @@ static struct miscdevice wdrtas_miscdev 
 	.fops =		&wdrtas_fops,
 };
 
-static struct file_operations wdrtas_temp_fops = {
+static const struct file_operations wdrtas_temp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= wdrtas_temp_read,
Index: linux-2.6.17-mm4/drivers/char/watchdog/wdt.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/wdt.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/wdt.c
@@ -495,7 +495,7 @@ static int wdt_notify_sys(struct notifie
  */
 
 
-static struct file_operations wdt_fops = {
+static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= wdt_write,
@@ -511,7 +511,7 @@ static struct miscdevice wdt_miscdev = {
 };
 
 #ifdef CONFIG_WDT_501
-static struct file_operations wdt_temp_fops = {
+static const struct file_operations wdt_temp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= wdt_temp_read,
Index: linux-2.6.17-mm4/drivers/char/watchdog/wdt285.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/wdt285.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/wdt285.c
@@ -178,7 +178,7 @@ watchdog_ioctl(struct inode *inode, stru
 	return ret;
 }
 
-static struct file_operations watchdog_fops = {
+static const struct file_operations watchdog_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= watchdog_write,
Index: linux-2.6.17-mm4/drivers/char/watchdog/wdt977.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/wdt977.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/wdt977.c
@@ -419,7 +419,7 @@ static int wdt977_notify_sys(struct noti
 	return NOTIFY_DONE;
 }
 
-static struct file_operations wdt977_fops=
+static const struct file_operations wdt977_fops=
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6.17-mm4/drivers/char/watchdog/wdt_pci.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/char/watchdog/wdt_pci.c
+++ linux-2.6.17-mm4/drivers/char/watchdog/wdt_pci.c
@@ -544,7 +544,7 @@ static int wdtpci_notify_sys(struct noti
  */
 
 
-static struct file_operations wdtpci_fops = {
+static const struct file_operations wdtpci_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= wdtpci_write,
@@ -560,7 +560,7 @@ static struct miscdevice wdtpci_miscdev 
 };
 
 #ifdef CONFIG_WDT_501_PCI
-static struct file_operations wdtpci_temp_fops = {
+static const struct file_operations wdtpci_temp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= wdtpci_temp_read,



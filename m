Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWCYKRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWCYKRK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 05:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWCYKRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 05:17:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16653 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751155AbWCYKRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 05:17:08 -0500
Date: Sat, 25 Mar 2006 11:17:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20060325101702.GA4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following:


Amos Waterland:
      The comment describing how MS_ASYNC works in msync.c is confusing

Andrzej Zaborowski:
      Fix simple typos

Baruch Even:
      rcu: undeclared variable used in documentation

Eric Sesterhenn:
      BUG_ON() Conversion in md/bitmap.c
      BUG_ON() Conversion in md/dm-hw-handler.c
      BUG_ON() Conversion in input/serio/hil_mlc.c
      BUG_ON() Conversion in fs/binfmt_elf_fdpic.c
      BUG_ON() Conversion in fs/coda/
      BUG_ON() Conversion in block/elevator.c
      BUG_ON() Conversion in ipc/msg.c
      BUG_ON() Conversion in kernel/cpu.c
      BUG_ON() Conversion in lib/swiotlb.c
      BUG_ON() Conversion in drivers/s390/block/dasd.c
      BUG_ON() Conversion in sound/sparc/cs4231.c
      BUG_ON() Conversion in drivers/block/
      BUG_ON() Conversion in drivers/parisc/
      BUG_ON() Conversion in drivers/video/

Jim Cromie:
      Re-alphabetize a couple MAINTANTER entries.
      tabify drivers/char/Makefile

Michael Owen:
      typo patch for fs/ufs/super.c

Uwe Zeisberger:
      fix typos "wich" -> "which"


 Documentation/RCU/whatisRCU.txt          |    4 -
 Documentation/arm/Booting                |    2 
 Documentation/arm/README                 |    2 
 Documentation/arm/Setup                  |    2 
 Documentation/filesystems/proc.txt       |    6 -
 Documentation/networking/packet_mmap.txt |   10 +-
 MAINTAINERS                              |   12 +--
 block/elevator.c                         |    3 
 drivers/acpi/Kconfig                     |    3 
 drivers/block/DAC960.c                   |    3 
 drivers/block/cciss.c                    |    3 
 drivers/block/cciss_scsi.c               |    2 
 drivers/block/cpqarray.c                 |    3 
 drivers/char/Makefile                    |   83 +++++++++++------------
 drivers/input/serio/hil_mlc.c            |    2 
 drivers/isdn/i4l/isdn_x25iface.c         |    2 
 drivers/md/bitmap.c                      |    2 
 drivers/md/dm-hw-handler.c               |    3 
 drivers/parisc/sba_iommu.c               |   10 --
 drivers/parisc/superio.c                 |    7 -
 drivers/s390/block/dasd.c                |   10 +-
 drivers/serial/mpc52xx_uart.c            |    2 
 drivers/usb/serial/option.c              |    2 
 drivers/video/bw2.c                      |    3 
 drivers/video/ffb.c                      |    3 
 drivers/video/sstfb.c                    |    2 
 drivers/w1/masters/matrox_w1.c           |    2 
 fs/befs/datastream.c                     |    2 
 fs/binfmt_elf_fdpic.c                    |    3 
 fs/coda/cache.c                          |    2 
 fs/coda/cnode.c                          |    3 
 fs/ufs/super.c                           |    2 
 include/linux/timer.h                    |    6 -
 ipc/msg.c                                |    3 
 kernel/cpu.c                             |    3 
 lib/swiotlb.c                            |   32 +++-----
 mm/msync.c                               |    2 
 scripts/Makefile.modpost                 |    2 
 sound/sparc/cs4231.c                     |    6 -
 39 files changed, 114 insertions(+), 140 deletions(-)


diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 5ed85af..b4ea51a 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -360,7 +360,7 @@ uses of RCU may be found in listRCU.txt,
 		struct foo *new_fp;
 		struct foo *old_fp;
 
-		new_fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+		new_fp = kmalloc(sizeof(*new_fp), GFP_KERNEL);
 		spin_lock(&foo_mutex);
 		old_fp = gbl_foo;
 		*new_fp = *old_fp;
@@ -461,7 +461,7 @@ The foo_update_a() function might then b
 		struct foo *new_fp;
 		struct foo *old_fp;
 
-		new_fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+		new_fp = kmalloc(sizeof(*new_fp), GFP_KERNEL);
 		spin_lock(&foo_mutex);
 		old_fp = gbl_foo;
 		*new_fp = *old_fp;
diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index fad566b..7685029 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -118,7 +118,7 @@ to store page tables.  The recommended p
 
 In either case, the following conditions must be met:
 
-- Quiesce all DMA capable devicess so that memory does not get
+- Quiesce all DMA capable devices so that memory does not get
   corrupted by bogus network packets or disk data. This will save
   you many hours of debug.
 
diff --git a/Documentation/arm/README b/Documentation/arm/README
index 5ed6f35..9b9c822 100644
--- a/Documentation/arm/README
+++ b/Documentation/arm/README
@@ -89,7 +89,7 @@ Modules
   Although modularisation is supported (and required for the FP emulator),
   each module on an ARM2/ARM250/ARM3 machine when is loaded will take
   memory up to the next 32k boundary due to the size of the pages.
-  Therefore, modularisation on these machines really worth it?
+  Therefore, is modularisation on these machines really worth it?
 
   However, ARM6 and up machines allow modules to take multiples of 4k, and
   as such Acorn RiscPCs and other architectures using these processors can
diff --git a/Documentation/arm/Setup b/Documentation/arm/Setup
index 0abd072..0cb1e64 100644
--- a/Documentation/arm/Setup
+++ b/Documentation/arm/Setup
@@ -58,7 +58,7 @@ below:
  video_y
 
    This describes the character position of cursor on VGA console, and
-   is otherwise unused. (should not used for other console types, and
+   is otherwise unused. (should not be used for other console types, and
    should not be used for other purposes).
 
  memc_control_reg
diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 944cf10..99902ae 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -121,7 +121,7 @@ Table 1-1: Process specific entries in /
 ..............................................................................
  File    Content                                        
  cmdline Command line arguments                         
- cpu	 Current and last cpu in wich it was executed		(2.4)(smp)
+ cpu	 Current and last cpu in which it was executed		(2.4)(smp)
  cwd	 Link to the current working directory
  environ Values of environment variables      
  exe	 Link to the executable of this process
@@ -309,13 +309,13 @@ is the same by default:
   > cat /proc/irq/0/smp_affinity 
   ffffffff
 
-It's a bitmask, in wich you can specify wich CPUs can handle the IRQ, you can
+It's a bitmask, in which you can specify which CPUs can handle the IRQ, you can
 set it by doing:
 
   > echo 1 > /proc/irq/prof_cpu_mask
 
 This means that only the first CPU will handle the IRQ, but you can also echo 5
-wich means that only the first and fourth CPU can handle the IRQ.
+which means that only the first and fourth CPU can handle the IRQ.
 
 The way IRQs are routed is handled by the IO-APIC, and it's Round Robin
 between all the CPUs which are allowed to handle it. As usual the kernel has
diff --git a/Documentation/networking/packet_mmap.txt b/Documentation/networking/packet_mmap.txt
index 8d4cf78..4fc8e98 100644
--- a/Documentation/networking/packet_mmap.txt
+++ b/Documentation/networking/packet_mmap.txt
@@ -40,7 +40,7 @@ network interface card supports some sor
 + How to use CONFIG_PACKET_MMAP
 --------------------------------------------------------------------------------
 
-From the user standpoint, you should use the higher level libpcap library, wich
+From the user standpoint, you should use the higher level libpcap library, which
 is a de facto standard, portable across nearly all operating systems
 including Win32. 
 
@@ -217,8 +217,8 @@ called pg_vec, its size limits the numbe
 
 kmalloc allocates any number of bytes of phisically contiguous memory from 
 a pool of pre-determined sizes. This pool of memory is mantained by the slab 
-allocator wich is at the end the responsible for doing the allocation and 
-hence wich imposes the maximum memory that kmalloc can allocate. 
+allocator which is at the end the responsible for doing the allocation and 
+hence which imposes the maximum memory that kmalloc can allocate. 
 
 In a 2.4/2.6 kernel and the i386 architecture, the limit is 131072 bytes. The 
 predetermined sizes that kmalloc uses can be checked in the "size-<bytes>" 
@@ -254,7 +254,7 @@ and, the number of frames be
 
 	<block number> * <block size> / <frame size>
 
-Suposse the following parameters, wich apply for 2.6 kernel and an
+Suposse the following parameters, which apply for 2.6 kernel and an
 i386 architecture:
 
 	<size-max> = 131072 bytes
@@ -360,7 +360,7 @@ TP_STATUS_LOSING      : indicates there 
                         statistics where checked with getsockopt() and
                         the PACKET_STATISTICS option.
 
-TP_STATUS_CSUMNOTREADY: currently it's used for outgoing IP packets wich 
+TP_STATUS_CSUMNOTREADY: currently it's used for outgoing IP packets which 
                         it's checksum will be done in hardware. So while 
                         reading the packet we should not try to check the 
                         checksum. 
diff --git a/MAINTAINERS b/MAINTAINERS
index 5b6a014..f854f31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2013,12 +2013,6 @@ L:	parisc-linux@parisc-linux.org
 W:	http://www.parisc-linux.org/
 S:	Maintained
 
-PERSONALITY HANDLING
-P:	Christoph Hellwig
-M:	hch@infradead.org
-L:	linux-abi-devel@lists.sourceforge.net
-S:	Maintained
-
 PCI ERROR RECOVERY
 P:	Linas Vepstas
 M:	linas@austin.ibm.com
@@ -2069,6 +2063,12 @@ M:	tsbogend@alpha.franken.de
 L:	netdev@vger.kernel.org
 S:	Maintained
 
+PERSONALITY HANDLING
+P:	Christoph Hellwig
+M:	hch@infradead.org
+L:	linux-abi-devel@lists.sourceforge.net
+S:	Maintained
+
 PHRAM MTD DRIVER
 P:	Jörn Engel
 M:	joern@wh.fh-wedel.de
diff --git a/block/elevator.c b/block/elevator.c
index 5e558c4..56c2ed0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -728,8 +728,7 @@ void elv_unregister_queue(struct request
 int elv_register(struct elevator_type *e)
 {
 	spin_lock_irq(&elv_list_lock);
-	if (elevator_find(e->elevator_name))
-		BUG();
+	BUG_ON(elevator_find(e->elevator_name));
 	list_add_tail(&e->list, &elv_list);
 	spin_unlock_irq(&elv_list_lock);
 
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 82710ae..5cb9630 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -256,7 +256,8 @@ config ACPI_CUSTOM_DSDT_FILE
 	depends on ACPI_CUSTOM_DSDT
 	default ""
 	help
-	  Enter the full path name to the file wich includes the AmlCode declaration.
+	  Enter the full path name to the file which includes the AmlCode
+	  declaration.
 
 config ACPI_BLACKLIST_YEAR
 	int "Disable ACPI for systems before Jan 1st this year" if X86_32
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 37b8cda..9bdea2a 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -228,8 +228,7 @@ static void *slice_dma_loaf(struct dma_l
 	void *cpu_end = loaf->cpu_free + len;
 	void *cpu_addr = loaf->cpu_free;
 
-	if (cpu_end > loaf->cpu_base + loaf->length)
-		BUG();
+	BUG_ON(cpu_end > loaf->cpu_base + loaf->length);
 	*dma_handle = loaf->dma_free;
 	loaf->cpu_free = cpu_end;
 	loaf->dma_free += len;
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 1f28909..71ec9e6 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -2361,8 +2361,7 @@ queue:
 	if (!creq)
 		goto startio;
 
-	if (creq->nr_phys_segments > MAXSGENTRIES)
-                BUG();
+	BUG_ON(creq->nr_phys_segments > MAXSGENTRIES);
 
 	if (( c = cmd_alloc(h, 1)) == NULL)
 		goto full;
diff --git a/drivers/block/cciss_scsi.c b/drivers/block/cciss_scsi.c
index 9e35de0..0e66e90 100644
--- a/drivers/block/cciss_scsi.c
+++ b/drivers/block/cciss_scsi.c
@@ -1316,7 +1316,7 @@ cciss_scsi_queue_command (struct scsi_cm
 
 	cp->Request.Timeout = 0;
 	memset(cp->Request.CDB, 0, sizeof(cp->Request.CDB));
-	if (cmd->cmd_len > sizeof(cp->Request.CDB)) BUG();
+	BUG_ON(cmd->cmd_len > sizeof(cp->Request.CDB));
 	cp->Request.CDBLen = cmd->cmd_len;
 	memcpy(cp->Request.CDB, cmd->cmnd, cmd->cmd_len);
 	cp->Request.Type.Type = TYPE_CMD;
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index 862b9ab..b6ea2f0 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -906,8 +906,7 @@ queue_next:
 	if (!creq)
 		goto startio;
 
-	if (creq->nr_phys_segments > SG_MAX)
-		BUG();
+	BUG_ON(creq->nr_phys_segments > SG_MAX);
 
 	if ((c = cmd_alloc(h,1)) == NULL)
 		goto startio;
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 090d154..b2a1124 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -45,56 +45,57 @@ obj-$(CONFIG_HVC_CONSOLE)	+= hvc_console
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MMTIMER)		+= mmtimer.o
-obj-$(CONFIG_VIOCONS) += viocons.o
+obj-$(CONFIG_VIOCONS)		+= viocons.o
 obj-$(CONFIG_VIOTAPE)		+= viotape.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
 obj-$(CONFIG_SGI_MBCS)		+= mbcs.o
 
-obj-$(CONFIG_PRINTER) += lp.o
-obj-$(CONFIG_TIPAR) += tipar.o
+obj-$(CONFIG_PRINTER)		+= lp.o
+obj-$(CONFIG_TIPAR)		+= tipar.o
 
-obj-$(CONFIG_DTLK) += dtlk.o
-obj-$(CONFIG_R3964) += n_r3964.o
-obj-$(CONFIG_APPLICOM) += applicom.o
-obj-$(CONFIG_SONYPI) += sonypi.o
-obj-$(CONFIG_RTC) += rtc.o
-obj-$(CONFIG_HPET) += hpet.o
-obj-$(CONFIG_GEN_RTC) += genrtc.o
-obj-$(CONFIG_EFI_RTC) += efirtc.o
-obj-$(CONFIG_SGI_DS1286) += ds1286.o
-obj-$(CONFIG_SGI_IP27_RTC) += ip27-rtc.o
-obj-$(CONFIG_DS1302) += ds1302.o
-obj-$(CONFIG_S3C2410_RTC) += s3c2410-rtc.o
-obj-$(CONFIG_RTC_VR41XX) += vr41xx_rtc.o
+obj-$(CONFIG_DTLK)		+= dtlk.o
+obj-$(CONFIG_R3964)		+= n_r3964.o
+obj-$(CONFIG_APPLICOM)		+= applicom.o
+obj-$(CONFIG_SONYPI)		+= sonypi.o
+obj-$(CONFIG_RTC)		+= rtc.o
+obj-$(CONFIG_HPET)		+= hpet.o
+obj-$(CONFIG_GEN_RTC)		+= genrtc.o
+obj-$(CONFIG_EFI_RTC)		+= efirtc.o
+obj-$(CONFIG_SGI_DS1286)	+= ds1286.o
+obj-$(CONFIG_SGI_IP27_RTC)	+= ip27-rtc.o
+obj-$(CONFIG_DS1302)		+= ds1302.o
+obj-$(CONFIG_S3C2410_RTC)	+= s3c2410-rtc.o
+obj-$(CONFIG_RTC_VR41XX)	+= vr41xx_rtc.o
 ifeq ($(CONFIG_GENERIC_NVRAM),y)
-  obj-$(CONFIG_NVRAM) += generic_nvram.o
+  obj-$(CONFIG_NVRAM)	+= generic_nvram.o
 else
-  obj-$(CONFIG_NVRAM) += nvram.o
+  obj-$(CONFIG_NVRAM)	+= nvram.o
 endif
-obj-$(CONFIG_TOSHIBA) += toshiba.o
-obj-$(CONFIG_I8K) += i8k.o
-obj-$(CONFIG_DS1620) += ds1620.o
-obj-$(CONFIG_HW_RANDOM) += hw_random.o
-obj-$(CONFIG_FTAPE) += ftape/
-obj-$(CONFIG_COBALT_LCD) += lcd.o
-obj-$(CONFIG_PPDEV) += ppdev.o
-obj-$(CONFIG_NWBUTTON) += nwbutton.o
-obj-$(CONFIG_NWFLASH) += nwflash.o
-obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
-obj-$(CONFIG_CS5535_GPIO) += cs5535_gpio.o
-obj-$(CONFIG_GPIO_VR41XX) += vr41xx_giu.o
-obj-$(CONFIG_TANBAC_TB0219) += tb0219.o
-obj-$(CONFIG_TELCLOCK) += tlclk.o
-
-obj-$(CONFIG_WATCHDOG)	+= watchdog/
-obj-$(CONFIG_MWAVE) += mwave/
-obj-$(CONFIG_AGP) += agp/
-obj-$(CONFIG_DRM) += drm/
-obj-$(CONFIG_PCMCIA) += pcmcia/
-obj-$(CONFIG_IPMI_HANDLER) += ipmi/
+obj-$(CONFIG_TOSHIBA)		+= toshiba.o
+obj-$(CONFIG_I8K)		+= i8k.o
+obj-$(CONFIG_DS1620)		+= ds1620.o
+obj-$(CONFIG_HW_RANDOM)		+= hw_random.o
+obj-$(CONFIG_FTAPE)		+= ftape/
+obj-$(CONFIG_COBALT_LCD)	+= lcd.o
+obj-$(CONFIG_PPDEV)		+= ppdev.o
+obj-$(CONFIG_NWBUTTON)		+= nwbutton.o
+obj-$(CONFIG_NWFLASH)		+= nwflash.o
+obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
+obj-$(CONFIG_CS5535_GPIO)	+= cs5535_gpio.o
+obj-$(CONFIG_GPIO_VR41XX)	+= vr41xx_giu.o
+obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o
+obj-$(CONFIG_TELCLOCK)		+= tlclk.o
+
+obj-$(CONFIG_WATCHDOG)		+= watchdog/
+obj-$(CONFIG_MWAVE)		+= mwave/
+obj-$(CONFIG_AGP)		+= agp/
+obj-$(CONFIG_DRM)		+= drm/
+obj-$(CONFIG_PCMCIA)		+= pcmcia/
+obj-$(CONFIG_IPMI_HANDLER)	+= ipmi/
+
+obj-$(CONFIG_HANGCHECK_TIMER)	+= hangcheck-timer.o
+obj-$(CONFIG_TCG_TPM)		+= tpm/
 
-obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
-obj-$(CONFIG_TCG_TPM) += tpm/
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
 
diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index 5704204..ea49978 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -556,7 +556,7 @@ static inline void hilse_setup_input(hil
 	do_gettimeofday(&(mlc->instart));
 	mlc->icount = 15;
 	memset(mlc->ipacket, 0, 16 * sizeof(hil_packet));
-	if (down_trylock(&(mlc->isem))) BUG();
+	BUG_ON(down_trylock(&(mlc->isem)));
 
 	return;
 }
diff --git a/drivers/isdn/i4l/isdn_x25iface.c b/drivers/isdn/i4l/isdn_x25iface.c
index edf14a2..743ac40 100644
--- a/drivers/isdn/i4l/isdn_x25iface.c
+++ b/drivers/isdn/i4l/isdn_x25iface.c
@@ -7,7 +7,7 @@
  *
  * stuff needed to support the Linux X.25 PLP code on top of devices that
  * can provide a lab_b service using the concap_proto mechanism.
- * This module supports a network interface wich provides lapb_sematics
+ * This module supports a network interface which provides lapb_sematics
  * -- as defined in Documentation/networking/x25-iface.txt -- to
  * the upper layer and assumes that the lower layer provides a reliable
  * data link service by means of the concap_device_ops callbacks.
diff --git a/drivers/md/bitmap.c b/drivers/md/bitmap.c
index eae4473..979e8ca 100644
--- a/drivers/md/bitmap.c
+++ b/drivers/md/bitmap.c
@@ -1309,7 +1309,7 @@ int bitmap_startwrite(struct bitmap *bit
 		case 1:
 			*bmc = 2;
 		}
-		if ((*bmc & COUNTER_MAX) == COUNTER_MAX) BUG();
+		BUG_ON((*bmc & COUNTER_MAX) == COUNTER_MAX);
 		(*bmc)++;
 
 		spin_unlock_irq(&bitmap->lock);
diff --git a/drivers/md/dm-hw-handler.c b/drivers/md/dm-hw-handler.c
index 4cc0010..baafaab 100644
--- a/drivers/md/dm-hw-handler.c
+++ b/drivers/md/dm-hw-handler.c
@@ -83,8 +83,7 @@ void dm_put_hw_handler(struct hw_handler
 	if (--hwhi->use == 0)
 		module_put(hwhi->hwht.module);
 
-	if (hwhi->use < 0)
-		BUG();
+	BUG_ON(hwhi->use < 0);
 
       out:
 	up_read(&_hwh_lock);
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 5d47c59..0821747 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1724,9 +1724,7 @@ printk("sba_hw_init(): mem_boot 0x%x 0x%
 		sba_dev->chip_resv.start = PCI_F_EXTEND | 0xfef00000UL;
 		sba_dev->chip_resv.end   = PCI_F_EXTEND | (0xff000000UL - 1) ;
 		err = request_resource(&iomem_resource, &(sba_dev->chip_resv));
-		if (err < 0) {
-			BUG();
-		}
+		BUG_ON(err < 0);
 
 	} else if (IS_PLUTO(sba_dev->iodc)) {
 		int err;
@@ -2185,8 +2183,7 @@ void sba_directed_lmmio(struct parisc_de
 	int i;
 	int rope = (pci_hba->hw_path & (ROPES_PER_IOC-1));  /* rope # */
 
-	if ((t!=HPHW_IOA) && (t!=HPHW_BCPORT))
-		BUG();
+	BUG_ON((t!=HPHW_IOA) && (t!=HPHW_BCPORT));
 
 	r->start = r->end = 0;
 
@@ -2228,8 +2225,7 @@ void sba_distributed_lmmio(struct parisc
 	int base, size;
 	int rope = (pci_hba->hw_path & (ROPES_PER_IOC-1));  /* rope # */
 
-	if ((t!=HPHW_IOA) && (t!=HPHW_BCPORT))
-		BUG();
+	BUG_ON((t!=HPHW_IOA) && (t!=HPHW_BCPORT));
 
 	r->start = r->end = 0;
 
diff --git a/drivers/parisc/superio.c b/drivers/parisc/superio.c
index ba971fe..ad6d3b2 100644
--- a/drivers/parisc/superio.c
+++ b/drivers/parisc/superio.c
@@ -157,8 +157,8 @@ superio_init(struct pci_dev *pcidev)
         if (sio->suckyio_irq_enabled)                                       
 		return;
 
-	if (!pdev) BUG();
-	if (!sio->usb_pdev) BUG();
+	BUG_ON(!pdev);
+	BUG_ON(!sio->usb_pdev);
 
 	/* use the IRQ iosapic found for USB INT D... */
 	pdev->irq = sio->usb_pdev->irq;
@@ -474,8 +474,7 @@ superio_probe(struct pci_dev *dev, const
 		dev->subsystem_vendor, dev->subsystem_device,
 		dev->class);
 
-	if (!sio->suckyio_irq_enabled)
-		BUG(); /* Enabled by PCI_FIXUP_FINAL */
+	BUG_ON(!sio->suckyio_irq_enabled);	/* Enabled by PCI_FIXUP_FINAL */
 
 	if (dev->device == PCI_DEVICE_ID_NS_87560_LIO) {	/* Function 1 */
 		superio_parport_init();
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index dfe542b..0eab05a 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -542,9 +542,8 @@ dasd_kmalloc_request(char *magic, int cp
 	struct dasd_ccw_req *cqr;
 
 	/* Sanity checks */
-	if ( magic == NULL || datasize > PAGE_SIZE ||
-	     (cplength*sizeof(struct ccw1)) > PAGE_SIZE)
-		BUG();
+	BUG_ON( magic == NULL || datasize > PAGE_SIZE ||
+	     (cplength*sizeof(struct ccw1)) > PAGE_SIZE);
 
 	cqr = kzalloc(sizeof(struct dasd_ccw_req), GFP_ATOMIC);
 	if (cqr == NULL)
@@ -584,9 +583,8 @@ dasd_smalloc_request(char *magic, int cp
 	int size;
 
 	/* Sanity checks */
-	if ( magic == NULL || datasize > PAGE_SIZE ||
-	     (cplength*sizeof(struct ccw1)) > PAGE_SIZE)
-		BUG();
+	BUG_ON( magic == NULL || datasize > PAGE_SIZE ||
+	     (cplength*sizeof(struct ccw1)) > PAGE_SIZE);
 
 	size = (sizeof(struct dasd_ccw_req) + 7L) & -8L;
 	if (cplength > 0)
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 928e6cf..6459edc 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -40,7 +40,7 @@
  * and so on). So the PSC1 is mapped to /dev/ttyPSC0, PSC2 to /dev/ttyPSC1 and
  * so on. But be warned, it's an ABSOLUTE REQUIREMENT ! This is needed mainly
  * fpr the console code : without this 1:1 mapping, at early boot time, when we
- * are parsing the kernel args console=ttyPSC?, we wouldn't know wich PSC it
+ * are parsing the kernel args console=ttyPSC?, we wouldn't know which PSC it
  * will be mapped to.
  */
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index a8455c9..495db57 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -102,7 +102,7 @@ static struct usb_driver option_driver =
 	.no_dynamic_id = 	1,
 };
 
-/* The card has three separate interfaces, wich the serial driver
+/* The card has three separate interfaces, which the serial driver
  * recognizes separately, thus num_port=1.
  */
 static struct usb_serial_driver option_3port_device = {
diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index c029db4..6577fdf 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -327,8 +327,7 @@ static void bw2_init_one(struct sbus_dev
 	} else
 #else
 	{
-		if (!sdev)
-			BUG();
+		BUG_ON(!sdev);
 		all->par.physbase = sdev->reg_addrs[0].phys_addr;
 		resp = &sdev->resource[0];
 		sbusfb_fill_var(&all->info.var, (sdev ? sdev->prom_node : 0), 1);
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 9c9b21d..7633e41 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -466,8 +466,7 @@ static void ffb_fillrect(struct fb_info 
 	unsigned long flags;
 	u32 fg;
 
-	if (rect->rop != ROP_COPY && rect->rop != ROP_XOR)
-		BUG();
+	BUG_ON(rect->rop != ROP_COPY && rect->rop != ROP_XOR);
 
 	fg = ((u32 *)info->pseudo_palette)[rect->color];
 
diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index 99921df..8c1a8b5 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -32,7 +32,7 @@
 
 -TODO: at one time or another test that the mode is acceptable by the monitor
 -ASK: Can I choose different ordering for the color bitfields (rgba argb ...)
-      wich one should i use ? is there any preferred one ? It seems ARGB is
+      which one should i use ? is there any preferred one ? It seems ARGB is
       the one ...
 -TODO: in  set_var check the validity of timings (hsync vsync)...
 -TODO: check and recheck the use of sst_wait_idle : we don't flush the fifo via
diff --git a/drivers/w1/masters/matrox_w1.c b/drivers/w1/masters/matrox_w1.c
index 591809c..2788b8c 100644
--- a/drivers/w1/masters/matrox_w1.c
+++ b/drivers/w1/masters/matrox_w1.c
@@ -98,7 +98,7 @@ static void matrox_w1_write_ddc_bit(void
  *
  * Using tristate pins, since i can't find any open-drain pin in whole motherboard.
  * Unfortunately we can't connect to Intel's 82801xx IO controller
- * since we don't know motherboard schema, wich has pretty unused(may be not) GPIO.
+ * since we don't know motherboard schema, which has pretty unused(may be not) GPIO.
  *
  * I've heard that PIIX also has open drain pin.
  *
diff --git a/fs/befs/datastream.c b/fs/befs/datastream.c
index 785f6b2..b7d6b92 100644
--- a/fs/befs/datastream.c
+++ b/fs/befs/datastream.c
@@ -118,7 +118,7 @@ befs_fblock2brun(struct super_block *sb,
  * befs_read_lsmylink - read long symlink from datastream.
  * @sb: Filesystem superblock 
  * @ds: Datastrem to read from
- * @buf: Buffer in wich to place long symlink data
+ * @buf: Buffer in which to place long symlink data
  * @len: Length of the long symlink in bytes
  *
  * Returns the number of bytes read
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 5b3076e..a2e48c9 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -572,8 +572,7 @@ static int create_elf_fdpic_tables(struc
 	csp -= sizeof(unsigned long);
 	__put_user(bprm->argc, (unsigned long *) csp);
 
-	if (csp != sp)
-		BUG();
+	BUG_ON(csp != sp);
 
 	/* fill in the argv[] array */
 #ifdef CONFIG_MMU
diff --git a/fs/coda/cache.c b/fs/coda/cache.c
index c607d92..5d05271 100644
--- a/fs/coda/cache.c
+++ b/fs/coda/cache.c
@@ -51,7 +51,7 @@ void coda_cache_clear_all(struct super_b
         struct coda_sb_info *sbi;
 
         sbi = coda_sbp(sb);
-        if (!sbi) BUG();
+	BUG_ON(!sbi);
 
 	atomic_inc(&permission_epoch);
 }
diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 23aeef5..4c9fecb 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -120,8 +120,7 @@ void coda_replace_fid(struct inode *inod
 	
 	cii = ITOC(inode);
 
-	if (!coda_fideq(&cii->c_fid, oldfid))
-		BUG();
+	BUG_ON(!coda_fideq(&cii->c_fid, oldfid));
 
 	/* replace fid and rehash inode */
 	/* XXX we probably need to hold some lock here! */
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index d257644..db98a4c 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -575,7 +575,7 @@ static int ufs_fill_super(struct super_b
 		if (!silent)
 			printk("You didn't specify the type of your ufs filesystem\n\n"
 			"mount -t ufs -o ufstype="
-			"sun|sunx86|44bsd|ufs2|5xbsd|old|hp|nextstep|netxstep-cd|openstep ...\n\n"
+			"sun|sunx86|44bsd|ufs2|5xbsd|old|hp|nextstep|nextstep-cd|openstep ...\n\n"
 			">>>WARNING<<< Wrong ufstype may corrupt your filesystem, "
 			"default is ufstype=old\n");
 		ufs_set_opt (sbi->s_mount_opt, UFSTYPE_OLD);
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 9b9877f..ee5a09e 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -69,13 +69,13 @@ extern unsigned long next_timer_interrup
  * @timer: the timer to be added
  *
  * The kernel will do a ->function(->data) callback from the
- * timer interrupt at the ->expired point in the future. The
+ * timer interrupt at the ->expires point in the future. The
  * current time is 'jiffies'.
  *
- * The timer's ->expired, ->function (and if the handler uses it, ->data)
+ * The timer's ->expires, ->function (and if the handler uses it, ->data)
  * fields must be set prior calling this function.
  *
- * Timers with an ->expired field in the past will be executed in the next
+ * Timers with an ->expires field in the past will be executed in the next
  * timer tick.
  */
 static inline void add_timer(struct timer_list *timer)
diff --git a/ipc/msg.c b/ipc/msg.c
index fbf7570..60c1e5c 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -220,8 +220,7 @@ asmlinkage long sys_msgget (key_t key, i
 		ret = -EEXIST;
 	} else {
 		msq = msg_lock(id);
-		if(msq==NULL)
-			BUG();
+		BUG_ON(msq==NULL);
 		if (ipcperms(&msq->q_perm, msgflg))
 			ret = -EACCES;
 		else {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e882c6b..8be22bd 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -223,8 +223,7 @@ int __devinit cpu_up(unsigned int cpu)
 	ret = __cpu_up(cpu);
 	if (ret != 0)
 		goto out_notify;
-	if (!cpu_online(cpu))
-		BUG();
+	BUG_ON(!cpu_online(cpu));
 
 	/* Now call notifier in preparation. */
 	notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 0af497b..1062578 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -296,8 +296,7 @@ map_single(struct device *hwdev, char *b
 	else
 		stride = 1;
 
-	if (!nslots)
-		BUG();
+	BUG_ON(!nslots);
 
 	/*
 	 * Find suitable number of IO TLB entries size that will fit this
@@ -416,14 +415,14 @@ sync_single(struct device *hwdev, char *
 	case SYNC_FOR_CPU:
 		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
 			memcpy(buffer, dma_addr, size);
-		else if (dir != DMA_TO_DEVICE)
-			BUG();
+		else
+			BUG_ON(dir != DMA_TO_DEVICE);
 		break;
 	case SYNC_FOR_DEVICE:
 		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 			memcpy(dma_addr, buffer, size);
-		else if (dir != DMA_FROM_DEVICE)
-			BUG();
+		else
+			BUG_ON(dir != DMA_FROM_DEVICE);
 		break;
 	default:
 		BUG();
@@ -529,8 +528,7 @@ swiotlb_map_single(struct device *hwdev,
 	unsigned long dev_addr = virt_to_phys(ptr);
 	void *map;
 
-	if (dir == DMA_NONE)
-		BUG();
+	BUG_ON(dir == DMA_NONE);
 	/*
 	 * If the pointer passed in happens to be in the device's DMA window,
 	 * we can safely return the device addr and not worry about bounce
@@ -592,8 +590,7 @@ swiotlb_unmap_single(struct device *hwde
 {
 	char *dma_addr = phys_to_virt(dev_addr);
 
-	if (dir == DMA_NONE)
-		BUG();
+	BUG_ON(dir == DMA_NONE);
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
 		unmap_single(hwdev, dma_addr, size, dir);
 	else if (dir == DMA_FROM_DEVICE)
@@ -616,8 +613,7 @@ swiotlb_sync_single(struct device *hwdev
 {
 	char *dma_addr = phys_to_virt(dev_addr);
 
-	if (dir == DMA_NONE)
-		BUG();
+	BUG_ON(dir == DMA_NONE);
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
 		sync_single(hwdev, dma_addr, size, dir, target);
 	else if (dir == DMA_FROM_DEVICE)
@@ -648,8 +644,7 @@ swiotlb_sync_single_range(struct device 
 {
 	char *dma_addr = phys_to_virt(dev_addr) + offset;
 
-	if (dir == DMA_NONE)
-		BUG();
+	BUG_ON(dir == DMA_NONE);
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
 		sync_single(hwdev, dma_addr, size, dir, target);
 	else if (dir == DMA_FROM_DEVICE)
@@ -696,8 +691,7 @@ swiotlb_map_sg(struct device *hwdev, str
 	unsigned long dev_addr;
 	int i;
 
-	if (dir == DMA_NONE)
-		BUG();
+	BUG_ON(dir == DMA_NONE);
 
 	for (i = 0; i < nelems; i++, sg++) {
 		addr = SG_ENT_VIRT_ADDRESS(sg);
@@ -730,8 +724,7 @@ swiotlb_unmap_sg(struct device *hwdev, s
 {
 	int i;
 
-	if (dir == DMA_NONE)
-		BUG();
+	BUG_ON(dir == DMA_NONE);
 
 	for (i = 0; i < nelems; i++, sg++)
 		if (sg->dma_address != SG_ENT_PHYS_ADDRESS(sg))
@@ -753,8 +746,7 @@ swiotlb_sync_sg(struct device *hwdev, st
 {
 	int i;
 
-	if (dir == DMA_NONE)
-		BUG();
+	BUG_ON(dir == DMA_NONE);
 
 	for (i = 0; i < nelems; i++, sg++)
 		if (sg->dma_address != SG_ENT_PHYS_ADDRESS(sg))
diff --git a/mm/msync.c b/mm/msync.c
index 2672b8d..bc6c953 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -126,7 +126,7 @@ static unsigned long msync_page_range(st
  * write out the dirty pages and wait on the writeout and check the result.
  * Or the application may run fadvise(FADV_DONTNEED) against the fd to start
  * async writeout immediately.
- * So my _not_ starting I/O in MS_ASYNC we provide complete flexibility to
+ * So by _not_ starting I/O in MS_ASYNC we provide complete flexibility to
  * applications.
  */
 static int msync_interval(struct vm_area_struct *vma, unsigned long addr,
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index bf96a61..9a3ec20 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -4,7 +4,7 @@
 #
 # Stage one of module building created the following:
 # a) The individual .o files used for the module
-# b) A <module>.o file wich is the .o files above linked together
+# b) A <module>.o file which is the .o files above linked together
 # c) A <module>.mod file in $(MODVERDIR)/, listing the name of the
 #    the preliminary <module>.o file, plus all .o files
 
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 53a148b..8804f26 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -611,8 +611,7 @@ static void snd_cs4231_advance_dma(struc
 		unsigned int period_size = snd_pcm_lib_period_bytes(substream);
 		unsigned int offset = period_size * (*periods_sent);
 
-		if (period_size >= (1 << 24))
-			BUG();
+		BUG_ON(period_size >= (1 << 24));
 
 		if (dma_cont->request(dma_cont, runtime->dma_addr + offset, period_size))
 			return;
@@ -1079,8 +1078,7 @@ static int snd_cs4231_playback_prepare(s
 	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE |
 					    CS4231_PLAYBACK_PIO);
 
-	if (runtime->period_size > 0xffff + 1)
-		BUG();
+	BUG_ON(runtime->period_size > 0xffff + 1);
 
 	chip->p_periods_sent = 0;
 	spin_unlock_irqrestore(&chip->lock, flags);


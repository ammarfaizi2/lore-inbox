Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbVJTDlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbVJTDlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 23:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbVJTDlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 23:41:14 -0400
Received: from xenotime.net ([66.160.160.81]:39089 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751727AbVJTDlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 23:41:14 -0400
Date: Wed, 19 Oct 2005 20:41:09 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH,RFC] kernel-parameters cleanup
Message-Id: <20051019204109.66049f66.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix typos & trailing whitespace.
Add blank lines in a few places.
Remove "AM53C974=" option:  driver does not exist.
Restrict to < 80 columns in most places (but don't split formatted
  command-line arguments).
Add a few option arguments for completeness.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 Documentation/kernel-parameters.txt |  496 +++++++++++++-------------
 1 files changed, 260 insertions(+), 236 deletions(-)

diff -Naurp linux-2614-rc4/Documentation/kernel-parameters.txt~doc_kern_prms linux-2614-rc4/Documentation/kernel-parameters.txt
--- linux-2614-rc4/Documentation/kernel-parameters.txt~doc_kern_prms	2005-10-14 17:31:21.000000000 -0700
+++ linux-2614-rc4/Documentation/kernel-parameters.txt	2005-10-19 20:33:44.000000000 -0700
@@ -17,7 +17,7 @@ are specified on the kernel command line
 
 	usbcore.blinkenlights=1
 
-The text in square brackets at the beginning of the description state the
+The text in square brackets at the beginning of the description states the
 restrictions on the kernel for the said kernel parameter to be valid. The
 restrictions referred to are that the relevant option is valid if:
 
@@ -27,8 +27,8 @@ restrictions referred to are that the re
 	APM	Advanced Power Management support is enabled.
 	AX25	Appropriate AX.25 support is enabled.
 	CD	Appropriate CD support is enabled.
-	DEVFS	devfs support is enabled. 
-	DRM	Direct Rendering Management support is enabled. 
+	DEVFS	devfs support is enabled.
+	DRM	Direct Rendering Management support is enabled.
 	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
 	EFI	EFI Partitioning (GPT) is enabled
 	EIDE	EIDE/ATAPI support is enabled.
@@ -71,7 +71,7 @@ restrictions referred to are that the re
 	SERIAL	Serial support is enabled.
 	SMP	The kernel is an SMP kernel.
 	SPARC	Sparc architecture is enabled.
-	SWSUSP	Software suspension is enabled.
+	SWSUSP	Software suspend is enabled.
 	TS	Appropriate touchscreen support is enabled.
 	USB	USB support is enabled.
 	USBHID	USB Human Interface Device support is enabled.
@@ -105,13 +105,13 @@ running once the system is up.
 			See header of drivers/scsi/53c7xx.c.
 			See also Documentation/scsi/ncr53c7xx.txt.
 
-	acpi=		[HW,ACPI] Advanced Configuration and Power Interface 
-			Format: { force | off | ht | strict }
+	acpi=		[HW,ACPI] Advanced Configuration and Power Interface
+			Format: { force | off | ht | strict | noirq }
 			force -- enable ACPI if default was off
 			off -- disable ACPI if default was on
 			noirq -- do not use ACPI for IRQ routing
 			ht -- run only enough ACPI to enable Hyper Threading
-			strict --  Be less tolerant of platforms that are not
+			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
 
 			See also Documentation/pm.txt, pci=noacpi
@@ -119,20 +119,23 @@ running once the system is up.
 	acpi_sleep=	[HW,ACPI] Sleep options
 			Format: { s3_bios, s3_mode }
 			See Documentation/power/video.txt
- 
-	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
-			Format: { level | edge |  high | low }
 
-	acpi_irq_balance	[HW,ACPI] ACPI will balance active IRQs
-				default in APIC mode
+	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
+			Format: { level | edge | high | low }
 
-	acpi_irq_nobalance	[HW,ACPI] ACPI will not move active IRQs (default)
-				default in PIC mode
+	acpi_irq_balance [HW,ACPI]
+			ACPI will balance active IRQs
+			default in APIC mode
+
+	acpi_irq_nobalance [HW,ACPI]
+			ACPI will not move active IRQs (default)
+			default in PIC mode
 
-	acpi_irq_pci=	[HW,ACPI] If irq_balance, Clear listed IRQs for use by PCI
+	acpi_irq_pci=	[HW,ACPI] If irq_balance, clear listed IRQs for
+			use by PCI
 			Format: <irq>,<irq>...
 
-	acpi_irq_isa=	[HW,ACPI] If irq_balance, Mark listed IRQs used by ISA
+	acpi_irq_isa=	[HW,ACPI] If irq_balance, mark listed IRQs used by ISA
 			Format: <irq>,<irq>...
 
 	acpi_osi=	[HW,ACPI] empty param disables _OSI
@@ -145,14 +148,14 @@ running once the system is up.
 
 	acpi_dbg_layer=	[HW,ACPI]
 			Format: <int>
-			Each bit of the <int> indicates an acpi debug layer,
+			Each bit of the <int> indicates an ACPI debug layer,
 			1: enable, 0: disable. It is useful for boot time
 			debugging. After system has booted up, it can be set
 			via /proc/acpi/debug_layer.
 
 	acpi_dbg_level=	[HW,ACPI]
 			Format: <int>
-			Each bit of the <int> indicates an acpi debug level,
+			Each bit of the <int> indicates an ACPI debug level,
 			1: enable, 0: disable. It is useful for boot time
 			debugging. After system has booted up, it can be set
 			via /proc/acpi/debug_level.
@@ -161,12 +164,13 @@ running once the system is up.
 
 	acpi_generic_hotkey [HW,ACPI]
 			Allow consolidated generic hotkey driver to
-			over-ride platform specific driver.
+			override platform specific driver.
 			See also Documentation/acpi-hotkey.txt.
 
 	enable_timer_pin_1 [i386,x86-64]
 			Enable PIN 1 of APIC timer
-			Can be useful to work around chipset bugs (in particular on some ATI chipsets)
+			Can be useful to work around chipset bugs
+			(in particular on some ATI chipsets).
 			The kernel tries to set a reasonable default.
 
 	disable_timer_pin_1 [i386,x86-64]
@@ -182,7 +186,7 @@ running once the system is up.
 
 	adlib=		[HW,OSS]
 			Format: <io>
- 
+
 	advansys=	[HW,SCSI]
 			See header of drivers/scsi/advansys.c.
 
@@ -192,7 +196,7 @@ running once the system is up.
 	aedsp16=	[HW,OSS] Audio Excel DSP 16
 			Format: <io>,<irq>,<dma>,<mss_io>,<mpu_io>,<mpu_irq>
 			See also header of sound/oss/aedsp16.c.
- 
+
 	aha152x=	[HW,SCSI]
 			See Documentation/scsi/aha152x.txt.
 
@@ -205,10 +209,6 @@ running once the system is up.
 	aic79xx=	[HW,SCSI]
 			See Documentation/scsi/aic79xx.txt.
 
-	AM53C974=	[HW,SCSI]
-			Format: <host-scsi-id>,<target-scsi-id>,<max-rate>,<max-offset>
-			See also header of drivers/scsi/AM53C974.c.
-
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
@@ -219,23 +219,24 @@ running once the system is up.
 			connected to one of 16 gameports
 			Format: <type1>,<type2>,..<type16>
 
-	apc=		[HW,SPARC] Power management functions (SPARCstation-4/5 + deriv.)
+	apc=		[HW,SPARC]
+			Power management functions (SPARCstation-4/5 + deriv.)
 			Format: noidle
 			Disable APC CPU standby support. SPARCstation-Fox does
 			not play well with APC CPU idle - disable it if you have
 			APC and your system crashes randomly.
 
-	apic=		[APIC,i386] Change the output verbosity  whilst booting
+	apic=		[APIC,i386] Change the output verbosity whilst booting
 			Format: { quiet (default) | verbose | debug }
 			Change the amount of debugging information output
 			when initialising the APIC and IO-APIC components.
- 
+
 	apm=		[APM] Advanced Power Management
 			See header of arch/i386/kernel/apm.c.
 
 	applicom=	[HW]
 			Format: <mem>,<irq>
- 
+
 	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
 			Format: <io>,<irq>,<nodeID>
 
@@ -250,38 +251,40 @@ running once the system is up.
 
 	atkbd.reset=	[HW] Reset keyboard during initialization
 
-	atkbd.set=	[HW] Select keyboard code set 
-			Format: <int> (2 = AT (default) 3 = PS/2)
+	atkbd.set=	[HW] Select keyboard code set
+			Format: <int> (2 = AT (default), 3 = PS/2)
 
 	atkbd.scroll=	[HW] Enable scroll wheel on MS Office and similar
 			keyboards
 
 	atkbd.softraw=	[HW] Choose between synthetic and real raw mode
 			Format: <bool> (0 = real, 1 = synthetic (default))
-	
-	atkbd.softrepeat=
-			[HW] Use software keyboard repeat
+
+	atkbd.softrepeat= [HW]
+			Use software keyboard repeat
 
 	autotest	[IA64]
 
 	awe=		[HW,OSS] AWE32/SB32/AWE64 wave table synth
 			Format: <io>,<memsize>,<isapnp>
- 
+
 	aztcd=		[HW,CD] Aztech CD268 CDROM driver
 			Format: <io>,0x79 (?)
 
 	baycom_epp=	[HW,AX25]
 			Format: <io>,<mode>
- 
+
 	baycom_par=	[HW,AX25] BayCom Parallel Port AX.25 Modem
 			Format: <io>,<mode>
 			See header of drivers/net/hamradio/baycom_par.c.
 
-	baycom_ser_fdx=	[HW,AX25] BayCom Serial Port AX.25 Modem (Full Duplex Mode)
+	baycom_ser_fdx=	[HW,AX25]
+			BayCom Serial Port AX.25 Modem (Full Duplex Mode)
 			Format: <io>,<irq>,<mode>[,<baud>]
 			See header of drivers/net/hamradio/baycom_ser_fdx.c.
 
-	baycom_ser_hdx=	[HW,AX25] BayCom Serial Port AX.25 Modem (Half Duplex Mode)
+	baycom_ser_hdx=	[HW,AX25]
+			BayCom Serial Port AX.25 Modem (Half Duplex Mode)
 			Format: <io>,<irq>,<mode>
 			See header of drivers/net/hamradio/baycom_ser_hdx.c.
 
@@ -292,7 +295,8 @@ running once the system is up.
 	blkmtd_count=
 
 	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
-	bttv.radio=	Most important insmod options are available as kernel args too.
+	bttv.radio=	Most important insmod options are available as
+			kernel args too.
 	bttv.pll=	See Documentation/video4linux/bttv/Insmod-options
 	bttv.tuner=	and Documentation/video4linux/bttv/CARDLIST
 
@@ -318,15 +322,17 @@ running once the system is up.
 	checkreqprot	[SELINUX] Set initial checkreqprot flag value.
 			Format: { "0" | "1" }
 			See security/selinux/Kconfig help text.
-			0 -- check protection applied by kernel (includes any implied execute protection).
+			0 -- check protection applied by kernel (includes
+				any implied execute protection).
 			1 -- check protection requested by application.
 			Default value is set via a kernel config option.
-			Value can be changed at runtime via /selinux/checkreqprot.
- 
- 	clock=		[BUGS=IA-32, HW] gettimeofday timesource override. 
+			Value can be changed at runtime via
+				/selinux/checkreqprot.
+
+ 	clock=		[BUGS=IA-32,HW] gettimeofday timesource override.
 			Forces specified timesource (if avaliable) to be used
-			when calculating gettimeofday(). If specicified timesource
-			is not avalible, it defaults to PIT. 
+			when calculating gettimeofday(). If specicified
+			timesource is not avalible, it defaults to PIT.
 			Format: { pit | tsc | cyclone | pmtmr }
 
 	hpet=		[IA-32,HPET] option to disable HPET and use PIT.
@@ -336,17 +342,19 @@ running once the system is up.
 			Format: { auto | [<io>,][<irq>] }
 
 	com20020=	[HW,NET] ARCnet - COM20020 chipset
-			Format: <io>[,<irq>[,<nodeID>[,<backplane>[,<ckp>[,<timeout>]]]]]
+			Format:
+			<io>[,<irq>[,<nodeID>[,<backplane>[,<ckp>[,<timeout>]]]]]
 
 	com90io=	[HW,NET] ARCnet - COM90xx chipset (IO-mapped buffers)
 			Format: <io>[,<irq>]
 
-	com90xx=	[HW,NET] ARCnet - COM90xx chipset (memory-mapped buffers)
+	com90xx=	[HW,NET]
+			ARCnet - COM90xx chipset (memory-mapped buffers)
 			Format: <io>[,<irq>[,<memstart>]]
 
 	condev=		[HW,S390] console device
 	conmode=
- 
+
 	console=	[KNL] Output console device and options.
 
 		tty<n>	Use the virtual console device <n>.
@@ -367,7 +375,8 @@ running once the system is up.
 			options are the same as for ttyS, above.
 
 	cpcihp_generic=	[HW,PCI] Generic port I/O CompactPCI driver
-			Format: <first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
+			Format:
+			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
 	cpia_pp=	[HW,PPT]
 			Format: { parport<nr> | auto | none }
@@ -384,10 +393,10 @@ running once the system is up.
 
 	cs89x0_media=	[HW,NET]
 			Format: { rj45 | aui | bnc }
- 
+
 	cyclades=	[HW,SERIAL] Cyclades multi-serial port adapter.
- 
-	dasd=		[HW,NET]    
+
+	dasd=		[HW,NET]
 			See header of drivers/s390/block/dasd_devmap.c.
 
 	db9.dev[2|3]=	[HW,JOY] Multisystem joystick support via parallel port
@@ -406,7 +415,7 @@ running once the system is up.
 
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
- 
+
 	digi=		[HW,SERIAL]
 			IO parameters + enable/disable command.
 
@@ -424,11 +433,11 @@ running once the system is up.
 
 	dtc3181e=	[HW,SCSI]
 
-	earlyprintk=	[IA-32, X86-64]
+	earlyprintk=	[IA-32,X86-64]
 			earlyprintk=vga
 			earlyprintk=serial[,ttySn[,baudrate]]
 
-			Append ,keep to not disable it when the real console
+			Append ",keep" to not disable it when the real console
 			takes over.
 
 			Only vga or serial at a time, not both.
@@ -451,7 +460,7 @@ running once the system is up.
 			Format: {"of[f]" | "sk[ipmbr]"}
 			See comment in arch/i386/boot/edd.S
 
-	eicon=		[HW,ISDN] 
+	eicon=		[HW,ISDN]
 			Format: <id>,<membase>,<irq>
 
 	eisa_irq_edge=	[PARISC,HW]
@@ -462,12 +471,13 @@ running once the system is up.
 			arch/i386/kernel/cpu/cpufreq/elanfreq.c.
 
 	elevator=	[IOSCHED]
-			Format: {"as"|"cfq"|"deadline"|"noop"}
-			See Documentation/block/as-iosched.txt
-			and Documentation/block/deadline-iosched.txt for details.
+			Format: {"as" | "cfq" | "deadline" | "noop"}
+			See Documentation/block/as-iosched.txt and
+			Documentation/block/deadline-iosched.txt for details.
+
 	elfcorehdr=	[IA-32]
-			Specifies physical address of start of kernel core image
-			elf header.
+			Specifies physical address of start of kernel core
+			image elf header.
 			See Documentation/kdump.txt for details.
 
 	enforcing	[SELINUX] Set initial enforcing status.
@@ -485,7 +495,7 @@ running once the system is up.
 	es1371=		[HW,OSS]
 			Format: <spdif>,[<nomix>,[<amplifier>]]
 			See also header of sound/oss/es1371.c.
- 
+
 	ether=		[HW,NET] Ethernet cards parameters
 			This option is obsoleted by the "netdev=" option, which
 			has equivalent usage. See its documentation for details.
@@ -526,12 +536,13 @@ running once the system is up.
 
 	gus=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma16>
- 
+
 	gvp11=		[HW,SCSI]
 
 	hashdist=	[KNL,NUMA] Large hashes allocated during boot
 			are distributed across NUMA nodes.  Defaults on
 			for IA-64, off otherwise.
+			Format: 0 | 1 (for off | on)
 
 	hcl=		[IA-64] SGI's Hardware Graph compatibility layer
 
@@ -595,13 +606,13 @@ running once the system is up.
 	ide?=		[HW] (E)IDE subsystem
 			Format: ide?=noprobe or chipset specific parameters.
 			See Documentation/ide.txt.
-	
+
 	idebus=		[HW] (E)IDE subsystem - VLB/PCI bus speed
 			See Documentation/ide.txt.
 
 	idle=		[HW]
 			Format: idle=poll or idle=halt
- 
+
 	ihash_entries=	[KNL]
 			Set number of hash buckets for inode cache.
 
@@ -649,7 +660,7 @@ running once the system is up.
 			firmware running.
 
 	isapnp=		[ISAPNP]
-			Format: <RDP>, <reset>, <pci_scan>, <verbosity>
+			Format: <RDP>,<reset>,<pci_scan>,<verbosity>
 
 	isolcpus=	[KNL,SMP] Isolate CPUs from the general scheduler.
 			Format: <cpu number>,...,<cpu number>
@@ -661,32 +672,33 @@ running once the system is up.
 			"number of CPUs in system - 1".
 
 			This option is the preferred way to isolate CPUs. The
-			alternative - manually setting the CPU mask of all tasks
-			in the system can cause problems and suboptimal load
-			balancer performance.
+			alternative -- manually setting the CPU mask of all
+			tasks in the system -- can cause problems and
+			suboptimal load balancer performance.
 
 	isp16=		[HW,CD]
 			Format: <io>,<irq>,<dma>,<setup>
 
-	iucv=		[HW,NET] 
+	iucv=		[HW,NET]
 
 	js=		[HW,JOY] Analog joystick
 			See Documentation/input/joystick.txt.
 
 	keepinitrd	[HW,ARM]
 
-	kstack=N	[IA-32, X86-64] Print N words from the kernel stack
+	kstack=N	[IA-32,X86-64] Print N words from the kernel stack
 			in oops dumps.
 
 	l2cr=		[PPC]
 
-	lapic		[IA-32,APIC] Enable the local APIC even if BIOS disabled it.
+	lapic		[IA-32,APIC] Enable the local APIC even if BIOS
+			disabled it.
 
 	lasi=		[HW,SCSI] PARISC LASI driver for the 53c700 chip
 			Format: addr:<io>,irq:<irq>
 
-	llsc*=		[IA64]
-			See function print_params() in arch/ia64/sn/kernel/llsc4.c.
+	llsc*=		[IA64] See function print_params() in
+			arch/ia64/sn/kernel/llsc4.c.
 
 	load_ramdisk=	[RAM] List of ramdisks to load from floppy
 			See Documentation/ramdisk.txt.
@@ -713,8 +725,9 @@ running once the system is up.
 			7 (KERN_DEBUG)		debug-level messages
 
 	log_buf_len=n	Sets the size of the printk ring buffer, in bytes.
-			Format is n, nk, nM.  n must be a power of two.  The
-			default is set in kernel config.
+			Format: { n | nk | nM }
+			n must be a power of two.  The default size
+			is set in the kernel config file.
 
 	lp=0		[LP]	Specify parallel ports to use, e.g,
 	lp=port[,port...]	lp=none,parport0 (lp0 not configured, lp1 uses
@@ -750,23 +763,23 @@ running once the system is up.
 	ltpc=		[NET]
 			Format: <io>,<irq>,<dma>
 
-	mac5380=	[HW,SCSI]
-			Format: <can_queue>,<cmd_per_lun>,<sg_tablesize>,<hostid>,<use_tags>
+	mac5380=	[HW,SCSI] Format:
+			<can_queue>,<cmd_per_lun>,<sg_tablesize>,<hostid>,<use_tags>
 
-	mac53c9x=	[HW,SCSI]
-			Format: <num_esps>,<disconnect>,<nosync>,<can_queue>,<cmd_per_lun>,<sg_tablesize>,<hostid>,<use_tags>
+	mac53c9x=	[HW,SCSI] Format:
+			<num_esps>,<disconnect>,<nosync>,<can_queue>,<cmd_per_lun>,<sg_tablesize>,<hostid>,<use_tags>
 
-	machvec=	[IA64]
-			Force the use of a particular machine-vector (machvec) in a generic
-			kernel.  Example: machvec=hpzx1_swiotlb
+	machvec=	[IA64] Force the use of a particular machine-vector
+			(machvec) in a generic kernel.
+			Example: machvec=hpzx1_swiotlb
 
-	mad16=		[HW,OSS]
-			Format: <io>,<irq>,<dma>,<dma16>,<mpu_io>,<mpu_irq>,<joystick>
+	mad16=		[HW,OSS] Format:
+			<io>,<irq>,<dma>,<dma16>,<mpu_io>,<mpu_irq>,<joystick>
 
 	maui=		[HW,OSS]
 			Format: <io>,<irq>
- 
-	max_loop=       [LOOP] Maximum number of loopback devices that can
+
+	max_loop=	[LOOP] Maximum number of loopback devices that can
 			be mounted
 			Format: <1-256>
 
@@ -776,11 +789,11 @@ running once the system is up.
 	max_addr=[KMG]	[KNL,BOOT,ia64] All physical memory greater than or
 			equal to this physical address is ignored.
 
-	max_luns=	[SCSI] Maximum number of LUNs to probe
+	max_luns=	[SCSI] Maximum number of LUNs to probe.
 			Should be between 1 and 2^32-1.
 
 	max_report_luns=
-			[SCSI] Maximum number of LUNs received
+			[SCSI] Maximum number of LUNs received.
 			Should be between 1 and 16384.
 
 	mca-pentium	[BUGS=IA-32]
@@ -796,11 +809,11 @@ running once the system is up.
 
 	md=		[HW] RAID subsystems devices and level
 			See Documentation/md.txt.
- 
+
 	mdacon=		[MDA]
 			Format: <first>,<last>
 			Specifies range of consoles to be captured by the MDA.
- 
+
 	mem=nn[KMG]	[KNL,BOOT] Force usage of a specific amount of memory
 			Amount of memory to be used when the kernel is not able
 			to see the whole system memory or for test.
@@ -851,15 +864,15 @@ running once the system is up.
 	MTD_Partition=	[MTD]
 			Format: <name>,<region-number>,<size>,<offset>
 
-	MTD_Region=	[MTD]
-			Format: <name>,<region-number>[,<base>,<size>,<buswidth>,<altbuswidth>]
+	MTD_Region=	[MTD] Format:
+			<name>,<region-number>[,<base>,<size>,<buswidth>,<altbuswidth>]
 
 	mtdparts=	[MTD]
 			See drivers/mtd/cmdline.c.
 
 	mtouchusb.raw_coordinates=
-			[HW] Make the MicroTouch USB driver use raw coordinates ('y', default)
-			or cooked coordinates ('n')
+			[HW] Make the MicroTouch USB driver use raw coordinates
+			('y', default) or cooked coordinates ('n')
 
 	n2=		[NET] SDL Inc. RISCom/N2 synchronous serial card
 
@@ -880,7 +893,9 @@ running once the system is up.
 			Format: <irq>,<io>,<mem_start>,<mem_end>,<name>
 			Note that mem_start is often overloaded to mean
 			something different and driver-specific.
- 
+			This usage is only documented in each driver source
+			file if at all.
+
 	nfsaddrs=	[NFS]
 			See Documentation/nfsroot.txt.
 
@@ -893,8 +908,8 @@ running once the system is up.
 			emulation library even if a 387 maths coprocessor
 			is present.
 
-	noalign		[KNL,ARM] 
- 
+	noalign		[KNL,ARM]
+
 	noapic		[SMP,APIC] Tells the kernel to not make use of any
 			IOAPICs that may be present in the system.
 
@@ -905,19 +920,19 @@ running once the system is up.
 			on "Classic" PPC cores.
 
 	nocache		[ARM]
- 
+
 	nodisconnect	[HW,SCSI,M68K] Disables SCSI disconnects.
 
 	noexec		[IA-64]
 
-	noexec		[IA-32, X86-64]
+	noexec		[IA-32,X86-64]
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable nn-executable mappings
 
 	nofxsr		[BUGS=IA-32]
 
 	nohlt		[BUGS=ARM]
- 
+
 	no-hlt		[BUGS=IA-32] Tells the kernel that the hlt
 			instruction doesn't work correctly and not to
 			use it.
@@ -948,8 +963,9 @@ running once the system is up.
 
 	noresidual	[PPC] Don't use residual data on PReP machines.
 
-	noresume	[SWSUSP] Disables resume and restore original swap space.
- 
+	noresume	[SWSUSP] Disables resume and restores original swap
+			space.
+
 	no-scroll	[VGA] Disables scrollback.
 			This is required for the Braillex ib80-piezo Braille
 			reader made by F.H. Papenmeier (Germany).
@@ -965,16 +981,16 @@ running once the system is up.
 	nousb		[USB] Disable the USB subsystem
 
 	nowb		[ARM]
- 
+
 	opl3=		[HW,OSS]
 			Format: <io>
 
 	opl3sa=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>,<mpu_io>,<mpu_irq>
 
-	opl3sa2=	[HW,OSS]
-			Format: <io>,<irq>,<dma>,<dma2>,<mss_io>,<mpu_io>,<ymode>,<loopback>[,<isapnp>,<multiple]
- 
+	opl3sa2=	[HW,OSS] Format:
+			<io>,<irq>,<dma>,<dma2>,<mss_io>,<mpu_io>,<ymode>,<loopback>[,<isapnp>,<multiple]
+
 	oprofile.timer=	[HW]
 			Use timer interrupt instead of performance counters
 
@@ -993,36 +1009,33 @@ running once the system is up.
 			Format: <parport#>
 	parkbd.mode=	[HW] Parallel port keyboard adapter mode of operation,
 			0 for XT, 1 for AT (default is AT).
-			Format: <mode> 
+			Format: <mode>
 
-	parport=0	[HW,PPT]	Specify parallel ports. 0 disables.
-	parport=auto			Use 'auto' to force the driver to use
-	parport=0xBBB[,IRQ[,DMA]]	any IRQ/DMA settings detected (the
-					default is to ignore detected IRQ/DMA
-					settings because of possible
-					conflicts). You can specify the base
-					address, IRQ, and DMA settings; IRQ and
-					DMA should be numbers, or 'auto' (for
-					using detected settings on that
-					particular port), or 'nofifo' (to avoid
-					using a FIFO even if it is detected).
-					Parallel ports are assigned in the
-					order they are specified on the command
-					line, starting with parport0.
-
-	parport_init_mode=
-			[HW,PPT]	Configure VIA parallel port to
-					operate in specific mode. This is
-					necessary on Pegasos computer where
-					firmware has no options for setting up
-					parallel port mode and sets it to
-					spp. Currently this function knows
-					686a and 8231 chips.
+	parport=	[HW,PPT] Specify parallel ports. 0 disables.
+			Format: { 0 | auto | 0xBBB[,IRQ[,DMA]] }
+			Use 'auto' to force the driver to use any
+			IRQ/DMA settings detected (the default is to
+			ignore detected IRQ/DMA settings because of
+			possible conflicts). You can specify the base
+			address, IRQ, and DMA settings; IRQ and DMA
+			should be numbers, or 'auto' (for using detected
+			settings on that particular port), or 'nofifo'
+			(to avoid using a FIFO even if it is detected).
+			Parallel ports are assigned in the order they
+			are specified on the command line, starting
+			with parport0.
+
+	parport_init_mode=	[HW,PPT]
+			Configure VIA parallel port to operate in
+			a specific mode. This is necessary on Pegasos
+			computer where firmware has no options for setting
+			up parallel port mode and sets it to spp.
+			Currently this function knows 686a and 8231 chips.
 			Format: [spp|ps2|epp|ecp|ecpepp]
 
-	pas2=		[HW,OSS]
-			Format: <io>,<irq>,<dma>,<dma16>,<sb_io>,<sb_irq>,<sb_dma>,<sb_dma16>
- 
+	pas2=		[HW,OSS] Format:
+			<io>,<irq>,<dma>,<dma16>,<sb_io>,<sb_irq>,<sb_dma>,<sb_dma16>
+
 	pas16=		[HW,SCSI]
 			See header of drivers/scsi/pas16.c.
 
@@ -1032,64 +1045,67 @@ running once the system is up.
 			See header of drivers/block/paride/pcd.c.
 			See also Documentation/paride.txt.
 
-	pci=option[,option...]		[PCI] various PCI subsystem options:
-		off			[IA-32] don't probe for the PCI bus
-		bios			[IA-32] force use of PCI BIOS, don't access
-					the hardware directly. Use this if your machine
-					has a non-standard PCI host bridge.
-		nobios			[IA-32] disallow use of PCI BIOS, only direct
-					hardware access methods are allowed. Use this
-					if you experience crashes upon bootup and you
-					suspect they are caused by the BIOS.
-		conf1			[IA-32] Force use of PCI Configuration Mechanism 1.
-		conf2			[IA-32] Force use of PCI Configuration Mechanism 2.
-		nosort			[IA-32] Don't sort PCI devices according to
-					order given by the PCI BIOS. This sorting is done
-					to get a device order compatible with older kernels.
-		biosirq			[IA-32] Use PCI BIOS calls to get the interrupt
-					routing table. These calls are known to be buggy
-					on several machines and they hang the machine when used,
-					but on other computers it's the only way to get the
-					interrupt routing table. Try this option if the kernel
-					is unable to allocate IRQs or discover secondary PCI
-					buses on your motherboard.
-		rom			[IA-32] Assign address space to expansion ROMs.
-					Use with caution as certain devices share address
-					decoders between ROMs and other resources.
-		irqmask=0xMMMM		[IA-32] Set a bit mask of IRQs allowed to be assigned
-					automatically to PCI devices. You can make the kernel
-					exclude IRQs of your ISA cards this way.
+	pci=option[,option...]	[PCI] various PCI subsystem options:
+		off		[IA-32] don't probe for the PCI bus
+		bios		[IA-32] force use of PCI BIOS, don't access
+				the hardware directly. Use this if your machine
+				has a non-standard PCI host bridge.
+		nobios		[IA-32] disallow use of PCI BIOS, only direct
+				hardware access methods are allowed. Use this
+				if you experience crashes upon bootup and you
+				suspect they are caused by the BIOS.
+		conf1		[IA-32] Force use of PCI Configuration
+				Mechanism 1.
+		conf2		[IA-32] Force use of PCI Configuration
+				Mechanism 2.
+		nosort		[IA-32] Don't sort PCI devices according to
+				order given by the PCI BIOS. This sorting is
+				done to get a device order compatible with
+				older kernels.
+		biosirq		[IA-32] Use PCI BIOS calls to get the interrupt
+				routing table. These calls are known to be buggy
+				on several machines and they hang the machine
+				when used, but on other computers it's the only
+				way to get the interrupt routing table. Try
+				this option if the kernel is unable to allocate
+				IRQs or discover secondary PCI buses on your
+				motherboard.
+		rom		[IA-32] Assign address space to expansion ROMs.
+				Use with caution as certain devices share
+				address decoders between ROMs and other
+				resources.
+		irqmask=0xMMMM	[IA-32] Set a bit mask of IRQs allowed to be
+				assigned automatically to PCI devices. You can
+				make the kernel exclude IRQs of your ISA cards
+				this way.
 		pirqaddr=0xAAAAA	[IA-32] Specify the physical address
-					of the PIRQ table (normally generated
-					by the BIOS) if it is outside the
-					F0000h-100000h range.
-		lastbus=N		[IA-32] Scan all buses till bus #N. Can be useful
-					if the kernel is unable to find your secondary buses
-					and you want to tell it explicitly which ones they are.
-		assign-busses		[IA-32] Always assign all PCI bus
-					numbers ourselves, overriding
-					whatever the firmware may have
-					done.
-		usepirqmask		[IA-32] Honor the possible IRQ mask
-					stored in the BIOS $PIR table. This is
-					needed on some systems with broken
-					BIOSes, notably some HP Pavilion N5400
-					and Omnibook XE3 notebooks. This will
-					have no effect if ACPI IRQ routing is
-					enabled.
-		noacpi			[IA-32] Do not use ACPI for IRQ routing
-					or for PCI scanning.
-		routeirq		Do IRQ routing for all PCI devices.
-					This is normally done in pci_enable_device(),
-					so this option is a temporary workaround
-					for broken drivers that don't call it.
-
-		firmware		[ARM] Do not re-enumerate the bus but
-					instead just use the configuration
-					from the bootloader. This is currently
-					used on IXP2000 systems where the
-					bus has to be configured a certain way
-					for adjunct CPUs.
+				of the PIRQ table (normally generated
+				by the BIOS) if it is outside the
+				F0000h-100000h range.
+		lastbus=N	[IA-32] Scan all buses thru bus #N. Can be
+				useful if the kernel is unable to find your
+				secondary buses and you want to tell it
+				explicitly which ones they are.
+		assign-busses	[IA-32] Always assign all PCI bus
+				numbers ourselves, overriding
+				whatever the firmware may have done.
+		usepirqmask	[IA-32] Honor the possible IRQ mask stored
+				in the BIOS $PIR table. This is needed on
+				some systems with broken BIOSes, notably
+				some HP Pavilion N5400 and Omnibook XE3
+				notebooks. This will have no effect if ACPI
+				IRQ routing is enabled.
+		noacpi		[IA-32] Do not use ACPI for IRQ routing
+				or for PCI scanning.
+		routeirq	Do IRQ routing for all PCI devices.
+				This is normally done in pci_enable_device(),
+				so this option is a temporary workaround
+				for broken drivers that don't call it.
+		firmware	[ARM] Do not re-enumerate the bus but instead
+				just use the configuration from the
+				bootloader. This is currently used on
+				IXP2000 systems where the bus has to be
+				configured a certain way for adjunct CPUs.
 
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
@@ -1127,19 +1143,20 @@ running once the system is up.
 			[ISAPNP] Exclude DMAs for the autoconfiguration
 
 	pnp_reserve_io=	[ISAPNP] Exclude I/O ports for the autoconfiguration
-		     	Ranges are in pairs (I/O port base and size).
+			Ranges are in pairs (I/O port base and size).
 
 	pnp_reserve_mem=
-			[ISAPNP] Exclude memory regions for the autoconfiguration
+			[ISAPNP] Exclude memory regions for the
+			autoconfiguration.
 			Ranges are in pairs (memory base and size).
 
 	profile=	[KNL] Enable kernel profiling via /proc/profile
-			{ schedule | <number> }
-			(param: schedule - profile schedule points}
-			(param: profile step/bucket size as a power of 2 for
-				statistical time based profiling)
+			Format: [schedule,]<number>
+			Param: "schedule" - profile schedule points.
+			Param: <number> - step/bucket size as a power of 2 for
+				statistical time based profiling.
 
-	processor.max_cstate=   [HW, ACPI]
+	processor.max_cstate=	[HW,ACPI]
 			Limit processor to maximum C-state
 			max_cstate=9 overrides any DMI blacklist limit.
 
@@ -1147,27 +1164,28 @@ running once the system is up.
 			before loading.
 			See Documentation/ramdisk.txt.
 
-	psmouse.proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to
-			probe for (bare|imps|exps|lifebook|any).
+	psmouse.proto=	[HW,MOUSE] Highest PS2 mouse protocol extension to
+			probe for; one of (bare|imps|exps|lifebook|any).
 	psmouse.rate=	[HW,MOUSE] Set desired mouse report rate, in reports
 			per second.
-	psmouse.resetafter=
-			[HW,MOUSE] Try to reset the device after so many bad packets
+	psmouse.resetafter=	[HW,MOUSE]
+			Try to reset the device after so many bad packets
 			(0 = never).
 	psmouse.resolution=
 			[HW,MOUSE] Set desired mouse resolution, in dpi.
 	psmouse.smartscroll=
-			[HW,MOUSE] Controls Logitech smartscroll autorepeat,
+			[HW,MOUSE] Controls Logitech smartscroll autorepeat.
 			0 = disabled, 1 = enabled (default).
 
 	pss=		[HW,OSS] Personal Sound System (ECHO ESC614)
-			Format: <io>,<mss_io>,<mss_irq>,<mss_dma>,<mpu_io>,<mpu_irq>
+			Format:
+			<io>,<mss_io>,<mss_irq>,<mss_dma>,<mpu_io>,<mpu_irq>
 
 	pt.		[PARIDE]
 			See Documentation/paride.txt.
 
 	quiet=		[KNL] Disable log messages
- 
+
 	r128=		[HW,DRM]
 
 	raid=		[HW,RAID]
@@ -1176,10 +1194,9 @@ running once the system is up.
 	ramdisk=	[RAM] Sizes of RAM disks in kilobytes [deprecated]
 			See Documentation/ramdisk.txt.
 
-	ramdisk_blocksize=
-			[RAM]
+	ramdisk_blocksize=	[RAM]
 			See Documentation/ramdisk.txt.
- 
+
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			New name for the ramdisk parameter.
 			See Documentation/ramdisk.txt.
@@ -1195,7 +1212,8 @@ running once the system is up.
 
 	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 
-	resume=		[SWSUSP] Specify the partition device for software suspension
+	resume=		[SWSUSP]
+			Specify the partition device for software suspend
 
 	rhash_entries=	[KNL,NET]
 			Set number of hash buckets for route cache
@@ -1225,7 +1243,7 @@ running once the system is up.
 			Format: <io>,<irq>,<dma>,<dma2>
 
 	sbni=		[NET] Granch SBNI12 leased line adapter
- 
+
 	sbpcd=		[HW,CD] Soundblaster CD adapter
 			Format: <io>,<type>
 			See a comment before function sbpcd_setup() in
@@ -1258,21 +1276,20 @@ running once the system is up.
 
 	serialnumber	[BUGS=IA-32]
 
-	sg_def_reserved_size=
-			[SCSI]
- 
+	sg_def_reserved_size=	[SCSI]
+
 	sgalaxy=	[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>,<sgbase>
 
 	shapers=	[NET]
 			Maximal number of shapers.
- 
+
 	sim710=		[SCSI,HW]
 			See header of drivers/scsi/sim710.c.
 
 	simeth=		[IA-64]
 	simscsi=
- 
+
 	sjcd=		[HW,CD]
 			Format: <io>,<irq>,<dma>
 			See header of drivers/cdrom/sjcd.c.
@@ -1403,10 +1420,10 @@ running once the system is up.
 	snd-wavefront=	[HW,ALSA]
 
 	snd-ymfpci=	[HW,ALSA]
- 
+
 	sonicvibes=	[HW,OSS]
 			Format: <reverb>
- 
+
 	sonycd535=	[HW,CD]
 			Format: <io>[,<irq>]
 
@@ -1423,7 +1440,7 @@ running once the system is up.
 
 	sscape=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<mpu_io>,<mpu_irq>
- 
+
 	st=		[HW,SCSI] SCSI tape parameters (buffers, etc.)
 			See Documentation/scsi/st.txt.
 
@@ -1446,7 +1463,7 @@ running once the system is up.
 	stram_swap=	[HW,M68k]
 
 	swiotlb=	[IA-64] Number of I/O TLB slabs
- 
+
 	switches=	[HW,M68k]
 
 	sym53c416=	[HW,SCSI]
@@ -1479,14 +1496,16 @@ running once the system is up.
 	tp720=		[HW,PS2]
 
 	trix=		[HW,OSS] MediaTrix AudioTrix Pro
-			Format: <io>,<irq>,<dma>,<dma2>,<sb_io>,<sb_irq>,<sb_dma>,<mpu_io>,<mpu_irq>
- 
+			Format:
+			<io>,<irq>,<dma>,<dma2>,<sb_io>,<sb_irq>,<sb_dma>,<mpu_io>,<mpu_irq>
+
 	tsdev.xres=	[TS] Horizontal screen resolution.
 	tsdev.yres=	[TS] Vertical screen resolution.
 
-	turbografx.map[2|3]=
-			[HW,JOY] TurboGraFX parallel port interface
-			Format: <port#>,<js1>,<js2>,<js3>,<js4>,<js5>,<js6>,<js7>
+	turbografx.map[2|3]=	[HW,JOY]
+			TurboGraFX parallel port interface
+			Format:
+			<port#>,<js1>,<js2>,<js3>,<js4>,<js5>,<js6>,<js7>
 			See also Documentation/input/joystick-parport.txt
 
 	u14-34f=	[HW,SCSI] UltraStor 14F/34F SCSI host adapter
@@ -1502,17 +1521,18 @@ running once the system is up.
 
 	usbhid.mousepoll=
 			[USBHID] The interval which mice are to be polled at.
- 
+
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.txt.
 
 	vga=		[BOOT,IA-32] Select a particular video mode
-			See Documentation/i386/boot.txt and Documentation/svga.txt.
+			See Documentation/i386/boot.txt and
+			Documentation/svga.txt.
 			Use vga=ask for menu.
 			This is actually a boot loader parameter; the value is
 			passed to the kernel using a special protocol.
 
-	vmalloc=nn[KMG]	[KNL,BOOT] forces the vmalloc area to have an exact
+	vmalloc=nn[KMG]	[KNL,BOOT] Forces the vmalloc area to have an exact
 			size of <nn>. This can be used to increase the
 			minimum size (128MB on x86). It can also be used to
 			decrease the size and leave more room for directly
@@ -1520,11 +1540,11 @@ running once the system is up.
 
 	vmhalt=		[KNL,S390]
 
-	vmpoff=		[KNL,S390] 
- 
+	vmpoff=		[KNL,S390]
+
 	waveartist=	[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>
- 
+
 	wd33c93=	[HW,SCSI]
 			See header of drivers/scsi/wd33c93.c.
 
@@ -1538,21 +1558,25 @@ running once the system is up.
 	xd_geo=		See header of drivers/block/xd.c.
 
 	xirc2ps_cs=	[NET,PCMCIA]
-			Format: <irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
-
+			Format:
+			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
 
 
+______________________________________________________________________
 Changelog:
 
+2000-06-??	Mr. Unknown
 	The last known update (for 2.4.0) - the changelog was not kept before.
-	2000-06-??	Mr. Unknown
 
+2002-11-24	Petr Baudis <pasky@ucw.cz>
+		Randy Dunlap <randy.dunlap@verizon.net>
 	Update for 2.5.49, description for most of the options introduced,
 	references to other documentation (C files, READMEs, ..), added S390,
 	PPC, SPARC, MTD, ALSA and OSS category. Minor corrections and
 	reformatting.
-	2002-11-24	Petr Baudis <pasky@ucw.cz>
-			Randy Dunlap <randy.dunlap@verizon.net>
+
+2005-10-19	Randy Dunlap <rdunlap@xenotime.net>
+	Lots of typos, whitespace, some reformatting.
 
 TODO:
 

---

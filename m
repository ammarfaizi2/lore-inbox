Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265109AbSKESba>; Tue, 5 Nov 2002 13:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265116AbSKESba>; Tue, 5 Nov 2002 13:31:30 -0500
Received: from pasky.ji.cz ([62.44.12.54]:59379 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S265109AbSKESbK>;
	Tue, 5 Nov 2002 13:31:10 -0500
Date: Tue, 5 Nov 2002 19:37:37 +0100
From: Petr Baudis <pasky@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Updated Documentation/kernel-parameters.txt
Message-ID: <20021105183737.GQ2502@pasky.ji.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.46) updates Documentation/kernel-parameters.txt to
the current state of kernel. It was somehow abadonded lately, so I did my best,
but it's possible that I still missed some of the options - thus, if you will
notice your favourite boot option missing there, please speak up.

  Also, I attempted to introduce some uniform format to the entries, I added
the format description where I was able to find it out and decypher it, and I
also added gross amount of external links to the headers of the source files or
to the README-like files, where the options are described into more degree.
This way, hopefully this file has a chance to be actually usable for the users
;-).

  There are almost certainly some entries which I missed, it was really a huge
number and the main reason is that some of the boot options don't use the
__setup macro, which I grep'd for.

  I hope the patch is ok, there should be no problems with it. Please apply.

 kernel-parameters.txt |  785 ++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 601 insertions(+), 184 deletions(-)

  Kind regards,
				Petr Baudis

--- linux/Documentation/kernel-parameters.txt	Fri Nov  1 22:18:25 2002
+++ linux+pasky/Documentation/kernel-parameters.txt	Tue Nov  5 19:28:39 2002
@@ -1,21 +1,22 @@
-July 2000		  Kernel Parameters			v2.4.0
-			  ~~~~~~~~~~~~~~~~~
+November 2002             Kernel Parameters                     v2.5.46
+                          ~~~~~~~~~~~~~~~~~
 
 The following is a consolidated list of the kernel parameters as implemented
-by the __setup() macro and sorted into English Dictionary order (defined      
-as ignoring all punctuation and sorting digits before letters in a case
-insensitive manner), and with descriptions where known.
+(mostly) by the __setup() macro and sorted into English Dictionary order
+(defined as ignoring all punctuation and sorting digits before letters in a
+case insensitive manner), and with descriptions where known.
 
 The text in square brackets at the beginning of the description state the
 restrictions on the kernel for the said kernel parameter to be valid. The
 restrictions referred to are that the relevant option is valid if:
 
-	ACPI    ACPI support is enabled.
+	ACPI	ACPI support is enabled.
+	ALSA	ALSA sound support is enabled.
 	APIC	APIC support is enabled.
-	APM 	Advanced Power Management support is enabled.
+	APM	Advanced Power Management support is enabled.
 	AX25	Appropriate AX.25 support is enabled.
 	CD	Appropriate CD support is enabled.
-	DEVFS   devfs support is enabled. 
+	DEVFS	devfs support is enabled. 
 	DRM	Direct Rendering Management support is enabled. 
 	EFI	EFI Partitioning (GPT) is enabled
 	EIDE	EIDE/ATAPI support is enabled.
@@ -24,38 +25,44 @@
 	IA-32	IA-32 aka i386 architecture is enabled.
 	IA-64	IA-64 architecture is enabled.
 	IP_PNP	IP DCHP, BOOTP, or RARP is enabled.
-	ISAPNP  ISA PnP code is enabled.
+	ISAPNP	ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
-	JOY 	Appropriate joystick support is enabled.
+	JOY	Appropriate joystick support is enabled.
 	LP	Printer support is enabled.
 	LOOP	Loopback device support is enabled.
-	M68k	M68k architecture is enabled. 
-	MCA 	MCA bus support is enabled.
-	MDA 	MDA console support is enabled.
+	M68k	M68k architecture is enabled.
+			These options have more detailed description inside of
+			Documentation/m68k/kernel-options.txt.
+	MCA	MCA bus support is enabled.
+	MDA	MDA console support is enabled.
 	MOUSE	Appropriate mouse support is enabled.
-	NET 	Appropriate network support is enabled.
-	NFS 	Appropriate NFS support is enabled.
+	MTD	MTD support is nebaled.
+	NET	Appropriate network support is enabled.
+	NFS	Appropriate NFS support is enabled.
+	OSS	OSS sound support is enabled.
 	PARIDE	The ParIDE subsystem is enabled.
-	PCI 	PCI bus support is enabled.
+	PCI	PCI bus support is enabled.
 	PCMCIA	The PCMCIA subsystem is enabled.
-	PNP 	Plug & Play support is enabled.
+	PNP	Plug & Play support is enabled.
+	PPC	PowerPC architecture is enabled.
 	PPT	Parallel port support is enabled.
-	PS2 	Appropriate PS/2 support is enabled.
-	RAM 	RAM disk support is enabled.
+	PS2	Appropriate PS/2 support is enabled.
+	RAM	RAM disk support is enabled.
+	S390	S390 architecture is enabled.
 	SCSI	Appropriate SCSI support is enabled.
 	SERIAL	Serial support is enabled.
-	SMP 	The kernel is an SMP kernel.
-	SOUND	Appropriate sound system support is enabled.
-	SWSUSP  Software suspension is enabled.
+	SMP	The kernel is an SMP kernel.
+	SWSUSP	Software suspension is enabled.
+	USB	USB support is enabled.
 	V4L	Video For Linux support is enabled.
-	VGA 	The VGA console has been enabled.
+	VGA	The VGA console has been enabled.
 	VT	Virtual terminal support is enabled.
 	XT	IBM PC/XT MFM hard disk support is enabled.
 
 In addition, the following text indicates that the option:
 
 	BUGS=	Relates to possible processor bugs on the said processor.
-	KNL 	Is a kernel start-up parameter.
+	KNL	Is a kernel start-up parameter.
 	BOOT	Is a boot loader parameter.
 
 Parameters denoted with BOOT are actually interpreted by the boot
@@ -67,66 +74,105 @@
 it will appear as a kernel argument readable via /proc/cmdline by programs
 running once the system is up.
 
-	53c7xx=		[HW,SCSI] Amiga SCSI controllers.
+	53c7xx=		[HW,SCSI] Amiga SCSI controllers
+			See header of drivers/scsi/53c7xx.c.
+			See also drivers/scsi/README.ncr53c7xx.
 
 	acpi=		[HW,ACPI] Advanced Configuration and Power Interface 
+			Format: off[,<...>]
+			See also Documentation/pm.txt.
  
-	ad1816=		[HW,SOUND]
+	ad1816=		[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma2>
+			See also Documentation/sound/oss/AD1816.
 
-	ad1848=		[HW,SOUND]
- 
-	adb_buttons=	[HW,MOUSE]
+	ad1848=		[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma2>,<type>
 
-	adlib=		[HW,SOUND]
+	adlib=		[HW,OSS]
+			Format: <io>
  
 	advansys=	[HW,SCSI]
+			See header of drivers/scsi/advansys.c.
 
-	aedsp16=	[HW,SOUND]
+	aedsp16=	[HW,OSS] Audio Excel DSP 16
+			Format: <io>,<irq>,<dma>,<mss_io>,<mpu_io>,<mpu_irq>
+			See also header of sound/oss/aedsp16.c.
  
 	aha152x=	[HW,SCSI]
+			See drivers/scsi/README.aha152x.
 
 	aha1542=	[HW,SCSI]
+			Format: <portbase>[,<buson>,<busoff>[,<dmaspeed>]]
 
 	aic7xxx=	[HW,SCSI]
+			See header of drivers/scsi/aic7xxx/aic7xxx_linux.c.
+
+	allowdma0	[ISAPNP]
 
 	AM53C974=	[HW,SCSI]
+			Format: <host-scsi-id>,<target-scsi-id>,<max-rate>,<max-offset>
+			See also header of drivers/scsi/AM53C974.c.
 
 	amijoy=		[HW,JOY] Amiga joystick support 
  
-	apm=		[APM] Advanced Power Management.
+	apm=		[APM] Advanced Power Management
+			See header of arch/i386/kernel/apm.c.
 
 	applicom=	[HW]
+			Format: <mem>,<irq>
  
-	arcrimi=	[HW,NET]
+	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
+			Format: <io>,<irq>,<nodeID>
 
 	ataflop=	[HW,M68k]
 
-	atarimouse=	[HW,MOUSE] Atari Mouse.
+	atarimouse=	[HW,MOUSE] Atari Mouse
+
+	atascsi=	[HW,SCSI] Atari SCSI
 
-	atascsi=	[HW,SCSI] Atari SCSI.
+	atkbd_set=	[HW]
+	atkbd_reset=
 
-	awe=            [HW,SOUND]
+	autotest	[IA64]
+
+	awe=		[HW,OSS] AWE32/SB32/AWE64 wave table synth
+			Format: <io>,<memsize>,<isapnp>
  
-	aztcd=		[HW,CD] Aztec CD driver.
+	aztcd=		[HW,CD] Aztech CD268 CDROM driver
+			Format: <io>,0x79 (?)
 
 	baycom_epp=	[HW,AX25]
+			Format: <io>,<mode>
  
-	baycom_par= 	[HW,AX25] BayCom Parallel Port AX.25 Modem.
-
-	baycom_ser_fdx=	[HW,AX25] BayCom Serial Port AX.25 Modem in Full
-			Duplex Mode.
-
-	baycom_ser_hdx=	[HW,AX25] BayCom Serial Port AX.25 Modem in Half
-			Duplex Mode.
-
-	bmouse=		[HW,MOUSE,PS2] Bus mouse.
-
-	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards), most
-	bttv.radio=	important insmod options are available as kernel args too.
-	bttv.pll=	see Documentation/video4linux/bttv/Insmod-options
+	baycom_par=	[HW,AX25] BayCom Parallel Port AX.25 Modem
+			Format: <io>,<mode>
+			See header of drivers/net/hamradio/baycom_par.c.
+
+	baycom_ser_fdx=	[HW,AX25] BayCom Serial Port AX.25 Modem (Full Duplex Mode)
+			Format: <io>,<irq>,<mode>[,<baud>]
+			See header of drivers/net/hamradio/baycom_ser_fdx.c.
+
+	baycom_ser_hdx=	[HW,AX25] BayCom Serial Port AX.25 Modem (Half Duplex Mode)
+			Format: <io>,<irq>,<mode>
+			See header of drivers/net/hamradio/baycom_ser_hdx.c.
+
+	blkmtd_device=	[HW,MTD]
+	blkmtd_erasesz=
+	blkmtd_ro=
+	blkmtd_bs=
+	blkmtd_count=
+
+	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
+	bttv.radio=	Most important insmod options are available as kernel args too.
+	bttv.pll=	See Documentation/video4linux/bttv/Insmod-options
 	bttv.tuner=	and Documentation/video4linux/bttv/CARDLIST
 
 	BusLogic=	[HW,SCSI]
+			See drivers/scsi/BusLogic.c, comment before function
+			BusLogic_ParseDriverOptions().
+
+	c101=		[NET] Moxa C101 synchronous serial card
 
 	cachesize=	[BUGS=IA-32] Override level 2 CPU cache size detection.
 			Sometimes CPU hardware bugs make them report the cache
@@ -136,54 +182,84 @@
 			This option provides an override for these situations.
 
 	cdu31a=		[HW,CD]
+			Format: <io>,<irq>[,PAS]
+			See header of drivers/cdrom/cdu31a.c.
 
-	chandev=	[HW,NET] 
+	chandev=	[HW,NET] Generic channel device initialisation
  
 	cm206=		[HW,CD]
+			Format: { auto | [<io>,][<irq>] }
 
-	com20020=	[HW,NET]
+	com20020=	[HW,NET] ARCnet - COM20020 chipset
+			Format: <io>[,<irq>[,<nodeID>[,<backplane>[,<ckp>[,<timeout>]]]]]
 
-	com90io=	[HW,NET]
+	com90io=	[HW,NET] ARCnet - COM90xx chipset (IO-mapped buffers)
+			Format: <io>[,<irq>]
 
-	com90xx=	[HW,NET]
+	com90xx=	[HW,NET] ARCnet - COM90xx chipset (memory-mapped buffers)
+			Format: <io>[,<irq>[,<memstart>]]
 
-	condev=		[HW]
+	condev=		[HW,S390] console device
+	conmode=
  
-	console=	[KNL] output console + comm spec (speed, control,
-			parity).
+	console=	[KNL] Output console
+			Console device and comm spec (speed, control, parity).
 
 	cpia_pp=	[HW,PPT]
+			Format: { parport<nr> | auto | none }
 
-	cs4232=		[HW,SOUND]
+	cs4232=		[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma2>,<mpuio>,<mpuirq>
 
 	cs89x0_dma=	[HW,NET]
+			Format: <dma>
+
+	cs89x0_media=	[HW,NET]
+			Format: { rj45 | aui | bnc }
 
 	ctc=		[HW,NET]
+			See drivers/s390/net/ctcmain.c, comment before function
+			ctc_setup().
  
 	cyclades=	[HW,SERIAL] Cyclades multi-serial port adapter.
  
 	dasd=		[HW,NET]    
+			See header of drivers/s390/block/dasd_devmap.c.
 
-	db9=		[HW,JOY]
-
-	db9_2=		[HW,JOY]
+	dasd_discipline=
+			[HW,NET]
+			See header of drivers/s390/block/dasd.c.
 
-	db9_3=		[HW,JOY]
+	db9=		[HW,JOY]
+	db9_2=
+	db9_3=
  
 	debug		[KNL] Enable kernel debugging (events log level).
 
 	decnet=		[HW,NET]
+			Format: <area>[,<node>]
+			See also Documentation/networking/decnet.txt.
 
-	devfs=          [DEVFS]
+	decr_overclock= [PPC]
+	decr_overclock_proc0=
+
+	devfs=		[DEVFS]
+			See Documentation/filesystems/devfs/boot-options.
  
-	digi=		[HW,SERIAL] io parameters + enable/disable command.
+	digi=		[HW,SERIAL]
+			IO parameters + enable/disable command.
 
 	digiepca=	[HW,SERIAL]
+			See drivers/char/README.epca and
+			Documentation/digiepca.txt.
 
 	dmascc=		[HW,AX25,SERIAL] AX.25 Z80SCC driver with DMA
 			support available.
+			Format: <io_dev0>[,<io_dev1>[,..<io_dev32>]]
+
+	dmasound=	[HW,OSS] Sound subsystem buffers
 
-	dmasound=	[HW,SOUND] (sound subsystem buffers).
+	dscc4.setup=	[NET]
 
 	dtc3181e=	[HW,SCSI]
 
@@ -194,101 +270,153 @@
 	edb=		[HW,PS2]
 
 	eicon=		[HW,ISDN] 
+			Format: <id>,<membase>,<irq>
 
-	es1370=		[HW,SOUND]
+	eisa_irq_edge=	[PARISC]
+			See header of drivers/parisc/eisa.c.
 
-	es1371=		[HW,SOUND]
- 
-	ether=		[HW,NET] Ethernet cards parameters (irq,
-			base_io_addr, mem_start, mem_end, name.
-			(mem_start is often overloaded to mean something
-			different and driver-specific).
+	elanfreq=	[IA-32]
+			See comment before function elanfreq_setup() in
+			arch/i386/kernel/cpu/cpufreq/elanfreq.c.
+
+	es1370=		[HW,OSS]
+			Format: <lineout>[,<micbias>]
+			See also header of sound/oss/es1370.c.
+
+	es1371=		[HW,OSS]
+			Format: <spdif>,[<nomix>,[<amplifier>]]
+			See also header of sound/oss/es1371.c.
+ 
+	ether=		[HW,NET] Ethernet cards parameters
+			This option is obsoleted by the "netdev=" option, which
+			has equivalent usage. See its documentation for details.
 
 	fd_mcs=		[HW,SCSI]
+			See header of drivers/scsi/fd_mcs.c.
 
 	fdomain=	[HW,SCSI]
+			See header of drivers/scsi/fdomain.c.
 
 	floppy=		[HW]
+			See Documentation/floppy.txt.
 
 	ftape=		[HW] Floppy Tape subsystem debugging options.
+			See Documentation/ftape.txt.
 
 	gamma=		[HW,DRM]
 
 	gc=		[HW,JOY]
-
-	gc_2=		[HW,JOY]
-	 
-	gc_3=		[HW,JOY]
+	gc_2=		See Documentation/input/joystick-parport.txt.
+	gc_3=		
  
 	gdth=		[HW,SCSI]
+			See header of drivers/scsi/gdth.c.
 
-	gpt             [EFI] Forces disk with valid GPT signature but
+	gpt		[EFI] Forces disk with valid GPT signature but
 			invalid Protective MBR to be treated as GPT.
 
 	gscd=		[HW,CD]
+			Format: <io>
 
-	gus=		[HW,SOUND] 
+	gt96100eth=	[NET] MIPS GT96100 Advanced Communication Controller
+
+	gus=		[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma16>
  
 	gvp11=		[HW,SCSI]
 
-	hd= 		[EIDE] (E)IDE hard drive subsystem geometry
-			(Cyl/heads/sectors) or tune parameters.
+	hcl=		[IA-64] SGI's Hardware Graph compatibility layer
+
+	hd=		[EIDE] (E)IDE hard drive subsystem geometry
+			Format: <cyl>,<head>,<sect>
 
-	hfmodem=	[HW,AX25]
+	hd?=		[HW] (E)IDE subsystem
+	hd?lun=		See Documentation/ide.txt.
 
 	hisax=		[HW,ISDN]
+			See Documentation/isdn/README.HiSax.
+
+	i8042_reset	[HW]
+	i8042_noaux
+	i8042_nomux
+	i8042_unlock
+	i8042_direct
+	i8042_dumbkbd
 
 	i810=		[HW,DRM]
 
-	ibmmcascsi=	[HW,MCA,SCSI] IBM MicroChannel SCSI adapter.
+	ibmmcascsi=	[HW,MCA,SCSI] IBM MicroChannel SCSI adapter
+			See Documentation/mca.txt.
 
 	icn=		[HW,ISDN]
+			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
-	ide?=		[HW] (E)IDE subsystem : config (iomem/irq), tuning or
-			debugging (serialize,reset,no{dma,tune,probe}) or
-			chipset specific parameters.
+	ide?=		[HW] (E)IDE subsystem
+			Config (iomem/irq), tuning or debugging
+			(serialize,reset,no{dma,tune,probe}) or chipset
+			specific parameters.
+			See Documentation/ide.txt.
 	
-	idebus=		[HW] (E)IDE subsystem : VLB/PCI bus speed.
+	idebus=		[HW] (E)IDE subsystem - VLB/PCI bus speed
+			See Documentation/ide.txt.
 
 	idle=		[HW]
+			Format: poll
  
 	in2000=		[HW,SCSI]
+			See header of drivers/scsi/in2000.c.
 
 	init=		[KNL]
+			Format: <full_path>
+			Run specified binary instead of /sbin/init as init
+			process.
 
-	initrd=		[BOOT] Specify the location of the initial ramdisk. 
+	initrd=		[BOOT] Specify the location of the initial ramdisk
 
-	ip=		[IP_PNP]
+	inport_irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
+			Format: <irq>
 
-	isapnp=		[ISAPNP] Specify RDP, reset, pci_scan and verbosity.
+	inttest=	[IA64]
 
-	isapnp_reserve_irq= [ISAPNP] Exclude IRQs for the autoconfiguration.
+	ip=		[IP_PNP]
+			See Documentation/nfsroot.txt.
 
-	isapnp_reserve_dma= [ISAPNP] Exclude DMAs for the autoconfiguration.
+	ip2=		[HW]
+			See comment before ip2_setup() in drivers/char/ip2.c.
 
-	isapnp_reserve_io= [ISAPNP] Exclude I/O ports for the autoconfiguration.
-				    Ranges are in pairs (I/O port base and size).
+	ips=		[HW,SCSI] Adaptec / IBM ServeRAID controller
+			See header of drivers/scsi/ips.c.
 
-	isapnp_reserve_mem= [ISAPNP] Exclude memory regions for the autoconfiguration.
-				     Ranges are in pairs (memory base and size).
+	isapnp=		[ISAPNP]
+			Format: <RDP>, <reset>, <pci_scan>, <verbosity>
 
 	isp16=		[HW,CD]
+			Format: <io>,<irq>,<dma>,<setup>
 
 	iucv=		[HW,NET] 
 
 	js=		[HW,JOY] Analog joystick
- 
-	kbd-reset	[VT]
+			See Documentation/input/joystick.txt.
+
+	keepinitrd	[HW,ARM]
+
+	l2cr=		[PPC]
 
-	keepinitrd	[HW, ARM]
+	lasi=		[HW,SCSI] PARISC LASI driver for the 53c700 chip
+			Format: addr:<io>,irq:<irq>
 
-	load_ramdisk=	[RAM] List of ramdisks to load from floppy.
+	llsc*=		[IA64]
+			See function print_params() in arch/ia64/sn/kernel/llsc4.c.
+
+	load_ramdisk=	[RAM] List of ramdisks to load from floppy
+			See Documentation/ramdisk.txt.
 
 	lockd.udpport=	[NFS]
 
 	lockd.tcpport=	[NFS]
 
-	logi_busmouse=	[HW, MOUSE]
+	logibm_irq=	[HW] Logitech Bus Mouse Driver
+			Format: <irq>
 
 	lp=0		[LP]	Specify parallel ports to use, e.g,
 	lp=port[,port...]	lp=none,parport0 (lp0 not configured, lp1 uses
@@ -305,42 +433,52 @@
 				from each port should be examined, to see if
 				an IEEE 1284-compliant printer is attached; if
 				so, the driver will manage that printer.
+				See also header of drivers/char/lp.c.
 
-	ltpc=		[HW]
+	ltpc=		[NET]
+			Format: <io>,<irq>,<dma>
 
 	mac5380=	[HW,SCSI]
+			Format: <can_queue>,<cmd_per_lun>,<sg_tablesize>,<hostid>,<use_tags>
 
-	mac53c9x= 	[HW,SCSI]
+	mac53c9x=	[HW,SCSI]
+			Format: <num_esps>,<disconnect>,<nosync>,<can_queue>,<cmd_per_lun>,<sg_tablesize>,<hostid>,<use_tags>
 	
-	mad16=		[HW,SOUND]
+	mad16=		[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma16>,<mpu_io>,<mpu_irq>,<joystick>
 
-	maui=		[HW,SOUND]
+	maui=		[HW,OSS]
+			Format: <io>,<irq>
  
-	max_loop=[0-255] [LOOP] Set the maximum number of loopback devices
-				that can be mounted.
+	max_loop=       [LOOP] Maximum number of loopback devices that can
+			be mounted
+			Format: <1-256>
 
-	maxcpus=	[SMP] States the maximum number of processors that
-			an SMP kernel should make use of.
+	maxcpus=	[SMP] Maximum number of processors that	an SMP kernel
+			should make use of
 
 	max_scsi_luns=	[SCSI]
 
-	mca		[IA-32] On some pentium machines the mce support defaults
-				to off as the mainboard support is not always present.
-				You must activate it as a boot option
+	max_scsi_report_luns=
+			[SCSI] Maximum number of LUNs received
+			Should be between 1 and 16384.
 
 	mca-pentium	[BUGS=IA-32]
 
+	mcatest=	[IA-64]
+
 	mcd=		[HW,CD]
+			Format: <port>,<irq>,<mitsumi_bug_93_wait>
 
 	mcdx=		[HW,CD]
 
-	md=		[HW] RAID subsystems devices and level.
+	mce		[IA-32] Machine Check Exception
 
-	mdisk=		[HW]
+	md=		[HW] RAID subsystems devices and level
+			See Documentation/md.txt.
  
 	mdacon=		[MDA]
-
-	megaraid=	[HW,SCSI]
+			Format: <first>,<last>
  
 	mem=exactmap	[KNL,BOOT,IA-32] enable setting of an exact
 			e820 memory map, as specified by the user.
@@ -351,16 +489,29 @@
 			memory; to be used when the kernel is not able
 			to see the whole system memory or for test.
 
-	memfrac=	[KNL]
-
 	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
 			memory.
 
+	memfrac=	[KNL]
+
 	mga=		[HW,DRM]
 
-	mpu401=		[HW,SOUND]
- 
-	msmouse=	[HW,MOUSE] Microsoft Mouse.
+	mpu401=		[HW,OSS]
+			Format: <io>,<irq>
+
+	MTD_Partition=	[MTD]
+			Format: <name>,<region-number>,<size>,<offset>
+
+	MTD_Region=	[MTD]
+			Format: <name>,<region-number>[,<base>,<size>,<buswidth>,<altbuswidth>]
+
+	mtdparts=	[MTD]
+			See drivers/mtd/cmdline.c.
+
+	n2=		[NET] SDL Inc. RISCom/N2 synchronous serial card
+
+	NCR_D700=	[HW,SCSI]
+			See header of drivers/scsi/NCR_D700.c.
 
 	ncr5380=	[HW,SCSI]
 
@@ -372,17 +523,18 @@
 
 	ncr53c8xx=	[HW,SCSI]
 
-	netdev=		[NET] Ethernet cards parameters (irq,
-			base_io_addr, mem_start, mem_end, name.
-			(mem_start is often overloaded to mean something
-			different and driver-specific).
-			(cf: ether=)
+	netdev=		[NET] Network devices parameters
+			Format: <irq>,<io>,<mem_start>,<mem_end>,<name>
+			Note that mem_start is often overloaded to mean
+			something different and driver-specific.
  
 	nfsaddrs=	[NFS]
+			See Documentation/nfsroot.txt.
 
 	nfsroot=	[NFS] nfs root filesystem for disk-less boxes.
+			See Documentation/nfsroot.txt.
 
-	nmi_watchdog=	[KNL,BUGS=IA-32] debugging features for SMP kernels.
+	nmi_watchdog=	[KNL,BUGS=IA-32] Debugging features for SMP kernels
 
 	no387		[BUGS=IA-32] Tells the kernel to use the 387 maths
 			emulation library even if a 387 maths coprocessor
@@ -398,7 +550,11 @@
 
 	nocache		[ARM]
  
-	nodisconnect	[HW,SCSI, M68K] Disables SCSI disconnects.
+	nodisconnect	[HW,SCSI,M68K] Disables SCSI disconnects.
+
+	nofxsr		[BUGS=IA-32]
+
+	nohighio	[BUGS=IA-32] Disable highmem block I/O.
 
 	nohlt		[BUGS=ARM]
  
@@ -415,27 +571,42 @@
 
 	nointroute	[IA-64]
 
+	nomce		[IA-32] Machine Check Exception
+
 	noresume	[SWSUSP] Disables resume and restore original swap space.
  
 	no-scroll	[VGA]
 
+	nosbagart	[IA-64]
+
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel.
 
-	nosync		[HW, M68K] Disables sync negotiation for all devices.
+	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
-	notsc           [BUGS=IA-32] Disable Time Stamp Counter
+	notsc		[BUGS=IA-32] Disable Time Stamp Counter
+
+	nousb		[USB]
 
 	nowb		[ARM]
  
-	opl3=		[HW,SOUND]
+	opl3=		[HW,OSS]
+			Format: <io>
 
-	opl3sa=		[HW,SOUND]
+	opl3sa=		[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma2>,<mpu_io>,<mpu_irq>
 
-	opl3sa2=	[HW,SOUND]
+	opl3sa2=	[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma2>,<mss_io>,<mpu_io>,<ymode>,<loopback>[,<isapnp>,<multiple]
  
 	optcd=		[HW,CD]
+			Format: <io>
+
+	osst=		[HW,SCSI] SCSI Tape Driver
+			Format: <buffer_size>,<write_threshold>
+			See also drivers/scsi/README.st.
 
-	panic=		[KNL] kernel behaviour on panic.
+	panic=		[KNL] Kernel behaviour on panic
+			Format: <timeout>
 
 	parport=0	[HW,PPT]	Specify parallel ports. 0 disables.
 	parport=auto			Use 'auto' to force the driver to use
@@ -452,13 +623,17 @@
 					order they are specified on the command
 					line, starting with parport0.
 
-	pas2=		[HW,SOUND]
+	pas2=		[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma16>,<sb_io>,<sb_irq>,<sb_dma>,<sb_dma16>
  
 	pas16=		[HW,SCSI]
+			See header of drivers/scsi/pas16.c.
 
 	pcbit=		[HW,ISDN]
 
 	pcd.		[PARIDE]
+			See header of drivers/block/paride/pcd.c.
+			See also Documentation/paride.txt.
 
 	pci=option[,option...]		[PCI] various PCI subsystem options:
 		off			[IA-32] don't probe for the PCI bus
@@ -503,153 +678,395 @@
 					have no effect if ACPI IRQ routing is
 					enabled.
 
+	pcmv=		[HW,PCMCIA] BadgePAD 4
+
 	pd.		[PARIDE]
+			See Documentation/paride.txt.
 
 	pf.		[PARIDE]
+			See Documentation/paride.txt.
 
 	pg.		[PARIDE]
+			See Documentation/paride.txt.
+
+	pirq=		[SMP,APIC] Manual mp-table setup
+			See Documentation/i386/IO-APIC.txt.
+
+	plip=		[PPT,NET] Parallel port network link
+			Format: { parport<nr> | timid | 0 }
+			See also Documentation/parport.txt.
+
+	pnpbios=	[ISAPNP]
+			{ on | off | curr | res | no-curr | no-res }
+
+	pnp_reserve_irq=
+			[ISAPNP] Exclude IRQs for the autoconfiguration
+
+	pnp_reserve_dma=
+			[ISAPNP] Exclude DMAs for the autoconfiguration
 
-	pirq=		[SMP,APIC] mp-table.
+	pnp_reserve_io=	[ISAPNP] Exclude I/O ports for the autoconfiguration
+		     	Ranges are in pairs (I/O port base and size).
 
-	plip=		[PPT,NET] Parallel port network link.
+	pnp_reserve_mem=
+			[ISAPNP] Exclude memory regions for the autoconfiguration
+			Ranges are in pairs (memory base and size).
 
-	profile=	[KNL] enable kernel profiling via /proc/profile
-			(param:log level).
+	profile=	[KNL] Enable kernel profiling via /proc/profile
+			Format: <log_level>
 
 	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
 			before loading.
+			See Documentation/ramdisk.txt.
+
+	psmouse_noext	[HW] Disable PS2 mouse protocol extensions
+
+	pss=		[HW,OSS] Personal Sound System (ECHO ESC614)
+			Format: <io>,<mss_io>,<mss_irq>,<mss_dma>,<mpu_io>,<mpu_irq>
 
-	pss=		[HW,SOUND] 
- 
 	pt.		[PARIDE]
+			See Documentation/paride.txt.
 
-	quiet=		[KNL] Disable log messages.
+	quiet=		[KNL] Disable log messages
  
 	r128=		[HW,DRM]
 
 	raid=		[HW,RAID]
+			See Documentation/md.txt.
 
-	ramdisk=	[RAM] Sizes of RAM disks in kilobytes [deprecated].
+	ramdisk=	[RAM] Sizes of RAM disks in kilobytes [deprecated]
+			See Documentation/ramdisk.txt.
 
 	ramdisk_blocksize=
 			[RAM]
+			See Documentation/ramdisk.txt.
  
-	ramdisk_size=	[RAM] New name for the ramdisk parameter.
+	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
+			New name for the ramdisk parameter.
+			See Documentation/ramdisk.txt.
 
 	ramdisk_start=	[RAM] Starting block of RAM disk image (so you can
 			place it after the kernel image on a boot floppy).
+			See Documentation/ramdisk.txt.
 
-	reboot=		[BUGS=IA-32]
+	reboot=		[BUGS=IA-32,BUGS=ARM,BUGS=IA-64] Rebooting mode
+			Format: <reboot_mode>[,<reboot_mode2>[,...]]
+			See arch/*/kernel/reboot.c.
 
-	reserve=	[KNL,BUGS] force the kernel to ignore some iomem area.
+	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 
-	resume=		[SWSUSP] specify the partition device for software suspension.
+	resume=		[SWSUSP] Specify the partition device for software suspension
 
 	riscom8=	[HW,SERIAL]
+			Format: <io_board1>[,<io_board2>[,...<io_boardN>]]
+
+	ro		[KNL] Mount root device read-only on boot
 
-	ro		[KNL] Mount root device read-only on boot.
+	root=		[KNL] Root filesystem
 
-	root=		[KNL] root filesystem.
+	rootflags=	[KNL] Set root filesystem mount option string
 
-	rootflags=	[KNL] set root filesystem mount option string
+	rootfstype=	[KNL] Set root filesystem type
 
-	rootfstype=	[KNL] set root filesystem type
+	rw		[KNL] Mount root device read-write on boot
 
-	rw		[KNL] Mount root device read-write on boot.
+	S		[KNL] Run init in single mode
 
-	S		[KNL] run init in single mode.
+	sa1100ir	[NET]
+			See drivers/net/irda/sa1100_ir.c.
 
-	sb=		[HW,SOUND]
+	sb=		[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma2>
+
+	sbni=		[NET] Granch SBNI12 leased line adapter
  
-	sbpcd=		[HW,CD] Soundblaster CD adapter.
+	sbpcd=		[HW,CD] Soundblaster CD adapter
+			Format: <io>,<type>
+			See a comment before function sbpcd_setup() in
+			drivers/cdrom/sbpcd.c.
+
+	scsi_debug_*=	[SCSI]
+			See drivers/scsi/scsi_debug.c.
 
 	scsi_logging=	[SCSI]
 
 	scsihosts=	[SCSI]
 
+	serialnumber	[BUGS=IA-32]
+
 	sg_def_reserved_size=
 			[SCSI]
  
-	sgalaxy=	[HW,SOUND]
+	sgalaxy=	[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma2>,<sgbase>
+
+	shapers=	[NET]
+			Maximal number of shapers.
  
 	sim710=		[SCSI,HW]
+			See header of drivers/scsi/sim710.c.
+
+	simeth=		[IA-64]
+	simscsi=
  
 	sjcd=		[HW,CD]
+			Format: <io>,<irq>,<dma>
+			See header of drivers/cdrom/sjcd.c.
+
+	slram=		[HW,MTD]
 
 	smart2=		[HW]
+			Format: <io1>[,<io2>[,...,<io8>]]
+
+	snd-ad1816a=	[HW,ALSA]
+
+	snd-ad1848=	[HW,ALSA]
+
+	snd-ali5451=	[HW,ALSA]
+
+	snd-als100=	[HW,ALSA]
+
+	snd-als4000=	[HW,ALSA]
+
+	snd-azt2320=	[HW,ALSA]
+
+	snd-cmi8330=	[HW,ALSA]
+
+	snd-cmipci=	[HW,ALSA]
+
+	snd-cs4231=	[HW,ALSA]
+
+	snd-cs4232=	[HW,ALSA]
+
+	snd-cs4236=	[HW,ALSA]
+
+	snd-cs4281=	[HW,ALSA]
+
+	snd-cs46xx=	[HW,ALSA]
+
+	snd-dt019x=	[HW,ALSA]
+
+	snd-dummy=	[HW,ALSA]
+
+	snd-emu10k1=	[HW,ALSA]
+
+	snd-ens1370=	[HW,ALSA]
+
+	snd-ens1371=	[HW,ALSA]
+
+	snd-es968=	[HW,ALSA]
+
+	snd-es1688=	[HW,ALSA]
+
+	snd-es18xx=	[HW,ALSA]
+
+	snd-es1938=	[HW,ALSA]
+
+	snd-es1968=	[HW,ALSA]
+
+	snd-fm801=	[HW,ALSA]
+
+	snd-gusclassic=	[HW,ALSA]
+
+	snd-gusextreme=	[HW,ALSA]
+
+	snd-gusmax=	[HW,ALSA]
+
+	snd-hdsp=	[HW,ALSA]
+
+	snd-ice1712=	[HW,ALSA]
+
+	snd-intel8x0=	[HW,ALSA]
+
+	snd-interwave=	[HW,ALSA]
+
+	snd-interwave-stb=
+			[HW,ALSA]
+
+	snd-korg1212=	[HW,ALSA]
+
+	snd-maestro3=	[HW,ALSA]
+
+	snd-mpu401=	[HW,ALSA]
+
+	snd-mtpav=	[HW,ALSA]
+
+	snd-nm256=	[HW,ALSA]
+
+	snd-opl3sa2=	[HW,ALSA]
+
+	snd-opti92x-ad1848=
+			[HW,ALSA]
+
+	snd-opti92x-cs4231=
+			[HW,ALSA]
+
+	snd-opti93x=	[HW,ALSA]
+
+	snd-pmac=	[HW,ALSA]
+
+	snd-rme32=	[HW,ALSA]
+
+	snd-rme96=	[HW,ALSA]
+
+	snd-rme9652=	[HW,ALSA]
+
+	snd-sb8=	[HW,ALSA]
+
+	snd-sb16=	[HW,ALSA]
+
+	snd-sbawe=	[HW,ALSA]
+
+	snd-serial=	[HW,ALSA]
+
+	snd-sgalaxy=	[HW,ALSA]
+
+	snd-sonicvibes=	[HW,ALSA]
+
+	snd-sun-amd7930=
+			[HW,ALSA]
+
+	snd-sun-cs4231=	[HW,ALSA]
+
+	snd-trident=	[HW,ALSA]
+
+	snd-usb-audio=	[HW,ALSA,USB]
+
+	snd-via82xx=	[HW,ALSA]
+
+	snd-virmidi=	[HW,ALSA]
+
+	snd-wavefront=	[HW,ALSA]
+
+	snd-ymfpci=	[HW,ALSA]
  
-	sonicvibes=	[HW,SOUND]
+	sonicvibes=	[HW,OSS]
+			Format: <reverb>
  
 	sonycd535=	[HW,CD]
+			Format: <io>[,<irq>]
 
-	sound=		[SOUND]
+	sonypi=		[HW] Sony Programmable I/O Control Device driver
+			Format: <minor>,<verbose>,<fnkeyinit>,<camera>,<compat>,<nojogdial>
 
-	soundmodem=	[HW,AX25,SOUND] Use sound card as packet radio modem.
+	soundmodem=	[HW,AX25,SOUND] Use sound card as packet radio modem
+			Format: <io>,<irq>,<dma>[,<dma2>[,<serio>[,<pario>]]],<mode>
+			mode: hw:modem
+			hw: sbc, wss, wssfdx
+			modem: afsk1200, fsk9600
 
-	specialix=	[HW,SERIAL] Specialix multi-serial port adapter.
+	specialix=	[HW,SERIAL] Specialix multi-serial port adapter
+			See Documentation/specialix.txt.
 
-	sscape=		[HW,SOUND]
+	spia_io_base=	[HW,MTD]
+	spia_fio_base=
+	spia_pedr=
+	spia_peddr=
+
+	spread_lpevents=
+			[PPC]
+
+	sscape=		[HW,OSS]
+			Format: <io>,<irq>,<dma>,<mpu_io>,<mpu_irq>
  
-	st=		[HW,SCSI] SCSI tape parameters (buffers, etc.).
+	st=		[HW,SCSI] SCSI tape parameters (buffers, etc.)
+			See drivers/scsi/README.st.
 
 	st0x=		[HW,SCSI]
+			See header of drivers/scsi/seagate.c.
 
-	stram_swap=	[HW]
+	stram_swap=	[HW,M68k]
 
-	swiotlb=        [IA-64] Number of I/O TLB slabs.
+	swiotlb=	[IA-64] Number of I/O TLB slabs
  
-	switches=	[HW, M68K]
+	switches=	[HW,M68k]
 
 	sym53c416=	[HW,SCSI]
+			See header of drivers/scsi/sym53c416.c.
 
 	sym53c8xx=	[HW,SCSI]
+			See drivers/scsi/README.ncr53c8xx.
 
 	t128=		[HW,SCSI]
+			See header of drivers/scsi/t128.c.
 
 	tdfx=		[HW,DRM]
  
-	tgfx=		[HW,JOY]
+	tgfx=		[HW,JOY] TurboGraFX parallel port interface
+	tgfx_2=		See Documentation/input/joystick-parport.txt.
+	tgfx_3=
 
-	tgfx_2=		[HW,JOY]
+	tipar=		[HW]
+			See header of drivers/char/tipar.c.
 
-	tgfx_3=		[HW,JOY]
+	tiusb=		[HW,USB] Texas Instruments' USB GraphLink (aka SilverLink)
+			Format: <timeout>
  
 	tmc8xx=		[HW,SCSI]
+			See header of drivers/scsi/seagate.c.
 
 	tmscsim=	[HW,SCSI]
+			See comment before function dc390_setup() in
+			drivers/scsi/tmscsim.c.
 
 	tp720=		[HW,PS2]
 
-	trix=		[HW,SOUND]
+	trix=		[HW,OSS] MediaTrix AudioTrix Pro
+			Format: <io>,<irq>,<dma>,<dma2>,<sb_io>,<sb_irq>,<sb_dma>,<mpu_io>,<mpu_irq>
  
-	u14-34f=	[HW,SCSI]
+	u14-34f=	[HW,SCSI] UltraStor 14F/34F SCSI host adapter
+			See header of drivers/scsi/u14-34f.c.
 
-	uart401=	[HW,SOUND]
-
-	uart6850=	[HW,SOUND]
- 
-	usbfix		[BUGS=IA-64] 
- 
-	video=		[FB] frame buffer configuration.
+	uart401=	[HW,OSS]
+			Format: <io>,<irq>
 
-	vga=		[BOOT] on IA-32, select a particular video mode
-			(use vga=ask for menu).  This is actually a
-			boot loader parameter; the value is passed to
-			the kernel using a special protocol.  See
-			linux/Documentation/i386/boot.txt for information.
+	uart6850=	[HW,OSS]
+			Format: <io>,<irq>
+ 
+	video=		[FB] Frame buffer configuration
+			See Documentation/fb/modedb.txt.
+
+	vga=		[BOOT,IA-32] Select a particular video mode
+			See Documentation/i386/boot.txt and Documentation/svga.txt.
+			Use vga=ask for menu.
+			This is actually a boot loader parameter; the value is
+			passed to the kernel using a special protocol.
 
 	vmhalt=		[KNL,S390]
 
 	vmpoff=		[KNL,S390] 
  
-	waveartist=	[HW,SOUND]
+	waveartist=	[HW,OSS]
+			Format: <io>,<irq>,<dma>,<dma2>
  
 	wd33c93=	[HW,SCSI]
+			See header of drivers/scsi/wd33c93.c.
 
 	wd7000=		[HW,SCSI]
+			See header of drivers/scsi/wd7000.c.
 
-	wdt=		[HW]
+	wdt=		[HW] Watchdog
+			See Documentation/watchdog.txt.
 
 	xd=		[HW,XT] Original XT pre-IDE (RLL encoded) disks.
+	xd_geo=		See header of drivers/block/xd.c.
+
+	xirc2ps_cs=	[NET,PCMCIA]
+			Format: <irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
+
+
+
+Changelog:
+
+	The last known update (for 2.4.0) - the changelog was not kept before.
+	2000-06-?? Mr. Unknown
+
+	Update for 2.5.46, description for most of the options introduced,
+	references to other documentation (C files, READMEs, ..), added S390,
+	PPC, MTD, ALSA and OSS category. Minor corrections and reformat.
+	2002-11-05 Petr Baudis <pasky@ucw.cz>
+
+TODO:
 
-	xd_geo=		[HW,XT]
+	Add documentation of ALSA options.
+	Add more DRM drivers.

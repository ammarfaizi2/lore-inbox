Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131224AbRCGXk3>; Wed, 7 Mar 2001 18:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131227AbRCGXkW>; Wed, 7 Mar 2001 18:40:22 -0500
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:63942 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S131224AbRCGXkI>; Wed, 7 Mar 2001 18:40:08 -0500
Date: Wed, 07 Mar 2001 17:20:56 -0600
From: Erik DeBill <edebill@swbell.net>
Subject: Linux 2.4.2ac12 and ac13 breaks usb-visor
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu>; from
 alan@lxorguk.ukuu.org.uk on Tue, Mar 06, 2001 at 10:42:33PM +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Message-id: <20010307172056.A8647@austin.rr.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-disposition: inline
Content-transfer-encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I went to install some new software on my Visor yesterday and got a
rude surpise, as my system froze hard (unpingable, no response to
keyboard or mouse, no oops).  A bit of experimenting shows:

It works fine with usb-uhci in all versions I tested.

Plain 2.4.2 works fine with either usb-uhci or uhci.

On ac12 and 13 if the visor driver is compiled into the kernel it will
work poorly for a time (very slow sync, jpilot/pilot-link complains of
"weird packet" or "timeout") and then quit, refusing to even register
when the device connects.  Once this happens, after hitting the "sync"
button the pda just sits and eventually times out, saying it failed to
connect to the desktop.

If I compile the driver as a module on ac12 and 13 it will hang the
system on module unload after a failed attempt to install software to
the pda.  Normal syncs may work, but installing 3-4 files will hang
the system every time.  Since the Visor only registers as a USB device
for the duration of the transfer this hangs the system as soon as the
sync attempt quits.

In no case do I get any error messages in the logs, no console
messages, and no oops.

This isn't a critical issue, as the usb-uhci driver works fine, but
the uhci driver is the default.  Still, hanging the system is
misbehavior.

I also noticed that selecting to statically compile usb serial
adapters, then selecting module for the Visor driver wouldn't compile
the Visor module.  As long as the usb serial and Visor were both set
the same (either static or module) it compiles fine.

I'd be happy to test patches, or step back through the 2.4.2-ac series
to find exactly where things broke (but the changelog below shows a
change to the visor in 2.4.2-ac12).


Thanks,
Erik


On Tue, Mar 06, 2001 at 10:42:33PM +0000, Alan Cox wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 2.4.2-ac13
> o	Clean up mad16 detection stuff			(Pavel Rabel)
> o	Fix epca unload					(Andrey Panin)
> o	Change null apic handling			(Maciej Rozycki)
> o	aicasm now uses db3				(Sergey Kubushin)
> o	Fix aic7xxx cross compile			(Cort Dougan)
> o	Merge small net driver fixups/config fixes	(Jeff Garzik)
> o	Update symbios drivers				(Gérard Roudier)
> o	Rusty has moved					(Rusty Russell)
> o	3c509/3c515 compile fixes			(Jeff Garzik)
> o	Console locking updates - should fix vesafb	(Andrew Morton)
> 	clock problems
> o	Merge the serial.c 5.0.5 update			(Jeff Garzik, 
> 							Ted Ts'o)
> o	Merge SiS framebuffer updates			(Can-Ru Yeou)
> o	Update ctrlfb					(Takashi Oe,
> 							 Michel Lanners)
> o	Add epson 640U scanner to the usb scanner list	(Patrick Dreker)
> 
> 2.4.2-ac12
> o	Move the pci_enable_device for cardbus		(David Hinds)
> o	Add Sony MSC-U01N to the unusual devices	(Marcel Holtmann)
> o	Final smc-mca fixups - should now work		(James Bottomley)
> o	Document kernel string/mem* functions		(Matthew Wilcox)
> 	| and I added a memcpy warning
> o	Update VIA IDE driver to 3.21			(Vojtech Pavlik)
> 	|No UDMA66 on 82c686, fix /proc and udma on
> 	|686b, fix dma disables
> o	Allow sleeping in ctrl-alt-del callbacks	(Andrew Morton)
> 	|Fix i2o, dac960, watchdog, gdth hangs on exit
> o	Fix binfmt_misc (and make the proc handling	(Al Viro)
> 	|a filesystem -
> 	|mount -t binfmt_misc none /proc/sys/fs/binfmt_misc
> o	Update the ACI support for sound/radio stuff	(Robert Siemer)
> o	Add RDS support to miroRadio			(Robert Siemer)
> o	Remove serverworks handling. The BIOS is our	(me)
> 	best (and right now only) hope for that chip
> o	Tune the vm behavioru a bit more		(Mike Galbraith)
> o	Update PAS16 documentation			(Thomas Molina)
> o	Reiserfs tools recommended are now 0d not 0b	(Steven Cole)
> o	Wan driver small fixes				(Jeff Garzik)
> o	Net driver fixes for 3c503, 3c509, 3c515,	(Jeff Garzik)
> 	8139too, de4x5, defxx, dgrs, dmfe, eth16i, 
> 	ewrk3, natsemi, ni5010, pci-skeleton, rcpci45,
> 	sis900, sk_g16, smc-ultra, sundance, tlan,
> 	via-rhine, winbond-840, yellowfin, wavelan_cs
> 	tms380tr
> o	Trim 3K off the aha1542 driver size	(Andrzej Krzysztofowicz)
> o	Trim 1K off qlogicfas			(Andrzej Krzysztofowicz)
> o	Fix openfirmware/mm boot on ppc			(Cort Dougan)
> o	Fix topdir handling in Makefile			(Keith Owens)
> o	Minor fusion driver updates			(Steve Ralston)
> o	Merge Etrax cris updates			(Bjorn Wesen)
> o	Clgen fb copyright update			(Jeff Garzik)
> o	AGP linkage fix					(Jeff Garzik)
> o	Update visor driver to work with minijam	(Arnim Laeuger)
> o	Fix a usb devio return code			(Dan Streetman)
> o	Resync a few other net device changes with the
> 	submits Jeff sent to Linus			(Jeff Garzik)
> o	Add missing md export symbol			(Mohammad Haque)
> 
> 2.4.2-ac11
> o	Fix NLS Config.in				(David Weinehall)
> o	Sort out one escaped revert from the megaraid	(me)
> 	update
> o	Resync with Linux 2.4.3pre1
> 	| Except tulip the network driver changes have
> 	| been used to replace the existing ones
> o	Fix parport case where a reader could get stuck	(Tim Waugh)
> o	Add ALi15x3 to the list of isa dma hangs	(Angelo Di Filippo)
> o	Fix nasty bug in IPX routing of netbios frames	(Arnaldo Carvalho
> 							 de Melo)
> o	Misc code cleanups				(Keith Owens)
> o	Updated 3c527 driver				(Richard Proctor)
> o	Further tulip updates				(Jeff Garzik)
> o	i810_rng fixes (FIPS test, regions)		(Jeff Garzik)
> o	Further cs89x0 cleanups				(Andrew Morton)
> o	Further USB hub updates				(Dave Brownell)
> o	Mall USB resource cleanup			(Jeff Garzik)
> o	Resync hp100 changes from Jeff Garzik		(Jeff Garzik)
> o	PCI documentation update			(Tim Waugh)
> o	Fix irda crash					(Jean Tourrilhes)
> o	PPC updates					(Cort Dougan)
> o	Resync dmfe, hamachi, pci-skeleton and winbond	(Jeff Garzik)
> 
> 2.4.2-ac10
> o	Add ZF-Logic watchdog driver			(Fernando Fuganti)
> o	Add devfs support to USB printers		(Mark McClelland)
> o	Fix baud rate handling on keyspan		(Paul Mackerras)
> o	USB documentation update			(Dave Brownell)
> o	Fix disconnect leak				(Randy Dunlap)
> o	ARM constants/fixes				(Russell King)
> o	Includes for integrator ARM architecture	(Russell King)
> o	Update NLS descriptions to be clearer		(Pablo Saratxaga)
> o	Add iso-8859-13 (latvian/lithuanian)		(Pablo Saratxaga)
> 	iso-8859-4, cp1251 (windows cyrillic), cp1255
> 	(windows hebrew), and some alises
> o	Merge 1.14 Megaraid driver			(Venkatesh Ramamurthy)
> o	Reapply other fixes this version dropped	(me)
> o	Reformat and clean up ifdefs in 1.14 Megaraid	(me)
> o	I/O apnic locking fixes				(Maciej Rozycki)
> o	Print ioapic id to help debugging		(Maciej Rozycki)
> o	Make the tpqic driver work			(Hugh Dickins)
> o	USB scanner updates				(David Nelson)
> o	Fix usbdevfs multimount				(Al Viro)
> o	Fix wrong calculation of path buffer size	(Hugh Dickins)
> o	cs89x0 allocated far too much memory		(Hugh Dickins)
> 
> 2.4.2-ac9
> o	misc device fix (ps/2 and drm are now back)	(Tachino Nobuhiro)
> 	| Believe it or not my main test box used no misc
> 	| device files..
> o	Radeon build without 8bit			(Cha Young-Ho)
> o	Fix oops in scc driver				(Andrew Morton)
> o	Add __setup for ISAPnP, update docs		(Jaroslav Kysela)
> o	Update E820 table sanitizer			(Brian Moyle)
> o	i810 audio updates/mmap fixes			(Doug Ledford)
> o	Be paranoid about VIA chipset configurations	(Arjan van de Ven)
> 	| Fixing VIA disk corruption bugs take 2
> o	Fix PPC request_irq problems, some fpu emu	(Cort Dougan)
> 	and timers
> o	Allow scsi drivers to limit request sizes	(Jens Axboe,
> 	(and fixed by Tim)				 Tim Waugh)
> o	Configure.help cleanups				(Steve Cole)
> o	Loop device fix of the day			(Jens Axboe)
> o	CDROM fixes					(Jens Axboe)
> o	Reiserfs crash on fsync of dir fix	(Alexander Zarochentcev)
> 
> 2.4.2-ac8
> o	Fix loop over loop crash			(Jens Axboe)
> o	Fix radeon build problems			(ISHIKAWA Mutsumi)
> o	Stop two people claiming the same misc dev id	(Philipp Rumpf)
> o	capable not suser on sx.c			(Rob Radez)
> o	Fix an ixj build combination bug	(Andrzej Krzysztofowicz)
> o	Add integrator to ARM machines			(Russell King)
> o	ARM include/constant cleanups			(Russell King)
> o	Update ARM vmlinuz.in				(Russell King)
> o	ARM i2c fixes					(Russell King)
> o	ARM scsi updates				(Russell King)
> o	ARM header updates				(Russell King)
> o	Handle E820 bios returns with overlaps		(Brian Moyle)
> o	Fix a sparc64 include build bug		(Andrzej Krzysztofowicz)
> o	Loop race fix					(Jens Axboe)
> o	s_maxbytes wasnt set for old style compat	(Chris Dukes)
> 	mounts in reiserfs
> o	Fix the fact we dont see all busses on some	(Don Dupuis)
> 	Compaq machines
> o	Fix missing watchdog configure.help		(Jakob Ostergaard)
> o	Fix oom deadlock (hopefully)			(Rik van Riel)
> o	Fix binfmt_aout sign handling bug		(Andrew Morton)
> 
> 2.4.2-ac7
> o	Fusion driver updates				(Steve Ralston)
> o	Olympic fix					(Andrew Morton)
> o	Work around hardware bug in older Rage128	(Gareth Hughes)
> o	Handle broken PIV MP tables with a NULL ioapic
> o	Use capable in esp serial driver		(Rob Radez)
> o	Use capable not suser in console		(Rob Radez)
> o	Small networking fixups				(Dave Miller)
> o	Fix make menuconfig breakage			(Keith Owens)
> o	Enable cmpxchg8 on Rise P6			(Dave Jones)
> o	Fix wakeup losses on cpu_allowed using tasks	(Manfred Spraul)
> o	Maestro3 now works with > 256Mb of ram		(Zach Brown)
> o	Opl3sa2 isapnp=0 handling was wrong		(Jérôme Augé)
> 	| I've fixed it a little differently however
> o	Turn off slow kmem chain check if not doing	(Ingo Molnar, me)
> 	slab debugging
> o	Fix cpu speed checking code			(Mikael Pettersson)
> o	Make bus computation more accurate		(me)
> o	Advantech watchdog driver			(Marek Michalkiewicz)
> o	dz.c serial clean up				(Rob Radez)
> o	Fix MSG_TRUNC for OOB TCP			(Ingo Molnar)
> o	Fix oops on unconfigured loop			(Arjan van de Ven)
> o	Drop nbd ll_rw_blk change			(Linus has spoken ;))
> o	pci resource api				(Jeff Garzik)
> o	Further Natsemi updates				(Don Becker, 
> 							 Jeff Garzik)
> o	Switch aurora serial to capable()		(Rob Radez)
> o	Radeon frame buffer				(Ani Joshi)
> 
> 2.4.2-ac6
> o	Remove incorrect modules doc changes		(Keith Owens)
> o	Fix elf.h defines				(Keith Owens)
> o	Add 0x2B mtrr decode for intel/cyrix III	(me)
> o	Make bigmem balancing somewhat saner		(Mark Hemment)
> o	Update irda 					(Dag Brattli)
> o	New FIR dongle support				(Dag Brattli)
> o	3ware driver updates				(Adam Radford)
> o	Further reiserfs tail conversion fixes		(Chris Mason)
> o	Fix tpqic02 to use capable			(Rob Radez)
> o	Set last_rx on comtrol hostess driver		(Arnaldo Carvalho 
> 							 de Melo)
> o	Raid Oops fix					(Neil Brown)
> o	Fix last_rx/skb refs on cyc_x25			(Arnaldo Carvalho 
> 							 de Melo)
> o	Fix last_rx/skb refs on 3c589			(Arnaldo Carvalho 
> 							 de Melo)
> o	Highmem fixes for deadlock			(Andrea Arcangeli,
> 							 Ingo Molnar)
> o	Another minor tulip fix				(Jeff Garzik)
> o	Fix hinote and maybe other ps/aux hangs		(me, Mark Clegg)
> o	Fix resource handling on 53c7xxx		(Rasmus Andersen)
> o	Fix scsi_register failure handling on AMD scsi	(Rasmus Andersen)
> o	Fix resource handling on aha1740		(Rasmus Andersen)
> o	Fix resource handling on blz1230		(Rasmus Andersen)
> o	Fix resource handling for dec_esp driver	(Rasmus Andersen)
> o	Fix resource handling for fastlane scsi		(Rasmus Andersen)
> o	Fix scsi_register failure on qlogic_fas		(Rasmus Andersen)
> o	Fix scsi_register failure on qlogicfc		(Rasmus Andersen)
> o	Fix irq alloc failure leak on sun3x_esp		(Rasmus Andersen)
> o	Fix wd7000 init failures			(Rasmus Andersen)
> o	Fix nbd device					(Steve Whitehouse)
> o	Fix try_atomic_semop				(Manfred Spraul)
> o	Parport fixes					(Tim Waugh)
> o	Starfire start/stop if fix			(Ion Badulescu)
> o	Fix raw.c off by one bug			(Tigran Aivazian)
> o	USB hub kmalloc wrong size corruption fix	(Peter Zaitcev)
> 
> 2.4.2-ac5
> o	Add Epson 1240U scanners to usb scanner		(Joel Becker)
> o	Fix eth= compatibility				(Andrew Morton)
> 	| Should fix 3c509 problems for one
> o	Add Pnp table to opl3sa2			(Bill Nottingham)
> o	Update loop driver fixes			(Jens Axboe, Andrea
> 							 Arcangeli, Al Viro)
> o	Fix busy loop in usb storage			(Arjan van de Ven)
> o	Add cardbus support to olympic			(Mike Phillips)
> o	Make BUG() configurable to save space		(Arjan van de Ven)
> o	Add configurability to most kernel debugging	(various people)
> 	functions on x86
> o	Richard Günther/binfmt_misc page move		(Richard Günther)
> o	Fix de4x5 crash					(Nikita Schmidt)
> o	Hopefully fix the smc-mca driver		(me)
> o	Don't run the disk queue if we didnt launder	(Marcelo Tosatti)
> 	any pages
> o	ALi 6 channel audio and sp/dif updates		(Matt Wu)
> o	Fix USB thread wakeup scheduling		(Arjan van de Ven)
> o	Fix alignment problems with uni16_to_x8		(Ivan Kokshaysky)
> 
> 2.4.2-ac4
> o	Fix Make xconfig failure			(J Magallon)
> o	Fix a typo in the ISDN docs			(Jim Freeman)
> o	Fix the 3ware driver a bit more			(Ben LaHaise)
> 	| should now be usable
> o	Update Dave Jones contact info			(Dave Jones)
> o	Revert wavelan inline->macro change		(Jean Tourillhes)
> 	| CVS gcc and 2.96-74 don't accidentally unline it now
> o	Zerocopy TCP/IP patches				(Dave Miller, 
> 							 Alexey Kuznetsov,
> 							 and many more)
> o	Fix up command line options to old ncr driver	(Martin Storsjö)
> o	NFS locking should call fs layer locking if	(Brian Dixon)
> 	present
> o	Fix cs46xx wakeup/poll problem			(David Huggins-Daines)
> o	Add some missing MTD config help texts		(Steven Cole,
> 							 David Woodhouse)
> o	Fix Alpha build bug				(Sven Koch)
> o	Final i386/ptrace bit
> o	Finish off the vmalloc/WP fixup			(me)
> o	Include file config.h fixes			(Niels Jensen)
> o	More dscc4 updates				(Francois Romieu)
> 
> 2.4.2-ac3
> o	Add documentation for the fb interfaces		(Brad Douglas)
> o	Work around apic disable_irq hardware bugs	(Maciej Rozycki)
> o	Rage128 not "Rage 128"				(Brad Douglas)
> o	Make ioremap debugging conditional		(J Magallon)
> o	Merge Ninja pcmcia scsi driver			(YOKOTA Hiroshi)
> o	Update 8139too docs				(Jeff Garzik)
> o	Tulip updates, merge bits from 0.92 		(Jeff Garzik,
> 							 Don Becker)
> o	Epic100 update					(Jeff Garzik)
> o	Clean up Ariadne driver				(Jeff Garzik)
> o	Remove dead wavelan prototype			(Jeff Garzik)
> o	Remove unused arlan variable			(Jeff Garzik)
> o	Clean up lance public symbols			(Jeff Garzik)
> o	Switch fmv18x to spinlocks, fix other bits	(Jeff Garzik)
> o	Clean up acenic global symbols			(Jeff Garzik)
> o	Fix IDE blocking kmalloc with irqs off		(Arjan van de Ven)
> 	| I've redone the code a bit so it might be wrong again 8)
> 
> 2.4.2-ac2
> o	Merge the loop device fixes			(Jens Axboe)
> o	Fix af_unix SYSCTL=n build failure		(Russell King)
> o	Adjust the throttling point for write		(Jens Axboe)
> 	throttles
> o	Fix sunhme ioremap				(Andrey Panin)
> o	Fix disk change handling with removable sd	(Alex Davis)
> o	Update/fix irq docs				(Matthew Wilcox)
> o	Update PPC gmac and ncr885e drivers		(Cort Dougan)
> 	| bmac patch dropped as it loses other fixes
> o	Kai Petzke has moved				(Kai Petzke)
> o	Fix starfire driver so pump doesnt kill it	(Ion Badulescu)
> 
> 2.4.2-ac1
> o	Merge Linus 2.4.2 tree
> 	| We now have disagreeing ymfpci fixes. I've kept the ones
> 	| I tested for now.
> o	Back out sr.c change				(me)
> o	Fix moxa smartio driver				(Tom Mraz)
> o	Hugh Blemings change of address			(Hugh Blemings)
> o	Allow more i2o config time for slow calls
> o	Aty128fb updates				(Brad Douglas,
> 						      Benjamin Herrenschmidt,
> 							 Michel Danzer,
> 							 Andreas Hundt)
> o	Add "loop" name to the root dev names		(Barry Nathan)
> o	Further spelling cleanups			(Dag Wieers)
> o	Remove bogus warning emissions from aha1740	(Nick Holloway)
> o	Remove surplus assignment in vmalloc		(Francis Galiegue)
> o	Remove unneeded ifdef in i386/kernel/irq.c	(Francis Galiegue)
> o	Add door locking ioctl to ide-floppy		(Francis Galiegue)
> o	Allow scsi disk opening O_NDELAY for removables	(me)
> o	Fix cosa compile warnings			(me)
> o	Clean up dumpable/setuid write ordering		(me)
> o	Hopefully fix the 3ware crashes 		(me)
> 
> 2.4.1-ac20
> o	Update fusion drivers				(Steve Ralston)
> o	Further VM page launder balancing		(Rik van Riel)
> o	Hopefully fix ext2 block size checking		(Andries Brouwer)
> o	Update the i810 random number generator		(Jeff Garzik)
> o	Hopefully fix the bonding crash on down/reboot	(Dave Miller)
> o	Tulip update (add accton comets, clean up pm)	(Jeff Garzik)
> o	Merge wavelan_cs, pcnet_cs and fmvj18x_cs	(Jeff Garzik)
> 	changes from Dave Hinds tree
> o	Make awe32 behave in 2.4 like 2.2 if given an	(Bill Nottingham)
> 	io
> o	Fix alpha build problems in stallion, c101     (Andrzej Krzysztofowicz)
> 	synclink and wavfront drivers
> o	Add isa_check_signature and missing ioctl ids  (Andrzej Krzysztofowicz)
> 	for hayesesp
> o	Fix math emulation bug				(Martin Schwidefsky)
> o	Disable APIC during APM to avoid suspend/resume (Mikael Pettersson)
> 	problems.
> o	SMP kernel on UP hardware APIC fixes		(Maciej Rozycki)
> o	Code cleanups in nmi, reduce NMI rate to 1Hz	(Mikael Pettersson)
> 
> 2.4.1-ac19
> o	Fix second module/exception table race		(me)
> 	| I hope ;)
> o	Additional CPIA usb ident			(Adam J Richter)
> o	Add SA1100 udc and also stall recovery to 	(Oleg Drokin)
> 	usbnet
> o	Limit smbfs to 2Gig/file			(Urban Widmark)
> o	Config/doc update for the eicon driver		(Armin Schindler)
> o	Update PMS driver to new request_region		(Andrey Panin)
> o	sys_semop bug check is overcareful		(Hugh Dickins)
> o	Fix ipc off by one on checks in ipc		(Hugh Dickins)
> o	Allow exceptions during module init		(Philipp Rumpf)
> o	Driver namespace cleanup			(Jeff Garzik)
> o	Network driver cleanups				(Jeff Garzik, 
> o	PPC irq updates					(Paul Mackerras)
> o	SMP fixes for PPC boxes				(Paul Mackerras)
> o	Fix tmpfs block size reporting			(Christoph Rohland)
> o	Update maintainers to add missing YAM maintainer(Jean-Paul Roubelat)
> o	Add hooks for /proc/rtas			(Paul Mackerras)
> o	Fix wrong bogomip reporting on SMP ppc		(Paul Mackerras)
> o	Remove unused dbcf inline function on PPC	(Paul Mackerras)
> o	Update Cort Dougans email/urls			(Paul Mackerras)
> o	Dont assume bit settings on pcnet/pci chips	(Paul Mackerras)
> o	Add mac ppc serial console hooks		(Paul Mackerras)
> o	Frame buffer driver updates for ppc		(Paul Mackerras)
> o	Fix devfs names for ppc serial			(Paul Mackerras)
> o	Move some symbols out of net where they didnt	
> 	belong, and into right export locations     (Andrzej Krzysztofowicz)
> o	Tidy and fix up syncppp drivers			(Krzysztof Halasa)
> 
> 2.4.1-ac18
> o	Fix SO_SNDTIMEO bugs				(Alexey Kuznetsov)
> o	Fix tmpfs fsync					(Lennert Buytenhek)
> o	PPC now uses generic pci bus setup		(Paul Mackerras)
> o	Remove PPC boot argument printing		(Paul Mackerras)
> o	Jeff Tranter has moved				(Jeff Tranter)
> o	ymf_pci driver cleanups				(Pete Zaitcev)
> o	Fix USB 2.0 compliance in hub.c			(Brad Hards)
> o	Fix usb hub device claim race			(Paul Mackerras)
> o	Fix some bugs in mac_hid driver			(Paul Mackerras)
> o	Fix more typos					(Dag Wieers)
> o	PPC compile warnings/symbol export fixes	(Paul Mackerras)
> 
> 2.4.1-ac17
> o	Fix pegasus for bigendian			(Roman Weissgaerber)
> o	Further smbfs fixes				(Urban Widmark)
> o	Update ISDN version tags			(Kai Germaschewski)
> o	Finish ISDN move to new style module_init	(Kai Germaschewski)
> o	Small Eicon driver updates/fix license bug	(Armin Schindler)
> o	Fix reiserfs tail packing problem		(Alexander Zarochentcev
> 							 Chris Mason)
> o	Export aci symbols from drivers/sound/aci.c	(Alexandr Kanevskiy)
> o	Merge Linus 2.4.2pre4
> o	Starfire update					(Ionu Badulescu)
> o	Fix 3270 merge					(Richard Hitt)
> 
> 2.4.1-ac16
> o	Fix the exception table/unload race		(me)
> o	Further tulip fixup				(Manfred Spraul)
> o	Fix USB oops on traverse/delete race		(Randy Dunlap)
> o	Set max_sectors to 255 for hd/xd drivers	(Paul Gortmaker)
> 	| This should make them work again
> o	Fix typo in USB makefile			(Arjan van de Ven)
> o	Fix accidental change to scsi_scan		(Steve Ralston)
> o	Hid rollover/endian fixes			(Paul Mackerras)
> o	Drop via pci fixup				(me)
> o	Further hp5300 fixups				(Arjan van de Ven)
> o	PCnet 32 init changes for non SEPROM cards	(Eli Carter)
> o	Fix acpi idle reporting on SMP			(Philipp Hahn)
> o	Add non PCI pci device list walk macro		(me)
> 	| pointed out by Mikael Pettersson
> o	IBM S/390 3270 drivers				(Richard Hitt)
> 
> 2.4.1-ac15
> o	Fix the non booting winchip/cyrix problem	(me)
> 	| Nasty interaction with the vmalloc fix 
> 	| wants a cleaner solution. This one is a hack
> 	| to get people up and running again
> o	Fix typo in vfat changes			(OGAWA Hirofumi)
> o	Update scsi blacklist table			(Karsten Hopp)
> o	dscc4 wan driver update				(Francois Romieu)
> o	Fix clgenfb warning				(Bryan Headley)
> 	
> 2.4.1-ac14
> o	Fix tulip problems introduced by in ac13	(Manfred Spraul)
> o	S/390x build fixes				(Ulrich Weigand)
> o	Fix off by one error in octagon driver		(David Woodhouse)
> o	Fix dasd driver for new queues			(Holger Smolinksi)
> o	Networking standards compliance fixes
> o	Fix binary layout assumptions in sym53c416	(Arjan van de Ven)
> o	tmpfs timestamps				(Christoph Rohland)
> o	Further mkdep changes				(Keith Owens)
> o	Fix 16bit vfat handling				(OGAWA Hirofumi)
> o	JIS nls fixes					(OGAWA Hirofumi)
> o	Handle more than 8 luns				(Eric Youngdale,
> 							 Doug Gilbert)
> o	Minor scsi clean ups				(Eric Youngdale)
> 
> 2.4.1-ac13
> o	Fix pnic tulip problems				(Manfred Spraul)
> o	Fix USB printer read and poll problems		(Johannes Erdfelt)
> o	Fix parport pci list corrupt bug		(Tim Waugh)
> o	Fix sbpcd driver crashes			(Paul Gortmaker)
> o	Clarify the locking doc				(Rusty Russell)
> o	i810 audio doesnt need OSS			(Jeff Garzik)
> o	Fix vmalloc fault race				(Mark Hemment)
> o	Makedep fixes					(Keith Owens)
> o	Fix missing unlock_kernel on usb hub		(Paul Mundt)
> o	Fix smbfs+bigmem, buffer and listing bugs	(Urban Widmark)
> o	Merge tms380 isa token ring support		(Jochen Friedrich)
> o	Sigmatel change didnt help, removed		(Jeff Garzik)
> 
> 2.4.1-ac12
> o	Make tmpfs use link counts of 2 on directories	(Christoph Rohland)
> o	Update Documentation/sound/Introductions	(Wade Hampton)
> o	Fix bug in new tlb shootdown code		(Ben LaHaise)
> o	Add isa_* api to the Alpha			(Richard Henderson)
> o	Export down_trylock on Alpha			(Richard Henderson)
> o	Fix maestro3 build on ia64			(Bill Nottingham)
> 
> 2.4.1-ac11
> o	Hack the setup code to do the right thing for	(me)
> 	Cyrix processors. Cpuid on cyrix should now work
> o	Change sigmatel codec inits			(Jeff Garzik)
> o	Revised TLB shootdown patch			(Ben LaHaise)
> o	Use pci quirks to handle the nonstandard irq	(Andrey Panin)
> 	setup for VIA ACPI
> o	If a user sets an io on the opl3sa2 assume they (me)
> 	mean it even if isapnp isnt turned off
> o	Fix xmms cpu burn on i810 audio			(Marcus Sundberg)
> o	Fix pnic problems with tulip driver		(Manfred Spraul)
> o	Add pci skeleton driver				(Jeff Garzik)
> o	Fix vfat mishandling of 16bit characters	(Kazuki Yasumatsu)
> o	Fix syntax things found by his source code	(Jean-Luc Leger)
> 	analyser
> o	Fix pcmcia ixj build bug			(Florian)
> o	Remove dead via sound docs			(Jeff Garzik)
> o	add __dev_alloc_skb for drivers needing to force(Jeff Garzik)
> 	allocation types
> o	Fix arcnet initializers				(Jeff Garzik)
> o	Fix various warnings				(Keith Owens)
> o	Further MPT fusion updates			(Steve Ralston)
> o	sock_alloc_send_skb fix				(Manfred Spraul)
> o	Fix signed/unsigned handling on 8139too		(Jeff Garzik)
> o	Document problem with old powertweak		(Dave Jones)
> o	s/controler/controller/ spelling fixes
> o	S/390 build fixes				(Neale Ferguson)
> 
> 2.4.1-ac10
> o	Merge with Linus 2.4.2pre3
> o	More net driver clean up			(Jeff Garzik)
> o	Further maxiradio fix				(Francois Romieu)
> o	Lock reclaiming fixes				(MCL)
> o	Update ver_linux				(Steven Cole)
> o	Add support for the Socket LP-E CF+ ethernet	(Nicolas Pitre)
> o	Fix microtek scanner abort handling		(Oliver Neukum)
> o	Fix very dumb bug in my dma.c changes that 	(me)
> 	Linus noticed
> o	Clean up AGP alloc/destroy a little 		(me)
> 	| Again a Linus request
> o	Remove dead 8129 config help			(Dave Jones)
> o	Clean up extra unneeded check in setup.c	(Dave Jones)
> o	Improve mkdep, remove acpi special case		(Keith Owens)
> o	Fix bogus dead comment in fs.h			(Jens Axboe)
> o	Clean up config.in syntax errors		(Christoph Hellwig)
> o	Offer Duron in CPU option list for clarity	(Terje Rosten)
> o	New binutils need --oformat, old ones handle it	(Andreas Jaeger)
> o	Move bitops include in fs.h inside __KERNEL__	(Herbert Xu)
> o	Fix misspellings of weird			(Felix Odenkirchen)
> o	Fix typos of 'valid' while we are at it		(Luuk van der Duim)
> 
> 2.4.1-ac9
> o	Merge with Linus 2.4.2pre2
> o	Highmem bounce fixes				(Ingo Molnar)
> o	Fix cosa driver kfree				(Jan Kasprzak)
> o	Clean up pdoc202xx driver sleeps		(Vojtech Pavlik)
> o	Final bits of NFS file handle changes		(Trond Myklebust)
> o	Fix usbnet driver 				(David Brownell)
> o	ATM includes fixes				(Werner Almesberger)
> o	Remove unneeded vm_enough_memory check		(Werner Almesberger)
> o	Fix free_dma prototype case			(Bill Nottingham)
> o	Fix build bugs from pci_match_device fix	(me)
> o	HP5300 USB scanner driver			(Oliver Neukum,
> 							 John Fremlin,
> 							 Jeremy Hall)
> o	DSP_SETFRAGMENT fixes for ymfpci		(Pavel Roskin)
> o	Fix codafs error returns			(Rob Radez)
> o	Fix 48 misspellings of interrupt		(André Dahlqvist)
> o	Fix 20 misspellings of successful		(André Dahlqvist)
> o	Fix 11 misspellings of suppress			(André Dahlqvist)
> o	Fix 46 misspellings of address			(André Dahlqvist)
> o	Fix 26 misspellings of receive			(André Dahlqvist)
> o	Fix 7 misspellings of acquire			(André Dahlqvist)
> o	Fix 4 misspellings of unneccessary		(André Dahlqvist)
> o	Fix 13 misspellings of until			(André Dahlqvist)
> 
> 2.4.1-ac8
> o	Fix irlap speed changes and kfrees		(Jean Tourrilhes)
> o	Further NTFS updates				(Anton Altaparmakov,
> 						Yuri Per, Rob Radez)
> o	Fix buglets in config.in for aic7xxx	       (Andrzej Krzysztofowicz)
> o	Cleanup irda QoS code				(Jean Tourrilhes)
> o	Fix mca documentations				(Rob Radez)
> o	Fix irlan device attach problems		(Dag Brattli)
> o	Fix irda dongle crash case			(Dag Brattli)
> o	Change Kaweth firmware loading, add DU-E10	(Eric Sandeen)
> o	pci_enable cleanups for networking		(Jeff Garzik)
> o	Fix rcpci45 probing				(Jeff Garzik)
> o	Use SET_MODULE_OWNER() in lanstreamer		(Jeff Garzik)
> o	Use pcmcia defines as per seperate pcmcia net	(Jeff Garzik)
> o	Fix people calling netif_start_queue from a 	(Jeff Garzik)
> 	timeout
> o	Remove 8129 driver (use 8139too)		(Jeff Garzik)
> o	Remove dead malloc.h from net drivers		(Jeff Garzik)
> o	Update eata driver to 6.04			(Dario Ballabio)
> o	Add DE320 support to ne2.c			(Alfred Arnold)
> o	Kernel hacking doc updates			(John Levon)
> o	Fix CPU detection offsets in head.S		(Mikael Pettersson)
> o	Fix apic init/cpu detect problems		(Mikael Pettersson)
> 
> 2.4.1-ac7
> o	Rebalance the 2.4.1 VM				(Rik van Riel)
> 	| This should make things feel a lot faster especially
> 	| on small boxes .. feedback to Rik
> o	Silence osf syscall error printk		(Ivan Kokshaysky)
> o	Don't trust ARC irq routing on ruffian		(Ivan Kokshaysky)
> o	Report the right module on 3c59x for pcmcia	(Arjan van de Ven)
> o	Update i82365 driver to add locks, delays, and	(Arjan van de Ven)
> 	'bouncing' on the card detect
> o	Get the name right on ide-cs (v ide_cs) and do	(Arjan van de Ven)
> 	resource claims
> o	Merge parport_cs				(David Hinds)
> o	Merge sedlbauer_cs				(Marcus Niemann)
> o	Fix a bug in the Cyrix pirq routing		(me)
> 
> 2.4.1-ac6
> o	Fix eepro100 reporting on lockup fix		(Ion Badulescu)
> o	Clean up i810 error message			(me)
> o	Fix S390 build bug				(me)
> o	Update version id on cpqarray driver		(Charles White)
> o	Further aic7xxx fixes				(Doug Ledford)
> 	| again please report aic7xxx stuff to Doug
> o	Further maxiradio cleanups		(Dimitromanolakis Apostolos)
> o	Change ide to use mdelay cleanly		(Petr Vandrovec)
> 	| Still broken for PROMISE if no IDE_CS
> o	Fix duplicated ncpfs fix			(Petr Vandrovec)
> o	Improve inode hash function			(Dave Miller)
> o	Correct 62 misspellings of transferred		(Andre Dahlqvist)
> o	Update AC97 codec setup and tables		(Jeff Garzik)
> 
> 2.4.1-ac5
> o	Fix zero page corruption			(Ben La Haise)
> o	Elevator corruption fixes			(Jens Axboe, Linus)
> o	Fix fdatasync possible corruption problem	(Arjan van de Ven)
> o	Further KSLI ethernet fixes			(Eric Sandeen)
> o	Merge the correct version of the pm fixes	(me)
> 	| noted by Mikael Pettersson
> o	Account for inode/dcache in free memory 	(Rik van Riel)
> o	Add info on how to check reiserfsprogs versions	(Steven Cole)
> o	Disable write combining on serverworks LE chips	(Mark Rusk)
> o	Fix via audio crashes				(Jeff Garzik)
> o	Fix ip accounting rules bug			(Rusty Russell)
> o	Handle USB printers that use device not 	(Johannes Erdfelt)
> 	interface descriptors
> o	Fix wheel on graphire usb tablet		(Peter Hofmann)
> o	Clean up maxiradio driver			(Francois Romieu)
> o	Fix visor USB size reporting on buffers		(Greg Kroah-Hartmann)
> o	Update USB serial documentation			(Greg Kroah-Hartmann)
> o	Fix locking on etherworks3 ethernet		(Jeff Garzik)
> o	Fix empeg USB driver problems			(Gary Brubaker)
> o	Generic USB serial driver fixes			(Greg Kroah-Hartmann)
> o	Update USB serial configure.help		(Greg Kroah-Hartmann)
> o	Add more device support to mct_u232 USB		(Cornel Ciocirlan)
> o	Fix typo in asm-ppc/semaphore.h			(Andre Dahlqvist)
> o	Report reiserfs tools in ver_linux		(Steven Cole)
> o	Fix resource leaks in NCR_53c406, atari_scsi	(Rasmus Andersen)
> 	and qlogicisp
> o	Move pci_enable_device earlier for hamachi	(Dave Jones)
> o	Type 6 drives are apparently floppy 2.88M	(Dave Jones)
> o	Remove duplicate pci_enable_device in ne2kpci	(Dave Jones)
> 
> 2.4.1-ac4
> o	Fix sk_in use counting in svcsock.c		(Neil Brown)
> 	| Not yet a complete and final agreed solution
> o	Add support for KLSI USB ethernet 		(Brad Hards,
> 				 Stephane Alnet, 'the Zapman', and co)
> o	Update aic7xxx driver				(Doug Ledford)
> 	| Please test this carefully and cc reports to Doug
> o	Add help for CONFIG_INPUT			(Steven Cole)
> o	3c523 driver update				(Tom Sightler)
> o	Fix reiserfs Changes entry further		(Steven Cole)
> o	Limit ide scatter gather to 128 blocks		(Jens Axboe)
> o	Merge hppa config.in changes			(Matthew Wilcox)
> o	Fix tx timeout recovery on via rhine		(Manfred Spraul)
> o	Fix stale comments in fs/block_dev.c		(Tigran Aivazian)
> o	Further defxx driver work			(Maciej Rozycki)
> o	winbond 840 reported wrong setting value	(Maciej Rozycki)
> o	Guillemot Maxi radio support		(Dimitromanolakis Apostolos)
> o	Allow sleeping in pm callbacks but with locking	(me)
> 	working
> 
> 2.4.1-ac3
> o	Remove ancient dead net/Changes file		(Janice Girouard)
> o	Merge Linus 2.4.2pre1
> o	Resync xirc2ps with Dave Hinds tree		(dilinger)
> o	Finish sorting out ramfs problems		(Mike Galbraith)
> o	Update AWE32 documentation			(Andre Dahlqvist)
> o	Remove reference to dead PPP documentation	(Andre Dahlqvist)
> o	Make max_map tunable 				(Werner Almesberger)
> o	Fix dead references to java support in some	(Andre Dahlqvist)
> 	arch/config
> o	Make shmfs estimate size limits if none set	(Christoph Rohland)
> o	Revert Crusoe hanging pci hanging changes
> 	| Im still chasing something weird in this
> 	| area that some of the pci changes I have fixes...
> o	Merge HPPA hackers into CREDITS			(Mathew Wilcox)
> o	Merge some of the HPPA updates			(Mathew Wilcox)
> o	Add Reiserfs tools to changes			(Steven Cole)
> o	Fix i2o Configure.help typo			(YOSHIMURA Keitaro)
> o	SuperH HD64465 host bridge support		(Greg Banks)
> o	Fix modversion.h includes			(Keith Owens)
> o	Tlan driver probing updates			(Jeff Garzik)
> o	Change media drivers to use new style module	(me)
> 	locking
> 	| Janitorial job - fix the last ones that
> 	| don't use module_*() and dump the init code
> 
> 2.4.1-ac2
> o	Fix matrox G450 framebuffer support		(Petr Vandrovec)
> o	Fix description of DMA-mapping.txt		(Dave Miller)
> o	Fix accidental revert of classifier bug		(Dave Miller)
> o	Fix accidental revert of isdn change
> o	Fix datagram hang on shutdown			(Alexey Kuznetsov)
> o	Fix 64bit build of clntproc			(Michal Jaegermann)
> 	| wants a tidier solution yet
> o	Fix ide toc caching bug introduced in 2.4.0	(Fredrik Vraalsen)
> 	| this should fix the DVD playback problems
> o	Swapfs renaming and final bits			(Christoph Rohland)
> o	Further APIC/NMI updates			(Mikael Pettersson)
> o	Add further kernel doc contributions		(John Levon)
> o	ACPI battery tweaks				(Pavel Machek)
> o	Further ramfs fixes				(Ingo Oeser)
> o	ROMFS fixes					(Mike Galbraith)
> o	CS4281 fixes					(Thomas Woller)
> o	Shift to authors official fixes for acenic	(Jes Sorensen)
> o	Update the usb host<->host network drivers	(David Brownell)
> 	| Experimental but he wanted feedback so if you
> 	| have one beat it up a bit
> 
> 2.4.1-ac1
> o	Resync with Linus 2.4.1
> o	Fix recursive make_request crash		(Ingo Molnar)
> o	Updated VIA IDE driver				(Vojtech Pavlik)
> 	| Please exercise due care and caution testing this
> 	| bit...
> o	Fix case where threaded apps might write to 	(Ben LaHaise)
> 	freed kernel memory
> o	Fix ACPI oopses on tecra (apparently bios bugs)	(Pavel Machek)
> o	AHA152x fixes from maintainer			(Juergen Fischer)
> o	Fix case where scsi could hang on boot waiting	(Rogier Wolff)
> 	for a disk spinup
> o	Further maestro3 pm work			(Zach Brown)
> o	Further NTFS fixes				(Yuri Per)
> o	Add GNU make to the list of URLs in Changes	(Steven Cole)
> o	Make dmx3191d enable device before touching it	(Rasmus Andersen)
> o	Make the sbpcd driver actually useful in 2.4	(Paul Gortmaker)
> o	Make buslogic enable device before touching it	(Rasmus Andersen)
> o	Fix tty module locking mishandling		(Maciej Rozycki)
> o	Workaround code for APIC problems with ne2k	(Maciej Rozycki)
> 	| this will break original 82489DX devices for now
> 	| ie _very_ early dual pentium boards
> o	Fix iptos netfilter bug				(Rusty Russell)
> o	Fix get/set_fpu_mxcsr to check xmm ont fxsr	(Doug Ledford)
> o	Fix name_to_kdev_t symbol			(Adam J Richter)
> o	Update magic sysrq docs				(Jeremy Dolan)
> o	Support for ETinc PCIsync boards		(Francois Romieu)
> o	Mass duplicated word spelling fixes 		(Dave Jones)
> o	Update sb driver to use spinlocks		(Chris Rankin)
> o	Fix leak in bmac driver				(Hans Grobler)
> o	Fix kmalloc check in atm/common			(Hans Grobler)
> o	Fix buffer leak in defxx			(Hans Grobler)
> o	Fix kmalloc check in netrom driver		(Hans Grobler)
> 	|BTW side exercise - how about using vmalloc here ?
> o	Ditto for rose					(Hans Grobler)
> 	|Ditto for comment ;)
> o	Fix lockd 64bit handling			(H J Lu)
> o	Tidy pci_match_device ifdefs			(Rasmus Andersen)
> o	Fix qla1280 handling of registration failure	(Rasmus Andersen
> 							 Rakesh Rakesh)
> o	Config include fixes				(Niels Jensen)
> o	MatroxFB updates				(Petr Vandrovec)
> o	Tidy fat_read_super to use get_hardsect_size	(Tigran Aivazian)
> o	Fix m68k bitops	ffs()				(Geert Uytterhoeven)
> o	Fix ip_nat_standalone ksyms stuff		(Rusty Russell)
> o	Fix copy_from_user mishandling in ip_fw_compat	(Rusty Russell)
> o	Fix romfs for 2.4ac maxbytes 			(Mike Galbraith)
> o	filemap/aging updates				(Rik van Riel)
> o	Enable device before reading irq in ne2k-pci	(Martin Diehl)
> o	Remove surplus nr_ioapics definition		(Rasmus Andersen)
> o	S/390 build fixes				(Florian Laroche)
> o	Advansys driver fixes/portability		(Arnaldo Carvalho
> 							 de Melo)
> o	Fix out of message handling error in i2o_block	(Jason Lai)
> o	Fix bit granularity of 32 in ACPI driver	(Adam J Richter)
> o	Fix unsafe casting for ARM on NFS root mount	(Russell King)
> o	Fix mxcsr masking on pentium IV			(Doug Ledford)
> o	Update u14/eata drivers to 6.03			(Dario Ballabio)
> o	Fix signed/unsigned mess in sysctl handlers	(me)
> 
> 
> ---
> Alan Cox <alan@lxorguk.ukuu.org.uk>
> Red Hat Kernel Hacker
> & Linux 2.2 Maintainer                        Brainbench MVP for TCP/IP
> http://www.linux.org.uk/diary                 http://www.brainbench.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

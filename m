Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272255AbTHIFlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 01:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272260AbTHIFln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 01:41:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:41349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272255AbTHIFkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 01:40:40 -0400
Date: Fri, 8 Aug 2003 22:40:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.0-test3
Message-ID: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The bulk of the diff by far is various architecture updates, and in 
particular bringing MIPS[64] a bit closer to being up-to-date for 2.6.x  
But there's arm, alpha, h8300 and ia64 updates too. 

Merging the SELinux security architecture also ends up growing the patch, 
even though it may not be all that noticeable for most normal users.

For most x86 users, the CPU frequency updates, network driver updates, and 
some USB updates are most likely to matter.

And this should fix the PCMCIA lock-up that a number of people have seen
happening since 2.5.71 or so. Thanks for people involved in testing and 
fixing that one.

Also, Andrew fixed a read-ahead bug that was introduced in test2 that
could cause (non-readahead) IO failures under load.

Shortlog follows, full details in the BK trees and in the log on the
ftp/web sites.

		Linus

----

Summary of changes from v2.6.0-test2 to v2.6.0-test3
====================================================

<nikkne:hotpop.com>:
  o I2C: fix Kconfig info

Adam Belay:
  o [PNP] Handle unset resources properly
  o [PNP] Remove protocol_data from pnp_dev and pnp_card
  o [PNPBIOS] Move Parsing Functions to the PnPBIOS driver
  o [SOUND] Remove __(dev)initdata from all pnp sound drivers
  o [PNPBIOS] Move low level code into a separate file
  o [PNP] Remove device naming based on id
  o [PNP] Increment Version Number
  o [PCMCIA] Fix PnP Probing in i82365.c

Alan Cox:
  o [NET]: illegal --> invalid
  o remove a dead EXPORT_NO_SYMBOLS
  o more typo fixes
  o dont assume newer cpus have the same magic registers
  o more arch typo/illegal->invalid fixes
  o docs for updated sk98 from vendor
  o kill an old __NO_VERSION__
  o re-enable SiS direct render
  o console on by default if not embedded (save mucho pain)
  o more typo/invalid bits
  o more typo fixes and dead old code removal
  o mouse and keyboard by default if not embedded
  o second block illegal/invalid fixups for isdn
  o keyboard controller by default if not embedded
  o some isdn invalid/illegal fixups
  o fix return on pms change
  o more typo fixes
  o sk98 vendor driver update
  o more net illegal/invalid typo fixes
  o further z85230 fixes
  o idents for all the new skge cards
  o fix pcmcia_cs without ISA
  o fix invalid/illegal and printk formatting for scsi drivers
  o phonedev handles this
  o phonedev has an owner so this is ok too I think
  o fix build of asix usb ethernet
  o vga text console if x86 and not embedded
  o fix invalid/illegal oddments in USB
  o switch escaped 8859-1 symbols inthe kernel to ascii
  o tdfx framebuffer updates
  o fix binfmt_flat typos
  o kill __NO_VERSION__ in intermezzo
  o use invalid not illegal in reiserfs
  o fix 2 byte data leak due to padding
  o typo fix for time.h
  o fix strncpy on generic user platforms
  o maintainer for sk98
  o the rest of the slab.c fix
  o sunrpc doesnt need uaccess.h
  o fix posix compliance for mkcompile_h script
  o allow 2.6 to build on old old setups
  o fix section conflict and typo in ALSA isa
  o further OSS audio updates
  o further sound updates
  o update Changes for NFS changes
  o work around tosh keyboards
  o update for DC395 driver (big)
  o remaining illegal/invalid/separate stuff for scsi
  o ikconfig

Alan Stern:
  o USB:  Proper I/O buffering for the shuttle_usbat subdriver
  o USB: Fix irq problem in hcd_endpoint_disable()
  o USB: Rename usb_connect() to usb_choose_address()
  o USB: Small fixes for usbtest
  o USB: More unusual_devs.h stuff
  o USB: Rename probe and unbind functions
  o USB: Add functions to enable/disable endpoints, interfaces
  o USB: Use the new enable/disable routines
  o USB: Remove usb_set_maxpacket()
  o USB: usb-storage: Move static string out of initializers.h

Alex Williamson:
  o ia64: New CMC/CPE polling
  o ia64: Update to CMC/CPE polling
  o PCI: trivial 2.4/2.6 PCI name change/addition

Alexey Kuznetsov:
  o [IPV4]: IP options were not updated while forwarding multicasts
  o [PKT_SCHED]: More reasonable PSCHED_JSCALE for various values of HZ

Andi Kleen:
  o x86-64 merge
  o Make x86-64 compile again

Andrew Morton:
  o misc fixes
  o selinux merge
  o re-slabify i386 pgd's and pmd's
  o buffer.c debugging
  o update to speedstep-centrino.c
  o 3c59x suspend/resume fix
  o dev_t printing
  o non-MII 3c59x fix
  o kwsapd can free too much memory
  o unlock_buffer() needs a barrier
  o Interface to invalidate regions of mmaps
  o Fix vmtruncate race and distributed filesystem race
  o fix bogus IO error messages
  o rework readahead for congested queues
  o ext3: avoid reading empty inode blocks
  o Fix race in ext3_getblk
  o ext3: don't start a commit in write_super()
  o fix alloc_bootmem_low_pages
  o soundcard.c devfs fix
  o 6PACK asumes HZ=100
  o devfs_lookup stack corruption fix rework
  o use mark_page_accessed() in the write() path
  o fix kswapd throttling
  o vmscan: decaying average of zone pressure
  o vmscan: use zone_pressure for page unmapping
  o direct-io support for XFS unwritten extents
  o Fix ipt_helper compilation
  o fix select() with an xoffed tty
  o fix ip_conntrack_core.h compile error
  o ext3: fix commit assertion failure
  o fix read_dir()
  o Move the special_file() definition
  o uidhash init-time locking
  o com20020_cs.c doesn't compile
  o pc300_drv build fix
  o binfmt_script argv[0] fix
  o Fix dac960 for devfs
  o quota typo fix
  o i810fb oops fix
  o export agp_memory_reserved
  o IPMI build fix
  o generic HDLC updates
  o dscc4 compile fix for hdlc
  o serial drivers are not experimental
  o ftl.c warning fix
  o Watchdog: use module_param
  o export install_page() to modules
  o cpu_idle() startup race fix
  o fix 64-bit architectures for the binprm change
  o remove PF_READAHEAD
  o ax8817x.c build fix for older gcc's
  o dm: don't use MODULE_PARM
  o dm: remove blk.h include
  o dm: decimal device num sscanf
  o dm: 64 bit ioctl fixes
  o dm: missing #include
  o [patch 7/25 dm: use sector_div()
  o dm: resume() name clash
  o reiserfs: fix savelinks on bigendian arches
  o reiserfs: fix problem when fs is out of space
  o reiserfs: fix races between link and unlink on same
  o remount_fs needs lock_kernel()
  o move_one_page() atomicity fix
  o ide-cd error handling oops fix
  o might_sleep() checks for x86 usercopy functions
  o Don't trigger NMI watchdog for panic delay
  o export lookup_create()
  o fix free_all_bootmem_core for virtual memmap
  o NMI watchdog documentation for x86-64
  o Add do_setitimer prototype to linux/time.h
  o itimer resolution and rounding fixes
  o ext3: handle aborted journals in
  o declare struct irq_desc
  o mtrr race fix
  o initialise page->private

Andries E. Brouwer:
  o osf partition numbering

Andy Grover:
  o ia64 fix for ACPI

Angelo Dell'Aera:
  o [NET]: Convert tc35815.c to spinlocks
  o [NET]: Trivial fix for 82596 driver

Anton Blanchard:
  o ppc64: remove all request_irq calls that occur before kmalloc is
    set up
  o ppc64: Fix any_online_cpu for > 32 cpus, mask must be unsigned long
  o ppc64: clear error_code in do_page_fault on an SLB miss
  o ppc64: add div64 for 32bit boot wrapper
  o ppc64: Add semtimedop
  o ppc64: Add posix timers, tgkill, utimes, statfs64
  o ppc64: add asm/sections.h
  o ppc64: defconfig update
  o [NET]: Add missing memory barriors for __LINK_STATE_RX_SCHED
    handling
  o ppc64: Reserve 8042 IO space on machines with no keyboard
  o __initdata must not be marked const

Arnaldo Carvalho de Melo:
  o wl3501: introduce iw_mgmt_info_element & associate functions and enums
  o wl3501: use iw_mgmt_info_element for phy_pset (now ds_parameter_set)
  o wl3501: fix set_essid wireless extension, using the flags for any
  o wl3501: fix bug in iw_mgmt_info_element id field and more
  o wl3501: introduce iw_mgmt_ibss_pset
  o wl3501: introduce struct iw_mgmt_cf_pset
  o wl3501: introduce iw_mgmt_data_rset and rate labels enum
  o wl3501: implement {get,set}_scan wireless extensions
  o wl3501: add a first cut, lazy scan triggering for set_scan
  o MAINTAINERS: add acme as wl3501 maintainer

Arun Sharma:
  o ia64: make ia32 core dumps work
  o ia64: epoll support for ia32 applications
  o ia64: compat_ioctl.c support

Bart De Schuymer:
  o [NETFILTER]: Fix use after free of skb in nf_reinject()
  o [BRIDGE]: Only build br_netfilter when INET is enabled

Bartlomiej Zolnierkiewicz:
  o ide: kill no longer used CONFIG_BLK_DEV_IDE_MODES
  o ide: kill no longer used CONFIG_BLK_DEV_NFORCE
  o ide: kill no longer used CONFIG_BLK_DEV_PDC202XX
  o ide: kill surplus menu in Kconfig
  o ide: fix ordering in Kconfig
  o ide: clean BLK_DEV_IDE dependencies in Kconfig
  o ide: clean IDE_CHIPSETS dependencies in Kconfig
  o ide: clean BLK_DEV_IDEDMA_PCI dependencies in Kconfig
  o ide: use def_bool in Kconfig
  o move "config SOUND" to sound/Kconfig
  o do not scan partitions twice for removable devices
  o fix ata_probe() driver autoloading
  o ide_unregister() fixes
  o fix return value for idedisk_*_max_address_* functions
  o capacity related fixes
  o init_idedisk_capacity() cleanup()
  o fix CONFIG_IDEDISK_STROKE support in ide-disk.c

Ben Collins:
  o Update IEEE1394 (r1023)

Benjamin Herrenschmidt:
  o I2C: timer clean up for i2c-keywest.c
  o [NET]: Do not call request_irq with spinlock held in sungem.c
  o PPC32: Properly register CPUs
  o PPC32: Update pmac_cpufreq driver back to working
  o Fix mdelay's use of 'msec' name

Bjorn Helgaas:
  o ia64: IOSAPIC .weak symbol cleanup
  o ia64: more ACPI/IOSAPIC cleanup

Chas Williams:
  o [ATM]: Update LANAI driver to modern PCI and DMA APIs (from
    mitch@sfgoth.com)
  o [ATM]: remove EXACT_TS remove from zatm (untested)
  o [ATM]: use set_current_state(x) (from bellucda@tiscali.it)
  o [ATM]: fix a typo in net/atm/Makefile (from eguaj@free.fr)
  o [ATM]: Convert cli() to spinlock in ZATM driver
  o [ATM]: update links to new site (from <mitch@sfgoth.com)
  o [ATM]: Minor LANAI fixes from mitch@sfgoth.com

Chip Salzenberg:
  o Require nfs-utils 1.0.5; document where to get it

Christoph Hellwig:
  o [netdrvr pcmcia] remove the release timer from all pcmcia net
    drivers

Daniel Ritz:
  o [IPV6]: Fix memory leak in esp6_input
  o [PCMCIA] don't call functions twice

Daniele Bellucci:
  o USB: Audit usb_register in drivers/usb/class/audio.c
  o USB: Audit usb_register() in drivers/usb/misc/emi26.c
  o USB: Audit usb_register() in drivers/usb/input/wacom.c
  o USB: Audit usb_register in drivers/usb/input/xpad.c
  o USB: Audit usb_register() in drivers/usb/input/usbkbd.c
  o USB: Audit usb_register() in drivers/usb/input/aiptek.c
  o USB: Audit usb_register in usbmouse_init()
  o USB: Audit usb_register() in drivers/usb/net/catc.c
  o I2C: fixed a little memory leak in i2c-ali15x3.c

Danny ter Haar:
  o CREDITS change

Dave Jones:
  o [CPUFREQ] update Documentation
  o [CPUFREQ] Fix compilation of speedstep-ich.c if SPEEDSTEP_DEBUG is
    set
  o [CPUFREQ] Longrun validate can fail
  o [CPUFREQ] Locking fixes [1/11] First part in a series of patches
    from Dominik which clean up the locking in cpufreq. It sort of
    worked, but is full of races. But to keep it working at least as
    well it works now, add a new spinlock cpufreq_driver_lock which
    will be what cpufreq_driver_sem intended to be -- but it can indeed
    be a spinlock instead of a semaphore. 
  o [CPUFREQ] Locking fixes [2/11] As the per-CPU initialization can
    fail, we need to deal with this situation in cpufreq_remove_dev as
    the sysdev core doesn't (yet) do this for us. The solution: add a
    "struct cpufreq_policy
  o [CPUFREQ] Fix locking [3/11] Change the return value of
    cpufreq_cpu_get from a nondescriptent int to struct
    cpufreq_policy*. This will allow for cleaner code - and later it
    will be expected that anyone who grabs a reference by calling
    cpufreq_cpu_get must return this struct cpufreq_policy* to
    cpufreq_cpu_put.
  o [CPUFREQ] Fix locking [4/11] Make cpufreq_remove_dev a bit more
    readable. Also, assure that the GOV_STOP and the
    cpufreq_driver->exit() call are indeed the last calls done.
  o [CPUFREQ] Fix locking [5/11] Make cpufreq_set_policy a bit more
    readable by storing the CPU's cpufreq_policy into a pointer.
  o [CPUFREQ] Fix locking [6/11] Change the function parameter of
    cpufreq_cpu_put to struct cpufreq_policy *.
  o [CPUFREQ] Fix locking [7/11] Finally implement the two different
    cpufreq_driver_target callbacks -- the one called while the per-CPU
    lock is held, the other while not. While we're at it, clean up
    cpufreq_governor.
  o [CPUFREQ] Fix locking [8/11] Split up cpufreq_governor into a
    locking and non-locking variant.
  o [CPUFREQ] Fix locking [9/11] Use the per-CPU policy->lock to lock
    the per-CPU "policy" data. Also, use it to serialize the setting of
    new frequency policies on each CPU.
  o [CPUFREQ] Fix locking [10/11] Remove the final instances of the
    now-deprecated cpufreq_driver_sem. Also, the previous
    "one-frequency change at one moment" limitation is gone. If it's
    needed by the cpufreq driver, it should be implemented in its
    cpufreq_driver->{target,setpolicy} callback.
  o [CPUFREQ] Fix locking [11/11] Implement per-CPU memory allocation.
    Is a bit cleaner than the previous "once and for all" approach.
  o [CPUFREQ] speedstep_ICH new frequency notification fix
  o [CPUFREQ] Sanity checks for voltage scaling in longhaul driver
  o [AGPGART] Handle Intel chipsets whose BIOS has 'forgotten' to
    assign resources
  o [AGPGART] Fix Nforce modular compilation
  o [CPUFREQ] Update MAINTAINERS/CREDITS Dominik doesn't want
    maintainership any more (besides him still doing lots of great work
    on it. 8-)
  o [CPUFREQ] Sparse __user annotations for acpi driver
  o [CPUFREQ] Fix sparse warnings in powernow-k7
  o [CPUFREQ] sparse __user annotation for cpufreq userspace interface
  o [CPUFREQ] longhaul printk cleanups
  o [CPUFREQ] Better handling of revisionKey bits on Longhaul
  o [CPUFREQ] Move MSRs from powernow-k7.h to include/asm-i386/msr.h
  o [CPUFREQ] Remove CVS idents
  o [CPUFREQ] Move rdmsrl/wrmsrl to include/asm-i386/msr.h
  o [CPUFREQ] Clean up longhaul MSR usage using bitfields
  o [CPUFREQ] Convert Longhaul v1 over to bitfields too
  o Cset exclude:
    davej@codemonkey.org.uk|ChangeSet|20030715115826|58980
  o [CPUFREQ] Fix detection of Transmeta CPUs. Makes longrun work again
  o [CPUFREQ] Fix compiler warnings in msr macros
  o [CPUFREQ] Use standard types in wrmsrl
  o [CPUFREQ] Update documentation
  o [CPUFREQ] Remove deprecated email address
  o Athlon Machine Check fix

Dave Kleikamp:
  o JFS: Missed some non-negative error return codes
  o JFS: fine-grained xattr locking
  o JFS: write_super_lockfs should mark superblock clean

David Brownell:
  o USB: usb audio, remove garbage warning
  o USB: ehci needs a readb() on IDP425 PCI (ARM)
  o USB: usbnet: zaurus c-750, motorola
  o USB: ehci-hcd, TT fixup
  o USB: usb_gadget.h doc fix
  o USB: usb_unlink_urb() kerneldoc
  o USB: ehci-hcd, show microframe schedules
  o USB: ehci-hcd and period=1frame hs interrupts
  o USB: usb root hubs need longer timeout
  o USB: hcd initialization fix
  o USB: ohci-hcd, minor d3cold resume fix
  o USB: usb_new_device() updates
  o USB: disable both sides of usb device ep0 at once
  o USB: usbnet, prevent exotic rtnl deadlock

David Mosberger:
  o ia64: Two small fixes to make ia64 build & work again
  o ia64: Add forgotton <asm-ia64/sections.h>
  o Many files
  o ia64: Define fsid_t for kernel purposes
  o xtalk.h, sn_ksyms.c, sn2_smp.c, cache.c, shuberror.c, shub.c,
    iomv.c, hcl.c
  o ia64: Clean up trailing whitespace
  o ia64: Make elfcore32.h compile for 2.6.0-test2
  o modify data types in efi.h

David S. Miller:
  o [SPARC64]: Mark more things __init in kernel/pci.c
  o [SPARC64]: Make sure to reject all PCI DAC dma masks
  o [SPARC64]: In schizo driver, if virtual-dma property exists,
    respect it
  o [ATM]: Remove -g option from driver directory CFLAGS
  o [NET]: Need to export secpath_dup to modules
  o [SPARC64]: Use i2c/media Kconfigs instead of hardcoding
  o [I2C]: ELV and VELLEMAN depend upon ISA
  o [DVB]: 64-bit fixes for skystar2.c
  o [DVB]: Fix pointer-->int cast in dvb_net.c
  o [DVB]: Fix pointer-->int cast in budget-patch.c
  o [DVB]: saa7134.h needs asm/io.h
  o [MEDIA]: Fix pointer-->int cast in saa5249.c
  o [MEDIA]: Make read operations return correct ssize_t in
    {c-qcam,bw-qcam,w9966}.c
  o [MEDIA]: Make VIDEO_PMS depend upon ISA
  o [MEDIA]: Make read method return ssize_t in cpia.c
  o [MEDIA]: bttvp.h needs asm/io.h
  o [MEDIA]: Fix u64 printing in bttv driver
  o [MEDIA]: bttv-cards.c needs linux/vmalloc.h
  o [SPARC64]: Update defconfig
  o [SPARC64]: Use Makefile to control dec_and_lock.o building not
    in-file ifdefs
  o [SCSI]: Make dc395x.c build again
  o [SPARC64]: Add some more symbol debugging in register dumps
  o [STRING]: Fix bug in generic strncpy() change
  o [SPARC64]: Propagate bprm->interp changes to sparc 32-bit compat
    layer
  o [SPARC64]: More tomatillo PCI controller fixes
  o [TG3]: More Sun onboard 5704 fixes
  o [SPARC64]: Update defconfig
  o [TG3]: Only call tg3_init_rings() after hardware has been reset
  o [SPARC64]: Fix AFSR error reporting for Cheetah+/Jalapeno
  o [SPARC64]: Missing cheetah+ ASI defines

David T. Hollis:
  o USB: AX8817x mii/ethtool fixes among others
  o USB: ax8817x.c - Fix flags to greatly increase rx performance

Eric Sandeen:
  o [XFS] Use C99 initializers on sysctl structs
  o [XFS] Catch read-only filesystems in xfs_setattr, and return EROFS

Felipe Damasio:
  o drivers/char/stallion.c: devfs_mk_cdev fix

François Romieu:
  o fix typo in drivers/net/arcnet/com20020-isa.c

Geert Uytterhoeven:
  o [IPSEC]: ipcomp.c does not neet net/esp.h

Gerd Knorr:
  o v4l: sysfs'ify videodev
  o v4l: bttv driver update

Greg Kroah-Hartman:
  o I2C: minor cleanups to the i2c-nforce2 driver
  o I2C: consolidate the i2c delay functions
  o USB: fix stupid kobject coding error with regards to struct
    usb_interface
  o USB: core cleanups for struct usb_interface changes
  o USB: changes due to struct usb_interface changing from a pointer to
    an array of pointers
  o USB: remove improper use of devinitdata markings for device ids
  o USB: Compile AX8817x driver
  o USB: AX8817x (USB ethernet) problem in 2.6.0-test1
  o USB: fix bug if open() fails in usb-serial device
  o USB: remove funny characters from visor driver after much prodding
  o USB: bluetty: remove write_urb_pool logic, fixing locking issues
  o Cset exclude: greg@kroah.com|ChangeSet|20030730200104|44589
  o USB: fix memory leak in auerswald driver
  o USB: added support for TIOCM_RI and TIOCM_CD to pl2303 driver and
    fix stupid bug
  o PCI: pci_device_id can not be marked __devinitdata.  Fixes up
    sound/*
  o PCI: pci_device_id can not be marked __devinitdata
  o PCI: pci_device_id can not be marked __devinitdata
  o PCI: pci_device_id can not be marked __devinitdata
  o PCI: pci_device_id can not be marked __devinitdata
  o PCI: pci_device_id can not be marked __devinitdata
  o I2C: remove devinitdata marking from i2c-nforce2.c as it's wrong
  o USB: fix up ALSA merge due to struct usb_interface changes
  o PCI: merge fixups
  o USB: remove some vendor specific stuff from the pl2303 driver to
    get other devices to work
  o USB: remove all struct device.name usage from the USB code
  o PCI: remove all struct device.name usage from the PCI core code
  o PCI: make eepro100 driver use pci_name() instead of dev.name
  o USB: remove dev.name usage from gadget code
  o I2C: move the name field back into the i2c_client and i2c_adapter
    structures
  o I2C: fix up driver model programming error

Harald Welte:
  o [NETFILTER]: Use in-kernel IPSEC structures in iptables ah (by
    Patrick McHardy)
  o [NETFILTER]: Use in-kernel IPSEC structures in iptables esp (by
    Patrick McHardy)

Herbert Xu:
  o [IPSEC]: Use per-SA flag to control ECN propagation
  o [IPSEC]: Fix SKB secpath refcounting
  o [XFRM]: Fix OOPS in xfrm_state_update
  o [XFRM_USER]: Pass correct args to xfrm_find_acq()
  o [XFRM_USER]: Fix spurious NLMSG_ERROR messages

Hirofumi Ogawa:
  o Fix the vfat dentry handling fix
  o uses ->i_pos instead of ->i_ino on fat_fs_panic()
  o Consolidate dot-stripping code
  o Inline vfat_strnicmp()
  o more use fat_get_short_entry()

Ian Abbott:
  o USB: ftdi_sio - additional pids
  o USB: ftdi_sio - VID/PID for ID TECH IDT1221U USB to RS-232 adapter

Ian Wienand:
  o ia64: hardirq.h should include smp_lock.h when preempt enabled

Ivan Kokshaysky:
  o alpha: pci domains update
  o PCI: pci_enable_device vs bridges bugs

Jan Dittmer:
  o I2C: convert via686a temp_* to milli degree celsius

Jan Kara:
  o Fix old quota format locking

Jaroslav Kysela:
  o ALSA update 0.9.5
  o ALSA 0.9.6 update
  o ALSA update

Javier Achirica:
  o [wireless airo] fix Tx race
  o [wireless airo] safer shutdown sequence
  o [wireless airo] eliminate infinite loop
  o [wireless airo] makes the card passive when entering monitor mode
  o [wireless airo] adds support for noise level reporting (if
    available)
  o [netdrvr airo] Missing defines (only for documentation)
  o [netdrvr airo] MAC type changed to unsigned
  o [netdrvr airo] add missing lines for Wireless Extensions 16
  o [netdrvr airo] MIC support with newer firmware
  o [netdrvr airo] safer unload code
  o [netdrvr airo] Fix adhoc config

Jean Tourrilhes:
  o Donauboe probe fix
  o IrLAP retry count
  o irda-usb probe fix
  o tekram-sir driver fix

Jeff Garzik:
  o [netdrvr bonding] update docs
  o [netdrvr bonding] fix ifenslave build on ia64
  o [tokenring ibmtr_cs] fix build, due to missing ibmtr.c build
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20030731201437|53548
  o intel ich5 irq router, pci ids
  o [netdrvr airo] now that it builds, re-enable wireless_ext
  o [irda] Add VIA FIR driver, via-ircc

Jens Axboe:
  o fix broken blk_start_queue behavior
  o get rid of unused request_queue field queue_wait
  o AS barrier bug
  o Fix bio RW_AHEAD test
  o Proper block queue reference counting
  o scsi_ioctl reference counting
  o floppy smp fix

Jesse Barnes:
  o ia64: Kconfig cleanup
  o ia64: sn2 pci fixes (among others)

Jones Desougi:
  o [IGMP]: linux/igmp.h needs asm/byteorder.h

Judd Montgomery:
  o USB: visor.h[c] USB device IDs documentation

Kai Germaschewski:
  o kbuild: Fix 'make -jN' warning
  o kbuild: [PATCH] fix in-kernel genksyms for parisc symbols
  o kbuild: Fix .config dependency generation
  o kbuild: List deps on generated files in drivers/video/logo/Makefile
  o kbuild: Add relocation information into .lst file

Kochi Takayoshi:
  o ia64: Interrupt polarity fix

Linus Torvalds:
  o Mark the SiS DRM driver as depending on the SiS FBCON support. It
    won't even compile without it.
  o Merge i830 IRQ handler cleanups from DRI CVS tree
  o Update r128 drm driver from DRI CVS tree
  o Fix up AGP merge: agp_memory_reserved got exported twice
  o Document non-standard do_div() calling convention, since it does
    not work like a C function.
  o Fix up ieee1394 compile
  o Make "static const" initializer to zero explicit, since truly
    constant values should not end up in the BSS.
  o "kernel_locked()" needs <linux/smp_lock.h>
  o Fix vfsmnt leak: make autofs4 mount point expiry release the entry
    that we got through the lookup_mnt().
  o Don't try to signal already-zombied threads in zap_threads
  o Merge with DRI CVS tree: fix use-after-free bug in DRM(takedown)
  o Remove bogus temporary file from revision control

Maciej W. Rozycki:
  o defxx: Maintenance + DMA API fixes

Martin Devera:
  o [NET]: Fix bugs in sch_htb packet scheduler

Michael Hunold:
  o Kconfig and Makefile updates
  o DVB core update
  o mt312 DVB frontend update
  o Update MAC handling for various DVB PCI cards
  o TTUSB-DEC driver update
  o Hexium saa7146 driver update

Michal Sojka:
  o USB: fixes for usb-skeleton.c

Miles Bader:
  o Add new include files for v850

Mitchell Blank Jr.:
  o PCI: Trivial DMA-mapping.txt fix
  o PCI: add 2 entries to pci_ids.h
  o [SPARC64]: Control debuglocks.c compilation using Makefile rules

Nathan Scott:
  o [XFS] Ensure the VFS doesn't rip the inode out from beneath us when
    doing unwritten extent conversion
  o [XFS] Avoid doing the page->mapping->host dereferences twice on
    writepage
  o [XFS] Fix couple of issues in max file size calculation, print big
    fs setting too
  o [XFS] Cleanup empty/noaddr pagebuf initialisation; particularly for
    buffers used for log IO - no longer allocate buffers for data
    device then reset target, gets it right from the start
  o [XFS] Max file size tweak for LBD - if LBD enabled on 32 bit
    platforms slightly bigger files are possible
  o [XFS] Fix the resvsp/truncate interaction problem that mikes@av.com
    reported
  o [XFS] Change any references to legal/illegal into valid/invalid -
    apparently this was bad, mkaay?
  o [XFS] Minor cleanups for unwritten extent fix, using one less
    variable on the stack
  o [XFS] Forward port 2.4 pagebuf locking to 2.5, based on Steve's
    analysis - to fix the infamous pagebuf IO completion buglet

Neil Brown:
  o Make sure sunrpc/cache doesn't confuse writers with readers
  o Change NFSEXP_CROSSMNT to NFSEXP_CROSSMOUNT
  o Remove some unused export flags and reserve a new one
  o Protect against NFS requests to create symlinks bigger than one
    page
  o Change atomic_inc to cache_get twice
  o Create a mountpoint for the nfsd filesystem
  o nfsv4 page boundary handling fixes
  o Fix the sunrpc cache/reader management properly

Nemosoft Unv.:
  o USB: PWC 8.11

Oliver Neukum:
  o USB: error return codes in usblp
  o USB: cleanup of usblp (release and poll)
  o USB: fix race condition in usblp_write
  o USB: remove GFP_DMA from pegasus
  o USB: DMA coherency issue with rtl8150
  o USB: use of __devinit in st5481
  o USB: dvb usb driver sleeping in interrupt

Olof Johansson:
  o [RANDOM]: Fix SMP deadlock in __check_and_rekey()

Otto Solares:
  o [SPARC]: Add local.h and sections.h headers

Patrick Dreker:
  o I2C: add ncforce2 i2c bus driver

Patrick McHardy:
  o [NETFILTER]: Fix logging of AH spis

Patrick Mochel:
  o [power] Create drivers/power/
  o [power] Move process suspension functions to their own file
  o [power] Move saved_context_* variables
  o [power] Make CONFIG_ACPI_SLEEP and CONFIG_SOFTWARE_SUSPEND
    independent
  o [power] Remove duplicate target
  o [power] Move drivers/power/ to kernel/power/
  o [power] Kill some unnessecary printk()s
  o [power] Fix up refrigerator to work with ^Z-ed processes
  o [power] Minor swsusp cleanups
  o [power] Divorce suspend console code from swsusp
  o [power] Make sure ACPI prepares a console during S3
  o [power] Fix compilation when CONFIG_PM=n
  o [power] Fix up compiler warnings
  o [power] Remove unused function reset_videobios_after_s3()

Paul Mackerras:
  o PPC32: Compile fix for arch/ppc/kernel/setup.c
  o PPC32: Fix compilation when CPU_FREQ is defined
  o PPC32: Make strncpy clear the unused part of the destination
  o PPC32: Fix the help message for the SANDPOINT config option

Peter Chubb:
  o ia64: Kill a warning if \!CONFIG_SMP

Petr Vandrovec:
  o Remove write-only palette variable from matroxfb. Now it is
    possible to build matroxfb without fbcon support.
  o matroxfb: Initialize fbcon's cmap
  o Add support for panning at vertical blanking to the matroxfb. Now
    mplayer output looks much better on primary output (secondary
    output is always synced with vbl).

Ralf Bächle:
  o MIPS update

Randy Dunlap:
  o janitor: don't init static data (arm26)
  o janitor: add MODULE_LICENSE() in 2 drivers
  o janitor: make serio init/exit static
  o janitor: use char arrays for strings
  o jantior: return -EFAULT on copy_user error
  o janitor: don't init statics to 0
  o don't init statics to 0 (fs/)
  o janitor: convert to pci_name()
  o [NET]: janitor: don't init statics to 0
  o Fix incorrect umem iounmap() call

Richard Henderson:
  o [ALPHA] Fix remaining pci bus conversion
  o [ALPHA] Compressed kernel bootp images
  o [ALPHA] Disable Wildfire, Titan, Marvel if !LEGACY_START_ADDRESS
  o [ALPHA] IRQ updates to match x86 changes
  o [ALPHA] Fix RTC init for LYNX
  o [ALPHA] Enhanced EV6/EV7 error management

Rik van Riel:
  o CREDITS update

Rob Radez:
  o remove unnecessary stubs from watchdog drivers

Roland McGrath:
  o spurious SIGCHLD from dying thread group leader
  o fix spinlock deadlock in ptrace-reaping of detached thread
  o fixes to zap_other_threads fix

Russell King:
  o [ARM] Update ARM ethernet drivers
  o [PCMCIA] Fix suspend for yenta_socket and i82092
  o [PCMCIA] Convert cs.c and rsrc_mgr.c to use named initialisers
  o [ARM] gcc 3.2.x for ARM miscompiles jffs2
  o [ARM] Automatically select compiler options for ARMv5/Xscale CPUs
  o [ARM] Add missing include for clps711x irq handling
  o [ARM] Make PXA compile
  o [ARM] Add generic sections.h for ARM
  o [ARM] Fix do_settimeofday()
  o [ARM] Remove old ARC and A5K machine class
  o [ARM] Remove unused get_hackkit_scr prototype
  o [ARM] Fix SSP IRQ handler return type
  o [ARM] Update machine types file
  o [ARM] Remove more static register accesses from sa1111.c
  o [ARM] Fix two Acorn SCSI drivers
  o [ARM] Fix platform_add_devices() prototype
  o [ARM] Add asm-arm/local.h
  o [netdrvr ARM] alloc_etherdev updates
  o [PCMCIA] Fix cardbus init failure paths
  o [PCMCIA] Disable IRQ steering and don't change the IRQ MUX register
  o [PCMCIA] Report subsystem vendor/device IDs

Sam Ravnborg:
  o usr: Create objectfile for usr filesystem using .incbin
  o fs/Makefile: Eliminate ifneq
  o bk: Ignore drivers/scsi/aic7xxx/aic7xxx_reg_print.c
  o kbuild/doc: Grammatical errors corrected
  o kbuild: Added CONFIG_DEBUG_INFO
  o arch/um: Renamed CONFIG_DEBUGSYM to CONFIG_DEBUG_INFO
  o kbuild/doc: Delete obsolete documentation files
  o docbook: Added support for generating man files
  o kbuild/doc: Delete instructions about running make dep
  o kbuild: Let 'make help' point to README
  o kbuild: Updated/moved around comments in top-level Makefile
  o kbuild: Allow architectures to change CPPFLAGS

Samuel Thibault:
  o [PPP]: Fix ppp_async xon/xoff handling

Sean Estabrooks:
  o I2C: Additional P4B subsystem id for hidden asus smbus

Sridhar Samudrala:
  o [SCTP] ADDIP basic infrastructure support. (Ardelle.Fan)
  o [SCTP] Fix to avoid large kmalloc failures on 64-bit platforms

Stephen Hemminger:
  o [BRIDGE]: Mailing list is at osdl.org now
  o [VLAN]: Allow it to compile with VLAN_DEBUG enabled
  o [VLAN]: Convert VLAN procfs stubs to no-ops
  o [VLAN]: Convert over to seq_file
  o [NET]: Fix rtnetlink symbol exports when INET is disabled
  o [NET]: Add likely/unlikely to pskb_may_pull
  o [BRIDGE]: Fix bridge notification processing
  o [NET]: Convert lp486e over to dynamic allocation
  o [NET] Dynamically allocate net_device structures for ROSE
  o [NET] Convert ROSE to seq_file
  o [NET] Fix use after free in AX.25
  o [NET] Fix X.25 use after free
  o [NET] X.25 async net_device fixup

Stephen Lord:
  o Do not include linux/version.h, avoid massive recompilations
  o Correct the maxbytes sb value for non-pagesize filesystem block
    sizes, and all uses of max file size constant within XFS
  o [XFS] remove extra locking which was folded into the xfs extended
    attribute calls - we do not need this.
  o Encapsulate the setting and clearing of PF_FSTRANS around xfs
    transactions. This is used to protect against nested transactions
    which can cause deadlocks. Also ensures we keep the state set for
    the duration of a chain of rolling transactions.
  o Add an IO completion handler to the direct_IO path to allow the
    initiator to take an action at completion time. XFS uses this to 
  o Rework XFS read/write path so that there is one common read and one
    common write path for all the different I/O variants. This means we
    can now support true async I/O.
  o Change XFS to support sector aligned O_DIRECT rather than
    filesystem block alignment.
  o [XFS] Scale default number of log buffers based on memory size
  o Make the permission operation in xfs conditional on ACLs being
    compiled in
  o Only add bytes read into the stats if we did not get an error
  o Use i_size_read and i_size_write instead of direct access to the
    i_size field.
  o Fix a couple of pagebuf end cases, in particular, deal with block
    device which is not correctly initialized and do not submit a bio
    to it - that trips a BUG.
  o Move from fsid_t to __kernel_fsid_t, fixes ia64 build
  o Do not include linux/version.h - no need for it

Steve French:
  o lookup intents part 2
  o cifs enablement for lookup intents (new 2.5 create/lookup flags)
    final part
  o fix create/open/lookup to use namei intent flags.  Enable oplock
    and packet signing
  o Fix oops in cifs mkdir when server fails to return inode info after
    successful mkdir
  o Fix oops in cifs reopen files (restoring state after server comes
    back from failure)
  o Oplock flag reversed in create path
  o Fix for file size handling for locally cached files
  o Do not leave files created with mknod open on server. Fix related
    oops.  Fix timeout on open to be at least server oplock break
    timeout to avoid timing out successful opens when secondary client
    hung
  o Fix blocksize and allocation size miscalculation
  o Fix blocksize and allocation size mismatch

Theodore Y. T'so:
  o Fix 32/64-bit bug in ext3

Tomas Szepe:
  o [NETFILTER]: Put netfilter Kconfig options into dedicated submenu

Ville Nuorvala:
  o [IPV6]: Use correct hop-limit in ip6_push_pending_frames()

Wensong Zhang:
  o [IPV4] IPVS missing stats locking in estimation_timer()
  o [IPV4] IPVS: sanity check of threshold setting and code tidy up

Wiktor Wodecki:
  o I2C: i2c sysfs rant

Wim Van Sebroeck:
  o [WATCHDOG] I810_TCO info in Kconfig
  o [WATCHDOG] Cleanup of Kconfig file for the watchdog drivers
  o [WATCHDOG] make wdt_pci.c independant of wdt.c
  o [WATCHDOG] advantechwdt patches

Yoshinori Sato:
  o h8300: config updates
  o h8300: interrupt management update
  o h8300: H8S architecture support
  o h8300: header file updates
  o h8300: arch update
  o h8300: build error fixes



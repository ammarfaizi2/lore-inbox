Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTHWAuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 20:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263536AbTHWAuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 20:50:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:64699 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263319AbTHWAs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 20:48:59 -0400
Date: Fri, 22 Aug 2003 17:48:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.0-test4
Message-ID: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There should be a lot of compile fixes here, along with updates for ia64, 
and the (painful) move of the 'name' entry out of the "struct device" that 
helps avoid unnecessary memory waste.

It's a lot of small stuff all over: nothing really stands out in diffstat,
except the big update of the Zoran video capture driver, and the blkmtd
driver - both updated from their respective development trees (and the ips
scsi driver, but that was due to massive whitespace fixing).

Normal merges with Andrew and arch maintainers (x86-64, ia64, sparc64,
arm), and AGP updates (notably the merging of the ATI IGP). And network
driver updates, ACPI and power management infrastructure.

		Linus

----

Summary of changes from v2.6.0-test3 to v2.6.0-test4
============================================

<bos:camp4.serpentine.com>:
  o Documentation for initramfs, klibc, and early userspace

<javier:tudela.mad.ttd.net>:
  o [wireless airo] Replaces task queues by simpler kernel_thread

<joern:infradead.org>:
  o keep cramfs silent, when it ought to be
  o remove cramfs maintainership

<kevino:asti-usa.com>:
  o USB: bug in EHCI device reset through transaction

<lkml:mathfillsmewithgreatjoy.com>:
  o Correct DEVPTS config help

Adam Belay:
  o Remove remaining usage of device.name in PnP
  o Fix sb_card.c for "name" removal
  o Fix awe PnP probing

Adam Kropelin:
  o [netdrvr] fix seeq8005 entry help text in Kconfig

Adrian Bunk:
  o [NET]: Kill EXPORT_NO_SYMBOLS from meth.c

Alan Cox:
  o [netdrvr eexpress] fix buglet in skb_padto conversion
  o Maintainer/Credit update

Alan Stern:
  o (as70b) Update request_bufflen to match this_count

Albert Cahalan:
  o fast AND correct strncpy
  o reduce diff between x86-64 & i386
  o IO port bitmap cleanups, x86-64 oops fix

Alexander Viro:
  o Fix pd.c for new queue allocation

Alexey Kuznetsov:
  o [IPV4]: Fix rt_score() and usage when purging rtcache hash chains

Andi Kleen:
  o [NET]: Allow XFRM subsystem to be optional
  o x86-64 merge for 2.6.0test3
  o add compat_statfs64
  o add compat_utimes
  o add posix timer compat functions
  o Make x86-64 use new compat support code
  o Make x86-64 compile again
  o Fix ugly hole in x86-64 interrupt gates

Andrea Arcangeli:
  o address update

Andrew Morton:
  o fadvise(POSIX_FADV_DONTNEED) fix
  o sys_fadvise64_64
  o Fix raid "bio too big" failures
  o missing #if for 1000 HZ
  o timer race fixes
  o AS: remove hash valid stuff
  o AS: no trinary states
  o AS requeue implementation
  o standalone elevator noop
  o pipe.c: don't write to readonly filesystems
  o reiserfs: remove unneeded kunmap
  o reiserfs: Fix handling of some extended inode
  o Set up P4 thermal interrupt vector on UP
  o nbd: fix send/receive/shutdown/disconnect races
  o /proc/net/pnp oops fix
  o vt_ioctl warning fixes
  o fix task struct refcount bug
  o probe UDF after reiserfs
  o fix ide-scsi for ide_drive_t->queue change
  o BUG fix for drivers/bluetooth/hci_usb.c
  o handle old-style "root=" arguments
  o firmware loader requires hotplug
  o devfs_mk_dir fix
  o _devfs_walk_path fix
  o floppy_init fix
  o Make MTRR init conform with recommended procedure
  o fix typo in hd.c
  o fix hugetlbfs slab corruption on umount
  o Kill warning in minix filesystem on 64-bit archs
  o loop oops fix
  o request_firmware fix
  o Kill warning in drivers/input/misc/uinput.c on IA64
  o kill warning in jbd/revoke.c
  o keyboard.c warning fix
  o fix [un]likely(), add ptr support
  o ipmi_kcs_intf.c compile warning
  o hugetlbfs - 'recovering' too many blocks on failure
  o more documentation for request_firmware()
  o state request_firmware() maintainership
  o jffs statfs fix
  o Make 16-way x440's boot
  o Fix strncpy off-by-one error
  o nls Makefile fix
  o Fix DAC960 oops
  o Better argument size tracking in fs/exec.c
  o bugfix for initialization bug in adm1021 driver
  o dnotify documentation update
  o access_process_vm() needs to dirty the page
  o Use mark_page_accessed() in follow_page()
  o uinput oops and panic fix
  o Docbook: Make mandocs output more terse
  o opl3 use-after-free fix
  o SELinux inode security init
  o Add SELinux entry to MAINTAINERS
  o AS: update as_requeue_request()
  o cpumask_t: allow more than BITS_PER_LONG CPUs
  o Fix si_band type in asm-generic/siginfo.h
  o signal handling race condition causing reboot hangs
  o add ASUS l3800P to DMI black list
  o Local APIC enable fixes
  o async write errors: report truncate and io errors on
  o async write errors: use flags in address space
  o async write errors: fix spurious fs truncate errors
  o enable the ikconfig stuff in config
  o aio: fix error-path mm leak in ioctx_alloc
  o Fix SELinux avc_log_lock
  o SELinux check behavior value
  o ymfpci oops fix
  o add locking to global list in ymfpci.c
  o slab: drain_array fix
  o loop: fix module unload oops
  o atp870u.c lockup fix
  o sysctl.h needs compiler.h
  o misc fixes
  o ext3 block allocator cleanup
  o vmscan: give dirty referenced pages another pass
  o When a partition is claimed, claim the whole device
  o Allow O_EXCL on a block device to claim exclusive use
  o opl3sa2 uninitialised spinlock
  o dscc4: commentary
  o dscc4: clock mode commentary
  o dscc4: debug messages
  o dscc4: scc changes
  o dscc4: reset changes
  o dscc4: CCR1 register fixes
  o dscc4: various
  o dscc4: module refcounting
  o fix intel copy_to_user()
  o update Documentation/filesystems/Locking
  o dmi_scan warning fix
  o fix for htree corruption
  o export device_suspend() and device_resume()
  o missing io_apic.h inclusions
  o Fix CPU boot problem
  o fix /proc mm_struct refcounting bug

Andries E. Brouwer:
  o hpt366 fix

Andy Grover:
  o ACPI: Fix intr on IA64 (davidm)
  o ACPI: Better blacklist messages (Jasper Spaans)
  o ACPI: Fix Kconfig for ia64 and SN2 (Jesse Barnes)
  o ACPI: toshiba_acpi update (John Belmonte)
  o ACPI: Allow irqs > 15 to use interrupt semantics other than PCI's
    standard active-low, level trigger. Make other changes as required
    for this.  (Andrew de Quincey)
  o ACPI: If notify handler fails to be removed properly, don't just
    return, but clean up other resources too (Daniele Bellucci)
  o ACPI: Fix ACPI for IA64 on Big Sur machines (HJ Lu)
  o ACPI: Update version so we can keep bugreports straight

Anton Blanchard:
  o minor fix to sym2 hotplug conversion
  o another fix to sym2 hotplug conversion

Arnaldo Carvalho de Melo:
  o atm/eni: use skb_queue_walk, not open coded equivalent

Arnd Bergmann:
  o correct local_dec on some architectures

Arun Sharma:
  o ia64: IA-32 compatibility patch: FP denormal handling
  o ia64: fix bug in handling ERESTART_RESTARTBLOCK for IA-32 emulation

Bartlomiej Zolnierkiewicz:
  o kill HDIO_GETGEO_BIG_RAW ioctl
  o ide: disk geometry/capacity cleanups
  o ide: always store disk capacity in u64
  o ide: limit drive capacity to 137GB if host doesn't support LBA48
  o ide: more ide_unregister() fixes
  o ide: build fixes for ide-tape.c
  o ide: remove bogus bh->bio conversion from ide-tape.c
  o ide: some CodingStyle fixes from 2.4.x for ide-tape.c

Benjamin Herrenschmidt:
  o PowerMac: Ground work for new driver model
  o Fix ide-scsi build with driver model change
  o PowerMac: Update for removal of device->name
  o Fix incorrect pci_ids.h for Radeon

Bjorn Helgaas:
  o ia64: Trivial 2.5 efivars.c whitespace cleanup
  o ia64: export EFI systab

Chas Williams:
  o [ATM]: Fix printk() warnings in LANAI driver (from
    mitch@sfgoth.com)
  o [ATM]: Use likely()/unlikely() in many potential hot-paths of LANAI
    driver (from mitch@sfgoth.com)
  o [ATM]: Cleanup/minor fixes to interrupt handler of LANAI driver
    (from mitch@sfgoth.com)
  o [ATM]: make br2684 more net_device * centric (from
    shemminger@osdl.org ala mitch@sfgoth.com)
  o [ATM]: remove MOD_* used as semaphore; convert others to new style
  o [ATM]: atmdev api cleanup -- remove sg_send() and feedback()
    (mitch@sfgoth.com)

Christoph Hellwig:
  o scsi_remove_device simplifications
  o AHA152x driver hangs on PCMCIA
  o make sym2 scan devices again
  o fix dc395x compile
  o nuke some junk from the pcmcia scsi drivers
  o place host-related LDM code directly in hosts.c
  o Re: scsi proc_info called unconditionally
  o [PCMCIA] kill remaining pcmcia release timers
  o [PCMCIA] kill off last remains of the release timer
  o [PCMCIA] kill remaining cardservices version checking
  o sedlbauer_cs.c: remove release timer

Christophe Saout:
  o Fix /sys/<dev>/<partition>/dev format: %04x -> %u:%u

Corey Minyard:
  o IPMI updates for 2.6.0-test3

Daniele Bellucci:
  o USB: usbvideo cleanup on error

Dave Jones:
  o [AGPGART] Kill off agp_try_unsupported module parameter
  o [AGPGART] Fix logic bug
  o [IPV6]: Missing break in switch statement of rawv6_getsockopt()
  o [IPV4]: /proc/net/pnp dumps items marked initdata
  o [SUNRPC]: Remove duplicate access_ok()
  o [AGPGART] Disable calibration cycle when not in AGP3 mode of
    operation on AGP3 chipset
  o [AGPGART] VIA AGP3 fixups
  o [AGPGART] Fix overflow on machines with >4GB From Marcelo E
    Magallon.
  o USB: Add Minolta Dimage F300 to unusual_devs
  o Enable OOSTORE on Geode
  o Don't refer to devel kernel in Kconfig option
  o winchip3d can use same -march as winchip2
  o Fix x87 FPU exception status check
  o microcode driver sparse __user annotations
  o document easier bitkeeper option
  o Remove duplicate ; at end of macro definitions
  o DAC960 64bit fixup
  o CCISS 64bit fixup
  o cpu_relax whilst in busy-wait loops
  o c99 initialisers for random.c
  o Remove unneeded ; from macros in i8042
  o remove version.h from bttv
  o misc 3c505 bits
  o c99 initialisers for bttv
  o FusionMPT 64bit fixup
  o arcnet indentation fixup
  o c99 struct initialisers for AMD8111e driver
  o boolean logic error in fpu emulation
  o CodingStyle fixes for drm_agpsupport
  o c99 initiliasers for bttv (2)
  o c99 for blkmtd
  o sparse annotations for MSR driver
  o PCMCIA copy_*_user fixes
  o missing copy_to_user check in tun driver
  o Missing copy_from_user check in comx driver
  o missing copy_from_user check in comx_proto_lapb driver
  o missing copy_to_user check in pc300 wan driver
  o missing copy_from_user check in comx-proto-fr driver
  o missing copy_*_user checks in sbni wan driver
  o Missing spin_unlock_irqrestore from rrunner driver
  o missing copy_from_user check in munich driver
  o missing copy_from_user check in mixcom driver
  o sync iocb wakeup
  o BEFS 64bit fixup
  o EFI 64bit fixup
  o sparse annotations for page-writeback
  o LDM 64bit fixup
  o correct tlb_remove_page comment
  o Remove useless assertions from reiserfs
  o AD1848 claims a card it shouldn't
  o sparse annotations for page_alloc
  o sparse annotations for ipc/sem
  o logic error in gus_wave driver
  o [AGPGART] Merge ATI IGP GART driver
  o [AGPGART] Move ATI PCI IDs to pci_ids.h
  o [AGPGART] Kill off agp_try_unsupported for ATI
  o [AGPGART] Masks cleanup for ATI GART
  o [AGPGART] Plug memory leak in failure path of ATI GATT allocator
  o [AGPGART] Kill compiler warnings for ATI GART driver
  o [AGPGART] Fix compiler warning
  o [AGPGART] Check ioremap for failure in Serverworks GART driver
  o [AGPGART] Remove duplicate agpgart: from printk's
  o [AGPGART] Another missing ioremap() failure check
  o [AGPGART] Kconfig updates for the ATI GART
  o [CPUFREQ] Fix up dumb thinko in powernow-k7 From John Clemens

Dave Olien:
  o DAC960 fix for NULL dereference in open()

David Brownell:
  o USB: dabusb doesn't claim every ez-usb an21xx device
  o add usb_reset_configuration()
  o USB: usb hcd-pci suspend/resume updates
  o usb hc cleanup-after-death, oops fix
  o USB: usb_start_wait_urb() rewrite

David Jeffery:
  o ips 4/4: version resync

David Mosberger:
  o ia64: Patch by Peter Chubb: Kill _syscallX macros that generate
    lots of warnings, in favour of inline syscalls for clone() and
    execve(), and direct calling of kernel functions for other system
    calls.
  o entry.S
  o ia64: Make things compile with gcc-pre3.4 and work on the simulator
  o Move patch from linux-ia64-2.5 to to-linus-2.5 repository
  o ia64: Fixes for the inline-asm cleanup patch so the tree builds and
    works again on the simulator (besides the real hw, of course).
  o .del-fw-emu.S~94665166d94d93e
  o ia64: Reapply lost patch due to bk breakage
  o ia64: perfmon update

David S. Miller:
  o [IPV6]: Make sure errors propagate properly in {udp,raw} sendmsg
  o [IPV4]: Fix setting net.ipv4.conf.all.forwarding via sysctl()
    system call
  o [SPARC]: Handle switches out of graphics mode properly in sbusfb
    drivers
  o [SPARC]: Fix typos in leo/cg14 fixes
  o [IDE]: Fix alim15x3 build after ATI PCI ID changes
  o [IDE]: Use pci_name() in amd74xx driver
  o [INPUT]: Use pci_name() in pcips2 driver
  o [SCSI]: Use pci_name() in eata_pio.c
  o [SPARC64]: Use pci_name() in sparc64 PCI layer
  o [SPARC]: Add sys_fadvise64{,_64} syscall entries
  o [SPARC]: Fix TLS and thread ID handling
  o [SPARC64]: Fix typo in clone changes
  o [MM]: Add and use offset_in_page() convenience macro
  o [SPARC]: Add missing sys_tgkill syscall entries
  o [SPARC]: Add more missing system calls
  o [SPARC64]: Fix syscall table alignments
  o [SCSI]: In dc395x.c, scsi_release_host() does not return a value
  o [TCP]: When socket route changes, do not forget to update
    ext2_header_len and sk_route_caps
  o [SPARC64]: Fix syscall table base loading assembler
  o [SCSI]: Fix bugs in sym2 hotplug conversion
  o [IPV6]: Fix some dst cache leaks
  o [CRYPTO]: Fix cast{5,6} build after cia_ivsize removal
  o [SPARC]: Kill bogus SHELL= lines in Makefiles
  o [SPARC64]: Update defconfig
  o [SPARC64]: Do not make sparc_{cpu,fpu}_type a NR_CPUS array
  o [SPARC64]: Only allocate cpu structs we really need in
    topology_init()
  o [SPARC64]: In solaris module use sparc64_get_clock_tick() to get
    cpu frequency
  o [SPARC64]: Kill prom_cpu_nodes, unused
  o [SPARC64]: Kill linux_cpus[]/linux_num_cpus, replace with cpu probe
    helpers
  o [SPARC64]: Turn cpu_data into per-cpu data
  o [SPARC64]: Remove unused crap from asm/irq.h
  o [SPARC64]: Make cpu_data present even on UP builds
  o [SPARC64]: Kill up_clock_tick, use cpu_data()
  o [SPARC64]: Always use cpu_data().udelay_val
  o [CPUMASK]: Prevent unused variable warnings on uniprocessor
  o [SPARC64]: Fix uniprocessor build
  o [NET]: Export neigh_changeaddr
  o [IPV6]: Fix dangling multicast device references

David Stevens:
  o [NET]: Fix IGMPv2/MLDv2 list handling OOPS

David T. Hollis:
  o USB: usbnet.c - trailing 'else' that probably breaks net1080

Doug Ledford:
  o Add irq and softirq time accounting to the kernel
  o Reserve the sys_prctl() numbers for and add the stub for allowing
    programs to select whether they use statistical time accounting

Eran Mann:
  o [VLAN]: Fix OOPS on module removal

François Romieu:
  o Clean up missing spin_unlock_irqrestore from rrunner driver
  o [IRDA]: style: Separate data from code in irlan_print_filter()

Fruhwirth Clemens:
  o Fix cryptoloop ECB mode
  o Fix cryptoloop disk corruption under CBC mode

Geert Uytterhoeven:
  o Make SELinux security module compile on m68k

Gerd Knorr:
  o v4l: remove stale CONFIG_VIDEO_PROC_FS

Greg Kroah-Hartman:
  o i2c: fix up "raw" printk() call
  o i2c: move w83481d to top of link order due to chip address takeover
    ability
  o USB: fix usb serial port release problem by untieing it from the
    usb_serial structure
  o USB: fix up usb-serial drivers now that port[] is an array of
    pointers
  o PCI: add PCI_DEVICE() macro to make pci_device_id tables easier to
    read
  o USB: fix usb class device sysfs representation
  o I2C: fix up the wording for the pii4x bugfix
  o USB: handle overloading of usb-serial functions in a much cleaner
    manner
  o Driver Core: remove struct device.name as it is not needed
  o Remove .name usage from floppy driver
  o Remove usage of struct device.name from ide core
  o Remove usage of struct device.name from pcmcia layer
  o Remove usage of struct device.name from bttv driver
  o Remove usage of struct device.name from scsi core
  o Driver Core: add warnings if .release functions are not set for
    objects
  o I2C: add adapter and client name files as the driver core no longer
    provides them
  o Fix Driver Core fixes Firewire
  o PCI: add PCI_DEVICE_CLASS() macro to match PCI_DEVICE() macro
  o PCI: remove #include <linux/miscdevice.h> from some pci hotplug
    drivers
  o PCI: add PCI_NAME_SIZE instead of using DEVICE_NAME_SIZE
  o Video: fix broken saa7111.c driver due to i2c structure changes
  o FB: fix broken tridentfb.c driver due to device.name change
  o PCI: added the pci_pretty_name() macro to pci.h as 2 arches already
    had it

Herbert Xu:
  o [XFRM_USER]: Add inner family field to all SAs and templates
  o [IPSEC]: Use xfrm_rcv for xfrm tunnel packets
  o Fix usb interface change in hisax st5481_*
  o [IPSEC]: Fix oops when destroying stillborn states

Hideaki Yoshifuji:
  o [IPV6]: Fix typo in linux/ipv6.h
  o [IPV4]: Fix IPVS build with IP_VS_PROTO_TCP disabled
  o [IPV6]: strategy handler for net.ipv6.conf.* forwarding
  o [SCTP]: Fix typo in Kconfig

Hirofumi Ogawa:
  o thread coredump oops fix
  o don't export add_timer

Hollis Blanchard:
  o spelling fix

Ingo Molnar:
  o More timer race fixes

Ion Badulescu:
  o [netdrvr tulip] add pci id for 3com 3CSOHO100B-TX

Ivan Kokshaysky:
  o PCI: undo recent pci_setup_bridge() change

James Bottomley:
  o cciss scsi: fix use before check of possible null pointer
  o Kill highmem_io flag in SCSI
  o SCSI: Introduce dma_boundary parameter
  o Correct email address in MAINTAINERS list
  o qla1280 driver update
  o Reintegrate qla1280 fixes
  o revert dc395x changes Cset exclude:
    aliakc@web.de|ChangeSet|20030802141539|54778
  o some left highmem_io instances
  o Qla1280 update to 3.23.24
  o oops in sd_shutdown
  o Add fastfail to SCSI
  o ips 1/4: lindent ips.c
  o ips 2/4: 2.4 resync
  o ips 3/4: use pci_dma APIs and remove GFP abuse
  o merge hch/gregkh scsi changes
  o remove generic device name field from parisc SCSI devices
  o scsi.h uses "u8" which isn't defined
  o Fix MCA for driver core update

James Morris:
  o [CRYPTO]: Documentation bugfix

Jamie Lenehan:
  o dc395x - 1/3 remove-static-eeprom-struct
  o dc395x - 2/3 remove-static-adapter-list
  o dc395x - 3/3 fix-failures
  o dc395x - list handling cleanups

Jamie Lokier:
  o Fix protocol bugs with NFS and nanoseconds
  o use simple_strtoul for unsigned kernel parameters
  o make NFS lockd port numbers assignable at run time

Jan Oravec:
  o [NET]: Set NLM_F_MULTI in answer of RTM_GETADDR dump answer

Janice Girouard:
  o PCI: testing for probe errors in pci-driver.c

Jaroslav Kysela:
  o ALSA added support for rev 50 cards.
  o ALSA Fixed 192kHz support
  o ALSA added quirk type AC97_TUNE_AD_SHARING.
  o ALSA improved the probe/resume function.
  o ALSA added use_pm to the kernel boot parameter.
  o ALSA Fixed typos (GRP->GPR)
  o ALSA fixed typos.
  o ALSA rewritten the pm whitelist as a static list.
  o ALSA fixed corruption of stream linked list in the interrupt handler.
  o ALSA more descriptions for vx drivers. 
  o ALSA removed buggy copy callback.
  o ALSA removed unused functions.
  o ALSA hopefully fixed the capture.
  o ALSA Removed bob_lock spinlock
  o ALSA fix mixed up vendor/device ID's for Asus P4P800
  o ALSA fix typos
  o ALSA fixed uninitialized spin_lock.
  o ALSA fixed missing spin_lock_init().
  o ALSA register dump in the proc file.
  o ALSA fixed the wrong order of object destruction
  o ALSA fix by James Courtier-Dutton <James@superbug.demon.co.uk>
  o ALSA Fixed open for O_RDWR when capture is not available
  o ALSA Synced USB audio driver with the latest 2.6 code
  o ALSA update

Javier Achirica:
  o [wireless airo] Turns on spy code in wireless extensions v16
  o [wireless airo] Fix PCI unregister code

Jean Delvare:
  o i2c: user/kernel bug and memory leak in i2c-dev

Jeff Garzik:
  o [netdrvr] add ethtool_ops to struct net_device, and associated
    infrastructure
  o [netdrvr tg3] convert to using ethtool_ops
  o [netdrvr] add SET_ETHTOOL_OPS back-compat hook
  o [hw_random] update documentation to reflect reality
  o 2.6: fix X86_VENDOR_ID offset in head.S
  o [netdrvr] clean up driver object name removal breakage
  o [arcnet com20020] check_region removal, ->name removal breakage fix
  o [arcnet com20020] misc fixes
  o [arcnet com90io] replace check_region with temporary
    request_region, in probe phase.
  o [netdrvr] add sis190 gigabit ethernet driver (note: needs work)
  o [netdrvr sis190] Lindent sis190.  zero code changes
  o [netdrvr sis190] manually clean up formatting a bit more
  o [netdrvr sis190] allocate RX/TX descriptors using PCI DMA API
  o add missing export-symbol lines for ethtool_ops
  o another ethtool_ops quickie
  o [ia32] Note that X86_VENDOR_ID offset in head.S is dependent
  o [netdrvr 8139too] add adapter to supported list, in docs
  o [netdrvr de2104x] fix Kconfig help text to reflect reality
  o fix ioapic build breakage
  o remove mount_root_failed_msg()

Jeroen Vreeken:
  o [NETROM]: Fix sysctl initializers
  o [NETROM]: Expire sockets faster on close
  o [NETROM]: Free buffers in write queue on socket destroy
  o [NETROM]: Reserve space in socket header for AX25 header
  o [NETROM]: Lock sockets while doing protocol processing
  o [NETROM]: Better control over the AX25 devices
  o [NETROM]: Use hlist for the routing table information
  o [AX25]: Fix ax25_cb locking
  o [AX25]: Use ->hard_header_len instead of some predicted worse case
  o [AX25]: Fix list usage and list locking in ax25_iface.c
  o [NETROM]: Update wrt. ax25_cb refcounting changes

Jes Sorensen:
  o qla3.23.34

Jesse Barnes:
  o ia64: is_headless_node fix

John Levon:
  o Document mounting of binfmt_misc
  o OProfile: reduce allocations of MSR structs
  o OProfile: export kernel pointer size in oprofilefs
  o OProfile: add a useful statistic
  o OProfile: don't assume MSRs stay the same across CPU models

Kai Germaschewski:
  o kbuild: Move generation of vmlinux.lds.s into arch/.../kernel

Kai Makisara:
  o SCSI tape fix for oops in read with wrong block size
  o Email address update

Karol Kozimor:
  o [netdrvr 8139too] fix resume behavior

Kartikey Mahendra Bhatt:
  o [CRYPTO]: Add cast5, integration by jmorris@intercode.com.au
  o [CRYPTO]: Add CAST6 (CAST-256) algorithm

Kazunori Miyazawa:
  o [IPV6]: Fix clearing in ah6 input
  o [IPV6]: Fix authentication error with TCP, with help from Joy
    Latten (latten@austin.ibm.com)

Kyle McMartin:
  o [IPSEC]: Add support for Twofish and Serpent

Len Brown:
  o update acpi= and acpismp= in kernel-parameters.txt
  o ACPI from 2.4
  o ACPI: this delta should have been included in previous cset
  o ACPI -- CONFIG_ACPI_HT
  o ACPI -- CONFIG_ACPI_HT -- this delta should have been in previous
    cset
  o ACPI: merge andy-2.6 into lenb-2.6
  o ACPI dmi_scan.c: delete some incomplete code that broke !SMP + APIC
    build; add ACPI blacklist comment, move __i386__ out of do_mounts.c
    and into create mount_root_failed_msg()
  o ACPI now honors "noapic" cmdline option config tweaks from Dominik
    Brodowski

Linus Torvalds:
  o Mark CLONE_DETACHED as being irrelevant: it must match CLONE_THREAD
  o DRI CVS update: document r128 and radeon version numbers
  o DRI CVS update: bump i810 driver to 1.4
  o Don't add noisy "deprecated" things to PM
  o Fix "no_idt" usage in reboot code, noticed by better asm
    typechecking in gcc-3.3.1.
  o Make <scsi/scsi.h> include the right headers and use the right
    types
  o Fix incomplete EISA device "name" conversion
  o Fix "make clean" in scripts/genksyms
  o More EISA/MCA fixups for removal of 'name' member in device struct
  o Fix compile warning in AFS by passing around "const" types properly
  o Fix up ad1848 OSS driver for PnP 'name' move
  o Update scx200 i2c driver for 'name' move
  o Fix up riscom8 driver to use work queues instead of task queueing
  o Fix up esp driver for task_queue -> work abstraction
  o Switch specialix driver from task-queues to work queues
  o Fix AGP device ID's - make them static, and fix bad ATI name
    confusion
  o Update isicom driver to work queue abstraction
  o Fix more drivers that broke due to losing the 'name' entry
  o Add proper header file for fewer warnings in blkmtd.c
  o Add CONFIG_BROKEN (default 'n') to hide known-broken drivers
  o Make BLKMTD and MTD_PCMCIA broken. They are. Maybe somebody will
    stand up and un-break them.
  o Fix broken x86_64 ioport code
  o Update x86 defconfig
  o The default ARCH_SI_BAND_T should be "int", since that is what
    Linux historically has had. Only x86-64 uses anything else, so make
    the special case be _there_.
  o Update the 32-bit Ninja SCSI driver from YOKOTA Hiroshi
  o Update the PCMCIA driver for the NinjaSCSI-3 by YOKOTA Hiroshi
  o Update the newly merged Ninja-SCSI PCMCIA driver to recent cleanups
    (removal of link release timer and the STALE_CONFIG crud).
  o Fix up DIGI driver for work-queue abstraction
  o Fix up various small compile warnings in an effort at getting rid
    of the simple stuff that hides the serious things. 
  o Fix video drivers for i2c 'name' move
  o Fix jiffy handling: they are "unsigned long"
  o Fix irda vlsi_ir.c for PCI device 'name' changes
  o Fix smctr.c warning for unused label
  o net/wan/sbni.c totally misused "pci_request_region()", thinking it
    was the same as the old request_region(). Not so.
  o Fix "jiffies" comparison in seeq8005.c: it's an unsigned long
  o aacraid: fix "flags" save value
  o aha1740: work around 'name' field removal
  o ultrastor.c: fix bitmap operation type
  o USB serial console: fix compile warning
  o NCR5380: don't play games with NCR5380_proc_info() - just mark it
    static unconditionally, to allow multiple built-in modules.
  o Fix tridentfd for 'name' move, and avoid compile warnings
  o The Intel Instruction set manual is wrong on how to test for a
    valid SEP bit. The errata has it right: you have to have at least
    model 3, stepping 3. Not "model >= 3 or stepping >= 3".
  o VT requires INPUT support: make it be automatically included
  o Make USB storage select SCSI support automatically, instead
  o Linux 2.6.0-test4

Maciej Soltysiak:
  o C99 initialisers for sound/oss

Marc Zyngier:
  o EISA bus update

Mark M. Hoffman:
  o I2C: i2c nforce2.c fixes

Mark W. McClelland:
  o USB: ov511 sysfs conversion (1/3)
  o USB: ov511 sysfs conversion (2/3)
  o USB: ov511 sysfs conversion (3/3)

Matt Wilson:
  o zap_other_threads() detaches thread group leader

Matthew Natalier:
  o [netdrvr 8139cp] fix h/w vlan offload

Matthew Wilcox:
  o Start cleaning up sym2
  o Convert sym2 to be hotplug-capable

Michel Daenzer:
  o [NET]: Make sure interval member of struct tc_estimator is signed

Mikael Pettersson:
  o Disable APIC on reboot

Mikael Ylikoski:
  o [IPSEC]: Fix oops using null ciper in CBC mode

Mike Anderson:
  o recovered error forward port
  o scsi host / scsi device ref counting take 2 [1/3]
  o scsi host / scsi device ref counting take 2 [2/3]
  o scsi host / scsi device ref counting take 2 [3/3]
  o Correct removal of procfs host enteries [1/2]
  o Correct removal of procfs host enteries [2/2]

Mike Christie:
  o fixes compile errors in cpqfc driver

Mitchell Blank Jr.:
  o [NET]: Small loopback.c cleanups

Muli Ben-Yehuda:
  o fix trident.c lockup on module load 2.6.0-test2

Nathan Scott:
  o [XFS] Fix a logic error allowing pages to marked uptodate when not
    all attached buffers were uptodate
  o [XFS] Use xfs_dev_t size rather than dev_t size in xfs_attr_fork
    initialization
  o [XFS] Fix up the default ACL inherit case, in the presence of
    failure during applying the default ACL (eg. from ENOSPC)
  o [XFS] Fix a race condition in async pagebuf IO completion, by
    moving blk queue manipulation down into pagebuf. 

Neil Brown:
  o Disable buggy raid5 handling of read-ahead
  o Fix bug in sunrpc/server code
  o kNFSd: Make sure nothing happens to a dead rpc/tcp socket
  o kNFSd: Make sure nfsd replies from the address the request was sent
    to
  o kNFSd: Release udp socket for next nfs request to arrive earlier

Oliver Neukum:
  o USB: ttusb_dec.c: another case of GFP_KERNEL in interrupt
  o USB: return to old timeout handling
  o USB: correct error handling in usb_driver_claim_interface()
  o USB: correct error handling in usb_driver_claim_interface() -
    comment
  o USB: error check for claiming second interface in usbnet
  o USB: genelink_tx_fixup fails to check for memory allocation failure

Patrick Mansfield:
  o add sysfs attributes to scan and delete scsi_devices

Patrick Mochel:
  o [power] Fix compilation error when CONFIG_PREEMPT=y
  o [power] Fix some incorrect comments
  o [power] Fix #ifdef in ACPI sleep code
  o [power] Move pm.c and mark functions depcrecated
  o [power] Split device PM functions
  o [sysfs] Add attribute groups
  o [power] Add PM info structure to struct device and PM registration
    functions
  o [power] Improve device suspend/resume sequence
  o [power] Get rid of internal spinlock
  o [power] Add PM usage counting
  o [sysfs] Convert struct attribute_group to take array of pointers
  o [sysfs] Mark some arguments const
  o [driver model] Change class functions to const arguments
  o [driver model] Check for probing errors in drivers/base/bus.c
  o [power] Add hooks for runtime device power control
  o [power] Begin to add sysfs files for controlling device power
    states
  o [power] Check device_suspend() return value in swsusp
  o [power] Minor cleanups
  o [swsusp] Remove two panic()s
  o [power] Various swsusp cleanups
  o [sysfs] Don't add ->d_fsdata until dentrys are created
  o [power] Make sure CONFIG_ACPI_SLEEP depends on CONFIG_PM
  o [driver model] Allow per-device shutdown or suspend on driver
    detach
  o [driver model] Remove 'power' file in favor of 'power' directory
  o [power] Register PM subsystem, and create power/ directory in sysfs
  o [power] Make sure we explicitly initialize pm_users
  o [power] Improve suspend functions
  o [power] Improve suspend sequence
  o [acpi] Fix broken Kconfig dependency
  o [acpi] Remove procfs sleep interface
  o [acpi] Convert sleep code to new PM infrastructure
  o [power] Make sure we only have one CPU running before suspending
  o [acpi] Update comments, copyright, and license in
    drivers/acpi/sleep/main.c
  o [power] Add flag to control suspend-to-disk behavior
  o [acpi] Always handle requests for entering S4, not just for S4bios
  o [power] Add initial support for suspend-to-disk
  o [acpi] Fix compilation when CONFIG_SMP=n
  o [x86] Kill warning in dmi_scan.c
  o [power] Adapt swsusp to new PM core. Clean up heavily
  o [power] Further swsusp cleanups
  o [power] Update device handling
  o [power] Move suspend()/resume() methods
  o [power] Update PCI to set PM methods in bus_type
  o [power] Update IDE to set suspend/resume methods in bus_type
  o [acpi] Fix HT Kconfig option one last time
  o [power] Update documentation
  o [power] Fixup device suspend/resume function names
  o [power] Make sure MTRR uses right methods in sysdev_driver
  o [dmi] Ugh, fixup broken merge once and for all
  o [power] Make swsusp-only mm functions available when CONFIG_PM=y
  o [acpi] Make a dummy mp_congig_ioapic_for_sci() function
  o [power] Fix locking in device_{suspend,resume}
  o [power] Update documentation
  o [power] Fix typo
  o [apm] Fix calls to device_{suspend,resume}
  o [cpufreq] Update resume method

Paul Mackerras:
  o [PPP]: Fix two bugs wrt. compression/decompression
  o PPC32: Fix compile error on SMP - asm-ppc/smp.h needs
    linux/threads.h

Peter Chubb:
  o ia64: Kill warnings in sys_ia32.c

Petr Vandrovec:
  o Recent i2c changes broke matroxfb

Randy Dunlap:
  o [NET]: Fixing kfree() in SLIP driver
  o janitor: scsi/gdth error handling
  o janitor: scsi/qlogicfc error handling
  o janitor: scsi ioctl error handling
  o janitor: use -Evalues in cpufreq/speedstep
  o janitor: [sound] don't init statics to 0
  o janitor: remove bogus locking
  o janitor: ad1816: don't init statics to 0
  o janitor: ite8172: don't init statics to 0
  o janitor: use pci_name in emu10k1
  o janitor: i810_audio: balance pci_alloc/free_consistent
  o janitor: es1370: pci_alloc_consistent error handling
  o janitor: input cleanups
  o janitor: input/evdev fix copy_user fault
  o janitor: handle locking in joydump same as in tmdc
  o janitor: add static/exit to some modules
  o janitor: audit RTC
  o janitor: dvb: return register_chrdev value
  o janitor: floppy: use register_blkdev return value
  o janitor: use request_module()
  o ppa needs to scsi_unregister(host)
  o [netdrvr hydra] janitor cleanups

Richard Henderson:
  o [ALPHA] Disable some printks in bootp
  o [ALPHA] Make sure the bridge COMMAND register is correctly set
    after assigning resources.
  o [ALPHA] Fix whitespace
  o [ALPHA] Tidy debugging of pci resources
  o [ALPHA] Corrected testing for peer PCI bus root
  o [ALPHA] Forward port SRM restore code from 2.4
  o [ALPHA] Convert DEBUG_MCHECK define to runtime variable
  o [ALPHA] Fix stxncpy zapping bytes outside the string
  o [EISA] Update for moving "name" out of struct device
  o [ALPHA] Update for "name" out of struct device

Rob Landley:
  o [docbook] Fix kernel-api reference to kernel/power/pm.c

Rob Radez:
  o [SPARC64]: Delete fop->read stub in riowatchdog driver

Robert Olsson:
  o [NET]: Make pktgen depend on procfs

Ronald Bultje:
  o Big zoran driver update

Russell King:
  o [ARM] Add ARMv6 definitions
  o [ARM] Add ARMv6 MMU context handling
  o [ARM] Add ARMv6 TLB handling
  o [ARM] Add ARMv6 memory type table initialisation tweaks
  o Make modules work on ARM
  o [ARM] Remove struct device .name usage
  o [ARM] Fix cpu-sa1110.c gcc3 build error (multi-line asm statement)
  o [ARM] Add Integrator IM/PD-1 module support for Integrator PP/2
  o Fix Acorn Eesox partition handling build
  o [ARM] Remove redundant CONFIG_DEBUG_INFO
  o [ARM] Add missing show_stack()
  o [ARM] Add missing IM-PD1 header file

Rusty Lynch:
  o I2C: bugfix for initialization bug in adm1021 driver

Rusty Russell:
  o [NETFILTER]: Fix masquerade routing check
  o /proc/kallsyms problem

Sam Ravnborg:
  o Move config tasks to kconfig/Makefile
  o fix make xconfig

Simon Evans:
  o blkmtd for 2.6

Simon Kelley:
  o [wireless atmel] minor updates

Stephen Hemminger:
  o [NET]: Add unlikely tag to skb_pull()
  o [TUN]: Driver not cleaning up on module remove
  o [NET]: Fix tun driver to use private linked lists
  o [NET]: Update bpqether for 2.6
  o [NET]: Add missing rcu_read_lock to bpqether
  o [NET]: Make lapbether work on 2.6.0-test3
  o [NETROM]: Make lists and locks static since they are only used in
    one file
  o [NETROM]: Convert to alloc_netdev()
  o [NETROM]: Convert /proc interface to seq_file
  o [NETROM]: Fix use after free in socket close
  o [NET]: Convert YAM driver to dynamic net_device
  o [NET]: Convert YAM driver to seq_file
  o [NET]: ibmtr - get rid of MOD_INC/DEC
  o [NET]: Network device renaming sysfs fix
  o [IPV6]: Set owner on /proc/net/rt6_stats
  o [IPV6]: Fix build with CONFIG_XFRM disabled
  o [NET]: net-sysfs misc fixes
  o [NET]: net-sysfs - use attribute group instead of kobject for
    statistics
  o [NET]: Move code inline if short and used once
  o [NET]: Add wireless statistics to sysfs
  o [IRDA]: Get rid of useless hashbin in irtty
  o [IRDA]: Fix irtty line disc and module semantics
  o [IRDA]: irda_device_setup should match ether_setup
  o [IRDA]: irlap_open should take const string
  o [IRDA]: irlap hashbin can be private
  o Make z8530.c build on 2.6
  o [NET]: free_netdev - free network device on last class_device_usage
  o [NET]: free_netdev - update documentation
  o [NET]: free_netdev - drivers/net/* changes
  o [NET]: free_netdev - tokenring changes
  o [NET]: free_netdev - pcmcia drivers
  o [NET]: free_netdev - misc drivers
  o [NET]: free_netdev - net/* drivers
  o [NET]: free_netdev - destructors
  o [NET]: free_netdev - fix leaky drivers
  o [NET]: free_netdev - define HAVE_FREE_NETDEV in linux/netdevice.h
  o [NET]: Document ->stop() method netdevice semantics
  o [NET]: Kill unused first argument in dev_get_idx()
  o [IRDA]: Kill old irtty driver, as suggested by Jean and Jeff
  o [NET]: update STRIP driver
  o [IRDA]: ircomm - set owner get rid of MOD_INC/MOD_DEC
  o [IRDA]: Set owner field on /proc/net/irda sub entries
  o [IRDA]: Remove unused function prototype in irda_device.c
  o [IRDA]: Remove hashbin from irlan
  o [IRDA]: Convert irlan to use alloc_netdev()
  o [IRDA]: Remove duplicate of irlan_state
  o [IRDA]: Convert irlan to seq_file interface
  o [NET]: Convert 802/tr to seq_file
  o [TOKENRING]: Get rid of egregious typedef
  o [TOKENRING]: spin_lock consistency
  o [TOKENRING]: mcast_addr need not be on stack
  o [TOKENRING]: better hash function
  o [TOKENRING]: fix the seq_file next operation
  o [TOKENRING]: expire timer improvements

Stephen Lord:
  o [XFS] get version 1 directories back into action
  o [XFS] clean up the flush logic some more, make the inode flush path
    less lossy since we now depend on it. Add a sync_fs callout which
    waits for flush to be done.
  o [XFS] fix 64bit build
  o [XFS] Add versioning to the on disk inode which we increment on
    each flush call. This is used during recovery to avoid replaying an
  o [XFS] use the 2.5 version of the arguments on sync_fs
  o [XFS] remove an impossible code path from mkdir and link paths,
    spotted by Al Viro.

Steve French:
  o add missing cifs quota support part 1
  o blocksize getting overwritten in construct dentry
  o Fix rename open file to better match standard unix semantics
  o fix rename of open files
  o fix incorrect length in rename by file handle frame
  o TotalDataCount field not getting set properly on the transact2
    SetFileInfo rename network operation
  o fix white space
  o retry socket write on EAGAIN.  Fix oops in write when tcp session
    dead
  o remove spurious logging of message on "create if file does not
    exist" case (without O_EXCL) when file exists
  o Add missing CIFS VFS entry to maintainers list

Suresh B. Siddha:
  o ia64: cleanup inline assembly

Thomas Molina:
  o Re: Linux 2.6.0-test3: logo patch

Tom Rini:
  o I2C: Fix for i2c-piix4 with on some boards
  o PPC32: Restrict when we enable IBM405_ERR{77,51}

Tommi Virtanen:
  o [NET]: Flush hw header caches on NETDEV_CHANGEADDR events

Trond Myklebust:
  o Support dentry revalidation under open(".")
  o Various RPC client fixes
  o If an RPC request has to be resent due to a timeout, it turns out
    that call_encode() may cause rq_rcv_buf to be reset despite the
    fact that a reply might be delivered at any moment by a softirq.
  o Back out some congestion control changes that were causing trouble,
    among other things, for the "soft" mount option.
  o Increase the minimum RTO timer value to 1/10 second. This is more
    in line with what is done for TCP.
  o A request cannot be used as part of the RTO estimation if it gets
    resent since you don't know whether the server is replying to the
    first or the second transmission. However we're currently setting
    the cutoff point to be the timeout of the first transmission.
  o Fix a problem whereby READDIRPLUS was causing lookups to result in
    ESTALE errors.
  o Fix problem with open(O_EXCL) not creating hashed dentries
  o Fix compiler warning about using a wrong type as the argument for
    nfsroot_mount().

Ville Nuorvala:
  o [IPV6]: Fix bugs in ip6ip6_tnl_xmit()
  o [IPV6]: Fix ip6_dst_lookup() route corruption
  o [IPV6]: Fix leaks of rt6_cow()d routes in route.c
  o [IPV6]: Fix tunnel encap limit handling as per RFC2473
  o [IPV6]: Fix target address for (proxy/anycast) NA
  o [IPV6]: Protect proxied addresses against DAD

Wensong Zhang:
  o [IPV4] IPVS: fix the dependence of IP_VS_FTP in Kconfig

William Lee Irwin III:
  o Fix APIC ID handling

Wim Van Sebroeck:
  o [WATCHDOG] sbc60xxwdt.c patch
  o [WATCHDOG] sbc60xxwdt patch2
  o [WATCHDOG] sbc60xxwdt patch3
  o [WATCHDOG] sbc60xxwdt patch4
  o [WATCHDOG] sbc60xxwdt.c patch5
  o [WATCHDOG] advantechwdt.c patch2
  o [WATCHDOG] w83877f_wdt patch
  o [WATCHDOG] w83877f_wdt.c patch2
  o [WATCHDOG] w83877f_wdt.c patch3 (add timeout features)
  o [WATCHDOG] sbc60xxwdt.c patch6
  o [WATCHDOG] sc520_wdt.c patch
  o [WATCHDOG] sc520_wdt.c patch2
  o [WATCHDOG] sc520_wdt.c patch3
  o [WATCHDOG] alim7101_wdt.c patch
  o [WATCHDOG] alim7101_wdt.c patch2
  o [WATCHDOG] alim7101_wdt.c patch3

Yoshinori Sato:
  o h8300 support fix (1/2)
  o h8300 support fix (2/2)



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264597AbUD1CEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264597AbUD1CEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 22:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbUD1CEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 22:04:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:10200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264597AbUD1CDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 22:03:52 -0400
Date: Tue, 27 Apr 2004 19:03:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.6-rc3
Message-ID: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


s390, cifs, ntfs, ppc, ppc64, cpufreq upates. Oh, and DVB and USB.

I'm hoping to do a final 2.6.6 later this week, so I'm hoping as many 
people as possible will test this.

	Thanks,

		Linus

----

Summary of changes from v2.6.6-rc2 to v2.6.6-rc3
============================================

Adrian Cox:
  o PPC32: In some cases we need to make all pages _PAGE_COHERENT

Alan Stern:
  o USB: Important bugfix for UHCI list management code
  o fs/proc/array.c: workaround for gcc-2.96

Alex Williamson:
  o ia64: bug w/ shared interrupts

Andrea Arcangeli:
  o i810_dma range check

Andreas Jochens:
  o [TG3]: Fix typo in TG3_TSO_FW_RODATA_ADDR definition

Andrew Morton:
  o Call populate_rootfs later in boot
  o remove show_trace_task()
  o fbdev comment fix
  o writeback livelock fix
  o dquot: remove unneeded test
  o task_lock() comment update
  o dio_bio_reap() return value fix
  o slab: use order 0 for vfs caches
  o smb_writepage retval fix
  o simplify put_page()
  o ppc32: dma_unmap_page() fix

Andy Lutomirski:
  o compute_creds race

Anton Altaparmakov:
  o NTFS: Set i_generation in VFS inode from seq_no in NTFS inode
  o NTFS: Make ntfs_lookup() NFS export safe, i.e. use
    d_splice_alias(), etc
  o NTFS: Make it compile
  o NTFS: Release 2.1.7 - Enable NFS exporting of mounted NTFS volumes
  o NTFS: Add missing return -EOPNOTSUPP; in
    fs/ntfs/aops.c::ntfs_commit_nonresident_write()
  o NTFS: Fix off by one error in ntfs_get_parent()
  o NTFS: Enforce no atime and no dir atime updates at mount/remount
    time as they are not implemented yet anyway.
  o NTFS: Move a few assignments after a NULL check in fs/ntfs/attrib.c
  o NTFS: Finally fix NFS exporting of mounted NTFS volumes by checking
    the return of d_splice_alias() and acting accordingly rather than
    just ignoring the returned dentry.

Arjan van de Ven:
  o [NET]: linux/if.h needs linux/compiler.h for __user

Armin Schindler:
  o ISDN CAPI: add ncci list semaphore
  o ISDN Eicon driver: remove call to trap usermode helper

Arthur Othieno:
  o PPC32: Fix two typos in arch/ppc/boot/
  o ide-probe.c: kill duplicate #include

Bartlomiej Zolnierkiewicz:
  o prevent module unloading for legacy IDE chipset drivers

Benjamin Herrenschmidt:
  o ppc64: Set ARCH_MIN_TASKALIGN

Bruno Ducrot:
  o [CPUFREQ] Correcting SGTC.  Timer is based upon FSB

Chas Williams:
  o [ATM]: [fore200e] 0.3e version by Christophe Lizzi (lizzi@cnam.fr)
  o [ATM]: [fore200e] make use tasklet configurable

Chris Mason:
  o lockfs: reiserfs fix
  o reiserfs: ignore prepared and locked buffers

Chris Wright:
  o [IPV4]: Fix return value on MCAST_MSFILTER error case
  o credentials locking fix

Christoph Hellwig:
  o lockfs - vfs bits
  o lockfs - xfs bits
  o lockfs - dm bits
  o fix fs/proc/task_nommu.c compile
  o remove Documentation/DocBook/parportbook.tmpl

Colin Leroy:
  o USB: fix cdc-acm as it is still (differently) broken

Daniel Drake:
  o generic PCI IDE support for Toshiba Piccolo chips

Dave Jones:
  o [CPUFREQ] powernow-k7 ACPI integration
  o [CPUFREQ] Drop unneeded part of last patch
  o [CPUFREQ] powernow-k7 needs to init later
  o [CPUFREQ] Remove bogus newline in powernow-k7 driver
  o [CPUFREQ] Add a module parameter to force ACPI to be used
  o [CPUFREQ] Make powernow-k7 acpi debug output a little less verbose
  o [CPUFREQ] powernow-k7 ACPI->PST values were a factor of 10 off
  o [CPUFREQ] clear defaults before powernow-k7 acpi fallback Decoding
    the legacy tables may have set these values.
  o [CPUFREQ] Not all powernow-K7 BIOS's put the frequency at MAX at
    POST
  o [CPUFREQ] Fix debug build of powernow-k8 From Paul Devriendt
  o [CPUFREQ] Fix up missing CONFIG_X86_POWERNOW_K8_ACPI We don't need
    this, we can infer from CONFIG_ACPI_PROCESSOR
  o [CPUFREQ] Fix broken cast
  o [CPUFREQ] Fix unbalanced try_get_module/put_module Spotted by
    Charles Coffing <ccoffing@novell.com>
  o [CPUFREQ] Remove redundant part of powernow-k7 module parm If used
    as a bootparam, this would've become
    powernow-k7.powernow_acpi_force which looks silly.
  o [CPUFREQ] Make an educated guess at the current P-state in the ACPI
    driver
  o [CPUFREQ] Export an array of acpi driver supported frequencies in
    sysfs From Dominik.
  o [CPUFREQ] Fix security hole in proc handler

Dave Kleikamp:
  o JFS: Fix non-ascii file name problem

David Brownell:
  o USB: ehci handles pci misbehavior better
  o USB: rndis gadget driver updates
  o USB: usbnet and pl2301/2302 reset
  o One more USB fix

David Mosberger:
  o ia64: Quiet another compiler-warning
  o ia64: Drop pci_sal_ext_{read,write}() and instead simply switch to
    extended config-space addresses when needed.  This avoids the
    fragile SAL version testing.
  o ia64: When delivering a signal, force byte-order to little-endian
  o ia64: Add message-queue support to copy_siginfo_from_user()

David S. Miller:
  o [TCP]: Abstract out all settings of tcp_opt->ca_state into a
    function
  o [TCP]: Add vegas congestion avoidance support
  o [SPARC64]: Update defconfig
  o [SPARC64]: Fix zero-extension issues wrt. {pgd,pmd}_val()
  o [TG3]: Update driver version and reldate
  o [TG3]: Undo comment typo fix, it was wrong

David Woodhouse:
  o Set ARCH_MIN_TASKALIGN on ppc32

Deepak Saxena:
  o [ARM PATCH] 1815/1: Generic DMA buffer bouncing support for ARM
    targets

Dominik Brodowski:
  o [CPUFREQ] don't use speedstep-centrino on unsupported CPUs

Eric Brower:
  o [COMPAT]: HDIO_DRIVE_TASK is a compatible ioctl

Geert Uytterhoeven:
  o m68k: Amiga A2065 Ethernet KERN_*
  o m68k bitops

Grant Grundler:
  o [TG3]: Fix comment typo

Greg Edwards:
  o ia64: Remove SN PDA page overflow check

Greg Kroah-Hartman:
  o USB: Don't try to suspend devices that do not support it
  o USB: fix cdc-acm warnings due to previous patch
  o USB: fix up fake usb_interface structure in hiddev
  o USB: further cleanup of the hiddev driver, fixing another possible
    oops on disconnect

Herbert Xu:
  o Set module license in mcheck/non-fatal.c

J. Bruce Fields:
  o sunrpc rmmod oops fix

Jakub Jelínek:
  o [SPARC64]: Fix 32-bit posix timers
  o [SPARC64]: Missing part of posix timers fix
  o ia64: add mq support for ia64

Jan Capek:
  o USB: ftdi patch fixup

Jan Kara:
  o ext3 journalled quota locking fix
  o Bigger quota hashtable
  o Per-sb dquot dirty lists
  o Minor fixes for ext3 journalled quotas

Jan-Benedict Glaw:
  o New set of input patches
  o lkkbd: Current version

Jeff Garzik:
  o [TG3]: Dump NIC-specific statistics via ethtool

Jens Axboe:
  o don't log drive loading failures
  o correct LoEj logic
  o fix SG_IO page leak

Keith M. Wesolowski:
  o [SPARC32]: Fix wraparound bug in bitmap allocator

Krzysztof Halasa:
  o [netdrvr tulip] fix use-after-free

Linda Xie:
  o symlink doesn't support kobj name > 20 charaters (KOBJ_NAME_LEN)

Linus Torvalds:
  o Revert fb_ioctl "fix" with extreme prejudice
  o Include <linux/syscalls.h> in files that need them
  o Linux 2.6.6-rc3

Maneesh Soni:
  o prune_dcache comment fix

Manfred Spraul:
  o slab alignment fixes

Marc-Christian Petersen:
  o ext3 avoid writing kernel memory to disk

Marcel Holtmann:
  o i4l: add compat ioctl's for CAPI

Marek Szuba:
  o isofs "default NLS charset not used" fix

Martin Pool:
  o ia64: fpswa_interface needs to be exported

Martin Schwidefsky:
  o s390: core s390
  o s390: common i/o layer
  o s390: 3270 device driver
  o s390: network device drivers
  o s390: dasd device driver
  o s390: zfcp adapter fixes
  o s390: crypto api
  o s390: no timer interrupts in idle

Matt Domsch:
  o EDD: set sysfs attr owner field
  o efivars fixes
  o efibootmgr location change

Matt Mackall:
  o dynamic proc cleanups
  o fix CONFIG_SYSFS=n compile warning

Matt Porter:
  o ppc32: fix head_44x.S copyrights

Matt Tolentino:
  o efivars: remove from arch/ia64
  o efivars: add to drivers/firmware
  o efivars: remove x86 references

Michael Chan:
  o [TG3]: Fix jimbo frame PHY programming

Michael E. Brown:
  o sysfs module unload race fix for bin_attributes

Michael Hunold:
  o V4L: Update the saa7146 driver
  o DVB: Documentation and Kconfig updazes
  o DVB: Update DVB budget drivers
  o DVB: Add EN50221 cam support to dvb-core
  o DVB: Other DVB core updates
  o DVB: AV7110 DVB driver updates
  o DVB: Misc. DVB frontend driver updates
  o DVB: Misc. DVB USB driver updates
  o DVB: Follow saa7146 changes in affected V4L drivers

Michael Veeck:
  o use kernel min/max in IDE code (1/2)
  o use kernel min/max in IDE code (2/2)

Michal Ludvig:
  o [CRYPTO]: Add module autoloads for null module
  o [CRYPTO]: Add module aliases for des and sha512

Mikael Pettersson:
  o clean up Pentium M quirk code in nmi.c
  o use smp_processor_id() in init_IRQ()

Nathan Lynch:
  o ppc64: remove duplicated mb() and comment from __cpu_up

Nicolas Pitre:
  o [ARM PATCH] 1824/1: guard against gcc not respecting local variable
    register assignment
  o [ARM PATCH] 1825/1: abort on bad code generation with div64 in some
    cases

Paul Jackson:
  o hugetlbpage: remove include linux/module.h

Pavel Machek:
  o doc: tips for S3 resume on radeon cards

Pavel Roskin:
  o ide-disk.c: fix for IDE CF card ejection with devfs
  o removal of MOD_{INC,DEC}_USE_COUNT in ide-cs.c

Petri Koistinen:
  o [SUNRPC]: Missing NULL kmalloc check in unix_domain_find()

Ralf Bächle:
  o Au1000 IrDA driver update
  o Remove RCS Id string
  o meth updates
  o BCM1250 network driver updates
  o sgiseeq fixes
  o IOC3 updates
  o declance updates
  o MIPS: PCI code is now shared
  o Add Pete Popov to credits
  o Merge missing MIPS i8042 bits
  o MIPS is an a.out free zone
  o Update comment in fs/compat.c

Randy Dunlap:
  o blkdev.h: functions no longer inline
  o doc: specifiying module parameters

Randy Vinson:
  o Renaming pplus_common.c to hawk_common.c to match gt64260_common.c,
    etc, plus minor cleanups.
  o Updating mcpn765 for 2.6
  o Merge bk://linux.bkbits.net/linux-2.5 into
    linuxbox.(none):/src/linux/ppc/linux-2.5/linux
  o Updating Force PCore to 2.6

Romain Liévin:
  o USB: tiglusb: wrong timeout value
  o tipar char driver: wrong timeout value

Russell King:
  o [ARM] Add find_first_bit and find_next_bit
  o [ARM] Add support for ARM Versatile platform
  o [SERIAL] Correct PL011 help text
  o pcmcia netdev ordering fixes
  o [ARM] Remove extraneous "volatile" from atomic_t pointers

Rusty Russell:
  o [NETFILTER]: Missing ip_rt_put in ipt_MASQUERADE
  o create singlethread_workqueue()
  o Use workqueue for call_usermodehelper
  o ppc64: Split prom.c Into pre-reloc and post-reloc Functions
  o ppc64: Rearrage finish_device_tree() and its functions in C Order
  o ppc64: Rearrage copy_device_tree() and its functions in C Order
  o ppc64: Rearrage interpret_funcs in C Order
  o ppc64: Rearrage Rest of prom.c in C Order
  o ppc64: Make finish_device_tree use lmb_alloc, not klimit
  o ppc64: make_room macro for ppc64 prom.c
  o ppc64: Fix prom.c to boot on G5 after make_room fix
  o ppc64: Clean up prom functions in prom.c
  o ppc64: Initrd Cleanup
  o ppc64: Move Initrd
  o ppc64: prom.c fix for CONFIG_BLK_DEV_INITRD=n
  o Fix cpumask iterator over empty cpu set

Sam Ravnborg:
  o kbuild: Improved external module support

Scott Feldman:
  o e100: ICH 10/H Tx hang fix

Simon Kelley:
  o atmel wireless update

Sridhar Samudrala:
  o [SCTP] Avoid the use of constant SCTP_IP_OVERHEAD to determine the
    max data size in a SCTP packet.
  o [SCTP] Cleanup sctp_packet and sctp_outq infrastructure
  o [SCTP] Partial Reliability Extension support
  o [SCTP] Propagate error from sctp_proc_init. (Olaf Kirch)

Stephen D. Smalley:
  o selinux: change context_to_sid handling for no-policy case
  o selinux: add runtime disable
  o selinux: remove hardcoded policy assumption from get_user_sids()
    logic
  o SELinux ptrace race fix

Stephen Hemminger:
  o [TCP]: Better packing of frto fields into tcp_opt
  o [TCP]: Add sysctl to turn off matrics caching
  o [TCP]: Report vegas info via tcp_diag
  o [TCP]: Add vegas sysctl docs
  o [IPV4]: Spelling fixed for ip-sysctl.txt
  o [IRDA]: Export irda_task_delete

Stephen Rothwell:
  o PPC64 iSeries virtual ethernet fix
  o ppc64: iSeries virtual cdrom module fix
  o ppc64: add some iSeries proc entries

Steve French:
  o Can not mount from cifs vfs client built with gcc 3.3.1 due to
    compiler optimization of unsafe global variable. Remove unsafe
    global variable
  o Fix problem reconnecting additional mounts to the same server after
    session failure.
  o Fix invalid dentry when race in mkdir between two clients
  o fix oops in send_sig on unmount of cifs vfs due to sending signal
    to demultiplex thread after it has exited
  o Fix EIO caused by network timeouts on changing file size
  o fix to not retime out the same session twice since it can
    invalidate the newly reestablished session unnecessarily
  o Do not return buffer if request has already timed out
  o move bad smb session retry to correct location, up one level in
    cifs vfs code
  o fix endian bug in lockingX and add retry on EAGAIN
  o have to reconnect open files safely, one at a time, as needed
  o finish off move from reopening all files on reconnection (which
    takes too long under heavy stress) to reopen file as needed after
    reconnection to server
  o correct retry on remaining handles based calls
  o Fix compile error
  o Missing soft vs. hard retry mount option
  o Do not grab i_sem (already taken in filemap.c across commit write
    calls) during reopen of invalidated file handle
  o Fix oops in mount error path when unload_nls called with bad
    pointer
  o Avoid smb data corruption under heavy stress
  o missing message on timed out requests
  o rcvtimeout set improperly for some cifs servers
  o invalidate locally cached pages when server breaks oplock.  Do not
    loop reconnecting for servers that drop tcp session rather than
    sending smb negprot response
  o Oops on reopen files when dentry already freed
  o invalidate cached pages when last local instance closed so we do
    not use stale data while someone may be modifying the file on the
    server.
  o fix double incrementing of transaction counter
  o Fix check of filldir return code during readdir to avoid incomplete
    search results displayed on very large directories. Fix cleanup of
    proc entries.  Add config parm to allow disabling negotiating Linux
    extensions
  o allow disabling cifs Linux extensions via proc
  o Fix an incorrect mapping of open flags to cifs open disposition. 
    Fix blocking byte range locks.  These fix breakages that were
    notice running lock tests 1 and 7 of the connectathon posix file
    api tests
  o set byte range locktimeouts properly
  o fix cifs readme
  o gracefully exit on failed mounts to win98 (which closes tcp session
    rather than erroring on smb protocol negotiation)
  o fix failed mounts to win98 part II
  o Fix global kernel name space pollution
  o Check return on failed dentry allocation.  Suggested by Randy
    Dunlap
  o Allow null password string pointer and passwords longer than 16
    bytes
  o finish handling commas in passwords
  o finish off mount parm sep override
  o Fix caching problem with multiply open files from different clients
  o Relax requested CIFS permissions on open to simply request
    GENERIC_READ and GENERIC_WRITE (instead of GENERIC_ALL which can
    unnecessarily conflict with share permissions by asking implicitly
    for take ownership and other unneeded flags)
  o fix remoting caching part 2
  o remove spurious debug messages
  o fix problem not connecting to server when port not specified
    explicitly and port field unitialized
  o reset searches properly when filldir fails
  o ipv6 enablement for cifs vfs fixes
  o Spurious white space and duplicated line cleanup
  o improve resume key resetting logic when filldir returns error and
    filename is in unicode
  o allow nosuid mounts
  o fix problem with inode revalidation and cache page invalidation
  o Fix the exec, suid, dev mount parms to not log warnings when
    specified
  o fix caching data integrity problem
  o use safer i_size_write mechanism to update i_size
  o fixes for fsx truncate/readahead/writebehind bug
  o clean up compiler warnings
  o Add missing description about how to specify credentials file
  o Invalidate readahead data properly when file closed, but other
    client changed it on server
  o Send NTCreateX with ATTR_POSIX if Linux/Unix extensions negotiated
    with server.  This allows files that differ only in case and 
    improves performance of file creation and file open to such servers
  o Fix 20 second hang on some deletes of reopened file due to
    semaphore conflict with vfs_delete on i_sem
  o fix merge problem with 2.6.5 (rename of page struct field list to
    lru)
  o Fix misc. minor memory leaks in error paths
  o free cifs read buffer on retry
  o Fix major page leak in read code caused by extra page_cache_get
    call
  o check permission locally for servers that do not support the CIFS
    Unix Extensions (allowing file_mode and dir_mode to augment the
    server permission check, by doing local vfs_permission check)
  o Remove 64 bit compiler warning
  o Remove "badness in remove_proc_entry" warning logged on module
    unload of cifs
  o Add in cifs fcntl handling to fix remote dnotify problem
  o Do not cache inode metadata when cache time set to 0 (fix hardlink
    count caching)
  o Retry 2nd time after failure on correct port
  o RFC1002 fixup
  o exit from waiting on smb response when session dead
  o Update change log for 1.10 cifs vfs
  o proper rc on host down
  o fix error code mapping on bad host
  o fix timeout on close operation when pending signal
  o do not allow routine user signals to kill SendReceive wait for
    response (which was damaging performance badly)

Tom Rini:
  o PPC32: Add CONFIG_MPC10X_BRIDGE
  o PPC32: Remove an unneeded include in arch/ppc/boot/
  o PPC32: Add more useful information to the oops output
  o PPC32: Change all #if FOO to #ifdef FOO
  o PPC32: Two minor Carolina PReP fixes
  o PPC32: Assign an interrupt for the VME chip on PReP MVME* boards

Trond Myklebust:
  o Fix nfsroot option handling
  o nfs_writepage() retval fix

Ulrich Drepper:
  o Add missing __initdata

William Lee Irwin III:
  o i386 hugetlb tlb correction
  o USB: silence dpcm warning
  o hugepage fixes

Yury Umanets:
  o loop_set_fd() sendfile check fix

Zwane Mwaikambo:
  o remove amd7xx_tco
  o SubmittingPatches diffing update


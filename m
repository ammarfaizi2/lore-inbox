Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129129AbQKCPJ4>; Fri, 3 Nov 2000 10:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130577AbQKCPJq>; Fri, 3 Nov 2000 10:09:46 -0500
Received: from TRAMPOLINE.THUNK.ORG ([216.175.175.172]:44806 "EHLO
	trampoline.thunk.org") by vger.kernel.org with ESMTP
	id <S129129AbQKCPJg>; Fri, 3 Nov 2000 10:09:36 -0500
Date: Fri, 3 Nov 2000 10:09:31 -0500
Message-Id: <200011031509.eA3F9V719729@trampoline.thunk.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
From: tytso@mit.edu
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Travel and other things have kept me more than a little busy lately, so
I fell a bit behind during the test10-pre* series, and didn't have a
chance to issue new updates of the 2.4 TODO list as often as I would
like.  I've caught up on my backlog, however, and this is as up to date
as I can make it as of 2.4.0-test10.

As always, the list isn't perfect.  Comments and reports of bugs fixed /
not fixed are welcome.  (Although for my sanity, please change the
subject line before replying.  :-)

						- Ted


                         Linux 2.4 Status/TODO Page

   This list is almost always out of date, by definition, since kernel
   development moves so quickly. I try to keep it as up to date as
   possible, though. Please send updates to tytso@mit.edu.

   Every few days or so, I periodically send updated versions of this
   list to the linux-kernel list, but you should consult
   http://linux24.sourceforge.net to get the latest information.

   If you're curious to see what has changed recently, check out
   http://linux24.sourceforge.net/status-changes.html. The previous set
   of changes can be found here. Also, this html file is managed under
   CVS at SourceForge.

   I try to keep e-mail addresses out of this document, since I don't
   want to make life easy for bottom-feeder spam artists. If you are a
   developer and want to contact the person who originally reported the
   problem, or want to see the e-mail message which prompted me to
   include a bug/issue in this list, contact me. I keep an mail archive
   which will have that information assuming it was an item added since I
   took over the list from Alan.

   Last modified: [tytso:20001103.1002EST]

   Hopefully up to date as of: test10

1. Should Be Fixed (Confirmation Wanted)

     * Fbcon races (cursor problems when running continual streaming
       output mixed with printk + races when switching from X while doing
       continuous rapid printing --- Alan)
     * USB: system hang with USB audio driver {CRITICAL} (David
       Woodhouse, Randy Dunlap, Narayan Desai) (Fixed with usb-uhci;
       uhci-alt is unknown -- randy dunlap)
     * USB: fix setting urb->dev in printer, acm, bluetooth, all serial
       drivers (Greg KH) {CRITICAL} (test10-pre1)
     * USB: race conditions on devices in use and being unplugged
       (test10)
     * USB: printer Device ID string should not be static; printers can
       update it (test10)
     * USB: fix usbdevfs memset() on IOC_WRITE (Dan Streetman) {CRITICAL}
       (test10)
     * USB: fix hub driver allocation/usage of portstr & tempstr (D.
       Brownell) (causes oops and memory corruptoin) {CRITICAL} (test10)
     * USB: USB mouse stopped working (2.4.0-test9) (Gunther Mayer)
       (fixed in test10)
     * USB: SMP/concurrent/thread-safe for scanner.c, mdc800.c, rio800.c
       (test10)
     * USB: printer open should not fail on printer not ready; add
       GETSTATUS ioctl (2.4.0-test10)

2. Capable Of Corrupting Your FS/data

     * Use PCI DMA by default in IDE is unsafe (must not do so on via
       VPx, x < 3) (Vojtech Pavlik --- requires chipset tuning to be
       enabled according to Andre Hedrick --- we need to turn this on by
       default, if it is safe -- TYT)
     * USB: Problems with USB storage drives (ORB, maybe Zip) during APM
       sleep/suspend
     * Bug in VFAT truncate code will cause slow and painful corruption
       of filesystem (Ivan Baldo, Alan Cox)

3. Security

     * Fix module remove race bug (still to be done: TTY, ldisc, I2C,
       video_device - Al Viro) (Rogier Wolff will handle ATM)

4. Boot Time Failures

     * Use PCI DMA 'lost interrupt' problem with PIIXn tuning enabled
       will hang laptop requiring physical power loss to restart (NEC
       Versa LX, 2.3.x to 2.4.0-test8-pre6, David Ford) (Vojtech Pavlik
       is looking at this)
     * Crashes on boot on some Compaqs ? (may be fixed)
     * Various Alpha's don't boot under 2.4.0-test9 (PCI resource
       allocation problem? Michal Jaegermann; Richard Henderson may have
       an idea what's failing.)
     * Palmax PD1100 hangs during boot since 2.4.0-test9 (Alan Cox)
     * Compaq proliant 7000 (with Compaq Smart Array-3100ES) hangs during
       2.4.0-test9. Likely related to the Raid driver given where it hung
       in the boot messages (chonga at isoft)

5. Compile errors

6. In Progress

     * Fix all remaining PCI code to use pci_enable_device (mostly done)
     * Finish the audit/code review of the code dealing with descriptor
       tables. (Al Viro)
     * DMFE is not SMP safe (Frank Davis patch exists, but hasn't gotten
       much commens yet)
     * Audit all char and block drivers to ensure they are safe with the
       2.3 locking - a lot of them are not especially on the
       read()/write() path. (Frank Davis --- moving slowly; if someone
       wants to help, contact Frank)
     * Fixing autofs4 to deal with VFS changes (Jeremy Fitzhardinge)

7. Obvious Projects For People (well if you have the hardware..)

     * Make syncppp use new ppp code
     * Fix SPX socket code

8. Fix Exists But Isnt Merged

     * Restore O_SYNC functionality (CRITICAL, DB's depend on it)
       (Stephen)
     * Update SGI VisWS to new-style IRQ handling (Ingo)
     * Support MP table above 1Gig (Ingo)
     * Dont panic on boot when meeting HP boxes with wacked APIC table
       numbering (AC)
     * Scheduler bugs in RT (Dimitris)
     * AIC7xxx doesnt work non PCI ? (Doug says OK, new version due
       anyway)
     * Fix boards with different TSC per CPU and kill TSC use on them
     * IRDA fixes:
          + Fixes from DAG: Incluldes a number of critical bugfixes.
            Detailed listing of changes here:
               o irda1
               o irda2
               o irda3
          + Fixes from Jean Tourrilhes (Fixes critical bugs: Infinite
            loop in /proc/discovery, unsafe discovery entry removal,
            potential out of array access in QoS handling) (Functional
            bugs fixed: Zombie sockets disable listening socket, some
            discovery acses unhandled)
     * Many network device drivers don't call MOD_INC_USE_COUNT in
       dev->open. (Paul Gortmaker has patches)
     * using ramfs with highmem enabled can yield a kernel NULL pointer
       dereference. (wollny at cns.mpg.de has a patch)
     * Writing past end of removeable device can cause data corruption
       bugs in the future (Jari Ruusu)
     * fix the UFS and sysvfs races (the latter couple is broken as ext2
       was, UFS is _completely_ broken; eats filesystems) (Al Viro --
       patch mostly exists)
     * HT6560/UMC8672 ide sets up stuff too early (before region stuff
       can be done) (Andre Herick has fix)
     * mtrr.c is broken for machines with >= 4GB of memory (David Wragg
       has a fix)

9. To Do

     * truncate->invalidate_inode_pages removes mapping information from
       mapped pages which may be dirty; sync_pte -> crash. (CRITICAL)
       (sct, Linus and AL are looking at this)
     * VM: raw I/O data loss (raw IO may arrive in a page which afer it
       is unammped from a process) (CRITICAL) (rik van riel)
     * Check all devices use resources properly (Everyone now has to use
       request_region and check the return since we no longer single
       thread driver inits in all module cases. Also memory regions are
       now requestable and a lot of old drivers dont know this yet. --
       Alan Cox)
     * Tulip hang on rmmod/crashes sometimes
     * Devfs races (mostly done - Al Viro)
     * Fix further NFS races (Al Viro)
     * Test other file systems on write
     * Fix mount failures due to copy_* user mishandling
     * Check all file systems are either LFS compliant or error large
       files
     * Issue with notifiers that try to deregister themselves? (lnz;
       notifier locking change by Garzik should backed out, according to
       Jeff)
     * Misc locking problems
          + drivers/pcmcia/ds.c: ds_read & ds_write. SMP locks are
            missing, on UP the sleep_on() use is unsafe.
          + Power management locking (Alan Cox)
          + USB:
               o USB: fix MOD_INC races in plusb.c and uss720.c
               o USB: fix concurrent read/write and other SMP like bugs
                 in:
                    # acm.c
                    # printer.c
                    # uss720.c
                    # serial/ftdi_sio.c
                    # serial/omninet.c
          + do_execve (Al Viro, reported by Manfred)
          + fix the quota races (Al Viro)
     * SCSI CD-ROM doesn't work on filesystems with < 2kb block size
       (Jens Axboe will fix)
     * Remove (now obsolete) checks for ->sb == NULL (Al Viro)
     * Audit list of drivers that dereference ioremap's return (Abramo
       Bagnara)
     * ISAPnP can reprogram active devices (2.4.0-test5, Elmer Joandi,
       alan)
     * Multilink PPP can get the kernel into a tight loop which spams the
       console and freezes the machine (Aaron Tiensivu)
     * mm->rss is modified in some places without holding the
       page_table_lock (sct)
     * Copying between two encrypting loop devices causes an immediate
       deadlock in the request queue (Andi Kleen)
     * FAT filesystem doesn't support 2kb sector sizes (did under 2.2.16,
       doesn't under 2.4.0test7. Kazu Makashima, alan)
     * The new hot plug PCI interface does not provide a method for
       passing the correct device name to cardmgr (David Hinds, alan)
     * non-PNP SB AWE32 has tobles in 2.4.0-test7 and newer (Gerard
       Sharp) (Paul Laufer has a potential patch)
     * 2.4.0-test8 pcmcia is unusable in fall forms (kernel, mixed, or
       dhinds code) (David Ford)
     * VGA Console can cause SMP deadlock when doing printk {CRITICAL}
       (Keith Owens)
     * Forwawrd port 2.2 fixes to allow 2 GHz or faster CPU's. {CRITICAL}
     * IDE tape driver broken; if the last data written does not make up
       a full block, then the driver won't be able to read back ANY part
       of the last block (Mikael Pettersson, Alan Cox)
     * VM: Fix the highmem deadlock, where the swapper cannot create low
       memory bounce buffers OR swap out low memory because it has
       consumed all resources {CRITICAL} (old bug, already reported in
       2.4.0test6)
     * VM: page->mapping->flush() callback in page_lauder() for easier
       integration with journaling filesystem and maybe the network
       filesystems
     * VM: maybe rebalance the swapper a bit... we do page aging now so
       maybe refill_inactive_scan() / shm_swap() and swap_out() need to
       be rebalanced a bit
     * DRM cannot use AGP support module when CONFIG_MODVERSIONS is
       defined (issue with get_module_symbol caused fix proposed by John
       Levon to be rejected)
     * Spin doing ioctls on a down netdeice as it unloads == BOOM
       (prumpf, Alan Cox) Possible other net driver SMP issues (andi
       kleen)
     * USB: SANE backend can't communicate to its scanner (sometimes,
       some scanners)
     * USB: OHCI memory corruption problem
     * USB: Fix differences in UHCI and OHCI HCD behaviors/semantics:
          + OHCI doesn't do URB timeouts
          + OHCI always does BULK_QUEUE (as David.B said, Bulk queueing
            is a UHCI notion; not needed in OHCI; fix not needed)
     * USB: fix USB_QUEUE_BULK problem in uhci.c (oopsen after a while)
       {CRITICAL}
     * USB: Fix serial/omninet.c to not require a small mtu setting in
       order to get a PPP link to work properly (as reported by Bernhard
       Reiter)
     * USB: pegasus: avoid warning spewage on disconnect
     * USB: OHCI optional zero length packet (USB_DISABLE_SPD at send)
     * USB: consistent short packet handling OHCI/UHCI (including
       0-length packets) (Roman)
     * USB: consistent URB next pointer handling by OHCI/UHCI (Roman)

10. To Do But Non Showstopper

     * Go through as 2.4pre kicks in and figure what we should mark
       obsolete for the final 2.4 (i.e. XT hard disk support?)
     * Union mount (Al Viro)
     * Per Process rtsigio limit
     * iget abuse in knfsd
     * ISAPnP IRQ handling failing on SB1000 + resource handling bug
     * Parallel ports should set SA_SHIRQ if PCI (eg in Plip)
     * Devfs compiled in but not mounted causes crap for ->mnt_devname of
       root (Al Viro)
     * PCMCIA/Cardbus hangs (Basically unusable - Hinds pcmcia code is
       reliable)
          + PCMCIA crashes on unloading pci_socket
     * ATM phy-chip-driver interface change for Firestream ATM card
       (Rogier Wolff)
     * Loop device can still hang (William Stearns has script that will
       hang 2.4.0-test7, Peter Enderborg has a short sequence that will
       hang 2.4.0test9)
     * USB: acm (modem) driver is slow compared to Windows drivers for
       same modems (maybe an HCD problem, not acm driver, or acm should
       use bulk queueing)
     * USB: add devfs support to drivers that don't have it
     * USB: add DocBook info to main USB driver interfaces (usb.c)
     * USB: Printer stalls at random places when printing large graphics.
       When printing big pictures (10..50 meg) the printer stalls
       halfway. The point where it stalls is random but the fact that it
       stalls is reproducable. Printing the same pictures using the
       parallel interface is ok. Printing text is ok anyway. (Frank van
       Maarseveen)
     * USB: Misc locking problems: fix concurrent read/write and other
       SMP-like bugs in:
          + bluetooth.c
          + serial/keyspan.c
          + serial/whiteheat.c
     * USB: fix usb_unlink_urb() bug when called with an urb that was
       used on a device that is no longer registered in the USB system.
     * USB: control pipe locking (mutual exclusion)
     * USB: use pci_alloc_consistent throughout (mostly OHCI; some people
       want UHCI also)
     * RTL 8139 cards sometimes stop responding. Both drivers don't
       handle this quite good enough yet. (reported by Rogier Wolff,
       tentatively reported as fixed by David Ford; reports from Frank
       Jacobberger and Shane Shrybman indicate that it doesn't appear to
       be fixed in test9)
     * tty_register_devfs and tty_unregister_devfs declare struct
       tty_struct as a local, which causes stack overflows for user-mode
       linux. (Jeff Dike)

11. To Check

     * Check O_APPEND atomicity bug fixing is complete
     * Protection on i_size (sct) [Al Viro mostly done]
     * Mikulas claims we need to fix the getblk/mark_buffer_uptodate
       thing for 2.3.x as well
     * VFS?VM - mmap/write deadlock (demo code seems to show lock is
       there)
     * kiobuf seperate lock functions/bounce/page_address fixes
     * Fix routing by fwmark
     * rw semaphores on inodes to fix read/truncate races ? [Probably
       fixed]
     * Not all device drivers are safe now the write inode lock isnt
       taken on write
     * Multiwrite IDE breaks on a disk error [minor issue at best]
       (hopefully fixed)
     * ACPI/APM suspend issue - IDE related stuff ? (requires full
       taskfile support that was vetoed by Linus)
     * NFS bugs are fixed
     * Chase reports of SMB not working
     * Some AWE cards are not being found by ISAPnP ??
     * RAM disk contents vanishing on cramfs (block change) and bforget
       cases
     * Disappointing performance of Software Raid, esp. write performance
       (reported by Nils Rennebarth)
     * List of potential problems found by Stanford students using g++
       hacks:
          + Andy Chou's list of mismatched spinlocks and interrupts/bh
            enable/disable.
          + Seth Andrew Hallem's list potentially sleeping functions
            called with interrupts off or spinlocks held.
          + Dawson Engler's list of potential kmalloc/kfree bugs
     * Potential races in file locking code (Christian Ehrhardt)
          + locks_verify_area checks the wrong range if O_APPEND is set
            and the current file position is not at the end of the file.
          + dito if the file position changes between the call to
            locks_verify_area and the actual read/write (requires a
            shared file pointer, an attacker can use this to circumvent
            virtually any mandatory lock).
          + active writes should prevent anyone from getting mandatory
            locks for the area beeing written.
          + active reads should prevent anyone from getting mandatory
            write locks for the area beeing read.
     * Possible race in b-tree code for HFS, HPFS, NTFS: insert into the
       tree whild doing a readdir (Matthew Wilcox)
     * Stressing the VM (IOPS SPEC SFS) with HIGHMEM turned on can hang
       system (linux-2.4.0test5, Ying Chen, Rik van Riel)
     * Eepro100 driver can sometimes report out of resources on reboot
       (Josue Emmanuel Amaro)

12. Probably Post 2.4

     * per super block write_super needs an async flag
     * per file_op rw_kiovec
     * rw sempahores on page faults (mmap_sem) (Currently protected by
       mmap_sem)
     * module remove race bugs (ipchains modules -- Rusty; won't fix for
       2.4)
     * NCR5380 isnt smp safe (Frank Davis --- belives the driver should
       be rewritten)
     * VM: physical->virtual reverse mapping, so we can do much better
       page aging with less CPU usage spikes
     * VM: better IO clustering for swap (and filesystem) IO
     * VM: move all the global VM variables, lists, etc. into the pgdat
       struct for better NUMA scalability
     * VM: (maybe) some QoS things, as far as they are major improvements
       with minor intrusion
     * VM: thrashing control, maybe process suspension with some forced
       swapping ?
     * VM: include Ben LaHaise's code, which moves readahead to the VMA
       level, this way we can do streaming swap IO, complete with
       drop_behind()
     * USB: spread out interrupt frames for devices that use the same
       interrupt period (interval)
     * USB: add USB 2.0 EHCI HCD
     _________________________________________________________________

Fixed

     * Incredibly slow loopback tcp bug (believed fixed about 2.3.48)
     * COMX series WAN now merged
     * VM needs rebalancing or we have a bad leak
     * SHM works chroot
     * SHM back compatibility
     * Intel i960 problems with I2O
     * Symbol clashes and other mess from _three_ copies of zlib!
     * PCI buffer overruns
     * Shared memory changes change the API breaking applications (eg
       gimp)
     * Finish softnet driver port over and cleanups
     * via rhine oopses under load ? S
     * SCSI generic driver crashes controllers (need to pass
       PCI_DIR_UNKNOWN..)
     * UMSDOS fixups resync (not quite done)
     * Make NTFS sort of work
     * Any user can crash FAT fs code with ftruncate
     * AFFS fixups
     * Directory race fix for UFS
     * Security holes in execve()
     * Lan Media WAN update for 2.3
     * Get the Emu10K merged
     * Paride seems to need fixes for the block changes yet
     * Kernel corrupts fs and gs in some situations (Ulrich has demo
       code)
     * 1.07 AMI MegaRAID
     * Merge 2.2.15 changes (Alan) x
     * Get RAID 0.90 in (Ingo)
     * S/390 Merge
     * NFS DoS fix (security)
     * Fix Space.c duplicate string/write to constants
     * Elevator and block handling queue change errors are all sorted
     * Make sure all drivers return 1 from their __setup functions (Done
       ?)
     * Enhanced disk statistics
     * Complete vfsmount merge (Al Viro)
     * Merge removed-buf-open directory stuff into VFS (Al Viro)
     * Problems with ip autoconfig according to Zaitcev
     * NFS causes dup kmem_create on reload (Trond)
     * vmalloc(GFP_DMA) is needed for DMA drivers (Ingo)
     * TLB flush should use highest priority (Ingo)
     * SMP affinity code creates multiple dirs with the same name (Ingo)
     * Set SMP affinity mask to actual cpu online mask (needed for some
       boards) (Ingo)
     * heavy swapping corrupts ptes (believed so)
     * pci_set_master forces a 64 latency on low latency setting
       devices.Some boards require all cards have latency <= 32
     * msync fails on NFS (probably fixed anyway)
     * Find out what has ruined disk I/O throughput. (mostly)
     * PIII FXSAVE/FXRESTORE support
     * The netdev name changing stuff broke GRE
     * put_user is broken for i386 machines (security) - sem stuff may be
       wrong too
     * BusLogic crashes when you cat /proc/scsi/BusLogic/0 (Robert de
       Vries)
     * Finish sorting out VM balancing (Rik Van Riel, Juan Quintela et
       al)
     * Fix eth= command line
     * 8139 + bridging fails
     * RtSig limit handling bug
     * Signals leak kernel memory (security) [FIX in ac tree]
     * TTY and N_HDLC layer called poll_wait twice per fd and corrupt
       memory
     * ATM layer calls poll_wait twice per fd and corrupts memory
     * Random calls poll_wait twice per fd and corrupts memory
     * PCI sound calls poll_wait twice per fd and corrupts memory
     * sbus audio calls poll_wait twice per fd and corrupts memory
     * IBM MCA driver breaks on Device_Inquiry at boot
     * SHM code corrupts memory (Russell)
     * Linux sends a 1K buffer with SCSI inquiries. The ANSI-SCSI limit
       is 255.
     * Linux uses TEST_UNIT_READY to chck for device presence on a
       PUN/LUN. The INQUIRY is the only valid test allowed by the spec.
     * truncate_inode_pages does unsafe page cache operations
     * Fix the ptrace code to be back compatible and add a new PTRACE
       call set for getting the PIII extra registers
     * EPIC100 fixes
     * Tlan and Epic100 crash under load
     * Fix hpfs_unlink (Al Viro)
     * exec loader permissions
     * Locking on getcwd
     * E820 memory setup causes crashes/corruption on some laptops[**VERY
       NASTY**] (fixed in test5)
     * Debian report that the gcc 2.95 possibly miscompiles fault.c or
       mm/remap.c (Perl script available from Arjan) (fixed in test2 or
       3)
     * Dcache threading (Al Viro)
     * Sockfs races (removing NULL ->i_sb stuf) (Al Viro)
     * Module remove race bug (done: anything with file_operations, fb
       stuff, procfs stuff - Al Viro)
     * DEFXX driver appears broken (reported fixed by Jeff Garzik)
     * Some FB drivers check the A000 area and find it busy then bomb out
       (checked and fixed, reported by Jeff Garzik)
     * Stick lock_kernel() calls around OSS driver with issues to hard to
       fix nicely for 2.4 itself (Alan, fixed)
     * Merge the current Compaq RAID driver into 2.4 (fixed, reported by
       Thomas Hiller)
     * mount crashes on Alpha platforms (fixed, reported by Thorsten
       Kranzkowski)
     * IDE fails on some VIA boards (eg the i-opener) (reported fixed by
       Konrad Stepien)
     * access_process_mm oops/lockup if task->mm changes (Manfred) [user
       can cause deliberately]
     * PCMCIA IRQ routing should now be fixed modulo ISA cards and bios
       doesn't tell us that an IRQ is ISA-only (Martin Mares)
     * TB Multisound driver hasnt been updated for new isa I/O totally.
       (reported fixed by John Coiner; see
       http://atv.ne.mediaone.net/linux-multisound)
     * yenta (PCMCIA) and pci_socket modules have mutual dependency
       (cardbus_register, yenta_operations) (test5, worked in test3)
       (reported fixed by Erik Mouw)
     * Keyboard/mouse problems (should be fixed?)
     * Floppy driver broken by VFS changes. Other drivers may be too
       (Stuff gets called after _close now - unload race possibly too;
       should be fixed in test6)
     * OSS module remove races (fixed by Christoph Hellwig)
     * Merge the 2.2 ServeRAID driver into 2.4 (Christoph Hellwig)
     * AHA27xx is broken (maybe 28xx too) (reported fixed by Doug
       Ledford)
     * Merge the network fixes (DaveM)
     * Finish 64bit vfs merges (lockf64 and friends missing -- willy?)
       (Andreas Jaeger reports that lockf64 has been added for Intel and
       Alpha; other architectures may not be done, but if not, they won't
       build :-)
     * Can't compile CONFIG_IBMTR and CONFIG_PCMCIA_IBMTR in kernel at
       once; kernel link failes (rasmus; fixed in a kludgy way by not
       allowing the combination by arjan)
     * Merge the RIO driver
     * Potential deadlock in EMU10K driver when running SMP (orre at
       nada.kth.se, Alan)
     * Symbol clashes from ppp and irda compression code (Arjan van de
       Ven)
     * Kernel build has race conditions when building modversions.h
       (Mikael Pettersson)
     * USB Pegasus driver explodes on disconnect (lots of printk and/or
       OOPS spewage to the console. David Ford) (reported fixed by Petko
       Manolov)
     * unsafe sleep_on in ibmcam and ov511 drivers (never was a problem,
       according to Mark McClelland)
     * netfilter doesn't compile correctly (test7-pre3, reported by Pau
       Aliagas, fixed by test7-pre6, rusty)
     * Innd data corruption, probably caused by bug truncation bug (Rik
       van Riel)
     * If all the ISO NLS's are modules, there can be an undefined ref to
       CONFIG_NLS_DEFAULT in inode.c (Dale Amon --- not a bug CONFIG_NLS
       is forced)
     * Fix sysinfo interface so it is binary compatible with 2.2.x (i.e.
       mem_unit=1), except when memory >= 4Gb (Erik Andersen)
     * Some people report 2.3.x serial problems (reported fixed by Shaya
       Potter)
     * Some Ultra-I sbus sparc64 systems fail to boot since 2.4.0-test3,
       may be due to specific memory configurations. (reported fixed by
       davem)
     * Fix, um, interesting races around dup2() and friends. (Al Viro)
     * complete the ext2 races fixes (truncate) (Al Viro)
     * USB pegasus driver doesn't work since 2.4.0test5 (David Ford)
     * Splitting a posix lock causes an infinite loop (Stephen Rothwell,
       according to Rusty)
     * Oops in dquot_transfer (David Ford, Martin Diehl) (Jan Kara has a
       potential patch from 2.2, submitted to Linus by Martin Diehl,
       fixed in test9)
     * SHM segments not always being detached and destroyed right ?
       (problem reported by Lincoln Dale (was combination of XFree86 and
       kernel bug, fixed))
     * Mount of new fs over existing mointpoint should return an error
       unless forced (Andrew McNabb, Alan Cox) (Andries Brouwer has
       posted a patch)
     * Boot hangs on a range of Dell docking stations (Latitude, reported
       fixed in 2.4.0-pre9)
          + Almost certainly related: PCI code doesn't see devices behind
            DECchip 21150 PCI bridges (used in Dell Latitude). Reported
            by Simon Trimmer. (Patch from Martin Mares exists but it
            disables cardbus devices, according to Tigran.)
          + Derek Fawcus at Cisco reports similar problems with Toshiba
            Tecra 8000 attached to the DeskStation V+ docking station.
            (once again, caused by bridge returning 0 when reading the
            I/O base/limit and Memory base/limit registers which confuses
            the new PCI resource code).
     * drivers/sound/cs46xx.c has compile errors test7 and test8 (C
       Sanjayan Rosenmund, reported fixed by Hayden James)
     * Network block device seems broken by block device changes (Jeffrey
       C. Becker reports no problems)
     * cdrecord doesn't work (produces CD-ROM coasters) w/o any errors
       reported, works under 2.2 (Damon LoCascio, reported as fixed by
       Robert M. Love)
     * ACPI hangs on boot for some systems (Are there any cases left?
       Reported as fixed by Simon Richter)
     * arcnet/com20020-isa.c doesn't compile, as of 2.4.0-test8. Dan
       Aloni has a fix, reported fixed)
     * 2.4.0-test8 has a BUG at ll_rw_blk:711. (Johnny Accot, Steffen
       Luitz) (Al Viro has a patch, reported fixed by Udo A. Steinberg)
     * Writing to tapes > 2.4G causes tar to fail with EIO (using
       2.4.0-test7-pre5; it works under 2.4.0-test1-ac18 --- Tigran
       Aivazian, reported fixed)
     * 2.4.0-test2 breaks the behaviour of the ether=0,0,eth1 boot
       parameter (dwguest, reported as fixed.)
     * IBM Thinkpad 390 won't boot since 2.3.11 (Decklin Foster; NOT A
       BUG; caused by misconfigured CPU model)
     * PPC-specific: won't boot on 601 CPU's (powermac) (Andreas Tobler;
       Paul Mackerras has fix in PPC tree)
     * Finish I2O merge (Intel/Alan, reported as fixed as it's going to
       be)
     * Non-atomic page-map operations can cause loss of dirty bit on
       pages (sct, alan, Ben LaHaise fixed)
     * NFS V3 lockd causes kernel oops (Trond Myklebust, reported fixed)
     * VM: Out of Memory handling {CRITICAL} (added in test10)
     * TLAN nic appears to be adding a timer twice (2.4.0test8pre6, Arjan
       ve de Ven) (Fixed, but patch not sent to Linus yet -- Torben
       Mathiasen)
     * Loading the qlogicfc driver in 2.4.0-test8 causes the kernel to
       loop forver reporting SCSI disks that aren't present (Paul
       Hubbard, Torben Mathiasen has a potential patch, sent to Linus,
       need to very with Paul)
     * Fix the minixfs races (Al Viro)
     * SIT tunneling (ipv6 in ipv4) is broken (Gerhard Mack; Davem has a
       fix) (fixed in test10-pre2)
     * USB: hid joystick handling (patch from Vajtech, 2.4.0.9.4)
     * USB: cpia_usb module doesn't handle "no bandwidth" returns (OOPS)
       (2.4.0.9.4)
     * USB: microtek memory handling (patch from Oliver Neukum)
       (2.4.0.9.4)
     * USB: usb-uhci not use set PCI Latency Timer register to 0
     * USB: printer driver aborts on out-of-paper or off-line conditions
       instead of retrying until the condition is fixed
     * USB: usb-uhci SMP spinlock/bad pointer crash
     * USB: cpia camera driver with OHCI HCD locks up or fails
     * USB: pegasus (ethernet) driver crashes often
     * USB: Fix differences in UHCI and OHCI HCD behaviors/semantics:
          + Only uhci.c does EARLY_COMPLETE (drop EARLY_COMPLETE ?)
          + USB: Fix the OOPS in usb-storage from the error-recovery
            handler. {CRITICAL} (reported by Matthew Dharm, fixed as of
            test9)
          + USB: booting with USB compiled into kernel causes a lot of
            syslog entries as the root hubs are probed by all drivers
            (this is especially obnoxious as the usb-serial drivers start
            up) (Fixed in test9, according to Greg KH)
          + USB: fix setting urb->dev in plusb, wacom, mdc800) (Greg KH)
            {CRITICAL} (fixed in test10-pre1)
          + USB: fix usb-uhci setting urb->dev = NULL at correct places
            only {CRITICAL} (fixed in test10-pre1)
          + USB: pegasus driver version 0.4.12: update to work with HCD
            changes; fix module use counting & dev refcounting; fix to
            work with dhcpd (Petko) {CRITICAL} (fixed in test10-pre1)
          + USB: pegasus driver locks up on slow oHCI machine; sometimes
            cannot be rmmod-ed (Cyrille Chepelov) (was uhci problem
            fixedin test10-pre1 according to Petko Manolov)
          + USB: oops on boot with 2.4.0-test9, usb-uhci, pegasus (in
            process_transfer) (frank@unternet.org) (was uhci problem
            fixedin test10-pre1 according to Petko Manolov)
          + Sys_revoke() (CRITICAL, revoke or some subset of it is needed
            to fix some security issues) (alan, linus, worked around for
            now)
          + USB: hotplug (PNP) and module autoloader support (currently
            being tested)
          + USB: OHCI root-hub-timer does not restart on resume
            {CRITICAL} (Paul Mackerras)
          + USB: add bandwidth allocation support to usb-uhci HCD
          + USB: usb-ohci needs to null urb->dev to avoid various
            reboots/hangs/oopses {CRITICAL} (David Brownell)
          + USB: speed up device enumeration (hub driver has large delays
            in it)
          + USB: OOPS when unplugging mouse from external hub (Unable to
            handle kernel paging request at virtual address 00080004; in
            usb_disconnect) (2.4.0-test9-pre7)
          + USB: With uhci HCD, switching from X to a text console and
            back to X, USB mouse is dead. (2.4.0-test9-pre7)
          + USB: plusb oops, segfaults, performance.
          + USB: usb-uhci, microtek scanner driver on 2.4.0-test7 & SANE
            1.0.3 OOPSes; usb-ohci works.
            >[usb-uhci]uhci_cleanup_unlink+4c/140<
          + USB: 2.4.0-test9-pre9: Novatek Ortek USB kbd not working.
          + USB: 2.4.0-test9-pre9: unresolved USB symbols when only
            usbcore is in-kernel.
          + USB: 2.4.0-test10: unresolved symbol 'this_module' when
            compiling only usbcore in kernel (in inode.c).
          + USB: 2.4.0-test9: USB + SMP gives lots of USB device timeout
            errors. OK without SMP. Tyan tiger 133 (1854d, i believe)
            mobo (via apollo pro 133a chipset). Redhat 6.2 and 7.0
            (thought it might be gcc 2.96, but it seems to happen with
            both). Either UHCI HCD. Or Asus p2b-ds mobo with the intel bx
            chipset with same results.
          + USB: test9, test10-pre1, and 2.2.18-pre15: OOPS with USB
            mouse. >>EIP; c0121491 >kmem_cache_free+14d/174< >=====
            Trace; d00387a6 >[usb-uhci]uhci_unlink_urb_sync+122/150<
          + USB: many unexplained "usb_control/bulk_msg: timeout"
            messages on several different USB devices.
          + USB: 3Com USB ISDN TA not working with test9-pre3 or
            test10-pre4. Worked with test8.

Probably Hardware Bugs

     * Data corruption on IDE disks (Generic PCI DMA and SiS support
       Steven Walter) (sounds like PCChips #M599LMR motherboard doesn't
       disable UDMA when a non-UDMA cable is used. If you disable UDMA in
       the BIOS, then there is no problem. hardware bug?)
     * AHA29xx driver appears to stomp other cards (may be BIOS; probably
       motherboard has assigned to small of a range to a card, so that
       it's overlapping with some other card -- Doug Ledford)
     * USB hangs on APM suspend on some machines (fixed more most; Alan
       has one still that fails but the BIOS has 'issues')
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

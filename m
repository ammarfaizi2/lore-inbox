Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTJYTJb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 15:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTJYTJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 15:09:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:35547 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262758AbTJYTJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 15:09:23 -0400
Date: Sat, 25 Oct 2003 12:09:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.0-test9
Message-ID: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, 2.6.0-test9 is out there in all the normal places..

First off, I have to say that this week has been a lot better than last
week. I've been cursing at some developers a _lot_ less: while a lot of
people wanted to sync up with me after the -test7 "stability freeze"  
announcements with stuff that wasn't really about stability, that dropped
off a lot this week, and I didn't have to be rude to people very much at
all.

There's some XFS and cifs updates here, but even they were pretty benign
and largely just bugfixes. Oh, and the SATA driver got included, which you
either disable or which allows people to use modern hardware. 

Anyway, while I've been happy with the progress from -test7, I want to see
this total stability freeze work even better. The test9 patch is about 
120kB compressed - which is small for a week of work, but is still more 
than I want to see before a stable release.

So guys, let's work on this even more for test10. I'm going to _totally_
ignore patches that aren't for major bugs. Don't send me anything that
_others_ wouldn't consider horribly critical.

In other words, even if you think that something is the most important
piece of software in the world, if you can't make aunt Tilly up the street
say "oh, but that would be a show-stopper", then don't bother sending it 
to me.

If it corrupts data, is a security issue, or causes lockups or just basic
nonworkingness: and this happens on hardware that _normal_ people are
expected to have, then it's critical.  Otherwise, it's noise and should
wait.

If this works out, then I'll submit -test10 to Andrew Morton, and if he 
takes it we'll probably have a real 2.6.0 after a final shakedown. So try 
to help, please. We'll all be happier.

			Linus

----
Summary of changes from v2.6.0-test8 to v2.6.0-test9
============================================

Alan Stern:
  o USB: fix for earlier unusual_devs.h patch

Alex Williamson:
  o ia64: trivial ia64 numa/discontig fixes

Alexander Schulz:
  o [ARM PATCH] 1692/1: Shark: PCIMEM_BASE

Alexander Viro:
  o Fix initrd with devfs enabled
  o fix for do_tty_hangup() access of kfreed memory

Alexey Kuznetsov:
  o TCP: do not return -EINTR, when data are available for read()

Andrew Morton:
  o [NET]: Make register_netdevice return correct error when driver
    init function fails
  o fix split_vma vs. invalidate_mmap_range_list race
  o scsi: handle zero-length requests
  o ia32 limit_regions update
  o Fix unmap_vmas() compile warning
  o Time precision, adjtime(x) vs. gettimeofday
  o atp870u oops fix
  o tmpfs 1/7 LTP ENAMETOOLONG fix
  o tmpfs 2/7 LTP S_ISGID on directories fix
  o tmpfs 3/7 swapoff/truncate race fix
  o tmpfs 4/7 getpage/truncate race fix
  o tmpfs 5/7 writepage/truncate race fix
  o tmpfs 6/7 write i_size_write
  o tmpfs 7/7 write mark_page_accessed
  o Quota deadlock fix
  o export system_running to other files
  o Kill early might_sleep warnings
  o digi_acceleport.c has bogus "address of" operator
  o fix microcode.c for older gcc's
  o Fix mtd printk warnings
  o fs/binfmt_elf.c:load_elf_binary() doesn't verify interpreter arch
  o JBD kfree() fix
  o Fix JBD memory leak
  o fix low-memory BUG in slab
  o fix for register_cpu()
  o fix bluetooth broken compilation when PROC_FS=n
  o make printk more robust with "null" pointers
  o kcapi.c CONFIG_MODULES=n build fix
  o DRM modprobe retval fix
  o parport_pc not releasing all ioports
  o Fix oops with CONFIG_MCA=y
  o Fix another CONFIG_MCA=y oops
  o ipc msg race fix
  o io scheduler oops fixes
  o pcm_native locking fix
  o Fix toshiba.c and neofb.c for CONFIG_PROC_FS=n
  o v850: Workaround for tty-driver init-order problem
  o v850: Don't reserve root-filesystem memory twice
  o v850: Use irqreturn_t on rte-me2-cb platform
  o Add needed __devexit_p's to two gameport drivers
  o /dev/mem range checking
  o Kill unneccessary debug printk
  o Fix arlan compilation with CONFIG_PROC_FS=n
  o Altix console driver
  o befs oops fix
  o early_serial_setup array bounds check

Arnaldo Carvalho de Melo:
  o leaking info on drivers/usb

Arun Sharma:
  o ia64: make strace of ia32 processes work again
  o ia64: don't touch IA-32 segment descriptors too early
  o ia64: fix broken __emul_prefix

Bart De Schuymer:
  o [EBTABLES]: Adjust skb->pkt_type when necessary

Bartlomiej Zolnierkiewicz:
  o fix drivers/ide/pci/siimage.c for PROC_FS=n
  o fix drivers/ide/pci/cmd640.c for CONFIG_PCI=n

Bjorn Helgaas:
  o ia64: fix EFI memory map trimming
  o ia64: prevent "dd if=/dev/mem" crash

Carsten Busse:
  o USB: one more digicam for unusual_devs.h

Dan Aloni:
  o [NET]: Fix sysctl breakage during network device renaming

Dave Jiang:
  o [ARM PATCH] 1691/1: Fix IOP321 platform booting in 2.6

David Brownell:
  o USB: ACM USB modem fixes
  o USB: fix usb-storage self-deadlock
  o USB: usb enumeration clears full speed ep0 state

David Mosberger:
  o ia64: Add missing exports to modules build again
  o ia64: Fix printk format error
  o ia64: Don't mix code and declarations (not C90-compliant)
  o ia64: Sync with i386 irq.c (deadlock avoidance for certain
    disable_irq()/ enable_irq() sequences).
  o ia64: Based on patch by Arun Sharma: fix IA-32 subsystem to support
    NPTL
  o ia64: Fix IA-32 NPTL fixes so things compile again
  o ia64: Fix efi_mem_type() and efi_mem_attributes() to avoid
    potential underflows.  In my case, the underflows occurred with the
    first memory descriptor which got trimmed down to a size of 0.
  o ia64: Patch by Arun Sharma: fix allocation/handling of GDT shared
    page (the old code was inconsistent and in places still assumed
    there is both a GDT and a TSS shared page, but the latter was
    removed a long time ago).
  o ia64: Sync with Linus' i386 patch: Revert bogus IRQ_INPROGRESS
    clear
  o ia64: Fix/finish kernel module table support so it actually works

David S. Miller:
  o [NET]: Undo deprecation of init_etherdev, we will add it back once
    all in-tree drivers are fixed
  o [LLC]: Make LLC2 compile with PROC_FS=n
  o [NET]: sysctl_net_core.c needs linux/module.h
  o [IPV6]: Set fl->proto in _decode_sesseion6
  o [TG3]: Disable/enable timer in suspend/resume
  o [NET COMPAT]: Fix hangs caused by bugs in do_netfilter_replace()
  o [SPARC]: Fix do_gettimeofday() as per cset 1.1347.1.17
  o [SPARC64]: Get hugetlb support back into working shape

David T. Hollis:
  o USB: ax8817x fixes in usbnet.c

Douglas Gilbert:
  o SCSI constants.c

Gerd Knorr:
  o Fix bttv BUG() at video-buf.c:378

Glen Overby:
  o [XFS] Fix problem with the debug code in xlog_state_do_callback
  o [XFS] remove xfs_dir2_node_addname_int remnants of an old block
    placement algorithm

Greg Kroah-Hartman:
  o USB: gadget fixes for 64bit processor warnings

Herbert Xu:
  o [NET]: More build fixes for CONFIG_XFRM disabled

Ian Abbott:
  o USB: ftdi_sio - Perle UltraPort new ids

Ian Wienand:
  o ia64: fix gate-data.S build for binutils 2.14

James Cleverdon:
  o Allow more APIC irq sources

Jeff Garzik:
  o [libata] Merge Serial ATA core, and drivers for
  o [libata] Integrate Serial ATA driver into kernel tree

Jesse Barnes:
  o ia64: fix topology init
  o ia64: zero out topology related sysfs nodes

Knut Petersen:
  o input / keyboard / Scancode Set 3 support broken
  o setkeycode ioctl fix

Len Brown:
  o [ACPI] speed up reads from /proc/acpi/ (Shaohua David Li)
    http://bugme.osdl.org/show_bug.cgi?id=726
  o [ACPI] fix object reference count bug for battery status (Shaohua
    David Li) http://bugme.osdl.org/show_bug.cgi?id=1038
  o [ACPI] acpi_ec_gpe_query(ec) fix for T40 crash (Shaohua David Li)
    http://bugme.osdl.org/show_bug.cgi?id=1171
  o [ACPI] fix acpi_ev_gpe_dispatch() parameter (Bob Moore)
  o [ACPI] fix !CONFIG_PCI build use X86 ACPI specific version of
    eisa_set_level_irq()
    http://bugzilla.kernel.org/show_bug.cgi?id=1390
  o [ACPI] Broken fan detection prevents booting (Shaohua David Li)
    http://bugme.osdl.org/show_bug.cgi?id=1185

Linus Torvalds:
  o bcopy() doesn't return anything
  o Make the pc9800, visws and voyager sub-architectures tell us their
    NR_IRQ_VECTORS.
  o Revert bogus IRQ_INPROGRESS clear
  o Make yenta allocate IO resource windows in same range as in 2.4.x
  o Add a quirk for the Intel ICH-[45] to add special ACPI regions

Mark Haverkamp:
  o Work around aacraid FW problem

Michael Hunold:
  o Fix bugs in various DVB drivers
  o Fix bug in saa7146 analog tv i2c-handling
  o Fix bugs in analog tv i2c-helper chipset drivers

Mike Anderson:
  o Add release function to sd for scsi_disk structure

Mike Christie:
  o fix oops caused when writing to the rescan attribute

Nathan Scott:
  o [XFS] Fix inode btree lookup code precision problem with large
    allocation groups
  o [XFS] final round of code cleanup, now using 3-clause-bsd in these
    headers
  o [XFS] Use an xfs_ino_t to hold the result of inode extraction from
    a handle, not a possibly 32-bit number

Neil Brown:
  o md -  Use sector rather than block numbers when splitting raid0
    requests
  o kNFSd -  In READDIRPLUS reply, don't return a file handle for a
    mounted directory

Pat LaVarre:
  o SG_SET_RESERVED_SIZE negative oops

Patrick Mansfield:
  o SCSI: limit mode sense usage

Russell King:
  o [NET]: Prevent 'eth0: driver changed get_stats after register' from
    lying
  o [ARM] Correct acornfb arguments for fb_set_var()

Stephen Lord:
  o [XFS] Change XFS maintainer

Steve French:
  o check return code on failed kmalloc.  list management bugs.  fix
    xid going negative
  o Fix spinlock usage for SMP safety
  o Fix various SMP/locking problems pointed out by Shoobhit Dayal and
    Arjan van de Ven
  o Remove illegal kunmap
  o Missing spin_unlock in error path and extraneous kunmap in
    cifs_writepages
  o missing cifs mount options
  o add missing mount option iocharset to cifs vfs
  o list processing fixes in cifs reopen_files
  o Fix case where server hung but tcpip session still good.  Fix
    double request of same spinlock
  o don't kill demultiplex thread on ERESTARTSYS
  o missing check for eagain on sock ops
  o fix loop on mount failure of session setup
  o fixes to not prematurely exit demultiplex captive thread

Stéphane Eranian:
  o ia64: two perfmon fixes
  o ia64: fix critical perfmon2 bugs

Zwane Mwaikambo:
  o [IPV6]: Fix sit.c compilation w/o CONFIG_XFRM



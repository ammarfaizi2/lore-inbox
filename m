Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263576AbSIRDYJ>; Tue, 17 Sep 2002 23:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264157AbSIRDYI>; Tue, 17 Sep 2002 23:24:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1805 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263576AbSIRDYH>; Tue, 17 Sep 2002 23:24:07 -0400
Date: Tue, 17 Sep 2002 20:32:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.36
Message-ID: <Pine.LNX.4.33.0209172029400.2648-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Big patch, most of it due to the XFS merge. 

The rest is pretty normal - more syncs with Andrew, some console code
reorg by James, NTFS fixes for highmem, and IDE, USB and firewire updates.

		Linus

---
Summary of changes from v2.5.35 to v2.5.36
============================================

Andrew Morton <akpm@digeo.com>:
  o low-latency zap_page_range
  o resurrect /proc/meminfo:Buffers
  o hugetlb pages
  o fix reverse map accounting leak
  o add /proc/meminfo:Mapped
  o ext3 ceanup: use EXT3_SB
  o hold the page ref across ->readpage
  o fix a bogus OOM condition for __GFP_NOFS allocations
  o clean up the TLB takedown code, remove debug
  o add dump_stack(): cross-arch backtrace
  o various small cleanups

<cattelan@sgi.com>:
  o XFS: "AutoVersion"

Christoph Hellwig <hch@sgi.com>:
  o XFS: update pagebuf comments
  o XFS: Return -ENOMEM on vmap failure in _pagebuf_lookup_pages
  o Import XFS CVS from 10092002

Peter Anvin <hpa@zytor.com>:
  o CPU detection fixes

James Simmons <jsimmons@maxwell.earthlink.net>:
  o These files missed the handle_sysrq change
  o Removed selection.h header. It is not needed and in the future
    selections will be a pure userland solution. Use set_current_state
    instead in tty_ioctl.c
  o Renames console.c and vt.c. The idea is to break these massive
    files into smaller ones. The main goal is to move all the high end
    tterminal emulation into one file. This way we can have a light
    weight printk without the extra weight. nice for embedded systems

Mark Lord <lord@sgi.com>:
  o XFS: remove dead code paths from create/mkdir/link/symlink
  o merge xfs up to 2.5.35

<mark@alpha.dyndns.org>:
  o ov511 1.62 for 2.5.34

<pdelaney@lsil.com>:
  o Fusion-MPT driver update

<stern@rowland.harvard.edu>:
  o USB storage:  Merging raw_bulk.c with transport.c

Anton Altaparmakov <aia21@cantab.net>:
  o NTFS: Pages are no longer kmapped around calls to

Ben Collins <bcollins@debian.org>:
  o IEEE-1394 updates

David Gibson <david@gibson.dropbear.id.au>:
  o Remove CONFIG_SMP around wait_task_inactive()

David S. Miller <davem@redhat.com>:
  o sparc64 2.5.x file corruptions found

David Woodhouse <dwmw2@infradead.org>:
  o Add three functions for rbtree manipulation -- rb_next(), rb_prev()
    and rb_replace_node()
  o Remove bogus rb_root_t and rb_node_t typedefs in favour of 'struct
    rb_node' and 'struct rb_root' Remove duplicate implementation of
    rb_next() in net/sched/sch_htb.c while we're at it.

Eric Sandeen <sandeen@sgi.com>:
  o XFS: teach icmn_err about CE_WARN
  o XFS: change symlink perms to 777
  o XFS: add error checks to linvfs_direct_IO

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: change the contact email address for the omninet driver
  o Driver Model: add dev_get_drvdata() and dev_set_drvdata() functions
  o Driver Model: fix oops when device is removed from system
  o USB: Convert the core code to use struct device_driver
  o USB: convert usb-serial drivers to new driver model
  o USB: convert the drivers/usb/class files to the new USB driver
    model
  o USB: convert the drivers/usb/image files to the new USB driver
    model
  o USB: convert the drivers/usb/input files to the new USB driver
    model
  o USB: convert the drivers/usb/media files to the new USB driver
    model
  o USB: convert the drivers/usb/misc files to the new USB driver model
  o USB: convert the drivers/usb/net files to the new USB driver model
  o USB: convert the drivers/usb/storage files to the new USB driver
    model
  o USB: convert the USB drivers that live outside of drivers/usb to
    the new USB driver model

Ingo Molnar <mingo@elte.hu>:
  o thread-exec-fix-2.5.35-A5, BK-curr

Jens Axboe <axboe@suse.de>:
  o Cleanup Config.in, and remove unused options
  o Make sure ide init happens in the right order
  o Missing exports
  o Move pio setup and blacklists to ide-lib
  o Missing module_init()
  o New IDE pci low level driver setup scheme
  o Update promise drivers to new ide pci init scheme, remove now
    unused
  o Mistakenly enabled ide-tape, disable it again (update of it is
    broken)
  o piix_pci_info() needs to be __initdata, not __devinit
  o ide.h needs to include pci.h
  o limit size of bio_vec pools
  o fix elevator_linus accounting
  o ide irq problem
  o hpt366 pci_tbl booboo
  o remove pdc202xx.h

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: vmlinux.lds.s needs dependency on scripts/fixdep
  o kbuild: Preprocess vmlinux.lds.S on all archs
  o kbuild: Convert arm vmlinux.lds generation
  o kbuild: Fix up CRIS vmlinux.lds.S
  o kbuild: Fix up MIPS vmlinux.lds.S
  o kbuild: Handle vmlinux linkscript from common code

Linus Torvalds <torvalds@transmeta.com>:
  o Make "in_atomic()" work right with preempt enabled
  o Remove IDE "panic on controller remove" code, since it does
    nothing, but makes it impossible to shut down cleanly.

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o USB storage: remove tests against EINPROGRESS
  o USB storage: macro-ize address manipulation
  o USB storage: minor compilation fixes
  o USB storage: add error checks, remove useless code

Nathan Scott <nathans@sgi.com>:
  o XFS: code cleanup


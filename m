Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbTILTq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbTILTq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:46:27 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:25103 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261232AbTILTqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:46:21 -0400
Date: Fri, 12 Sep 2003 16:48:50 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-pre4
Message-ID: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, 

Here goes -pre4, which contains networking update, IA64 update, PPC
update, USB update, bunch of knfsd fixes, amongst others.

And finally merge most important part of -aa VM. Those changes are fixing
some OOM deadlocks, give us better per-zone balancing and better
reclaiming. The OOM killer has been removed.

I've been using it on my 256MB desktop: performance feels much better, but 
it needs extensive testing, so please help.


Summary of changes from v2.4.23-pre3 to v2.4.23-pre4
============================================

<adsharma:unix-os.sc.intel.com>:
  o ia64: IA-32 compatibility patch: FP denormal handling

<alex.williamson:hp.com>:
  o ia64: Correct NR_CPUS/cpu_online test order in CMC/CPE polling

<bjorn.helgaas:hp.com>:
  o ia64: Remove partial semtimedop32 stuff from upstream
  o ia64: Merge to newer ACPI CA
  o ia64: sys_ia32.c needs linux/quotacompat.h
  o ia64: tlb.c whitespace cleanup to follow 2.5
  o ia64: make cpu_relax() a barrier to be consistent with 2.5
  o ia64: kernel/acpi.c: Whitespace changes to follow 2.5
  o ia64: MCA: pass GP *physical address* to SAL
  o ia64: minor bugfixes and whitespace cleanup to follow 2.5
  o ia64: MCA: Find correct offset of OEM data (from Keith Owens)
  o ia64: sal.h: Backport spelling and other trivial changes from 2.5
  o ia64: Comment changes to fix "correctable" usage
  o ia64: Fix check for binutils that supports "hint" instructions
  o ia64: Update configs for upstream changes
  o ia64: Use ARRAY_SIZE(), fix formatting, remove static initializers to zero
  o ia64 unwind: (unw_access_ar): initialize struct pt_regs *pt before using it to get AR_CSD & AR_SSD
  o ia64: Update defconfig to new generic config
  o ia64: initialize bootmem early for acpi_table_init()
  o ia64: Use $(CC), not $(AS), when checking for "hint @pause" support in binutils
  o ia64: Clarify ACPI available_cpus handling
  o ia64: TRIVIAL: Remove extraneous '`'
  o ia64: minstate.h: whitespace changes to reduce diffs with 2.5
  o ia64: Fix minstate comments
  o ia64: fix SAVE_RESET so OS INIT handler works again
  o ia64: Remove AIC7XXX driver from ski defconfig
  o 2.4 HCDP early printk support

<chas:nrl.navy.mil>:
  o [ATM]: In atm_getaddr() do not copy_to_user() with locks held

<daniel:deadlock.et.tudelft.nl>:
  o Implement LCD display support in atyfb driver

<eric:lammerts.org>:
  o fix current->user->processes leak in reparent_to_init()

<erikj:subway.americas.sgi.com>:
  o ia64: 9/3/2003 SGI update

<erlend-a:us.his.no>:
  o [CRYPTO]: Add alg. type to /proc/crypto output

<joris:struyve.be>:
  o unusual_devs.h entry

<karlis:mt.lv>:
  o [BRIDGE]: kfree --> kfree_skb

<marcelo:logos.cnet>:
  o Mehmet Ceyran/Alan Cox: Longer i810_audio.c retries
  o aa VM merge: Per-zone watermark changes, add lower_zone_reserve_ratio
  o aa VM merge: page reclaiming logic changes: Kills oom killer
  o aa VM merge: Page accounting helpers changes
  o aa VM merge: tunables
  o aa VM merge: Kill PF_MEMDIE
  o aa VM merge: Fixup page reclaiming changes patch
  o Changed EXTRAVERSION to -pre4
  o Cset exclude: root@macp.eti.br|ChangeSet|20030912113656|10550

<matthewc:cse.unsw.edu.au>:
  o smpboot.c, acpi.c

Alan Cox:
  o Fix ymfpci oops

Alex Williamson:
  o ia64: Use PAL_HALT_LIGHT in cpu_idle
  o ia64: New CMC/CPE polling
  o ia64: Update to CMC/CPE polling
  o ia64: Rename SAL_CALL_SAFE to SAL_CALL_REENTRANT

Arjan van de Ven:
  o LSB compliance fix in mprotect

Arun Sharma:
  o ia64: translate F_GETLK64/F_SETLK64 to F_GETLK/F_SETLK
  o ia64: fix memory leak in sys32_execve path

Chas Williams:
  o [ATM]: If clip isn't a module don't __MOD_DEC_USE_COUNT()
  o [ATM]: #define'ing pci_pool_create() breaks CONFIG_MODVERSION
  o [ATM]: Backport lane/mpoa module locking cleanup from 2.6.x

David Mosberger:
  o ia64: handle_fpu_swa() scaling fix
  o ia64: Backtraces of all processes on INIT, warning cleanup

Greg Kroah-Hartman:
  o USB: fix data toggle problem for pl2303 driver
  o USB: update usb-serial.h with spelling fixes and get and set functions
  o USB: backport some pl2303 B0 fixes
  o USB: fix oops when yanking a usb-serial device from the system with the port still opened
  o USB: fix copy_from_user call in acm.c
  o USB: fix copy_from_user call in aiptek.c
  o USB: fix copy_to_user call in uhci-debug.h
  o USB: fix copy_to_user call in mdc800 driver
  o USB: remove duplicated copy_from_user call in stv680 driver
  o USB: fix copy_to_user calls in vicam driver

Harald Welte:
  o [NETFILTER]: NAT range calculation fix

Jack Steiner:
  o ia64: discontig/NUMA support
  o ia64: Add ia64_imva() and a few more ia64_tpa() uses
  o ia64: add support for non-identity mapped kernels
  o ia64: remove some SN1 remnants, add a bit more SN2 support

Jean Tourrilhes:
  o wireless extension update: 802.11a/802.11g fixes

Jens Axboe:
  o Add NEC iStorage to SCSI blacklist

Keith M. Wesolowski:
  o [SPARC32]: Ignore btfixups in .text.exit

Keith Owens:
  o ia64: Clean up several warnings (no functional change)
  o ia64: Correct typo in UNW_DPRINT() call
  o ia64: Fix more UNW_DPRINT() typos
  o ia64: Delete some generated ia64 files that were being left by make mrproper

Marc-Christian Petersen:
  o Fixup 'make xconfig' problem caused by fetchop Config.in change

Martin Hicks:
  o ia64: max user stack size of main thread configurable via RLIMIT_STACK

Matthew Wilcox:
  o ia64: return PCI domain for pci_controller_num()

Neil Brown:
  o knfsd: Lock client list while detaching locks
  o knfsd: Set d_op when creating a parent directory during nfsd fh->dentry conversion
  o knfsd: lockd fails to purge blocked NLM_LOCKs
  o Fix typo in umem.c
  o knfsd: Make sure nfs/tcp socket only gets closed
  o knfsd: Change name of a #define in nfsd to match 2.6
  o knfsd: Make sure nfsd replies from the address the request was sent to

Oleg Drokin:
  o [2.4] Rocketport driver compile fix

Paul Fulghum:
  o synclink update
  o synclinkmp update
  o synclink_cs update
  o n_hdlc update
  o synclink drivers fixup

Paul Mackerras:
  o PPC32: Handle single-stepped emulated instructions correctly
  o PPC32: Fix for highmem on machines with 64-bit PTEs (e.g. PPC440)
  o PPC32: Simplify VMALLOC_START, make it just a variable
  o PPC32: Fix a typo in the PPC 440GP support
  o PPC32: Fix a bug where TLB entries didn't get execute permission on 40x

Ralf Bächle:
  o avoid glibc conflict

Seth Rohit:
  o ia64: use "hint @pause" in cpu_relax() and spinlock contention
  o ia64: patch to use >256MB purges
  o ia64: Restructure pt_regs and optimize syscall path
  o ia64: Correct .unwabi for PT_REGS_SAVES (should be "3, 'i'")

Stephen Hemminger:
  o [BRIDGE]: Clear hw checksum flags when bridging

Stéphane Eranian:
  o ia64: Fix perfmon usage of rum/srsm and sum/ssm

Tom Rini:
  o PPC32: Add Magic SysRq support to MPC8260 platforms
  o PPC32: Minor bootwrapper fixups

Tony Luck:
  o ia64: cleaning up the INIT code (Backported from 2.5 by Bjorn Helgaas)
  o ia64: Trim granules correctly in efi_memmap_walk()








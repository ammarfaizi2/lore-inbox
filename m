Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUEVIh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUEVIh7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUEVIh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:37:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:61058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264917AbUEVIhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:37:07 -0400
Date: Sat, 22 May 2004 01:36:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-mm5
Message-Id: <20040522013636.61efef73.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm5/
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm5/



- Some rearchitecting of the VFS's symlink walking code.  Reduces stack
  usage and apparently permits us to increase the maximum hop count from 5 to
  8, although the patch doesn't actually do that.


- Implementation of request barriers for IDE and SCSI.  The idea here is
  that a filesystem can tag an IO request as a barrier and the disk will not
  reorder writes across the barrier.  It provides additional integrity
  guarantees for the journalling filesystems.  The feature is enabled for
  reiserfs and ext3.

  On reiserfs do `mount /dev/hda /wherever -o barrier=flush' or
  `barrier=none'.

  On ext3 do `mount ... -o barrier=1' or `barrier=0'.

  ext3 also supports `mount -o remount,barrier=N'.  I didn't check whether
  reiserfs supports switching at remount time and nobody tells me these
  things.

  (Yes, we should give these mount options the same name).

  Although this feature has been around for a while it is new code, and the
  usual cautions apply.  If it munches all your files please tell Jens and
  he'll type them in again for you.

- The pagecache radix-tree spinlocks have gone back to rwlocks again.  It
  helps big SMP significantly and doesn't seem to make much difference to
  small SMP (1-2% at most IIRC).  It does need some more measuring.

- Added a new SATA RAID driver from 3ware.  From a quick peek it seem to
  need a little work yet.




 linus.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-i2c.patch
 bk-input.patch
 bk-libata.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-pcmcia.patch
 bk-scsi.patch

 Latest versions of various development trees

-system-state-splitup.patch
-idedisk_reboot.patch
-fealnx-bogon-fix.patch
-blk_run_page-race-fix.patch
-put-module-license-in-swim3c.patch
-ppc32-get-full-register-set-on-bad-kernel-accesses.patch
-stack-reductions-nfsread.patch
-use-less-stack-in-ide_unregister.patch
-mark-config_mac_serial-drivers-macintosh-macserialc-as-broken.patch
-dpt_i2o-warning-fixes.patch
-invalid-notify_changesymlink-in-nfsd.patch
-nfs_writepage_sync-stack-reduction.patch
-nfs4-stack-reduction.patch
-raid-locking-fix.patch
-seeky-readahead-speedups.patch
-add-disable-param-to-capabilities-module.patch
-remove-hardcoded-offsets-from-i386-asm.patch
-madvise-len-check.patch
-dentry-size-tuning.patch
-vm-shrink-zone.patch
-vm-shrink-zone-fix.patch
-enable-runtime-cache-line-size-for-slab-on-i386.patch
-allow-arch-override-for-kmem_bufctl_t.patch
-add-kmem_cache_alloc_node.patch
-work-around-gcc-333-hammer-sched-miscompilation-on-x86-64.patch
-befs-maintainer-update.patch
-nfs-long-symlinks-fix.patch
-fix-for-266-makefiles-to-get-kbuild_output-working.patch
-kexec-reserve-syscall-slot.patch
-fore200e-warning-fixes.patch
-qlogicfas408-warning-fix.patch
-blk_run_queues-remnants.patch
-use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec.patch
-use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api.patch
-replace-mod_inc_use_count-in-cyber2000fb.patch
-dont-mention-mod_inc_use_count-mod_dec_use_count-in-docs.patch
-mark-plan-video-driver-broken.patch
-kbuild-subdirs=more-than-one.patch
-correct-ps2esdi-module-parm-name.patch
-fix-error-handling-in-selinuxfs.patch
-quota-fix-3-quota-file-corruption.patch
-submittingdrivers-completeness.patch
-edd-remove-unused-scsi-header-files.patch
-efivars-add-module_version-remove-unnecessary-check-in-exit.patch
-do_generic_mapping_read-cleanup.patch
-drivers-cdrom-aztcdc-warning-fix.patch
-init-mca_bus_type-even-if-mca_bus.patch
-split-backing_dev-memory-backed.patch
-ramdisk-fixes.patch
-ramdisk-memory-allocation-fixes.patch
-ramdisk-lock-io-pages.patch
-ramdisk-use-kmap_atomic.patch
-ramdisk-page-uptodate-fix.patch
-ramdisk-writepages.patch
-blockdev-split-backing_dev_info.patch
-ramdisk-split-backing_dev_info.patch
-knfsd-1-of-10-use-correct-_bh-locking-on-sv_lock.patch
-knfsd-2-of-10-make-sure-cache_negative-is-cleared-when-a-cache-entry-is-updates.patch
-knfsd-3-of-10-allow-larger-writes-to-sunrpc-svc-caches.patch
-knfsd-4-of-10-change-fh_compose-to-not-consume-a-reference-to-the-dentry.patch
-knfsd-5-of-10-protect-reference-to-exp-across-calls-to-nfsd_cross_mnt.patch
-knfsd-6-of-10-fix-race-conditions-in-idmapper.patch
-knfsd-7-of-10-improve-idmapper-behaviour-on-failure.patch
-knfsd-8-of-10-reduce-timeout-when-waiting-for-idmapper-userspace-daemon.patch
-knfsd-9-of-10-remove-check-on-number-of-threads-waiting-on-user-space.patch
-knfsd-10-of-10-add-a-warning-when-upcalls-fail.patch
-svc_recv-fix.patch
-debugging-option-to-put-data-symbols-in-kallsyms.patch
-sis900-add-new-isa-bridge-pci-id.patch
-sis900-small-cleanup-and-spelling-fixes.patch
-cache-sizing-fix.patch
-vga16fb-fix.patch
-fix-overzealous-use-of-online-cpu-iterators.patch

 Merged

+nosysfs-sysfs_rename_dir-fix.patch

 Fix !CONFIG_SYSFS build

+vga16fb-warning-fix.patch

 Fix a warning

+gss_api-build-fix.patch
+gss_api-build-fix-tweak.patch

 Fix NFS build with gcc-2.95

+make-tree_lock-an-rwlock.patch

 Switch the pagecache lock back from a spinlock to an rwlock.  Better for big
 SMP and pretty much a wash for small SMP.

+radix_tree_tag_set-atomic.patch

 Make the radix-tree tagging operations atomic

+radix_tree_tag_set-only-needs-read_lock.patch

 Switch lots of pagecache write_locks to read_locks.

+ppc64-console-autodetection-for-pmac.patch

 PPC64 power mac fix/feature

-sched-ifdef-active-balancing.patch

 Dropped - was a bit messy.

-speed-up-sata.patch

 Dropped - was obsolete.

+reiserfs-block-allocator-should-not-inherit-packing-locality.patch

 Fix a bug in reiserfs-group-alloc-9.patch

-make-4k-stacks-permanent.patch

 Dropped - 8k stacks work better with kgdb.

-mlock_group-sysctl.patch

 Dropped - don't see a need for this.

+use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api.patch

 Fix i2c build for lib/idr.c changes

-mqueue-rlimit-compile-fix-for-ppc-cris-m68k.patch

 Folded into rlim-add-rlimit-entry-for-posix-mqueue-allocation.patch

+hpet-rtc-dependency-fix.patch
+hpet-free_irq-deadlock-fix.patch

 HPET driver fixes

+ext3-retry-allocation-after-transaction-commit-v2-jbd-api.patch

 Clean up the interfaces in the ext3 -ENOSPC fix patch

+vmscan-handle-synchronous-writepage-fix.patch

 Fix vmscan-handle-synchronous-writepage.patch

+ramdisk-buffer-uptodate-fix.patch

 Fiddle with the ramdisk pagecache code a bit.

+ppc64-fault-deadlock-fix.patch
+ia32-fault-deadlock-fix.patch
+ia32-fault-deadlock-fix-cleanup.patch

 Avoid deadlocking the kernel when it takes an oops while holding the tasks's
 mmap_sem.

+ext3-htree-rename-fix.patch

 Fix an htree bug

+out-of-bounds-access-in-hiddev_cleanup.patch

 Fix some USB oops

+sis900-xcvr-fix.patch

 sis900 transceiver handling fix

+advansys-basic-highmem-dma-support.patch

 Add highmem support to the Advansys scsi driver

+fbdev-mode-switching-fix.patch

 fbdev fix

+ipr-gcc-attribute-fixes.patch

 scsi driver fix

+ipr-ppc64-depends.patch

 Make ipr.c depend on PPC

+SL0-core-RC6-bk5.patch
+SL1-ext2-RC6-bk5.patch
+SL2-trivial-RC6-bk5.patch
+SL3-page-RC6-bk5.patch
+SL4-smb-RC6-bk5.patch
+SL5-xfs-RC6-bk5.patch
+SL6-shm-RC6-bk5.patch
+SL7-befs-RC6-bk5.patch
+SL8-jffs2-RC6-bk5.patch

 symlink rework

+scsi-qla1280c-warning-fix.patch

 Fix a warning

+trivial-use-page_to_phys-in-dma_map_page.patch

 cleanup

+trivial-fix-duplicated-includes.patch

 Remove lots of duplicated includes

+fix-knfsd-scary-message.patch

 Prevent a rude boot-time message coming out of the kernel NFS server.

+mangled-printk-oops-output-fix.patch
+mangled-printk-oops-output-fix-tweaks.patch

 Should fix the mess which comes out on the serial console when an SMP box
 oopses.

+crypto-scatterwalk-fixes.patch

 Fix a few things in the crypto scatter/gather code

+sanitise-unneeded-syscall-stubs.patch
+sanitise-unneeded-syscall-stubs-fixes.patch

 Clean up the selection of which architectures want which syscall stubs.

+ep_send_events-simplification.patch

 Stack reduction in eventpoll

+blk-completion-clear-stack-pointer-on-return.patch

 Prevent possible crashes which haven't happened yet.

+disk-barrier-core.patch
+disk-barrier-core-tweaks.patch
+disk-barrier-ide.patch
+disk-barrier-ide-symbol-expoprt.patch
+disk-barrier-ide-warning-fix.patch
+disk-barrier-scsi.patch

 Support for IDE and SCSI barriers

+disk-barrier-dm.patch
+disk-barrier-md.patch

 Via device mapper and raid as well.

+reiserfs-v3-barrier-support.patch

 Implement it on reiserfs

+ext3-barrier-support.patch
+#ext3-barrier-support-default-on.patch
+sync_dirty_buffer-retval.patch
+jbd-barrier-fallback-on-failure.patch

 And on ext3

+x86-stack-dump-fixes.patch

 Tidy a few things up

+add-futex_cmp_requeue-futex-op.patch

 New futex mode

+swsusp-kill-unneccessary-debugging.patch

 Cleanup

+race-condition-with-current-group_info.patch
+race-condition-with-current-group_info-tweaks.patch

 Fix a race in the new group-handling code

+swsusp-fix-devfs-breakage-introduced-in-266.patch

 swsusp fix

+check-return-status-of-register-calls-in-i82365.patch

 Missing error return checks

+26-isdn-eicon-driver-fix-__devexit-in-prototype.patch

 ISDN fix

+cpuid-cache-info-update.patch

 Intel P4E's were missing cache-size info.

+3ware-9000-sata-raid-driver-for-266-mm5.patch

 New SATA RAID driver from 3ware.

+autofs4-printk-cleanup.patch
+autofs4-maintainer.patch

 autofs changes.





All 264 patches


linus.patch

nosysfs-sysfs_rename_dir-fix.patch
  Fix !CONFIG_SYSFS build

vga16fb-warning-fix.patch
  vga16fb warning fix

gss_api-build-fix.patch
  gss_api build fix

gss_api-build-fix-tweak.patch
  gss_api-build-fix-tweak

bk-agpgart.patch

bk-alsa.patch

bk-arm.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-i2c.patch

bk-input.patch

bk-libata.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-pcmcia.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

revert-i8042-interrupt-handling.patch
  revert i8042 input interrupt handling changes

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
  kgdb: fix for recent gcc
  kgdb warning fixes
  THREAD_SIZE fixes for kgdb

kgdb-in-sched_functions.patch

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-in-sched_functions-x86_64.patch

kgdb-ia64-support.patch
  IA64 kgdb support

swapper_space-tree_lock-fix.patch
  Make swapper_space tree_lock irq-safe

__add_to_swap_cache-simplification.patch
  __add_to_swap_cache and add_to_pagecache() simplification

revert-swapcache-changes.patch
  revert recent swapcache handling changes

vmscan-revert-may_enter_fs-changes.patch
  vmscan-revert-may_enter_fs-changes

sync_page-use-swapper-space.patch
  Make sync_page use swapper_space again

__set_page_dirty_nobuffers-race-fix.patch
  __set_page_dirty_nobuffers race fix

rmap-7-object-based-rmap.patch
  rmap 7 object-based rmap
  rmap-7-object-based-rmap-sync_page-fix

ia64-rmap-build-fix.patch
  ia64 rmap build fix

rmap-8-unmap-nonlinear.patch
  rmap 8 unmap nonlinear
  try_to_unmap_cluster-comment

slab-panic.patch
  slab: consolidate panic code

rmap-9-remove-pte_chains.patch
  rmap 9 remove pte_chains
  page_add_anon_rmap BUG fix

rmap-10-add-anonmm-rmap.patch
  rmap 10 add anonmm rmap

rmap-anonhd-locking-fix.patch
  rmap anonhd locking fix

rmap-11-mremap-moves.patch
  rmap 11 mremap moves

rmap-12-pgtable-remove-rmap.patch
  rmap 12 pgtable remove rmap

rmap-13-include-asm-deletions.patch
  rmap 13 include/asm deletions

i_mmap_lock.patch
  Convert i_shared_sem back to a spinlock
  i_mmap_lock fix 1
  i_mmap_lock fix 2
  i_mmap_lock mremap fix

rmap-14-i_shared_lock-fixes.patch
  rmap 14: i_shared_lock fixes

numa-api-x86_64.patch
  numa api: -64 support
  numa api: Bitmap bugfix

numa-api-i386.patch
  numa api: Add i386 support

numa-api-ia64.patch
  numa api: Add IA64 support

numa-api-core.patch
  numa api: Core NUMA API code
  numa api: docs and policy_vma() locking fix
  numa-api-core-tweaks
  Some fixes for NUMA API
  From: Matthew Dobson <colpatch@us.ibm.com>
  Subject: [PATCH] include/linux/gfp.h cleanup for NUMA API
  numa-api-core bitmap_clear fixes

mpol-in-copy_vma.patch
  mpol in copy_vma

numa-api-core-slab-panic.patch
  numa-api-core-slab-panic

numa-api-statistics-2.patch
  Re-add NUMA API statistics

numa-api-vma-policy-hooks.patch
  numa api: Add VMA hooks for policy
  numa-api-vma-policy-hooks fix

numa-api-shared-memory-support.patch
  numa api: Add shared memory support
  numa-api-shared-memory-support-tweaks

small-numa-api-fixups.patch
  small numa api fixups
  small-numa-api-fixups-fix

small-numa-api-fixups-fix.patch
  small-numa-api-fixups-fix

numa-api-statistics.patch
  numa api: Add statistics

numa-api-anon-memory-policy.patch
  numa api: Add policy support to anonymous  memory

numa-api-fix-end-of-memory-handling-in-mbind.patch
  numa api: fix end of memory handling in mbind

rmap-15-vma_adjust.patch
  rmap 15: vma_adjust

rmap-16-pretend-prio_tree.patch
  rmap 16: pretend prio_tree

rmap-17-real-prio_tree.patch
  rmap 17: real prio_tree

rmap-18-i_mmap_nonlinear.patch
  rmap 18: i_mmap_nonlinear

unmap_mapping_range-comment.patch
  unmap_mapping_range-comment

rmap-19-arch-prio_tree.patch
  rmap 19: arch prio_tree
  rmap-19-arch-prio_tree-parisc

vm_area_struct-size-comment.patch
  vm_area_struct size comment

rmapc-comment-style-fixups.patch
  rmap.c comment/style fixups

rmap-20-i_mmap_shared-into-i_mmap.patch
  rmap 20 i_mmap_shared into i_mmap
  rmap-20-i_mmap_shared-into-i_mmap-parisc

rmap-21-try_to_unmap_one-mapcount.patch
  rmap 21 try_to_unmap_one mapcount

rmap-22-flush_dcache_mmap_lock.patch
  rmap 22 flush_dcache_mmap_lock
  rmap-22-flush_dcache_mmap_lock-parisc

rmap-23-empty-flush_dcache_mmap_lock.patch
  rmap 23 empty flush_dcache_mmap_lock

rmap-24-no-rmap-fastcalls.patch
  rmap 24 no rmap fastcalls

rmap-27-memset-0-vma.patch
  rmap 27 memset 0 vma

rmap-28-remove_vm_struct.patch
  rmap 28 remove_vm_struct

rmap-29-vm_reserved-safety.patch
  rmap 29 VM_RESERVED safety

rmap-30-fix-bad-mapcount.patch
  rmap 30 fix bad mapcount

rmap-31-unlikely-bad-memory.patch
  rmap 31 unlikely bad memory

rmap-32-zap_pmd_range-wrap.patch
  rmap 32 zap_pmd_range wrap

rmap-33-install_arg_page-vma.patch
  rmap 33 install_arg_page vma

rmap-34-vm_flags-page_table_lock.patch
  rmap 34 vm_flags page_table_lock

rmap-35-mmapc-cleanups.patch
  rmap 35 mmap.c cleanups

rmap-36-mprotect-use-vma_merge.patch
  rmap 36 mprotect use vma_merge

rmap-37-page_add_anon_rmap-vma.patch
  rmap 37 page_add_anon_rmap vma

rmap-38-remove-anonmm-rmap.patch
  rmap 38 remove anonmm rmap

rmap-39-add-anon_vma-rmap.patch
  rmap 39 add anon_vma rmap

rmap-40-better-anon_vma-sharing.patch
  rmap 40 better anon_vma sharing

partial-prefetch-for-vma_prio_tree_next.patch
  partial prefetch for vma_prio_tree_next

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

radix_tree_tag_set-atomic.patch
  Make radix_tree_tag_set/clear atomic wrt the tag

radix_tree_tag_set-only-needs-read_lock.patch
  radix_tree_tag_set only needs read_lock()

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-console-autodetection-for-pmac.patch
  From: Olaf Hering <olh@suse.de>
  Subject: [PATCH] console autodetection for pmac

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

allow-i386-to-reenable-interrupts-on-lock-contention.patch
  Allow i386 to reenable interrupts on lock contention

pdflush-diag.patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

local_bh_enable-warning-fix.patch

schedstats.patch
  sched: scheduler statistics

cond_resched-might-sleep.patch
  cond_resched() might sleep

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

siimage-update.patch
  ide: update for siimage driver

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

sk98lin-buggy-vpd-workaround.patch
  net/sk98lin: correct buggy VPD in ASUS MB

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation
  ext3 reservations: fix performance regression
  ext3 block reservation patch set -- mount and ioctl feature
  ext3 block reservation patch set -- dynamically increase reservation window

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-reservation-ifdef-cleanup-patch.patch
  ext3 reservation ifdef cleanup patch

ext3-reservation-max-window-size-check-patch.patch
  ext3 reservation max window size check patch

ext3-reservation-file-ioctl-fix.patch
  ext3 reservation file ioctl fix

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard

ext3-reservation-bad-inode-fix.patch
  ext3 reservations: bad_inode fix

ext3_reservation_discard_race_fix.patch
  ext3 reservation discard race fix

clean-up-asm-pgalloch-include.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-2.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-3.patch
  Clean up asm/pgalloc.h include 3

ppc64-uninline-__pte_free_tlb.patch
  ppc64: uninline __pte_free_tlb()

input-tsdev-fixes.patch
  tsdev.c fixes

fix-scancode-keycode-scancode-conversion-for-265.patch
  Fix scancode->keycode->scancode conversion

fealnx-mac-address-and-other-issues.patch
  Fealnx. Mac address and other issues

reiserfs-group-alloc-9.patch
  reiserfs: block allocator optimizations

reiserfs-block-allocator-should-not-inherit-packing-locality.patch
  reiserfs: block allocator should not inherit "packing locality 1"

reiserfs-remove-debugging-warning-from-block-allocator.patch
  reiserfs: remove debugging warning from block allocator

reiserfs-group-alloc-9-build-fix.patch
  reiserfs-group-alloc-9 build fix

reiserfs-search_reada-5.patch
  reiserfs: btree readahead

reiserfs-data-logging-support.patch
  reiserfs data logging support

problems-with-atkbd_command--atkbd_interrupt-interaction.patch
  Problems with atkbd_command & atkbd_interrupt interaction

sis-agp-updates.patch
  fbdev: SIS AGP updates

clear_backing_dev_congested.patch
  clear_baking_dev_congested

force-config_regparm-to-y.patch
  Force CONFIG_REGPARM to `y'

hugetlb_shm_group-sysctl-gid-0-fix.patch
  hugetlb_shm_group sysctl-gid-0-fix

idr-overflow-fixes.patch
  Fixes for idr code

idr-remove-counter.patch
  idr: remove counter bits from id's

idr-fixups.patch
  IDR fixups

use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api.patch
  use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api

rlim-add-rlimit-entry-for-controlling-queued-signals.patch
  RLIM: add rlimit entry for controlling queued signals

rlim-add-sigpending-field-to-user_struct.patch
  RLIM: add sigpending field to user_struct

rlim-pass-task_struct-in-send_signal.patch
  RLIM: pass task_struct in send_signal()

rlim-add-simple-get_uid-helper.patch
  RLIM: add simple get_uid() helper

rlim-enforce-rlimits-on-queued-signals.patch
  RLIM: enforce rlimits on queued signals

rlim-remove-unused-queued_signals-global-accounting.patch
  RLIM: remove unused queued_signals global accounting

rlim-add-rlimit-entry-for-posix-mqueue-allocation.patch
  RLIM: add rlimit entry for POSIX mqueue allocation

rlim-add-mq_bytes-to-user_struct.patch
  RLIM: add mq_bytes to user_struct

rlim-add-mq_attr_ok-helper.patch
  RLIM: add mq_attr_ok() helper

rlim-enforce-rlimits-for-posix-mqueue-allocation.patch
  RLIM: enforce rlimits for POSIX mqueue allocation

rlim-adjust-default-mqueue-sizes.patch
  RLIM: adjust default mqueue sizes

call-might_sleep-in-tasklet_kill.patch
  Call might_sleep() in tasklet_kill

add-qsort-library-function.patch
  add qsort library function

have-xfs-use-kernel-provided-qsort.patch
  Have XFS use kernel-provided qsort

have-xfs-use-kernel-provided-qsort-fix.patch
  have-xfs-use-kernel-provided-qsort-fix

slabify-iocontext-request_queue-SLAB_PANIC.patch
  slabify-iocontext-request_queue: use SLAB_PANIC

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

fix-crash-on-modprobe-ohci1394.patch
  fix crash on `modprobe ohci1394; modprobe -r ohci1394'

abs-cleanup.patch
  abs() cleanup

add-i386-readq.patch
  add i386 readq()/writeq()

hpet-driver.patch
  HPET driver

hpet-driver-updates.patch
  HPET driver updates

hpet-driver-updates-move-readq.patch
  hpet-driver-updates-move-readq

hpet-kconfig-loop-fix.patch
  HPET: Fix Kconfig dependency loop

hpet-rtc-dependency-fix.patch
  HPET RTC dependency fix

hpet-free_irq-deadlock-fix.patch
  hpet-free_irq-deadlock-fix

checkstack-target.patch
  Add `make checkstack' target

kill-off-pc9800.patch
  Remove PC9800 support

more-pc9800-removal.patch
  more PC9800 removal

pc9800-merge-std_resourcesc-back-into-setupc.patch
  pc9800: merge std_resources.c back into setup.c

266-mm2-r8169-ethtool-set_settings.patch
  r8169: ethtool .set_settings

266-mm2-r8169-ethtool-get_settings.patch
  r8169: ethtool .get_settings

266-mm2-r8169-link-handling-rework-1-2.patch
  r8169: link handling rework (1/2)

266-mm2-r8169-link-handling-rework-2-2.patch
  r8169: link handling rework (2/2)

hfsplus-dir-rename-fix.patch
  hfsplus directory renaming fix

ftruncate-vs-block_write_full_page.patch
  ftruncate-vs-block_write_full_page

fix-userspace-include-of-linux-fsh.patch
  Fix userspace include of linux/fs.h

ext3-retry-allocation-after-transaction-commit-v2.patch
  Ext3: Retry allocation after transaction commit (v2)

ext3-retry-allocation-after-transaction-commit-v2-jbd-api.patch
  ext3-retry-allocation-after-transaction-commit-v2: implement JBD API

sysfs-leaves-mount.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-dir.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-file.patch
  sysfs backing store: sysfs_create() changes

sysfs-leaves-bin.patch
  sysfs backing store: bin attribute changes

sysfs-leaves-symlink.patch
  sysfs backing store: sysfs_create_link changes

sysfs-leaves-misc.patch
  sysfs backing store: attribute groups and misc routines

pty-allocation-first-fit.patch
  pty-allocation-first-fit-fix

sync_inodes_sb-debug.patch
  sync_inodes_sb-debug

vmscan-handle-synchronous-writepage.patch
  vmscan: handle synchronous writepage()

vmscan-handle-synchronous-writepage-fix.patch
  vmscan-handle-synchronous-writepage-fix

ramdisk-buffer-uptodate-fix.patch
  ramdisk: buffer_uptodate fix

2-3-small-tweaks-to-standard-resource-stuff.patch
  small tweaks to standard resource stuff

3-3-same-small-tweaks-x86_64-version.patch
  same small resource tweaks, x86_64 version

sis900-maintainer.patch
  Sis900: maintainer update

sis900-fix-phy-transceiver-detection.patch
  sis900: Fix PHY transceiver detection

getgroups16-fix.patch
  getgroups16() fix

fixing-sendfile-on-64bit-architectures.patch
  fix sendfile on 64bit architectures

ppc64-fault-deadlock-fix.patch
  ppc64: fix deadlocks due to fault-inside-mmap_sem

ia32-fault-deadlock-fix.patch
  ia32: fix deadlocks due to fault-inside-mmap_sem

ia32-fault-deadlock-fix-cleanup.patch
  ia32-fault-deadlock-fix cleanup

ext3-htree-rename-fix.patch
  ext3: htree rename fix

out-of-bounds-access-in-hiddev_cleanup.patch
  out of bounds access in hiddev_cleanup

sis900-xcvr-fix.patch
  sis900 transceiver fix

advansys-basic-highmem-dma-support.patch
  advansys: add basic highmem/DMA support

fbdev-mode-switching-fix.patch
  fbdev: mode switching fix.

ipr-gcc-attribute-fixes.patch
  Fix drivers/scsi/ipr.c on ia32

SL0-core-RC6-bk5.patch
  symlinks: infrastructure

SL1-ext2-RC6-bk5.patch
  symlinks: ext2 conversion

SL2-trivial-RC6-bk5.patch
  symlinks: trivial cases

SL3-page-RC6-bk5.patch
  symlinks: reuse new helpers

SL4-smb-RC6-bk5.patch
  symlinks: smbfs

SL5-xfs-RC6-bk5.patch
  symlinks: XFS

SL6-shm-RC6-bk5.patch
  symlinks: tmpfs

SL7-befs-RC6-bk5.patch
  symlinks: befs

SL8-jffs2-RC6-bk5.patch
  symlinks: jffs2

ipr-ppc64-depends.patch
  Make ipr.c require ppc

scsi-qla1280c-warning-fix.patch
  scsi/qla1280.c warning fix.

trivial-use-page_to_phys-in-dma_map_page.patch
  trivial: use page_to_phys in dma_map_page()

trivial-fix-duplicated-includes.patch
  trivial: remove duplicated #includes
  trivial: drivers/media/video_saa7134_saa7134-input.c: kill duplicate include
  Subject: [TRIVIAL] [TRIVIAL 2.6] drivers_net_wireless_orinoco_plx.c: kill 	duplicate

fix-knfsd-scary-message.patch
  Prevent scary warnings from knfsd

mangled-printk-oops-output-fix.patch
  Fix the mangled-oops-output-on-SMP problem

mangled-printk-oops-output-fix-tweaks.patch
  mangled-printk-oops-output-fix tweaks

crypto-scatterwalk-fixes.patch
  crypto scatterwalking fixes

sanitise-unneeded-syscall-stubs.patch
  Sanitise handling of unneeded syscall stubs

sanitise-unneeded-syscall-stubs-fixes.patch
  sanitise-unneeded-syscall-stubs-fixes

ep_send_events-simplification.patch
  ep_send_events-simplification

blk-completion-clear-stack-pointer-on-return.patch
  blk: clear completion stack pointer on return

disk-barrier-core.patch
  disk barriers: core

disk-barrier-core-tweaks.patch
  disk-barrier-core-tweaks

disk-barrier-ide.patch
  disk barriers: IDE

disk-barrier-ide-symbol-expoprt.patch
  disk-barrier-ide-symbol-expoprt

disk-barrier-ide-warning-fix.patch
  disk-barrier ide warning fix

disk-barrier-scsi.patch
  disk barriers: scsi

disk-barrier-dm.patch
  disk barriers: devicemapper

disk-barrier-md.patch
  disk barriers: MD

reiserfs-v3-barrier-support.patch
  reiserfs v3 barrier support

ext3-barrier-support.patch
  ext3 barrier support

sync_dirty_buffer-retval.patch
  make sync_dirty_buffer() return something useful

jbd-barrier-fallback-on-failure.patch
  jbd: barrier fallback on failure

x86-stack-dump-fixes.patch
  x86 stack dump fixes

add-futex_cmp_requeue-futex-op.patch
  Add FUTEX_CMP_REQUEUE futex op

swsusp-kill-unneccessary-debugging.patch
  From: Pavel Machek <pavel@ucw.cz>
  Subject: swsusp: kill unneccessary debugging

race-condition-with-current-group_info.patch
  Fix race condition with current->group_info

race-condition-with-current-group_info-tweaks.patch
  race-condition-with-current-group_info-tweaks

swsusp-fix-devfs-breakage-introduced-in-266.patch
  swsusp: fix devfs breakage introduced in 2.6.6

check-return-status-of-register-calls-in-i82365.patch
  Check return status of register calls in i82365

26-isdn-eicon-driver-fix-__devexit-in-prototype.patch
  i4l: Eicon driver: fix __devexit in prototype

cpuid-cache-info-update.patch
  x86 cpuid cache info update

3ware-9000-sata-raid-driver-for-266-mm5.patch
  3ware 9000 SATA-RAID driver for 2.6.6-mm5

autofs4-printk-cleanup.patch
  autofs4: printk cleanup

autofs4-maintainer.patch
  autofs4: MAINTAINERS update




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266358AbUHBI6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266358AbUHBI6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 04:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266359AbUHBI6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 04:58:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:60590 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266358AbUHBI5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 04:57:01 -0400
Date: Mon, 2 Aug 2004 01:55:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc2-mm2
Message-Id: <20040802015527.49088944.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm2/


- Some fairly significant changes to the RCU code.  Should address
  scheduling latency issues which we've seen in there.

- Various changes to the writeback code - mainly to support concurrent
  O_SYNC writers to the same file.  Also arrange for O_SYNC writes to sync
  only the part of the file which the caller actually wrote.  Database stuff.

- Added Con's staircase CPU scheduler.

  This will probably have to come out again because various people are still
  fiddling with the CPU scheduler.  But my feeling here is that the current
  1st-gen CPU scheduler has been tweaked as far as it can go and is still not
  100% right.  It is time to start thinking about a new design which addresses
  the requirements and current problems by algorithmic means rather than by
  tweaking.  Removing over 300 lines from the scheduler is a good sign.

  Feedback on this patch is sought.

- Added Rik's token-based load control patch.  The VM currently has pretty
  bad performance problems under heavy swapping loads and this patch speeds up
  simple tests most impressively.  People who care about these things: please
  test and measure.

- Tons of new fixes and cleanups and updates to various things as usual.

- Again, 2.6.8 is close, so if people have critical fixes in here which
  need flushing out, please ping me.



Changes since 2.6.8-rc2-mm1:


 linus.patch
 bk-acpi.patch
 bk-alsa.patch
 bk-dma-declare-coherent-memory.patch
 bk-cpufreq.patch
 bk-drm.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-libata.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-pnp.patch
 bk-power.patch
 bk-scsi.patch
 bk-usb.patch

 Latest versions of external trees

-fixes-for-rcu_offline_cpu-rcu_move_batch-268-rc2.patch
-unix98-pty-indices-leak.patch
-sched-initialize-sched-domain-table.patch
-compat_clock_getres-shouldnt-return-efault-if-res-==-null.patch
-bio-page-refcounting-fix.patch
-bk-acpi-x86_cpu_to_apicid-fix.patch
-ppc64-page-align-emergency-stack-2.patch
-ppc64-remove-multiple-irq-optimisation.patch
-ppc64-cpu-hotplug-fix.patch
-ppc64-whitespace-cleanup-in-promc.patch
-ppc64-hvcs-driver.patch
-ppc64-smt-bugfix.patch
-ppc32-fix-ppc44x-early-uart-setup.patch
-ppc32-export-some-dma-api-symbols.patch
-ppc32-fix-comment-in-arch-ppc-platforms-pmac_pcic.patch
-enable-suspend-resuming-of-e1000.patch
-i810_audio-mmio-support.patch
-i810_audio-mmio-support-2.patch
-ia64-ptrace-fix-fix.patch
-possible-buglet-in-drivers-input-joystick-tmdcc.patch
-gcc35-advansys.c.patch
-gcc35-arlan.h.patch
-gcc35-fore200e.c.patch
-gcc35-index.html.patch
-gcc35-ip6_fib.c.patch
-gcc35-iphase.h.patch
-gcc35-irttp.h.patch
-gcc35-netrom.h.patch
-gcc35-pppoe.c.patch
-gcc35-usblp.c.patch
-gcc35-xfrm6_state.c.patch
-fix-rivafbs-nv_arch_-cleanup-debug-backlight-control-on-ppc.patch
-fix-rivafbs-nv_arch_-cleanup-debug-backlight-control-on-ppc-fix.patch
-hugetlbfs-vm_pgoff-bugs.patch
-unknown-symbol-in-drivers-scsi-pcmcia-fdomain_csko.patch
-fix-double-reset-in-aic7xxx-driver.patch
-v850-define-find_first_bit.patch
-radeonfb-64-bit-fix.patch
-net-sunrpc-xprtc-gcc341-inlining-fix.patch
-switch-sgc-to-standard-jiffies-converters.patch
-sign-fix-in-swapfilec.patch
-a-trivial-patch-for-removing-unnecessary-comment-in-mm-filemapc.patch
-fix-for-buffer-limit-for-long-in-sysctlc.patch
-ipmi_msghandler-module-load-failure-fix.patch
-remove-scripts-mkconfigs.patch
-267-msi-x-update.patch
-fix-readahead-breakage-for-sequential-after-random-reads.patch
-update-mailing-list-for-osst.patch
-fix-aic-for-db4.patch
-m68k-68060-errata-i14.patch
-m68k-ifpsp060.patch
-m68k-sparse-missing-void.patch
-m68k-sparse-if-vs-ifdef.patch
-m68k-sparse-void-return.patch
-m68k-sparse-extern.patch
-m68k-sparse-inline.patch
-dsp56k-sparse-const.patch
-m68k-sparse-floating-point.patch
-dnfb-sparse-struct-init.patch
-amifb-sparse-=.patch
-m68k-hardirqh.patch
-dmasound-paths.patch
-m68k-bitops.patch
-m68k-checksum-include.patch
-m68k-pgalloc-fixup.patch
-m68k-maintainership.patch
-depends-on-pci-multi-tech-synclink-applicom-serial.patch
-pci-warnings-moxa-serial.patch
-pci-warnings-specialix-serial.patch
-depends-on-pci-via686a-i2c.patch
-depends-on-pci-dma-api-ieee1394-core-and-sbp-2.patch
-depends-on-pci-fritzpci-pciv2-pnp-and-hysdn.patch
-pci-warnings-hisax-isdn.patch
-depends-on-pci-guillemot-maxi-radio-fm-2000.patch
-depends-on-pci-technisat-skystar2-pci.patch
-depends-on-pci-dma-api-cisco-aironet-34x-35x-4500-4800.patch
-depends-on-pci-toshiba-and-via-fir.patch
-depends-on-pci-matrox-1-wire.patch
-dallas-1-wire-delayh.patch
-linux-mmzoneh-const.patch
-cirrusfb-update-for-amiga-zorro.patch
-page_cache_readahead-unused-variable.patch
-remove-faulty-__inits-from-drivers-video-fbmemc-fwd.patch
-export-all-functions-in-lib-stringc.patch
-hlist_for_each_safe-cleanup.patch
-front-buttons-wouldnt-mute-ess-maestro.patch
-ipv6-routec-gcc-341-fix-inline.patch
-config-file-for-laptop-mode.patch
-add-documentation-about-proc-sys-vm-laptop_mode-to-various-docs.patch
-automatically-disable-laptop-mode-when-battery-almost-runs-out.patch
-ppc32-snd-powermac-requires-i2c.patch
-ext2_readdir-retval-fix.patch
-ncpfs-setattr-retval-fix.patch
-recommend-noapic-when-timer-via-ioapic-fails.patch
-s390-core-changes.patch
-s390-zfcp-host-adapter.patch
-s390-network-driver-changes.patch
-dvb-major-number.patch
-selinux-fix-clearing-of-new-personality-bit-on-security-transitions.patch
-lost-error-code-in-rescan_partitions.patch
-trivial-doc-patch-for-partitions.patch
-rename-config_pci_use_vector-to-config_pci_msi.patch
-fix-bogus-ioctl-return-in-mtrr.patch
-remove-boot98.patch
-writepages-drops-bh-on-not-uptodate-page.patch
-critical-x86-64-patches-for-268rc2.patch

 Merged

-sysfs-leaves-mount.patch
-sysfs-leaves-dir.patch
-sysfs-leaves-file.patch
-sysfs-leaves-bin.patch
-sysfs-leaves-symlink.patch
-sysfs-leaves-misc.patch
+sysfs-backing-store-add-sysfs_dirent-to-sysfs-dentry.patch
+sysfs-backing-store-use-sysfs_dirent-tree-for-readdir-etc.patch
+sysfs-backing-store-free-sysfs_dirent-on-file-removal.patch
+sysfs-backing-store-change-sysfs_file_operations.patch
+sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves.patch

 Updated backing-store-for-sysfs patches

+sched-use-for_each_cpu.patch

 CPU hotunplug fix

+fix-bsd-accounting-cross-platform-compatibility.patch

 BSD accounting format fix

+mm-swsusp-make-sure-we-do-not-return-to-userspace-where-image-is-on-disk.patch
+mm-swsusp-copy_page-is-harmfull.patch

 swsusp fixes

+ppc64-__make_room-warning-fix.patch
+ppc64-fix-off-by-one-in-mem_init.patch
+ppc64-struct-pci_controller-cleanup.patch
+ppc64-isa-device-tree-node-refcount-fix.patch
+ppc64-fix-hotplug-irq-migration-code.patch
+ppc64-fix-cpu_up-race.patch
+ppc64-improve-slb-reload.patch
+ppc64-remove-include-processorh-from-div64s.patch

 ppc64 updates

+ppc32-support-for-mpc8560-cpu-and-boards.patch
+ppc32-support-for-mpc8555-cpu-and-board.patch

 ppc32 updates

+dev-mem-restriction-patch.patch

 Restrict the memory which may be accessed via /dev/mem (x86 only).

 Disable /dev/kmem writes altogether.

+sched-merge-fix.patch

 CPU scheduler fix

+sched-isolated-sched-domains.patch
+sched-isolated-sched-domains-fix.patch
+create-cpu_sibling_map-for-ppc64.patch
+create-cpu_sibling_map-for-ppc64-fix.patch
+sched-adjust-p4-per-cpu-gain.patch

 CPU scheduler updates

+sysctl-tunable-for-flexmmap.patch
+legacy_va_layout-docs.patch

 Create /proc/sys/vm/legacy_va_layout - it switches the mmap layout back to
 the old version, system-wide.

+packet-remove-warning.patch
+packet-door-unlock.patch
+pkt_lock_door-warning-fix.patch
+trivial-cdrw-packet-writing-doc-update.patch
+simplified-request-size-handling-in-cdrw-packet-writing.patch
+fix-setting-of-maximum-read-speed-in-cdrw-packet-writing.patch

 Packet driver updates

+uml-remove-a-group-of-unused-bh-functions.patch

 UML cleanup

+bio_copy_user-cleanups.patch

 Fix BIO copy-to-userspace handling

+journal_clean_checkpoint_list-latency-fix-fix.patch

 Fix the fix for recuding latency in JBD.

+e1000-inlining-fix.patch

 gcc-3.5 build fix

+msi-stop-using-dev-bus-ops-directly-in-msic.patch
+msi-msi-msi-x-api-updates.patch
+rename-config_pci_use_vector-to-config_pci_msi.patch

 MSI updates

+signal-race-fix-s390-fix.patch
+signal-race-fix-x86_64-fix.patch
+ppc-signal-handling-fixes.patch
+signal-race-fixes-sparc-sparc64.patch
+signal-race-fixes-ppc64.patch

 Update various architectures for the signal handling race fix.

+i2o-resync-with-post-266-changes.patch
+i2o-resync-with-post-266-changes-2.patch

 Forward-port the 2.6.6->current i2o changes into the i2o driver rewrite.

+make-shrinker_sem-an-rwsem.patch

 Concurrent slab shrinking in the VM

+vlan-support-for-3c59x-3c90x.patch

 Add vlan support to 3c59x.c

+add-support-for-innovision-dm-8401h.patch

 More IDE chip support

+break-out-zone-free-list-initialization.patch

 Split up some mm init code for future work

+fbcon-differentiate-bits_per_pixel-from-color-depth.patch
+fbcon-differentiate-bits_per_pixel-from-color-depth-fixup.patch
+fbcon-differentiate-bits_per_pixel-from-color-depth-export.patch
+fbdev-set-color-fields-correctly.patch
+fbdev-attn-maintainers-set-correct-hardware-capabilities.patch
+rivafb-do-not-tap-vga-ports-if-not-x86.patch
+i810fb-fixes.patch
+i810fb-fixes-2.patch

 Framebuffer updates

+268-rc2-mm1-link-errors.patch

 Fix bogus detection of undefined symbols

+drm-optimisation.patch

 DRM cleanups/speedups

+maintainers-update.patch

 macro has moved.

+fdomain-isa-fixup.patch

 Fix the fdomain driver build

+net-smc9194c-fix-inline-compile-errors-fwd.patch
+net-hamachic-remove-bogus-inline-at-function-prototype.patch
+scsi-qla2xxx-fix-inline-compile-errors.patch
+net-rrunnerc-fix-inline-compile-error.patch
+istallion-remove-inlines.patch
+mxserc-fix-inlines-fwd.patch
+radio-maestroc-remove-an-inline-fwd.patch
+netfilter-ip_nat_snmp_basicc-fix-inlines-fwd.patch
+net-tulip-dmfec-fix-inline-compile-errors-fwd.patch
+fix-inlining-errors-in-drivers-scsi-aic7xxx-aic79xx_osmc.patch
+fix-inline-related-gcc-34-build-failures-in.patch

 More attempts to recover from the gcc-3.4 disaster.

+modular-swim3.patch
+modular-anscd.patch

 Fix a couple of drivers for modular builds

+jffs2_compression_options-fix.patch

 jffs2 fix

+ppc8xx-maintainer-patch.patch

 MAINTAINER update

+ext2_readdir-filp-f_pos-fix.patch

 Fix f_pos handling in ext2_readdir()

+do_general_protection-doesnt-disable-irq.patch

 Remvoe unneeded local IRQ enabling

+jbd-jh-unmapping-race-fix.patch

 JBD race fix.

+nfs4-oops-fixes.patch

 nfsv4 oops fixes

+proc_pid_cmdline-race-fix.patch

 Fix race accessing /porc/pid/cmdline

+support-for-exar-xr17c158-octal-uart.patch

 Serial driver support

+dvb-errno-removal.patch

 Fix DVB build

+x86-64-merge-for-268rc2-mm1.patch

 Big x86_64 udpate

+ia64-swiotlb-fixes.patch

 Fix bugs in IA64 swiotlb code.

+documentation-fix-for-nmi-watchdog.patch

 NMI documentation fix

+hpet-copyrights-cleanup.patch

 Fix copyrights in HPET driver

+remove-outdated-reference-to-documentation-arm-sa1100-pcmcia-fwd.patch
+canonically-reference-files-in-documentation-code-comments-part.patch

 Fox references to Documentation files

+altix-system-controller-communication-driver.patch
+snsc-build-fix.patch

 SGI Altix system controller communication support

+move-duplicate-bug-and-warn_on-bits-to-asm-generic.patch

 Consolidate some debug macros

+fix-con_buf_size-usage.patch

 CON_BUF_SIZE fix

+vprintk-support.patch
+vprintk-for-ext2-errors.patch
+vprintk-for-ext3-errors.patch

 Add vprintk(), use it in ext2 and ext3.

+remove-symbol_is.patch

 Remove unused symbol_is()

+prio_tree-kill-vma_prio_tree_init.patch
+prio_tree-iterator-vma_prio_tree_next-cleanup.patch

 prio-tree cleanups

+rcu-cpu-offline-cleanup.patch
+rcu-rcu-cpu-offline-fix.patch
+rcu-low-latency-rcu.patch

 RCU updates.

+alpha-print-the-symbol-of-pc-and-ra-during-oops.patch

 Make alpha oopses more friendly.

+staircase-cpu-scheduler-268-rc2-mm1.patch

 Staircase scheduler.

+first-next_cpu-returns-values-nr_cpus.patch
+first-next_cpu-returns-values-nr_cpus-fix.patch

 Fix __first_cpu() and __next_cpu()

+add-support-for-it8212-ide-controllers.patch

 More IDE device support

+drivers-net-wan-cycx_x25c189-warning-conflicting-types.patch

 Warning fix

+watchdog-fix-warning-defined-but-not-used.patch

 Wanring fix

+fix-pci-access-mode-dependences-in-arch-i386-kconfig.patch

 Kconfig dependency fix

+drivers-block-ubc-6.patch
+ub-warning-fixes.patch

 Add simple USB block driver.  No documentation so you're on your own with
 this one.

+i386-hotplug-cpu.patch

 Add i386 CPU hotplug support. No documentation so you're on your own with
 this one.

+token-based-thrashing-control.patch
+token-based-thrashing-control-remove-debug.patch

 VM load control.

+writeback-page-range-hint.patch
+fix-writeback-page-range-to-use-exact-limits.patch
+mpage-writepages-range-limit-fix.patch
+filemap_fdatawrite-range-interface.patch
+concurrent-o_sync-write-support.patch

 O_SYNC writeback speedups.

+nfsd-force-server-side-tcp-when-nfsv4-enabled.patch
+nfsd-nfsd-is-missing-a-put_group_info-in-the-auth_null.patch
+nfsd-make-cache_init-initialize-reference-count-to-1.patch
+nfsd-simplify-auth_domain_lookup.patch
+nfsd-fix-ip_map-cache-reference-count-leak.patch
+nfsd-basic-v4-acl-definitions.patch
+nfsd-posix-nfsv4-acl-translation-for-nfsd.patch
+nfsd-acl-support-for-the-nfsv4-server.patch

 kNFSD update

+bridge-build-fix.patch

 Fix the build.





All 388 patches:


linus.patch

sched-use-for_each_cpu.patch
  sched: use for_each_cpu

fix-bsd-accounting-cross-platform-compatibility.patch
  Fix BSD accounting cross-platform compatibility

sysfs-backing-store-add-sysfs_dirent-to-sysfs-dentry.patch
  sysfs backing store: add sysfs_dirent to sysfs dentry

sysfs-backing-store-use-sysfs_dirent-tree-for-readdir-etc.patch
  sysfs backing store: use sysfs_dirent tree for ->readdir etc.

sysfs-backing-store-free-sysfs_dirent-on-file-removal.patch
  sysfs backing store: free sysfs_dirent on file removal

sysfs-backing-store-change-sysfs_file_operations.patch
  sysfs backing store: change sysfs_file_operations

sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves.patch
  sysfs backing store: stop pinning dentries & inodes for leaves

bk-acpi.patch

bk-alsa.patch

bk-dma-declare-coherent-memory.patch

bk-cpufreq.patch

bk-drm.patch

bk-ieee1394.patch

bk-input.patch

bk-libata.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-pnp.patch

bk-power.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

longhaul-fix.patch
  longhaul build fix

bk-netdev-axnet_cs-fix.patch
  bk-netdev-axnet_cs-fix

bk-netdev-hp-plus-fix.patch
  bk-netdev-hp-plus-fix

bk-power-x86_64-fix.patch
  bk-power x86_64 fixes

mm-swsusp-make-sure-we-do-not-return-to-userspace-where-image-is-on-disk.patch
  -mm swsusp: make sure we do not return to userspace where image is on disk

mm-swsusp-copy_page-is-harmfull.patch
  -mm swsusp: copy_page is harmfull

nmi-trigger-switch-support-for-debuggingupdated.patch
  NMI trigger switch support for debugging(updated)

nmi-trigger-switch-support-for-debuggingupdated-fix.patch
  nmi-trigger-switch-support-for-debuggingupdated-fix

make-i386-die-more-resilient-against-recursive-errors.patch
  Make i386 die() more resilient against recursive errors

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
  Fix stack overflow test for non-8k stacks
  kgdb-ga.patch fix for i386 single-step into sysenter
  fix TRAP_BAD_SYSCALL_EXITS on i386
  add TRAP_BAD_SYSCALL_EXITS config for i386

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix

kgdb-ia64-fixes.patch
  kgdb: ia64 fixes

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

mustfix-lists.patch
  mustfix lists

ppc64-__make_room-warning-fix.patch
  ppc64: __make_room() warning fix

ppc64-fix-off-by-one-in-mem_init.patch
  ppc64: fix off-by-one in mem_init()

ppc64-struct-pci_controller-cleanup.patch
  ppc64: struct pci_controller cleanup

ppc64-isa-device-tree-node-refcount-fix.patch
  ppc64: ISA device tree node refcount fix

ppc64-fix-ras-irq-handlers.patch
  ppc64: fix RAS irq handlers

ppc64-fix-hotplug-irq-migration-code.patch
  ppc64: fix hotplug irq migration code

ppc64-fix-cpu_up-race.patch
  ppc64: Fix cpu_up race

ppc64-improve-slb-reload.patch
  ppc64: improve SLB reload

ppc64-remove-include-processorh-from-div64s.patch
  ppc64: remove #include processor.h from div64.S

ppc32-support-for-mpc8560-cpu-and-boards.patch
  ppc32: Support for MPC8560 CPU and boards

ppc32-support-for-mpc8555-cpu-and-board.patch
  ppc32: support for MPC8555 CPU and board

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

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
  ext3 reservation ifdef cleanup patch
  ext3 reservation max window size check patch
  ext3 reservation file ioctl fix

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard
  ext3 reservations: bad_inode fix
  ext3 reservation discard race fix

hugetlb_shm_group-sysctl-gid-0-fix.patch
  hugetlb_shm_group sysctl-gid-0-fix

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

ipr-ppc64-depends.patch
  Make ipr.c require ppc

disk-barrier-core.patch
  disk barriers: core
  disk-barrier-core-tweaks

disk-barrier-ide.patch
  disk barriers: IDE
  disk-barrier-ide-symbol-expoprt
  disk-barrier ide warning fix

barrier-update.patch
  barrier update

barrier-flushing-fix.patch
  barrier flushing fix

disk-barrier-scsi.patch
  disk barriers: scsi

disk-barrier-dm.patch
  disk barriers: devicemapper

disk-barrier-md.patch
  disk barriers: MD

reiserfs-v3-barrier-support.patch
  reiserfs v3 barrier support
  reiserfs-v3-barrier-support-tweak

sync_dirty_buffer-retval.patch
  make sync_dirty_buffer() return something useful

ext3-barrier-support.patch
  ext3 barrier support

jbd-barrier-fallback-on-failure.patch
  jbd: barrier fallback on failure

ide-print-failed-opcode.patch
  ide: print failed opcode on IO errors
  From: Jens Axboe <axboe@suse.de>
  Subject: Re: ide errors in 7-rc1-mm1 and later

add-bh_eopnotsupp-for-testing.patch
  add BH_Eopnotsupp for testing async barrier failures

handle-async-barrier-failures.patch
  Handle async barrier failures

tty_io-hangup-locking.patch
  tty_io.c hangup locking

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
  CONFIG_PERFCTR=n build fix
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
  perfctr #if/#ifdef cleanup
  perfctr Dothan support
  perfctr x86_tests build fix

perfctr-x86-init-bug.patch
  perfctr x86 init bug

perfctr-k8-fix-for-internal-benchmarking-code.patch
  perfctr: K8 fix for internal benchmarking code

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
  perfctr ppc32 update
  perfctr update 4/6: PPC32 cleanups

perfctr-ppc32-buglet-fix.patch
  perfctr ppc32 buglet fix

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
  perfctr update 6/6: misc minor cleanups
  perfctr update 3/6: __user annotations
  perfctr-cpus_complement-fix
  perfctr cpumask cleanup

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr update 2/6: Kconfig-related updates

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr update 5/6: reduce stack usage

perfctr-low-level-documentation.patch
  perfctr low-level documentation

perfctr-documentation-update.patch
  perfctr documentation update

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance 1/3: driver updates

perfctr-inheritance-illegal-sleep-bug.patch
  perfctr inheritance illegal sleep bug

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance 2/3: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance 3/3: documentation updates

ext3-online-resize-patch.patch
  ext3: online resizing

ext3-online-resize-warning-fix.patch
  ext3-online-resize-warning-fix

sched-clean-init-idle.patch
  sched: cleanup init_idle()

sched-clean-fork.patch
  sched: cleanup, improve sched <=> fork APIs

sched-clean-fork-rename-wake_up_new_process-wake_up_new_task.patch
  sched: rename wake_up_new_process -> wake_up_new_task

kernelthread-idle-fix-2.patch
  kernel thread idle fix

sched-misc-cleanups-2.patch
  sched: misc cleanups #2

sched-unlikely-rt_task.patch
  sched: make rt_task unlikely

sched-misc.patch
  sched: sched misc changes

sched-misc-fix-rt.patch
  sched: fix RT scheduling & interactivity estimator

sched-no-balance-clone.patch
  sched: disable balance on clone

sched-remove-balance-clone.patch
  sched: remove balance on clone

sched-fork-hotplug-cleanuppatch.patch
  sched: fork hotplug hanling cleanup

sched-consolidate-sched-domains.patch
  sched: consolidate sched domains

sched-consolidate-domains-fix.patch
  sched: fix for sched-consolidate-domains

sched-consolidate-domains-fix-2.patch
  another sched consolidate domains fix

sched-domain-node-span-4.patch
  sched: limit cpuspan of node scheduler domains

sched-merge-fix.patch
  sched: merge fix

sched-domain-node-span-4-warning-fix.patch
  sched-domain-node-span-4-warning-fix

sched-isolated-sched-domains.patch
  sched: isolated sched domains

sched-isolated-sched-domains-fix.patch
  sched-isolated-sched-domains-fix

create-cpu_sibling_map-for-ppc64.patch
  Create cpu_sibling_map for PPC64

create-cpu_sibling_map-for-ppc64-fix.patch
  create-cpu_sibling_map-for-ppc64-fix

sched-adjust-p4-per-cpu-gain.patch
  sched: adjust p4 per-cpu gain

memory-backed-inodes-fix.patch
  memory-backed inodes fix

ext3_bread-cleanup.patch
  ext3_bread() cleanup

flexible-mmap-2.6.7-mm3-A8.patch
  i386 virtual memory layout rework

flexible-mmap-bug-fix.patch
  flexible-mmap BUG fix

flexible-mmap-updatepatch-267-mm5.patch
  flexible-mmap update

sysctl-tunable-for-flexmmap.patch
  sysctl tunable for flexmmap

legacy_va_layout-docs.patch
  legacy_va_layout docs

driver-model-and-sysfs-support-for-pcmcia-1-3.patch
  driver model and sysfs support for PCMCIA (1/3)

driver-model-and-sysfs-support-for-pcmcia-update.patch
  driver model and sysfs support for PCMCIA update

update-drivers-net-pcmcia-2-3.patch
  update drivers/net/pcmcia (2/3)

update-drivers-net-wireless-3-3.patch
  update drivers/net/wireless (3/3)

posix-locking-fix-to-posix_same_owner.patch
  posix locking: Minimal fix to posix_same_owner()

posix-locking-fix-to-locking-code.patch
  posix locking: more locking code fixes

posix-locking-fix-up-nfs4statec.patch
  posix locking: Fix up nfs4state.c

posix-locking-fix-up-lockd.patch
  posix locking: Fix up lockd to make use of the new interface

posix-locking-fl_owner_t-to-pid-mapping.patch
  posix locking: mapping between fl_owner_t and client-side "pid"

dvdrw-support-for-267-bk13.patch
  DVD+RW support for 2.6.7-bk13

cdrw-packet-writing-support-for-267-bk13.patch
  CDRW packet writing support

packet-remove-warning.patch
  packet: remove #warning

packet-door-unlock.patch
  packet writing: door unlocking fix

pkt_lock_door-warning-fix.patch
  pkt_lock_door() warning fix

dvd-rw-packet-writing-update.patch
  Packet writing support for DVD-RW and DVD+RW discs.

fix-race-in-pktcdvd-kernel-thread-handling.patch
  Fix race in pktcdvd kernel thread handling

fix-open-close-races-in-pktcdvd.patch
  Fix open/close races in pktcdvd

packet-writing-review-fixups.patch
  packet writing: review fixups

remove-pkt_dev-from-struct-pktcdvd_device.patch
  Remove pkt_dev from struct pktcdvd_device

packet-writing-docco.patch
  packet writing documentation

trivial-cdrw-packet-writing-doc-update.patch
  Trivial CDRW packet writing doc update

convert-packet-writing-to-seq_file.patch
  packet writing: convert to seq_file

control-pktcdvd-with-an-auxiliary-character-device.patch
  Control pktcdvd with an auxiliary character device

control-pktcdvd-with-an-auxiliary-character-device-fix.patch
  control-pktcdvd-with-an-auxiliary-character-device-fix

simplified-request-size-handling-in-cdrw-packet-writing.patch
  Simplified request size handling in CDRW packet writing

fix-setting-of-maximum-read-speed-in-cdrw-packet-writing.patch
  Fix setting of maximum read speed in CDRW packet writing

r8169_napi-help-text-2.patch
  R8169_NAPI help text

no-sysgood-for-ptrace-singlestep.patch
  Don't use SYSGOOD for ptrace singlestep

err2-6-hashbin_remove_this-locking-fix.patch
  err2-6: hashbin_remove_this() locking fix

dm-use-idr.patch
  devicemapper: use an IDR tree for tracking minors

ipc-1-3-add-refcount-to-ipc_rcu_alloc.patch
  ipc: Add refcount to ipc_rcu_alloc

ipc-2-3-remove-sem_revalidate.patch
  ipc: remove sem_revalidate

ipc-3-3-enforce-semvmx-limit-for-undo.patch
  ipc: enforce SEMVMX limit for undo

cleanup-of-ipc-msgc.patch
  cleanup of ipc/msg.c

sk98lin-procfs-fix.patch
  sk98lin procfs fix

cpufreq-driver-for-nforce2-kernel-267.patch
  cpufreq driver for nForce2

allow-modular-ide-pnp.patch
  allow modular ide-pnp

uml-base-patch.patch
  uml: Uml base patch

rename-uml-console-device.patch
  uml: rename console_device

uml-readds-just-for-now-ghashh-for-uml.patch
  uml: Readds (just for now) ghash.h for UML

uml-avoid-that-gcc-breaks-uml-with-unit-at-a-time-compilation-mode.patch
  uml: Avoid that gcc breaks UML with "unit at a time" compilation mode.

uml-fixes-an-host-fd-leak-caused-by-hostfs.patch
  uml: Fixes an host fd leak caused by hostfs.

uml-adds-legacy_pty-config-option.patch
  uml: Adds LEGACY_PTY config option

uml-makes-make-help-arch=um-work.patch
  uml: Makes "make help ARCH=um" work.

uml-fixes-fixdepc-to-support-arch-um-include-uml-configh.patch
  uml: Fixes "fixdep.c" to support arch/um/include/uml-config.h.

uml-kill-useless-warnings.patch
  uml: Kill useless warnings

uml-avoids-compile-failure-when-host-misses-tkill.patch
  uml: Avoids compile failure when host misses tkill().

uml-reduces-code-in-_user-files-by-moving-it-in-_kern-files-if-already-possible.patch
  uml: Reduces code in *_user files, by moving it in _kern files if already possible.

uml-fixes-raw-and-uses-it-in-check_one_sigio-also-fixes-a-silly-panic-eintr-returned-by-call.patch
  uml: Fixes raw() and uses it in check_one_sigio; also fixes a silly panic (EINTR returned by call).

uml-folds-hostaudio_userc-into-hostaudio_kernc.patch
  uml: Folds hostaudio_user.c into hostaudio_kern.c.

uml-use-ptrace_scemu-the-so-called-sysemu-to-reduce-syscall-cost.patch
  uml: Use PTRACE_SCEMU (the so-called SYSEMU) to reduce syscall cost.

uml-adds-the-nosysemu-command-line-parameter-to-disable-sysemu.patch
  uml: Adds the "nosysemu" command line parameter to disable SYSEMU

uml-adds-proc-sysemu-to-toggle-sysemu-usage.patch
  uml: Adds /proc/sysemu to toggle SYSEMU usage.

uml-fix-for-sysemu-patches.patch
  uml: Fix for sysemu patches

uml-handles-correctly-errno-==-eintr-in-lots-of-places.patch
  uml: Handles correctly errno == EINTR in lots of places.

uml-adds-some-exports.patch
  uml: Adds some exports

uml-avoids-a-panic-for-a-legal-situation.patch
  uml: Avoids a panic for a legal situation

uml-removes-dead-code-in-trap_kernc.patch
  uml: Removes dead code in trap_kern.c

uml-make-malloc-call-vmalloc-if-needed-needed-for-hostfs-on-26-host.patch
  uml: Make malloc() call vmalloc if needed. Needed for hostfs on 2.6 host.

uml-little-kmalloc.patch
  uml: little-kmalloc

uml-fix-os_process_pc-and-os_process_parent-for-corner-cases.patch
  uml: Fix os_process_pc and os_process_parent for corner cases.

uml-remove-a-group-of-unused-bh-functions.patch
  uml: remove a group of unused bh functions

fix-warnings-in-net-irda.patch
  sparse: fix warnings in net/irda/*

i810_audio-fix-the-error-path-of-resource-management.patch
  i810_audio: Fix the error path of resource management

fix-drivers-isdn-hisax-avm_pcic-build-warning-when.patch
  Fix drivers/isdn/hisax/avm_pci.c build warning when !CONFIG_ISAPNP

idr-stale-comment.patch
  idr.c: remove stale comment

bio_copy_user-cleanups.patch
  bio_copy_user() cleanups

idr-comments-updates.patch
  idr comments updates

schedule-profiling.patch
  schedule() profiling
  From: Arjan van de Ven <arjanv@redhat.com>
  Subject: Re: schedule profileing

add-a-few-might_sleep-checks.patch
  Add a few might_sleep() checks

add-a-few-might_sleep-checks-fix.patch
  add-a-few-might_sleep-checks fix

release_task-may-sleep.patch
  permit sleeping in release_task()

crc16-renaming-in-via-velocity-ethernet-driver.patch
  CRC16 renaming in VIA Velocity ethernet driver

per_cpu-per_cpu-cpu_gdt_table.patch
  percpu: cpu_gdt_table

per_cpu-per_cpu-cpu_gdt_table-fix.patch
  per_cpu-per_cpu-cpu_gdt_table-fix

per_cpu-per_cpu-init_tss.patch
  percpu: init_tss

per_cpu-per_cpu-cpu_tlbstate.patch
  percpu: cpu_tlbstate

gcc35-alps_tdlb7.c.patch
  gcc-3.5 fixes

gcc35-always-inline.patch
  gcc-3.5 fixes

gcc35-auerswald.c.patch
  gcc-3.5 fixes

gcc35-dabusb.c.patch
  gcc-3.5 fixes

gcc35-ds.c.patch
  gcc-3.5 fixes

gcc35-fixmap.h.patch
  gcc-3.5 fixes

gcc35-mtrr.h.patch
  gcc-3.5 fixes

gcc35-sonypi.patch
  gcc-3.5 fixes

gcc35-sp887x.c.patch
  gcc-3.5 fixes

gcc35-tda1004x.c.patch
  gcc-3.5 fixes

gcc35-transport.h.patch
  gcc-3.5 fixes

gcc35-ufs_fs.h.patch
  gcc-3.5 fixes

gcc35-videodev.c.patch
  gcc-3.5 fixes

gcc35-wavefront_fx.c.patch
  gcc-3.5 fixes

dev-zero-vs-hugetlb-mappings.patch
  /dev/zero vs hugetlb mappings.

hugetlbfs-private-mappings.patch
  hugetlbfs private mappings

net-kconfig-crc16-fix.patch
  net/Kconfig crc16 warning fix

preset-loops_per_jiffy-for-faster-booting.patch
  preset loops_per_jiffy for faster booting

define-inline-as-__attribute__always_inline-also-for-gcc-=-34.patch
  #define inline as __attribute__((always_inline)) also for gcc >= 3.4

gcc-34-and-broken-inlining.patch
  clean up __always_inline__ usage

handle-undefined-symbols.patch
  Fail if vmlinux contains undefined symbols

268-rc2-mm1-link-errors.patch
  put irq stacks back into bss

split-generic_file_aio_write-into-buffered-and-direct-i-o-parts.patch
  split generic_file_aio_write into buffered and direct I/O parts

radeonfb-cleanup-and-little-fixes.patch
  radeonfb: cleanup and little fixes

making-i-dhash_entries-cmdline-work-as-it-use-to.patch
  Make i/dhash_entries cmdline work as it use to.

making-i-dhash_entries-cmdline-work-as-it-use-to-fix.patch
  making-i-dhash_entries-cmdline-work-as-it-use-to-fix

rivafb-i2c-fixes.patch
  Rivafb I2C fixes

jbd-recovery-latency-fix.patch
  jbd recovery latency fix

truncate_inode_pages-latency-fix.patch
  truncate_inode_pages-latency-fix

journal_clean_checkpoint_list-latency-fix.patch
  journal_clean_checkpoint_list latency fix

journal_clean_checkpoint_list-latency-fix-fix.patch
  journal_clean_checkpoint_list-latency-fix-fix

kjournald-smp-latency-fix.patch
  kjournald-smp-latency-fix

unmap_vmas-smp-latency-fix.patch
  unmap_vmas-smp-latency-fix

__cleanup_transaction-latency-fix.patch
  __cleanup_transaction-latency-fix

prune_dcache-latency-fix.patch
  prune_dcache-latency-fix

filemap_sync-latency-fix.patch
  filemap_sync-latency-fix

slab-latency-fix.patch
  slab-latency-fix

get_user_pages-latency-fix.patch
  get_user_pages-latency-fix

oom-show_free_areas.patch
  oom-killer: call show_free_areas

send_IPI_mask_bitmask-build-fix.patch
  send_IPI_mask_bitmask() build fix

e1000-build-fix.patch
  e1000 build fix

e1000-inlining-fix.patch
  e1000 inlining fix

pty_write-latency-fix.patch
  pty_write-latency-fix

enable-all-events-for-initramfs.patch
  Enable all events for initramfs

arch-i386-kernel-smpc-gcc341-inlining-fix.patch
  arch/i386/kernel/smp.c gcc341 inlining fix

fix-menuconfig-partial-inability-to-show-help-texts.patch
  Fix menuconfig partial inability to show help texts.

was-removal-of-sync-in-panic.patch
  remove sync() from panic

move-cache_reap-out-of-timer-context.patch
  Move cache_reap out of timer context

move-cache_reap-out-of-timer-context-fix.patch
  move-cache_reap-out-of-timer-context-fix

gettimeofday-nanoseconds-patch-makes-it-possible-for-the-posix-timer.patch
  gettimeofday nanoseconds patch

quiet-down-per-zone-memory-stats.patch
  quieten down per-zone memory stats

x86-64-singlestep-through-sigreturn-system-call-2.patch
  Fix x86-64 singlestep through sigreturn system call

create-nodemask_t.patch
  Create nodemask_t

fat-kill-nls-default.patch
  FAT: kill nls default

add-ixdp2x01-board-support-to-cs89x0-driver.patch
  Add IXDP2x01 board support to CS89x0 driver

msi-stop-using-dev-bus-ops-directly-in-msic.patch
  MSI: stop using dev->bus->ops directly in msi.c

msi-msi-msi-x-api-updates.patch
  MSI: MSI/MSI-X API updates

rename-config_pci_use_vector-to-config_pci_msi.patch
  rename CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI

remove-dead-prototypes.patch
  remove dead prototypes

s390-use-include-asm-generic-dma-mapping-brokenh.patch
  s390: Use include/asm-generic/dma-mapping-broken.h

cdrom-get_last_written-fix.patch
  Subject: cdrom.c get_last_written fixup

intel8x0c-to-include-ck804-audio-support.patch
  intel8x0.c to include CK804 audio support

get_random_bytes-returns-the-same-on-every-boot.patch
  get_random_bytes() returns the same on every boot

locking-optimization-for-cache_reap.patch
  slab: locking optimization for cache_reap

b44-add-47xx-support.patch
  b44: add 47xx support

fbmon-edd-blacklist.patch
  fbcom: EDD-based blacklisting

signal-race-fix.patch
  signal handling race fix

signal-race-fix-ia64.patch
  signal-race-fix: ia64

signal-race-fix-s390.patch
  signal-race fixes for s390

signal-race-fix-s390-fix.patch
  s390 signal handling fixes

signal-race-fix-x86_64.patch
  signal-race-fixes: x86-64 support

signal-race-fix-x86_64-fix.patch
  x86_64 signal handling fix

ppc-signal-handling-fixes.patch
  ppc signal handling fixes

signal-race-fixes-sparc-sparc64.patch
  signal handling race fixes: sparc and sparc64

signal-race-fixes-ppc64.patch
  pPC64 signal race fix patch

process-aggregates.patch
  Process Aggregates (PAGG)

process-aggregates-warning-fix.patch
  process-aggregates warning fix

d_unhash-consolidation.patch
  d_unhash consolidation

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

move-pit-code-to-timer_pit.patch
  x86: move PIT code to timer_pit

move-pit-code-to-timer_pit-warning-fix.patch
  move-pit-code-to-timer_pit-warning-fix

i2o-build_99.patch
  i20 rewrite

i2o-build_99-gcc295-fixes.patch
  i2o-build_99-gcc295-fixes

i2o-resync-with-post-266-changes.patch
  i2o: resync with post-2.6.6 changes

i2o-resync-with-post-266-changes-2.patch
  i2o: more resyncing with post-2.6.6 changes

activate-smbus-device-on-hp-d300l.patch
  activate SMBus device on hp d300l

apic-output-reduction.patch
  IO-APIC debug message reduction

fix-ide-probe-double-detection.patch
  Fix ide probe double detection

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

serial-cs-and-unusable-port-size-ranges.patch
  serial-cs and unusable port size ranges

make-shrinker_sem-an-rwsem.patch
  make shrinker_sem an rwsem

vlan-support-for-3c59x-3c90x.patch
  VLAN support for 3c59x/3c90x

add-support-for-innovision-dm-8401h.patch
  Add support for Innovision DM-8401H

break-out-zone-free-list-initialization.patch
  break out zone free list initialization

fbcon-differentiate-bits_per_pixel-from-color-depth.patch
  fbcon: ifferentiate bits_per_pixel from color depth

fbcon-differentiate-bits_per_pixel-from-color-depth-fixup.patch
  fbcon-differentiate-bits_per_pixel-from-color-depth-fixup

fbcon-differentiate-bits_per_pixel-from-color-depth-export.patch
  fbcon-differentiate-bits_per_pixel-from-color-depth-export

fbdev-set-color-fields-correctly.patch
  fbdev: set color fields correctly

fbdev-attn-maintainers-set-correct-hardware-capabilities.patch
  fbdev: ATTN: Maintainers - Set correct hardware capabilities

rivafb-do-not-tap-vga-ports-if-not-x86.patch
  rivafb: Do not tap VGA ports if not X86

i810fb-fixes.patch
  i810fb fixes

i810fb-fixes-2.patch
  i810fb fixes #2

drm-optimisation.patch
  drm optimisation

maintainers-update.patch
  MAINTAINERS update

fdomain-isa-fixup.patch
  fdomain_cs ISA fix

net-smc9194c-fix-inline-compile-errors-fwd.patch
  net/smc9194.c: fix gcc-3.5 inline compile errors

net-hamachic-remove-bogus-inline-at-function-prototype.patch
  net/hamachi.c: gcc-3.5 build fixes

scsi-qla2xxx-fix-inline-compile-errors.patch
  qla2xxx gcc-3.5 fixes

net-rrunnerc-fix-inline-compile-error.patch
  net/rrunner.c: gcc-3.5 fixes

istallion-remove-inlines.patch
  istallion: gcc-3.5 fixes

mxserc-fix-inlines-fwd.patch
  mxser.c: gcc-3.5 fixes

radio-maestroc-remove-an-inline-fwd.patch
  radio-maestro.c: gcc-3.5 fixes

modular-swim3.patch
  modular swim3

modular-anscd.patch
  Fix modular anscd

jffs2_compression_options-fix.patch
  JFFS2_COMPRESSION_OPTIONS dependency fix

ppc8xx-maintainer-patch.patch
  PPC8xx Maintainer patch

ext2_readdir-filp-f_pos-fix.patch
  ext2_readdir() filp->f_pos fix

netfilter-ip_nat_snmp_basicc-fix-inlines-fwd.patch
  netfilter/ip_nat_snmp_basic.c: gcc-3.5 fixes

net-tulip-dmfec-fix-inline-compile-errors-fwd.patch
  net/tulip/dmfe.c: gcc-3.5 fixes

do_general_protection-doesnt-disable-irq.patch
  do_general_protection doesn't disable irq

jbd-jh-unmapping-race-fix.patch
  jbd-jh-unmapping-race-fix

nfs4-oops-fixes.patch
  nsf4 oops fixes

proc_pid_cmdline-race-fix.patch
  proc_pid_cmdline() race fix

support-for-exar-xr17c158-octal-uart.patch
  Support for Exar XR17C158 Octal UART

dvb-errno-removal.patch
  DVB: "errno" undefined

x86-64-merge-for-268rc2-mm1.patch
  x86-64 merge for 2.6.8rc2-mm1

ia64-swiotlb-fixes.patch
  ia64: Various swiotlb fixes

documentation-fix-for-nmi-watchdog.patch
  Documentation fix for NMI watchdog

hpet-copyrights-cleanup.patch
  HPET copyrights, cleanup

remove-outdated-reference-to-documentation-arm-sa1100-pcmcia-fwd.patch
  remove outdated reference to Documentation/arm/SA1100/PCMCIA

canonically-reference-files-in-documentation-code-comments-part.patch
  Canonically reference files in Documentation/ code comments part

altix-system-controller-communication-driver.patch
  Altix system controller communication driver

snsc-build-fix.patch
  snsc-build-fix

move-duplicate-bug-and-warn_on-bits-to-asm-generic.patch
  move duplicate BUG and WARN_ON bits to asm-generic

fix-con_buf_size-usage.patch
  Fix CON_BUF_SIZE usage

vprintk-support.patch
  vprintk support

vprintk-for-ext2-errors.patch
  vprintk for ext2 errors

vprintk-for-ext3-errors.patch
  vprintk for ext3 errors

remove-symbol_is.patch
  Remove symbol_is()

prio_tree-kill-vma_prio_tree_init.patch
  prio_tree: kill vma_prio_tree_init()

prio_tree-iterator-vma_prio_tree_next-cleanup.patch
  prio_tree: iterator + vma_prio_tree_next cleanup

rcu-cpu-offline-cleanup.patch
  RCU - cpu-offline-cleanup

rcu-rcu-cpu-offline-fix.patch
  RCU - cpu offline fix

rcu-low-latency-rcu.patch
  RCU: low latency rcu

alpha-print-the-symbol-of-pc-and-ra-during-oops.patch
  alpha: print the symbol of pc and ra during Oops

staircase-cpu-scheduler-268-rc2-mm1.patch
  Staircase cpu scheduler

first-next_cpu-returns-values-nr_cpus.patch
  first/next_cpu returns values > NR_CPUS

first-next_cpu-returns-values-nr_cpus-fix.patch
  first-next_cpu-returns-values-nr_cpus fix

add-support-for-it8212-ide-controllers.patch
  Add support for IT8212 IDE controllers

drivers-net-wan-cycx_x25c189-warning-conflicting-types.patch
  drivers/net/wan/cycx_x25.c:189: warning: conflicting types for built-in function 'log2'

watchdog-fix-warning-defined-but-not-used.patch
  watchdog: fix warning "defined but not used"

fix-pci-access-mode-dependences-in-arch-i386-kconfig.patch
  fix PCI access mode dependences in arch/i386/Kconfig

drivers-block-ubc-6.patch
  drivers/block/ub.c #6

ub-warning-fixes.patch
  ub warning fixes

i386-hotplug-cpu.patch
  i386 Hotplug CPU

token-based-thrashing-control.patch
  token based thrashing control

token-based-thrashing-control-remove-debug.patch
  token-based-thrashing-control-remove-debug

writeback-page-range-hint.patch
  Writeback page range hint

fix-writeback-page-range-to-use-exact-limits.patch
  Fix writeback page range to use exact limits

mpage-writepages-range-limit-fix.patch
  mpage writepages range limit fix

filemap_fdatawrite-range-interface.patch
  filemap_fdatawrite range interface

concurrent-o_sync-write-support.patch
  Concurrent O_SYNC write support

fix-inlining-errors-in-drivers-scsi-aic7xxx-aic79xx_osmc.patch
  inlining errors in drivers/scsi/aic7xxx/aic79xx_osm.c

fix-inline-related-gcc-34-build-failures-in.patch
  fix inline related gcc 3.4 build failures in drivers/net/wan/dscc4.c

nfsd-force-server-side-tcp-when-nfsv4-enabled.patch
  nfsd: force server-side TCP when NFSv4 enabled

nfsd-nfsd-is-missing-a-put_group_info-in-the-auth_null.patch
  nfsd: nfsd is missing a put_group_info in the auth_null

nfsd-make-cache_init-initialize-reference-count-to-1.patch
  nfsd: make cache_init initialize reference count to 1

nfsd-simplify-auth_domain_lookup.patch
  nfsd: simplify auth_domain_lookup

nfsd-fix-ip_map-cache-reference-count-leak.patch
  nfsd: fix ip_map cache reference count leak.

nfsd-basic-v4-acl-definitions.patch
  nfsd: basic v4 ACL definitions

nfsd-posix-nfsv4-acl-translation-for-nfsd.patch
  nfsd: POSIX<->NFSv4 acl translation for nfsd

nfsd-acl-support-for-the-nfsv4-server.patch
  nfsd: ACL support for the NFSv4 server

bridge-build-fix.patch
  bridge build fix




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbUB2WGn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 17:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbUB2WGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 17:06:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:26038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262165AbUB2WFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 17:05:09 -0500
Date: Sun, 29 Feb 2004 14:06:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc1-mm1
Message-Id: <20040229140617.64645e80.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm1/


- Added the POSIX message queue implementation.  We're still stitching
  together a decent description of all of this.  Reference information is at

	http://www.mat.uni.torun.pl/~wrona/posix_ipc/
 and
	http://www.opengroup.org/onlinepubs/007904975/basedefs/mqueue.h.html

- A fair amount of work against the page reclaim code.  Mainly
  reorganisation and simplification of various little glitches.  This means
  that a few of the optimisations which were in 2.6.3-mm4 were broken and
  were dropped.  But this is a better basis upon which to reintroduce them.

  Performance, however, seems similar to 2.6.3-mm4 in a few tests. 
  Inter-zone balancing is much better than 2.6.3 but still could be improved a
  little.

  Slab reclaim balancing is improved, however with some (artificial)
  workloads slab is still being a problem because of tremendous internal
  fragmentation problems: 6% occupancy of the pages which are allocated to
  dcache, for example.  More work is needed to account for this.

  I tested the swapout code with 7.2G of tmpfs pagecache on a 7G machine. 
  The rotate_reclaimable_page() logic seems to work fine here - only 200M of
  memory was added to swapcache and was swapped out.  

- Plus the usual various little fixes and cleanups.

- The contents of the broken-out/ directory are now available in the
  2.6.4-rc1-mm1-broken-out.tar.gz file.  This includes the `series' file
  which describes the patching order.

  People who are using patch-scripts can recreate the patching machinery by
  doing:

	cd /usr/src/linux
	tar xfz ~/2.6.4-rc1-mm1-broken-out.tar.gz
	mv broken-out/*.patch patches
	mv broken-out/series .
	for i in $(cat-series series)
	do
		pcpatch $i
	done
	rmdir broken-out



Changes since 2.6.3-mm4:


 linus.patch
 bk-acpi.patch
 bk-alsa.patch
 bk-arm.patch
 bk-driver-core.patch
 bk-ieee1394.patch
 bk-netdev.patch
 bk-scsi.patch
 bk-usb.patch

 Latest versions of various external trees.  bk-i2c.patch was dropped
 pending it getting its lmsensors act together.  And bk-input was dropped
 because it was old and nobody will tell me the input project's bk URL.

-nfsd-NGROUPS-fixes.patch
-kill-old-dead-netdev-apis.patch
-gcc-35-pdaudiocf_irq-build-fix.patch
-m68k-406.patch
-bk-driver-core-x86_64-build-fix.patch
-ppc64-tulip-build-fix.patch
-hfs-rewrite.patch
-hfsplus-support.patch
-knfsd-rpcsec_gss-minimal-support.patch
-knfsd-rpcsec_gss-minimal-support-NGROUPS-fix.patch
-knfsd-rpcsec_gss-minimal-support-NGROUPS-fix-2.patch
-knfsd-gss-api-integrity-checking.patch
-knfsd-IDmap-support.patch
-knfsd-nfs4-pointer-cleanup.patch
-knfsd-nfs4-locking-state-fix.patch
-knfsd-v4-exclusive-open-fix.patch
-knfsd-changeinfo-time-higher-resolution.patch
-knfsd-shareowner-fix.patch
-knfsd-replaying-fixes.patch
-knfsd-setclientid-fix.patch
-knfsd-lockowner-fix.patch
-knfsd-readdir-error-code-fix.patch
-knfsd-nfserr_nofilehandle-fix.patch
-knfsd-lookup_parent-fix.patch
-knfsd-error-code-return-fixes.patch
-knfsd-xdr-error-fix.patch
-knfsd-symlink-fixes.patch
-knfsd-lock-length-fix.patch
-knfsd-rename-error-code-fixes.patch
-knfsd-unlock-on-close-fix.patch
-knfsd-comment-fix.patch
-knfsd-fh_dup2-fix.patch
-knfsd-implement-RELEASE_LOCKOWNER.patch
-knfsd-add-OP_ILLEGAL.patch
-knfsd-OP_CREATE-fix.patch
-knfsd-OP_LOCK-check.patch
-knfsd-OP_OPEN_CONFIRM-fix.patch
-knfsd-open_downgrade-enforcement.patch
-knfsd-readlink-error-return-fix.patch
-knfsd-nfsd4_remove-error-fix.patch
-knfsd-stateid-replay-fixes.patch
-knfsd-attribute-decoding-retval-fix.patch
-knfsd-READ_BUF-cleanup.patch
-knfsd-sunrpc_init-ordering-fixes.patch
-knfsd-readdir-more-than-one-page.patch
-add-MODULE_VERSION-macro.patch
-rename-MODULE_VERSION.patch
-ide-siimage-seagate.patch
-ide-ali-UDMA6-support.patch
-fbdev-cursor-1.patch
-cursor-fix.patch
-superblock-fixes.patch
-zoran-refcounting-fixes.patch
-s390-01-general-update.patch
-s390-02-common-io-layer.patch
-s390-03-console-driver.patch
-s390-04-compat_timer_settime.patch
-s390-05-ctc-net-driver.patch
-s390-06-lcs-net-driver.patch
-s390-07-iucv-net-driver.patch
-s390-08-dasd-driver.patch
-s390-09-virtual-timer-interface.patch
-s390-10-zvm-monitor-stream.patch
-s390-11-collaborative-memory-management.patch
-s390-12-cannel-measurement-block-interface.patch
-s390-zfcp-host-adapter.patch
-s390-syscalls-h-update.patch
-s390-dcss-block-driver.patch
-ide-io-CONFIG_LBD-fix.patch
-dvb-01-update-subsystem-docs.patch
-dvb-02-update-saa7146-core.patch
-dvb-03-skystar2-updates.patch
-dvb-04-core-updates.patch
-dvb-05-frontend-updates.patch
-dvb-06-stv0299-frontend-update.patch
-dvb-07-tda1004x-update.patch
-dvb-08-av7110-update.patch
-dvb-09-ttusb-budget-update.patch
-dvb-ttusb-budget-compile-fix.patch
-n_tty-cleanup.patch
-mac-driver-config-update.patch
-request_firmware-01-class-fixes.patch
-request_firmware-02-more-class-fixes.patch
-request_firmware-03-bitmap.patch
-request_firmware-04-priv-leak-fix.patch
-request_firmware-05-release-race-fixes.patch
-request_firmware-06-cleanups.patch
-request_firmware-07-attribute-fixes.patch
-early-printk-doc-fix.patch
-radeon-config-fix-2.patch
-remove-tty-CALLOUT-defines.patch
-tdfx-remove-float.patch
-mtd-locking-fix.patch
-afs-c99-fix.patch
-remove-KERNEL_SYSCALLS-stuff.patch
-msi-kirqd-build-fix.patch
-isdn-c99-fixes.patch
-airo-c99-fixes.patch
-wanxl-c99-fixes.patch
-pci200syn-c99-fixes.patch
-irda-usb-c99-fixes.patch
-saa7146_video-c99-fixes.patch
-stv0229-c99-fixes.patch
-alps_tdlb7-c99-fixes.patch
-sp887x-c99-fixes.patch
-budget-av-c99-fixes.patch
-saa5246a-rev1-2.6.3.patch
-kbuild-add-defconfig-targets-to-make-help.patch
-wanmain-build-fix.patch
-3c505-build-fix.patch

 Merged

+move-dma_consistent_dma_mask.patch
+move-dma_consistent_dma_mask-x86_64-fix.patch

 move pci_dev.consistent_dma_mask to dev.coherent_dma_mask

+scsi-external-build-fix.patch

 Fix scsi.h for inclusion by userspace apps - it used to work, so...

+umount-dataloss-fix.patch

 Fix a rare race whch can cause umount data loss.

+ppc64-iseries-mmu-hashtable-fix.patch
+ppc64-export-numa-symbols.patch

 PPC64 stuff

+remove-sys_ioperm-stubs.patch

 Clean up syscall stubs

+readdir-cleanups.patch

 Hoist directory atime updates up to the VFS layer.

+sched-domains-improvements.patch

 CPU scheduler tuning

-vm-dont-rotate-active-list.patch
-vm-lru-info.patch
-vm-shrink-zone.patch
-vm-tune-throttle.patch
-zone-balancing-fix.patch
-zone-balancing-batching.patch
+shrink_slab-precision-fix.patch
+try_to_free_pages-shrink_slab-evenness.patch
+vmscan-total_scanned-fix.patch
+zone-balancing-fix-2.patch
+vmscan-control-by-nr_to_scan-only.patch
+vmscan-balance-zone-scanning-rates.patch
+vmscan-dont-throttle-if-zero-max_scan.patch
+kswapd-avoid-higher-zones.patch
+vmscan-throttle-later.patch
+slab-no-higher-order.patch

 Page reclaim rework

-nfs-write-throttling.patch
-nfs-mount-error-recovery.patch
+nfs-mount-fix.patch
+nfs_unlink-oops-fix.patch
+nfs-remove-XID-spinlock.patch
+nfs-misc-rpc-fixes.patch

 Reworked NFS patches

+initramfs-search-for-init.patch

 Nth version of this patch, still churning.

-expanded-pci-config-space.patch

 Drop this - it's causing problems for some people and is still churning
 somewhat.

-dm-crypt-cipher-digest.patch

 Dropped, was old.

+remove-__io_virt_debug.patch

 Clean up old debug code

+rioctrl-retval-fixes.patch

 errnos are negative

+doc-index-updates.patch

 Fix up references to internal documentation

+genrtc-cleanups.patch

 cleanup

+piix_ide_init-can-be-__init.patch

 Make a function __init

+fusion-use-min-max.patch

 Use generic min()/max()

+doc2000-warning-fixes.patch

 Fix a warning

+initrd-kconfig-dependencies.patch

 Fix initrd dependencies

+poweroff-atomicity-fix.patch

 Part-fix sysrq-o

+bio-highmem-fix.patch

 Fix BIO memory referencing

+ini9100u-build-fix.patch

 Compile fix

+dm-crypt-cleanups.patch
+dm-crypt-end_io-bv_offset-fix.patch

 dm-crypt fixes

+queue-congestion-callout.patch
+queue-congestion-dm-implementation.patch

 Make device mapper queues correctly implement the queue congestion APIs

+proc-thread-visibility-revert.patch

 Revert the /proc/<tid> "fix".

+zr36067-update.patch

 Driver update

+keyspan-c99-fixes.patch
+hisax-c99-fixes.patch
+cs46_xx-c99-fix.patch

 C99 initialiser fixes

+scsi-host-allocation-fix.patch

 First-fit allocation of scsi host indices

+i386-early-memory-cleanup.patch

 Clean up the super-early x86 memory handling code.

+raid1-bio_put-oops-fix.patch

 RAID1 oops fix.

+modular-mce-handler.patch

 permit the x86 MCE handler to be used as a module.

+LOOP_CHANGE_FD.patch

 Add a sort of pivot-backing-file for loop.

+fastcall-warning-fixes.patch

 Declaration consistency for FASTCALL

+README-update.patch

 Update the README file.

+DCSSBLK-depends-on-s390.patch

 DCSSBLK is s390-only.

+slab-warning-fix.patch

 Fix a warnnig in slab.c

+remove-more-KERNEL_SYSCALLS.patch
+remove-more-KERNEL_SYSCALLS-build-fix.patch
+remove-more-KERNEL_SYSCALLS-build-fix-2.patch

 Remove lots of the kernel-internal syscalls and just directly call
 sys_foo() instead.

+xprt_create_socket-fix.patch

 Fix an error-path bug in xprt_create_socket()

+remove-nlmclnt_grace_wait.patch

 Dead function

+tty-drivers-devfs-fix.patch

 Make all tty drivers set the devfs name.

+vt-mode-changes-fix.patch

 Fix switching between KD_GRAPHICS and KD_TEXT.

+sys_alarm-retval-fix.patch

 Fix the return value from sys_alarm().

+gcc-35-lec-fix.patch

 gcc-3.5 build fix.

+ip_rt_init-sizing-fix.patch

 Fix the sizing of the tcp and route caches.

+buslogic-sections-fix.patch

 Make a function non-__init.

+mq-01-codemove.patch
+mq-02-syscalls.patch
+mq-03-core.patch
+mq-03-core-update.patch
+mq-04-linuxext-poll.patch
+mq-05-linuxext-mount.patch

 POSIX messages queues.

+remove-make-dep-references.patch

 Comment fixes

+use-set_task_cpu-in-kthread_bind.patch

 Cleanup in kthread code.

+HPFS1-hpfs2-RC4-rc1.patch
+HPFS2-hpfs_namei-RC4-rc1.patch
+HPFS3-hpfs_iget-RC4-rc1.patch
+HPFS4-hpfs_lock_iget-RC4-rc1.patch
+HPFS5-hpfs_locking-RC4-rc1.patch
+HPFS6-hpfs_cleanup-RC4-rc1.patch
+HPFS7-hpfs_cleanup2-RC4-rc1.patch
+HPFS8-hpfs_race2-RC4-rc1.patch
+HPFS9-hpfs_deadlock-RC4-rc1.patch

 HPFS fixes

+tcp-oops-fix.patch

 Fix rare oops in TCP

+swap-config-clarity.patch

 Kconfig clarity

+powernow-k8-fix.patch

 Fix this cpufreq driver

+x86_64-update.patch

 Latest x86_64 tree

+libata-fix.patch

 SATA fix

+usb-pc-watchdog-implementation.patch

 New watchdog driver

+pdflush-use-kthread.patch

 Switch pdflush to use kthread()

+firmware-pin-module.patch
+firmware-delay-hotplug.patch

 Firmware loader updates



All 237 patches:

linus.patch

bk-acpi.patch

bk-alsa.patch

bk-arm.patch

bk-driver-core.patch

bk-ieee1394.patch

bk-netdev.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

dma_sync_for_device-cpu.patch
  dma_sync_for_{cpu,device}()

compat-signal-noarch-2004-01-29.patch
  Generic 32-bit compat for copy_siginfo_to_user

compat-generic-ipc-emulation.patch
  generic 32 bit emulation for System-V IPC

move-dma_consistent_dma_mask.patch
  move consistent_dma_mask to the generic device

move-dma_consistent_dma_mask-x86_64-fix.patch

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdb-ga-recent-gcc-fix.patch
  kgdb: fix for recent gcc

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

kgdb-THREAD_SIZE-fixes.patch
  THREAD_SIZE fixes for kgdb

scsi-external-build-fix.patch
  use __u8 in scsi.h

umount-dataloss-fix.patch
  fix umount dataloss problem

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-iseries-mmu-hashtable-fix.patch
  ppc64: fix a bug in iSeries MMU hash management

ppc64-export-numa-symbols.patch
  Add missing numa EXPORT_SYMBOLs

ppc64-reloc_hide.patch

remove-sys_ioperm-stubs.patch
  Clean up sys_ioperm stubs

readdir-cleanups.patch
  readdir() cleanups

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

support-zillions-of-scsi-disks.patch
  support many SCSI disks

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

CONFIG_SYSFS.patch
  From: Pat Mochel <mochel@osdl.org>
  Subject: [PATCH] Add CONFIG_SYSFS

CONFIG_SYSFS-boot-from-disk-fix.patch

slab-leak-detector.patch
  slab leak detector

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

sched-domains-improvements.patch
  sched domains kernbench improvements

sched-clock-fixes.patch
  fix sched_clock()

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask
  p4-clockmod sibling_map fix
  p4-clockmod: handle more than two siblings

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT
  sched: Fix CONFIG_SMT oops on UP
  sched: fix SMT + NUMA bug
  Change arch_init_sched_domains to use cpu_online_map
  Fix build with NR_CPUS > BITS_PER_LONG

sched-domain-tweak.patch
  i386-sched-domain code consolidation

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-domain-debugging.patch
  sched_domain debugging

sched-domain-balancing-improvements.patch
  scheduler domain balancing improvements

sched-group-power.patch
  sched-group-power

sched-group-power-warning-fixes.patch
  sched-group-power warning fixes

sched-domains-use-cpu_possible_map.patch
  sched_domains: use cpu_possible_map

ppc64-cpu_vm_mask-fix.patch
  ppc64: cpu_vm_mask fix

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

laptop-mode-2.patch
  laptop-mode for 2.6, version 6
  Documentation/laptop-mode.txt
  laptop-mode documentation updates
  Laptop mode documentation addition
  laptop mode simplification

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

drm-include-fix.patch

process-migration-speedup.patch
  Reduce TLB flushing during process migration

hotplugcpu-generalise-bogolock.patch
  Atomic Hotplug CPU: Generalize Bogolock

hotplugcpu-generalise-bogolock-fix-for-kthread-stop-using-signals.patch

hotplugcpu-use-bogolock-in-modules.patch
  Atomic Hotplug CPU: Use Bogolock in module.c

hotplugcpu-core.patch
  Atomic Hotplug CPU: Hotplug CPU Core

stop_machine-warning-fix.patch

hotplugcpu-core-sparc64-build-fix.patch
  hotplugcpu-core sparc64 build fix

hotplugcpu-core-fix-for-kthread-stop-using-signals.patch

migrate_to_cpu-dependency-fix.patch
  migrate_to_cpu() dependency fix

hotplugcpu-core-drain_local_pages-fix.patch
  split drain_local_pages

hotplugcpu-rcupdate-many-cpus-fix.patch
  CPU hotplug, rcupdate high NR_CPUS fix

nfs-31-attr.patch
  NFSv2/v3/v4: New attribute revalidation code

nfs-reconnect-fix.patch

nfs-mount-fix.patch
  Update to NFS mount....

nfs-d_drop-lowmem.patch
  NFS: handle nfs_fhget() error

nfs-avoid-i_size_write.patch
  NFS: avoid unlocked i_size_write()

nfs_unlink-oops-fix.patch
  nfs: fix "busy inodes after umount"

nfs-remove-XID-spinlock.patch
  nfs: Remove an unnecessary spinlock from XID generation...

nfs-misc-rpc-fixes.patch
  nfs: Misc RPC fixes...

nfs-server-in-root_server_path.patch
  Pull NFS server address out of root_server_path

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

sleep_on-needs_lock_kernel.patch
  sleep_on(): check for lock_kernel

initramfs-search-for-init.patch
  search for /init for initramfs boots

centaur-crypto-core-support.patch
  First steps toward VIA crypto support

adaptive-lazy-readahead.patch
  adaptive lazy readahead

ext3-journalled-quotas.patch
  ext3: Journalled quotas

ext3-journalled-quotas-warning-fix.patch

ext3-journalled-quotas-cleanups.patch

sysfs_remove_dir-race-fix.patch
  sysfs_remove_dir-vs-dcache_readdir race fix

sysfs_remove_subdir-dentry-leak-fix.patch
  Fix dentry refcounting in sysfs_remove_group()

per-node-rss-tracking.patch
  Track per-node RSS for NUMA

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

futex_wait-debug.patch
  futex_wait debug

module_exit-deadlock-fix.patch
  module unload deadlock fix

tulip-printk-cleanup.patch
  tulip printk cleanup

parport-01-move-exports.patch
  parport: move exports

parport-02-use-module_init.patch
  parport: use module_init() for low-level driver init

parport-03-sysctls-use-module_init.patch
  parport: use module_init() for sysctl registration

parport-04-move-option-parsing.patch
  parport: move parport_pc option parsing

parport-irq-warning-fix.patch
  parport warning fixes

parport-05-parport_pc_probe_port-fixes.patch
  parport: sanitize parport_pc_probe_port()

parport-06-refcounting-fixes.patch
  parport: refcounting fixes

parport-07-unregister-fixes.patch
  parport: parport_unregister_port() splitups abd fixes

parport-08-parport_announce-cleanups.patch
  parport: parport_announce_port() cleanup

parport-09-track-used-ports.patch
  parport: parport_pc(): keep track of ports

parport-09-track-used-ports-fix.patch

parport-10-sunbpp-track-ports.patch
  parport: parport_sunbpp(): keep track of ports

parport-11-remove-parport_enumerate.patch
  parport: remove parport_enumerate()

parport-12-driver-list-cleanup.patch
  parport: use list.h for driver list

hitachi-scsi_devinfo-fix.patch
  Add Hitachi 9960 Storage on SCSI devlist as BLIST_SPARSELUN|BLIST_LARGELUN

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

ext3-dirty-debug-patch.patch
  ext3 debug patch

ufs2-01.patch
  read-only support for UFS2

ide-scsi-error-handling-fixes.patch
  ide-scsi error handling fixes

fb_console_init-fix.patch
  fb_console_init fix

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

zwane-is-floppy-maintainer-now.patch
  floppy oops fix(?)

pcmcia-debugging-rework-1.patch
  Overhaul PCMCIA debugging (1)

cs_err-compile-fix.patch
  pcmcia: workaround for gcc-2.95 bug in cs_err()

pcmcia-debugging-rework-2.patch
  Overhaul PCMCIA debugging (2)

distribute-early-allocations-across-nodes.patch
  Manfred's patch to distribute boot allocations across nodes

time-interpolator-fix.patch
  time interpolator fix

kmsg-nonblock.patch
  teach /proc/kmsg about O_NONBLOCK

mixart-build-fix.patch
  CONFIG_SND_MIXART doesn't compile

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

remove-__io_virt_debug.patch
  remove __io_virt_debug

rioctrl-retval-fixes.patch
  char/rio/rioctrl: fix ioctl return values

doc-index-updates.patch
  Doc/00-index additions

genrtc-cleanups.patch
  genrtc: cleanups

piix_ide_init-can-be-__init.patch
  piix_ide_init can be __init

fusion-use-min-max.patch
  message/fusion: use kernel min/max

doc2000-warning-fixes.patch
  mtd/doc200x: warning fixes

initrd-kconfig-dependencies.patch
  Fix initrd Kconfig dependencies

poweroff-atomicity-fix.patch
  sysrq-o atomicity fix

bio-highmem-fix.patch
  fix small highmem bio bounce bvec handling glitch

ini9100u-build-fix.patch
  ini9100u build fix

move-scatterwalk-functions-to-own-file.patch
  move scatterwalk functions to own file

in-place-encryption-fix.patch
  fix in-place de/encryption bug with highmem

dm-crypt-cleanups.patch
  dm-crypt cleanups

dm-crypt-end_io-bv_offset-fix.patch
  dm-crypt end_io bv_offset fix

queue-congestion-callout.patch
  Add queue congestion callout

queue-congestion-dm-implementation.patch
  Implement queue congestion callout for device mapper

proc-thread-visibility-revert.patch
  revert the /proc thread visibility fix

zr36067-update.patch
  zr36067 driver update

keyspan-c99-fixes.patch
  C99 initializers for drivers/usb/serial/keyspan.h

hisax-c99-fixes.patch
  C99 initiailzers for drivers/isdn/hisax/hisax_fcpcipnp.c

scsi-host-allocation-fix.patch
  SCSI host num allocation improvement

i386-early-memory-cleanup.patch
  i386 very early memory detection cleanup patch

raid1-bio_put-oops-fix.patch
  raid1: fix oops in bio_put()

modular-mce-handler.patch
  Allow X86_MCE_NONFATAL to be a module

LOOP_CHANGE_FD.patch
  LOOP_CHANGE_FD ioctl

fastcall-warning-fixes.patch
  fastcall / regparm fixes

README-update.patch
  linux/README update

DCSSBLK-depends-on-s390.patch
  DCSSBLK depends on CONFIG_S390

slab-warning-fix.patch
  mm/slab.c warning in cache_alloc_debugcheck_after

cs46_xx-c99-fix.patch
  c99 initializers for cs46xx_wrapper

remove-more-KERNEL_SYSCALLS.patch
  further __KERNEL_SYSCALLS__ removal

remove-more-KERNEL_SYSCALLS-build-fix.patch
  build fix for remove-more-KERNEL_SYSCALLS.patch

remove-more-KERNEL_SYSCALLS-build-fix-2.patch
  fix the build for remove-more-KERNEL_SYSCALLS

xprt_create_socket-fix.patch
  NFS SUNRPC fix

remove-nlmclnt_grace_wait.patch
  kill a dead function in lockd

tty-drivers-devfs-fix.patch
  Fix tty drivers which dont set tty_driver->devfs_name

vt-mode-changes-fix.patch
  Fix VT mode change vs. fbcon

sys_alarm-retval-fix.patch
  sys_alarm() return value fix

gcc-35-lec-fix.patch
  gcc-3.5 fix for net/atm/lec.c

ip_rt_init-sizing-fix.patch
  Fix network hashtable sizing

buslogic-sections-fix.patch
  buslogic initsection fix

mq-01-codemove.patch
  posix message queues: code move

mq-02-syscalls.patch
  posix message queues: syscall stubs

mq-03-core.patch
  posix message queues: implementation

mq-03-core-update.patch
  posix message queues: update to core patch

mq-04-linuxext-poll.patch
  posix message queues: linux-specific poll extension

mq-05-linuxext-mount.patch
  posix message queues: made user mountable

remove-make-dep-references.patch
  remove a few remaining "make dep" references

use-set_task_cpu-in-kthread_bind.patch
  use set_task_cpu() in kthread_bind()

HPFS1-hpfs2-RC4-rc1.patch

HPFS2-hpfs_namei-RC4-rc1.patch

HPFS3-hpfs_iget-RC4-rc1.patch

HPFS4-hpfs_lock_iget-RC4-rc1.patch

HPFS5-hpfs_locking-RC4-rc1.patch

HPFS6-hpfs_cleanup-RC4-rc1.patch

HPFS7-hpfs_cleanup2-RC4-rc1.patch

HPFS8-hpfs_race2-RC4-rc1.patch

HPFS9-hpfs_deadlock-RC4-rc1.patch

tcp-oops-fix.patch
  TCP oopser fix

swap-config-clarity.patch
  clarify CONFIG_SWAP Kconfig help

powernow-k8-fix.patch
  Make powernow-k8 cpufreq control work again

x86_64-update.patch
  x86-64 fixes for 2.6.4rc1

libata-fix.patch
  2.6.x libata fix

usb-pc-watchdog-implementation.patch
  pcwd_usb watchdog implementation

pdflush-use-kthread.patch
  convert pdflush to kthread

firmware-pin-module.patch
  firmware loader: pin firmware module

firmware-delay-hotplug.patch
  firmware loader: delay firmware hotplug event

instrument-highmem-page-reclaim.patch
  vm: per-zone vmscan instrumentation

blk_congestion_wait-return-remaining.patch
  return remaining jiffies from blk_congestion_wait()

vmscan-remove-priority.patch
  mm/vmscan.c: remove unused priority argument.

kswapd-throttling-fixes.patch
  kswapd throttling fixes

vm-refill_inactive-preserve-referenced.patch
  vmscan: preserve page referenced info in refill_inactive()

shrink_slab-precision-fix.patch
  shrink_slab: math precision fix

try_to_free_pages-shrink_slab-evenness.patch
  vm: shrink slab evenly in try_to_free_pages()

vmscan-total_scanned-fix.patch
  vmscan: fix calculation of number of pages scanned

shrink_slab-for-all-zones-2.patch
  vm: scan slab in response to highmem scanning

zone-balancing-fix-2.patch
  vmscan: zone balancing fix

vmscan-control-by-nr_to_scan-only.patch
  vmscan: drive everything via nr_to_scan

vmscan-balance-zone-scanning-rates.patch
  Balance inter-zone scan rates

vmscan-dont-throttle-if-zero-max_scan.patch
  vmscan: avoid bogus throttling

kswapd-avoid-higher-zones.patch
  kswapd: avoid unnecessary reclaiming from higher zones

vmscan-throttle-later.patch
  vmscan: less throttling of page allocators and kswapd

slab-no-higher-order.patch
  slab: avoid higher-order allocations

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

ia64-lockmeter-fix.patch

lockmeter-2.2-cruft.patch
  lockmeter.h: remove kernel 2.2 #ifdef (i386 + alpha)

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
  4G/4G might_sleep warning fix
  4g/4g pagetable accounting fix
  Fix 4G/4G and WP test lockup
  4G/4G KERNEL_DS usercopy again
  Fix 4G/4G X11/vm86 oops
  Fix 4G/4G athlon triplefault
  4g4g SEP fix
  Fix 4G/4G split fix for pre-pentiumII machines
  4g/4g PAE ACPI low mappings fix
  zap_low_mappings() cannot be __init
  4g/4g: remove printk at boot

4g4g-THREAD_SIZE-fixes.patch

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

ppc-fixes.patch
  make mm4 compile on ppc

O_DIRECT-race-fixes-rollup.patch
  O_DIRECT data exposure fixes

O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
  Fix race between ll_rw_block() and block_write_full_page()

blockdev-direct-io-speedup.patch
  blockdev direct-io speedups

O_DIRECT-vs-buffered-fix.patch
  Fix O_DIRECT-vs-buffered data exposure bug

O_DIRECT-vs-buffered-fix-pdflush-hang-fix.patch
  pdflush hang fix

serialise-writeback-fdatawait.patch
  serialize_writeback_fdatawait patch

dio-aio-fixes.patch
  direct-io AIO fixes

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUCIUJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbUCIUJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:09:44 -0500
Received: from mail02.hansenet.de ([213.191.73.62]:58853 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S262119AbUCIUH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:07:28 -0500
From: Malte =?iso-8859-1?q?Schr=F6der?= <Malte.Schroeder@hanse.net>
Reply-To: MalteSch@gmx.de
To: linux-kernel@vger.kernel.org
Subject: [BUG] in generic.c, unloading alsa [Re: 2.6.4-rc2-mm1]
Date: Tue, 9 Mar 2004 21:07:04 +0100
User-Agent: KMail/1.6.1
References: <20040307223221.0f2db02e.akpm@osdl.org>
In-Reply-To: <20040307223221.0f2db02e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_tPiTAZN3oCiCXG9";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403092107.09881.Malte.Schroeder@hanse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_tPiTAZN3oCiCXG9
Content-Type: multipart/mixed;
  boundary="Boundary-01=_oPiTAPfzQ0EokeW"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_oPiTAPfzQ0EokeW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, by trying to unload alsa (emu10k1) I get the following:

=2D-----------[ cut here ]------------
kernel BUG at fs/proc/generic.c:664!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c0187be9>]    Not tainted VLI
EFLAGS: 00010286
EIP is at remove_proc_entry+0xe9/0x140
eax: f3209cc0   ebx: f3fb85f0   ecx: f63d2140   edx: f7fece00
esi: 00000005   edi: f375a140   ebp: 00000000   esp: f42ffe70
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1835, threadinfo=3Df42fe000 task=3Df23b7150)
Stack: f375a140 f375a188 f375a140 f3209dc0 f375a188 f9ada470 f375a240 00000=
080
       f9acfa7b f375a188 f3fb85c0 f74abe00 f74abe00 f9acf5b1 f375a240 f3fb8=
5c0
       f42fe000 f9acddcf f74abe00 00000002 f22989c0 c0171bde f7ff7b2c f2298=
9c0
Call Trace:
 [<f9acfa7b>] snd_info_unregister+0x3b/0x70 [snd]
 [<f9acf5b1>] snd_info_card_free+0x31/0x60 [snd]
 [<f9acddcf>] snd_card_free+0xef/0x230 [snd]
 [<c0171bde>] destroy_inode+0x4e/0x50
 [<c016fca2>] dput+0x22/0x270
 [<f9b5e3a9>] snd_card_emu10k1_remove+0x19/0x30 [snd_emu10k1]
 [<c01f1f8b>] pci_device_remove+0x3b/0x40
 [<c0235394>] device_release_driver+0x64/0x70
 [<c02353c0>] driver_detach+0x20/0x30
 [<c02355ed>] bus_remove_driver+0x3d/0x80
 [<c0235a03>] driver_unregister+0x13/0x28
 [<c01f2166>] pci_unregister_driver+0x16/0x30
 [<f9b6d2ef>] alsa_card_emu10k1_exit+0xf/0x35 [snd_emu10k1]
 [<c013685c>] sys_delete_module+0x13c/0x190
 [<c02f7bf2>] sysenter_past_esp+0x43/0x65
=20
Code: 01 00 00 00 89 44 24 0c 8b 47 04 89 44 24 08 8b 44 24 28 8b 40 04 c7 =
04=20
24 c0 c4 31 c0 89 44 24 04 e8 ac a7 f9 ff e9 77 ff ff ff <0f> 0b 98 02 68 9=
e=20
31 c0 eb b4 8b 44 24 28 66 ff 48 0a eb 86 8d

My kernel-config is attached.

On Monday 08 March 2004 07:32, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc2/2=
=2E6
>.4-rc2-mm1/
>
>
> - Added Jens's patch which teaches the kernel to use DMA when reading
>   audio from IDE CDROM drives.  These devices tend to be flakey, and we
>   need lots of testing please.
>
> - Re-added the device mapper update
>
> - Brought back Ingo's patch which permits remap_file_pages() to set the
>   memory access permissions on a per-page basis.  This is mainly
> interesting for its very significant performance benefits to UML.
>
>   Breaks the build on most architectures.  There are how-to-fix-it
>   instructions in the changelog.
>
> - A new version of the patch which permits ext3 quota updates to be fully
>   journalled.
>
>
>
>
> Changes since 2.6.4-rc1-mm2:
>
>
>  linus.patch
>  bk-acpi.patch
>  bk-alsa.patch
>  bk-input.patch
>  bk-netdev.patch
>  bk-scsi.patch
>  bk-usb.patch
>
>  Latest external trees
>
> -fastcall-warning-fixes.patch
> -fastcall-warning-fixes-2.patch
> -ppc64-xmon-survival-fix.patch
> -put_compat_timespec-prototype-fix.patch
> -sparc-sys_ioperm-fix.patch
> -support-zillions-of-scsi-disks.patch
> -tulip-printk-cleanup.patch
> -parport-01-move-exports.patch
> -parport-02-use-module_init.patch
> -parport-03-sysctls-use-module_init.patch
> -parport-04-move-option-parsing.patch
> -parport-irq-warning-fix.patch
> -parport-05-parport_pc_probe_port-fixes.patch
> -parport-06-refcounting-fixes.patch
> -parport-07-unregister-fixes.patch
> -parport-08-parport_announce-cleanups.patch
> -parport-09-track-used-ports.patch
> -parport-09-track-used-ports-fix.patch
> -parport-10-sunbpp-track-ports.patch
> -parport-11-remove-parport_enumerate.patch
> -parport-12-driver-list-cleanup.patch
> -hitachi-scsi_devinfo-fix.patch
> -zwane-is-floppy-maintainer-now.patch
> -rioctrl-retval-fixes.patch
> -initrd-kconfig-dependencies.patch
> -queue-congestion-callout.patch
> -queue-congestion-dm-implementation.patch
> -cs46_xx-c99-fix.patch
> -remove-nlmclnt_grace_wait.patch
> -HPFS3-hpfs_iget-RC4-rc1.patch
> -HPFS4-hpfs_lock_iget-RC4-rc1.patch
> -HPFS5-hpfs_locking-RC4-rc1.patch
> -HPFS6-hpfs_cleanup-RC4-rc1.patch
> -HPFS7-hpfs_cleanup2-RC4-rc1.patch
> -HPFS8-hpfs_race2-RC4-rc1.patch
> -HPFS9-hpfs_deadlock-RC4-rc1.patch
> -HPFS10-fix-RC4-rc1.patch
> -alpha-switch-semaphores.patch
> -serial_core-build-fix.patch
> -sb16-sample-size-fix.patch
> -ext2-ext3-ENOSPC-fix.patch
> -missing-MODULE_LICENSEs.patch
> -v4l1-compatibility-module-fix.patch
> -i2o-fixes.patch
>
>  Merged
>
> +move-dma_consistent_dma_mask-sn-fix.patch
>
>  Fix move-dma_consistent_dma_mask.patch for SN platforms
>
> +export-filemap_flush.patch
>
>  XFS needs this symbol.
>
> +vma-corruption-fix.patch
>
>  Fix nasty memory management race.
>
> -ext3-journalled-quotas.patch
> -ext3-journalled-quotas-warning-fix.patch
> -ext3-journalled-quotas-cleanups.patch
> +ext3-journalled-quotas-2.patch
>
>  New journal-quotas-on-ext3 patch.
>
> +sched-smt-nice-optimisation.patch
>
>  CPU scheduler tuneup for SMT hardware.
>
> +ide-scsi-error-handling-update.patch
>
>  Update to ide-scsi-error-handling-fixes.patch
>
> -doc2000-warning-fixes.patch
>
>  Dropped - this driver is otherwise broken.
>
> -scsi-host-allocation-fix.patch
>
>  A perfectly good patch dropped :( Apparently it will expose races in
>  userspace's handling of the existing /proc API's.
>
> -remove-more-KERNEL_SYSCALLS-build-fix.patch
> -remove-more-KERNEL_SYSCALLS-build-fix-2.patch
>
>  Folded into remove-more-KERNEL_SYSCALLS.patch
>
> +mq-security-fix.patch
>
>  POSIX message queue fix
>
> +dm-01-endio-method.patch
> +dm-03-list_for_each_entry-audit.patch
> +dm-04-default-queue-limits-fix.patch
> +dm-05-list-targets-command.patch
> +dm-06-stripe-width-fix.patch
>
>  Device Mapper update
>
> +dm-maplock.patch
>
>  Add an rwlock to the device mapper maptable management so that
>  +queue-congestion-dm-implementation.patch does not try to take a semapho=
re
>  inside a spinlock.
>
> -blk-unplug-when-max-request-queued.patch
>
>  This was buggy, and is hard to fix.
>
> -pdc_202xx_old-update.patch
>
>  This broke, and was a duplicate of other IDE patches.  I think.  It got
>  very confusing in there.
>
> +cdromaudio-use-dma.patch
>
>  Use IDE DMA for reading audio CDROMs
>
> +sysfs-pin-kobject.patch
>
>  I was asked to bring back this sysfs race fix.
>
> +ATI-IXP-IDE-support.patch
>
>  ATI IXP IDE support
>
> +ipmi-updates-3.patch
> +ipmi-socket-interface.patch
>
>  IPMI driver updates
>
> +md-use-schedule_timeout.patch
>
>  Don't use yield() in the RAID drivers
>
> +md-array-assembly-fix.patch
>
>  RAID fix
>
> +compiler_h-scope-fixes.patch
>
>  Header file fix
>
> +remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch
>
>  Per-page permissions for remap_file_pages()
>
> +nmi_watchdog-local-apic-fix.patch
> +nmi-1-hz.patch
>
>  NMI watchdog fixes
>
> +elf-mmap-fix.patch
>
>  Don't hardwire the mmap size.
>
> +kbuild-more-cleaning.patch
>
>  Make `make clean' delete more things
>
> +loop-setup-race-fix.patch
>
>  Loop race fix.
>
> +handle-dot-o-paths.patch
>
>  kbuild pathname fix
>
> +acpi-asmlinkage-fix.patch
>
>  ACPI build fix for current gcc
>
> +ipc-sem-extra-sem_unlock.patch
>
>  Missing unlock in the IPC code.
>
> +procfs-dangling-subdir-fix.patch
>
>  Trap buggy /proc users
>
> +AMD-768MPX-bootmem-fix.patch
>
>  "works around the infamous "only works stable when a mouse is plugged in"
>  problem some AMD 768MPX Dual Athlon chipsets have"
>
> +i810fb-on-x86_64.patch
>
>  Enable i810fb on x86_64
>
> +ext23-remove-acl-limits.patch
>
>  ACL uture-proofness
>
> +watchdog-moduleparam-patches.patch
>
>  Watchdog driver module parameter updates
>
> +amd-elan-fix.patch
>
>  Conig fix for AMD ELAN.
>
> +pcmcia-netdev-ordering-fixes.patch
>
>  Attempt to fix some ordering problems with PCMCIA netdevices.
>
> -shrink-inode-cache-harder.patch
>
>  Drop this - it was entirely too speculative and might actually slow thin=
gs
>  down.
>
> +4g4g-handle_BUG-fix.patch
>
>  Fix the handling of BUG()s when using the 4:4 split.
>
> +ppc-fixes-dependency-fix.patch
>
>  Make dependency fix
>
> +restore-writeback-trylock.patch
>
>  More fiddling with the writebakc locking for the O_DIRECT-vs-buffered
>  problem.  Am getting a bit tired of this problem.
>
> +aio-direct-io-oops-fix.patch
>
>  Fix an AIO oops due to aio-fallback-bio_count-race-fix-2.patch
>
>
>
>
>
> All 232 patches:
>
>
> linus.patch
>
> bk-acpi.patch
>
> bk-alsa.patch
>
> bk-input.patch
>
> bk-netdev.patch
>
> bk-scsi.patch
>
> bk-usb.patch
>
> mm.patch
>   add -mmN to EXTRAVERSION
>
> dma_sync_for_device-cpu.patch
>   dma_sync_for_{cpu,device}()
>
> move-dma_consistent_dma_mask.patch
>   move consistent_dma_mask to the generic device
>
> move-dma_consistent_dma_mask-x86_64-fix.patch
>
> move-dma_consistent_dma_mask-sn-fix.patch
>   Fix dma_mask patch for sn platform
>
> kgdb-ga.patch
>   kgdb stub for ia32 (George Anzinger's one)
>   kgdbL warning fix
>   kgdb buffer overflow fix
>   kgdbL warning fix
>   kgdb: CONFIG_DEBUG_INFO fix
>   x86_64 fixes
>   correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
>
> kgdb-ga-recent-gcc-fix.patch
>   kgdb: fix for recent gcc
>
> kgdboe-netpoll.patch
>   kgdb-over-ethernet via netpoll
>
> kgdboe-non-ia32-build-fix.patch
>
> kgdb-warning-fixes.patch
>   kgdb warning fixes
>
> kgdb-x86_64-support.patch
>   kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
>
> kgdb-THREAD_SIZE-fixes.patch
>   THREAD_SIZE fixes for kgdb
>
> export-filemap_flush.patch
>   export filemap_flush() to modules
>
> vma-corruption-fix.patch
>   vma corruption fix
>
> must-fix.patch
>   must fix lists update
>   must fix list update
>   mustfix update
>
> must-fix-update-5.patch
>   must-fix update
>
> ppc64-reloc_hide.patch
>
> compat-signal-noarch-2004-01-29.patch
>   Generic 32-bit compat for copy_siginfo_to_user
>
> compat-generic-ipc-emulation.patch
>   generic 32 bit emulation for System-V IPC
>
> remove-sys_ioperm-stubs.patch
>   Clean up sys_ioperm stubs
>
> readdir-cleanups.patch
>   readdir() cleanups
>
> ext3-journalled-quotas-2.patch
>   ext3: journalled quota
>
> invalidate_inodes-speedup.patch
>   invalidate_inodes speedup
>   more invalidate_inodes speedup fixes
>
> cfq-4.patch
>   CFQ io scheduler
>   CFQ fixes
>
> config_spinline.patch
>   uninline spinlocks for profiling accuracy.
>
> pdflush-diag.patch
>
> zap_page_range-debug.patch
>   zap_page_range() debug
>
> get_user_pages-handle-VM_IO.patch
>   fix get_user_pages() against mappings of /dev/mem
>
> pci_set_power_state-might-sleep.patch
>
> CONFIG_STANDALONE-default-to-n.patch
>   Make CONFIG_STANDALONE default to N
>
> extra-buffer-diags.patch
>
> CONFIG_SYSFS.patch
>   From: Pat Mochel <mochel@osdl.org>
>   Subject: [PATCH] Add CONFIG_SYSFS
>
> CONFIG_SYSFS-boot-from-disk-fix.patch
>
> slab-leak-detector.patch
>   slab leak detector
>   mm/slab.c warning in cache_alloc_debugcheck_after
>
> scale-nr_requests.patch
>   scale nr_requests with TCQ depth
>
> truncate_inode_pages-check.patch
>
> local_bh_enable-warning-fix.patch
>
> sched-find_busiest_node-resolution-fix.patch
>   sched: improved resolution in find_busiest_node
>
> sched-domains.patch
>   sched: scheduler domain support
>   sched: fix for NR_CPUS > BITS_PER_LONG
>   sched: clarify find_busiest_group
>   sched: find_busiest_group arithmetic fix
>
> sched-domains-improvements.patch
>   sched domains kernbench improvements
>
> sched-clock-fixes.patch
>   fix sched_clock()
>
> sched-sibling-map-to-cpumask.patch
>   sched: cpu_sibling_map to cpu_mask
>   p4-clockmod sibling_map fix
>   p4-clockmod: handle more than two siblings
>
> sched-domains-i386-ht.patch
>   sched: implement domains for i386 HT
>   sched: Fix CONFIG_SMT oops on UP
>   sched: fix SMT + NUMA bug
>   Change arch_init_sched_domains to use cpu_online_map
>   Fix build with NR_CPUS > BITS_PER_LONG
>
> sched-domain-tweak.patch
>   i386-sched-domain code consolidation
>
> sched-no-drop-balance.patch
>   sched: handle inter-CPU jiffies skew
>
> sched-directed-migration.patch
>   sched_balance_exec(): don't fiddle with the cpus_allowed mask
>
> sched-domain-debugging.patch
>   sched_domain debugging
>
> sched-domain-balancing-improvements.patch
>   scheduler domain balancing improvements
>
> sched-group-power.patch
>   sched-group-power
>   sched-group-power warning fixes
>
> sched-domains-use-cpu_possible_map.patch
>   sched_domains: use cpu_possible_map
>
> sched-smt-nice-handling.patch
>   sched: SMT niceness handling
>
> sched-smt-nice-optimisation.patch
>   sched: SMT-ice optimisation
>
> fa311-mac-address-fix.patch
>   wrong mac address with netgear FA311 ethernet card
>
> laptop-mode-2.patch
>   laptop-mode for 2.6, version 6
>   Documentation/laptop-mode.txt
>   laptop-mode documentation updates
>   Laptop mode documentation addition
>   laptop mode simplification
>
> pid_max-fix.patch
>   Bug when setting pid_max > 32k
>
> use-soft-float.patch
>   Use -msoft-float
>
> DRM-cvs-update.patch
>   DRM cvs update
>
> drm-include-fix.patch
>
> process-migration-speedup.patch
>   Reduce TLB flushing during process migration
>
> hotplugcpu-generalise-bogolock.patch
>   Atomic Hotplug CPU: Generalize Bogolock
>
> hotplugcpu-generalise-bogolock-fix-for-kthread-stop-using-signals.patch
>
> hotplugcpu-use-bogolock-in-modules.patch
>   Atomic Hotplug CPU: Use Bogolock in module.c
>
> hotplugcpu-core.patch
>   Atomic Hotplug CPU: Hotplug CPU Core
>
> stop_machine-warning-fix.patch
>
> hotplugcpu-core-sparc64-build-fix.patch
>   hotplugcpu-core sparc64 build fix
>
> hotplugcpu-core-fix-for-kthread-stop-using-signals.patch
>
> migrate_to_cpu-dependency-fix.patch
>   migrate_to_cpu() dependency fix
>
> hotplugcpu-core-drain_local_pages-fix.patch
>   split drain_local_pages
>
> hotplugcpu-rcupdate-many-cpus-fix.patch
>   CPU hotplug, rcupdate high NR_CPUS fix
>
> nfs-31-attr.patch
>   NFSv2/v3/v4: New attribute revalidation code
>
> nfs-reconnect-fix.patch
>
> nfs-mount-fix.patch
>   Update to NFS mount....
>
> nfs-d_drop-lowmem.patch
>   NFS: handle nfs_fhget() error
>
> nfs-avoid-i_size_write.patch
>   NFS: avoid unlocked i_size_write()
>
> nfs_unlink-oops-fix.patch
>   nfs: fix "busy inodes after umount"
>
> nfs-remove-XID-spinlock.patch
>   nfs: Remove an unnecessary spinlock from XID generation...
>
> nfs-misc-rpc-fixes.patch
>   nfs: Misc RPC fixes...
>
> nfs-improved-writeback-strategy.patch
>   nfs: improve writeback caching
>
> nfs-simplify-config-options.patch
>   nfs: simplify client configuration options.
>
> nfs-fix-msync.patch
>   nfs: fix msync()
>
> nfs-mount-return-useful-errors.patch
>   nfs: make mount command return more useful errors
>
> nfs-misc-minor-fixes.patch
>   nfs: misc minor fixes
>
> nfs-lockd-sync-01.patch
>   nfs: sync lockd to 2.4.x
>
> nfs-lockd-sync-02.patch
>   nfs: sync lockd to 2.4.x
>
> nfs-lockd-sync-03.patch
>   nfs: sync lockd to 2.4.x
>
> nfs-lockd-sync-04.patch
>   nfs: sync lockd to 2.4.x
>
> nfs-rpc-remove-redundant-memset.patch
>   nfs: remove unnecessary memset() in RPC
>
> nfs-tunable-rpc-slot-table.patch
>   nfs: make the RPC slot table size a tunable value.
>
> nfs-short-read-fix.patch
>   nfs: fix an NFSv2 read bug
>
> nfs-server-in-root_server_path.patch
>   Pull NFS server address out of root_server_path
>
> non-readable-binaries.patch
>   Handle non-readable binfmt_misc executables
>
> binfmt_misc-credentials.patch
>   binfmt_misc: improve calaulation of interpreter's credentials
>
> initramfs-search-for-init.patch
>   search for /init for initramfs boots
>
> centaur-crypto-core-support.patch
>   First steps toward VIA crypto support
>
> adaptive-lazy-readahead.patch
>   adaptive lazy readahead
>
> sysfs_remove_dir-race-fix.patch
>   sysfs_remove_dir-vs-dcache_readdir race fix
>
> sysfs_remove_subdir-dentry-leak-fix.patch
>   Fix dentry refcounting in sysfs_remove_group()
>
> per-node-rss-tracking.patch
>   Track per-node RSS for NUMA
>
> aic7xxx-deadlock-fix.patch
>   aic7xxx deadlock fix
>
> futex_wait-debug.patch
>   futex_wait debug
>
> module_exit-deadlock-fix.patch
>   module unload deadlock fix
>
> selinux-inode-race-trap.patch
>   Try to diagnose Bug 2153
>
> ext3-dirty-debug-patch.patch
>   ext3 debug patch
>
> ufs2-01.patch
>   read-only support for UFS2
>
> ide-scsi-error-handling-fixes.patch
>   ide-scsi error handling fixes
>
> ide-scsi-error-handling-update.patch
>   ide-scsi error handler update
>
> fb_console_init-fix.patch
>   fb_console_init fix
>
> poll-select-longer-timeouts.patch
>   poll()/select(): support longer timeouts
>
> poll-select-range-check-fix.patch
>   poll()/select() range checking fix
>
> poll-select-handle-large-timeouts.patch
>   poll()/select(): handle long timeouts
>
> pcmcia-debugging-rework-1.patch
>   Overhaul PCMCIA debugging (1)
>
> cs_err-compile-fix.patch
>   pcmcia: workaround for gcc-2.95 bug in cs_err()
>
> pcmcia-debugging-rework-2.patch
>   Overhaul PCMCIA debugging (2)
>
> distribute-early-allocations-across-nodes.patch
>   Manfred's patch to distribute boot allocations across nodes
>
> time-interpolator-fix.patch
>   time interpolator fix
>
> kmsg-nonblock.patch
>   teach /proc/kmsg about O_NONBLOCK
>
> mixart-build-fix.patch
>   CONFIG_SND_MIXART doesn't compile
>
> add-a-slab-for-ethernet.patch
>   Add a kmalloc slab for ethernet packets
>
> remove-__io_virt_debug.patch
>   remove __io_virt_debug
>
> genrtc-cleanups.patch
>   genrtc: cleanups
>
> piix_ide_init-can-be-__init.patch
>   piix_ide_init can be __init
>
> fusion-use-min-max.patch
>   message/fusion: use kernel min/max
>
> i386-early-memory-cleanup.patch
>   i386 very early memory detection cleanup patch
>
> modular-mce-handler.patch
>   Allow X86_MCE_NONFATAL to be a module
>
> remove-more-KERNEL_SYSCALLS.patch
>   further __KERNEL_SYSCALLS__ removal
>   build fix for remove-more-KERNEL_SYSCALLS.patch
>   fix the build for remove-more-KERNEL_SYSCALLS
>
> mq-01-codemove.patch
>   posix message queues: code move
>
> mq-02-syscalls.patch
>   posix message queues: syscall stubs
>
> mq-03-core.patch
>   posix message queues: implementation
>
> mq-03-core-update.patch
>   posix message queues: update to core patch
>
> mq-04-linuxext-poll.patch
>   posix message queues: linux-specific poll extension
>
> mq-05-linuxext-mount.patch
>   posix message queues: made user mountable
>
> mq-update-01.patch
>   posix message queue update
>
> mq-security-fix.patch
>   security bugfix for mqueue
>
> dm-01-endio-method.patch
>   dm: endio method
>
> dm-03-list_for_each_entry-audit.patch
>   dm: list_for_each_entry audit
>
> dm-04-default-queue-limits-fix.patch
>   dm: default queue limits
>
> dm-05-list-targets-command.patch
>   dm: list targets cmd
>
> dm-06-stripe-width-fix.patch
>   dm: stripe width fix
>
> queue-congestion-callout.patch
>   Add queue congestion callout
>
> queue-congestion-dm-implementation.patch
>   Implement queue congestion callout for device mapper
>
> dm-maplock.patch
>   devicemapper: use rwlock for map alterations
>
> use-wait_task_inactive-in-kthread_bind.patch
>   use wait_task_inactive() in kthread_bind()
>
> HPFS1-hpfs2-RC4-rc1.patch
>
> HPFS2-hpfs_namei-RC4-rc1.patch
>
> selinux-cleanup-binary-mount-data.patch
>   selinux: clean up binary mount data
>
> udffs-update.patch
>   UDF filesystem update
>
> kbuild-redundant-CFLAGS.patch
>   kbuild: Remove CFLAGS assignment in i386/mach-*/Makefile
>
> numa-aware-zonelist-builder.patch
>   NUMA-aware zonelist builder
>   numa-aware zonelist builder fix
>   numa-aware node builder fix #2
>
> remove-redundant-unplug_timer-deletion.patch
>   Redundant unplug_timer deletion
>
> queue_work_on_cpu.patch
>   Add queue_work_on_cpu() workqueue function
>
> m68k-rename-sys_functions.patch
>   m68k: rename sys_* functions
>
> pdc202xx_new-update.patch
>   ide: update for pdc202xx_new driver
>
> siimage-update.patch
>   ide: update for siimage driver
>
> ide-cleanups-01.patch
>   ide: IDE cleanups
>
> ide-cleanups-02.patch
>   ide: IDE cleanups
>
> ide-cleanups-03.patch
>   ide: IDE cleanups
>
> cdromaudio-use-dma.patch
>   use DMA for CDROM audio reading
>
> sysfs-pin-kobject.patch
>   sysfs: pin kobjects to fix use-after-free crashes
>
> ATI-IXP-IDE-support.patch
>   ATI IXP IDE support
>
> ipmi-updates-3.patch
>   IPMI driver updates
>
> ipmi-socket-interface.patch
>   IPMI: socket interface
>
> md-use-schedule_timeout.patch
>   md: use "shedule_timeout(2)" instead of yield()
>
> md-array-assembly-fix.patch
>   md: allow assembling of partitioned arrays at boot time.
>
> compiler_h-scope-fixes.patch
>   compiler.h scoping fixes
>
> remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch
>   per-page protections for remap_file_pages()
>
> nmi_watchdog-local-apic-fix.patch
>   Fix nmi_watchdog=3D2 and P4 HT
>
> nmi-1-hz.patch
>   set nmi_hz to 1 with nmi_watchdog=3D2 and SMP
>
> elf-mmap-fix.patch
>   Fix elf mapping of the zero page
>
> kbuild-more-cleaning.patch
>   kbuild: Cause `make clean' to remove more files
>
> LOOP_CHANGE_FD.patch
>   LOOP_CHANGE_FD ioctl
>
> loop-setup-race-fix.patch
>   loop setup race fix
>
> handle-dot-o-paths.patch
>   kbuild: fix usage with directories containing '.o'
>
> acpi-asmlinkage-fix.patch
>   gcc-3.5: acpi build fix
>
> ipc-sem-extra-sem_unlock.patch
>   Remove unneeded unlock in ipc/sem.c
>
> procfs-dangling-subdir-fix.patch
>   /proc data corruption check
>
> AMD-768MPX-bootmem-fix.patch
>   Work around an AMD768MPX erratum
>
> i810fb-on-x86_64.patch
>   Enable i810 fb on x86-64
>
> ext23-remove-acl-limits.patch
>   Remove arbitrary #acl entries limits on ext[23] when reading
>
> watchdog-moduleparam-patches.patch
>   watchdog: moduleparam-patches
>
> amd-elan-fix.patch
>   AMD ELAN Kconfig fix
>
> pcmcia-netdev-ordering-fixes.patch
>   PCMCIA netdevice ordering issues
>
> instrument-highmem-page-reclaim.patch
>   vm: per-zone vmscan instrumentation
>
> blk_congestion_wait-return-remaining.patch
>   return remaining jiffies from blk_congestion_wait()
>
> vmscan-remove-priority.patch
>   mm/vmscan.c: remove unused priority argument.
>
> kswapd-throttling-fixes.patch
>   kswapd throttling fixes
>
> vm-refill_inactive-preserve-referenced.patch
>   vmscan: preserve page referenced info in refill_inactive()
>
> shrink_slab-precision-fix.patch
>   shrink_slab: math precision fix
>
> try_to_free_pages-shrink_slab-evenness.patch
>   vm: shrink slab evenly in try_to_free_pages()
>
> vmscan-total_scanned-fix.patch
>   vmscan: fix calculation of number of pages scanned
>
> shrink_slab-for-all-zones-2.patch
>   vm: scan slab in response to highmem scanning
>
> zone-balancing-fix-2.patch
>   vmscan: zone balancing fix
>
> vmscan-control-by-nr_to_scan-only.patch
>   vmscan: drive everything via nr_to_scan
>
> vmscan-balance-zone-scanning-rates.patch
>   Balance inter-zone scan rates
>
> vmscan-dont-throttle-if-zero-max_scan.patch
>   vmscan: avoid bogus throttling
>
> kswapd-avoid-higher-zones.patch
>   kswapd: avoid unnecessary reclaiming from higher zones
>
> kswapd-avoid-higher-zones-reverse-direction.patch
>   kswapd: fix lumpy page reclaim
>
> kswapd-avoid-higher-zones-reverse-direction-fix.patch
>   fix the kswapd zone scanning algorithm
>
> vmscan-throttle-later.patch
>   vmscan: less throttling of page allocators and kswapd
>
> vm-batch-inactive-scanning.patch
>   vmscan: batch up inactive list scanning work
>
> vm-batch-inactive-scanning-fix.patch
>   fix vm-batch-inactive-scanning.patch
>
> vm-balance-refill-rate.patch
>   vm: balance inactive zone refill rates
>
> slab-no-higher-order.patch
>   slab: avoid higher-order allocations
>
> list_del-debug.patch
>   list_del debug check
>
> oops-dump-preceding-code.patch
>   i386 oops output: dump preceding code
>
> lockmeter.patch
>   lockmeter
>
> lockmeter-ia64-fix.patch
>   ia64 CONFIG_LOCKMETER fix
>
> 4g-2.6.0-test2-mm2-A5.patch
>   4G/4G split patch
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g/4g usercopy atomicity fix
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g/4g usercopy atomicity fix
>   4G/4G preempt on vstack
>   4G/4G: even number of kmap types
>   4g4g: fix __get_user in slab
>   4g4g: Remove extra .data.idt section definition
>   4g/4g linker error (overlapping sections)
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g4g: show_registers() fix
>   4g/4g usercopy atomicity fix
>   4g4g: debug flags fix
>   4g4g: Fix wrong asm-offsets entry
>   cyclone time fixmap fix
>   4G/4G preempt on vstack
>   4G/4G: even number of kmap types
>   4g4g: fix __get_user in slab
>   4g4g: Remove extra .data.idt section definition
>   4g/4g linker error (overlapping sections)
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g4g: show_registers() fix
>   4g/4g usercopy atomicity fix
>   4g4g: debug flags fix
>   4g4g: Fix wrong asm-offsets entry
>   cyclone time fixmap fix
>   use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
>   4G/4G might_sleep warning fix
>   4g/4g pagetable accounting fix
>   Fix 4G/4G and WP test lockup
>   4G/4G KERNEL_DS usercopy again
>   Fix 4G/4G X11/vm86 oops
>   Fix 4G/4G athlon triplefault
>   4g4g SEP fix
>   Fix 4G/4G split fix for pre-pentiumII machines
>   4g/4g PAE ACPI low mappings fix
>   zap_low_mappings() cannot be __init
>   4g/4g: remove printk at boot
>
> 4g4g-THREAD_SIZE-fixes.patch
>
> 4g4g-locked-userspace-copy.patch
>   Do a locked user-space copy for 4g/4g
>
> ia32-4k-stacks.patch
>   ia32: 4Kb stacks (and irqstacks) patch
>
> ia32-4k-stacks-build-fix.patch
>   4k stacks build fix
>
> 4k-stacks-in-modversions-magic.patch
>   Add 4k stacks to module version magic
>
> 4g4g-handle_BUG-fix.patch
>   4g4g: fix handle_BUG()
>
> ppc-fixes.patch
>   make mm4 compile on ppc
>
> ppc-fixes-dependency-fix.patch
>   ppc-fixes dependency fix
>
> O_DIRECT-race-fixes-rollup.patch
>   O_DIRECT data exposure fixes
>
> O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
>   Fix race between ll_rw_block() and block_write_full_page()
>
> blockdev-direct-io-speedup.patch
>   blockdev direct-io speedups
>
> O_DIRECT-vs-buffered-fix.patch
>   Fix O_DIRECT-vs-buffered data exposure bug
>
> O_DIRECT-vs-buffered-fix-pdflush-hang-fix.patch
>   pdflush hang fix
>
> serialise-writeback-fdatawait.patch
>   serialize_writeback_fdatawait patch
>
> restore-writeback-trylock.patch
>   writeback trylock patch
>
> dio-aio-fixes.patch
>   direct-io AIO fixes
>
> aio-fallback-bio_count-race-fix-2.patch
>   AIO+DIO bio_count race fix
>
> aio-direct-io-oops-fix.patch
>   AIO/direct-io oops fix
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--Boundary-01=_oPiTAPfzQ0EokeW
Content-Type: text/plain;
  charset="iso-8859-1";
  name="config-2.6.4-rc2-mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config-2.6.4-rc2-mm1"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
CONFIG_MK8=y
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_X86_4G is not set
# CONFIG_X86_SWITCH_PAGETABLES is not set
# CONFIG_X86_4G_VM_LAYOUT is not set
# CONFIG_X86_UACCESS_INDIRECT is not set
# CONFIG_X86_HIGH_ENTRY is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_DISK=y
CONFIG_PM_DISK_PARTITION="/dev/hda9"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
CONFIG_X86_POWERNOW_K8=y
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
CONFIG_HOTPLUG_PCI_ACPI=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_PCIE is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
CONFIG_SCSI_SATA_PROMISE=y
CONFIG_SCSI_SATA_VIA=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Macintosh device drivers
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_IPMI_SOCKET=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
CONFIG_SCTP_HMAC_SHA1=y
# CONFIG_SCTP_HMAC_MD5 is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_8139_RXBUF_IDX=2
CONFIG_SIS900=m
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_R8169=m
# CONFIG_SIS190 is not set
CONFIG_SK98LIN=m
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_BCSP_TXCRC is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
CONFIG_JOYSTICK_DB9=m
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_INPUT_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=2
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SMB=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I8XX_TCO is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_W83627HF_WDT=m
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
CONFIG_AGP_AMD64=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
CONFIG_MWAVE=m
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m
# CONFIG_I2C_VOODOO3 is not set

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_EEPROM=m
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM83=m
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=m

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
# CONFIG_LOGITECH_FF is not set
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
CONFIG_USB_MTOUCH=m
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
CONFIG_USB_PWC=m
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
CONFIG_USB_W9968CF=m

#
# USB Network adaptors
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
CONFIG_USB_SERIAL_IR=m
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=m
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SPINLINE is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_KGDB is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--Boundary-01=_oPiTAPfzQ0EokeW--

--Boundary-03=_tPiTAZN3oCiCXG9
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBATiPt4q3E2oMjYtURAi1PAKDCaHESkH85pyVCrjG/ovoeV1s84wCfXXLc
+BCxLbXlTv2xJE9RuAKdSbU=
=X3aA
-----END PGP SIGNATURE-----

--Boundary-03=_tPiTAZN3oCiCXG9--

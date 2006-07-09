Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWGIJLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWGIJLO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 05:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWGIJLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 05:11:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932312AbWGIJLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 05:11:12 -0400
Date: Sun, 9 Jul 2006 02:11:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc1-mm1
Message-Id: <20060709021106.9310d4d1.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/

- We're getting a relatively large number of crash reports coming out of the
  core sysfs/kobject/driver/bus code, and they're all really hard to diagnose.

  I am suspecting that what's happening is that some registration functions
  are failing and the caller is ignoring that failure.  The code proceeds and
  crashes much later, in obscure ways.

  All these functions return error codes, and we're not checking them.  We
  should.  So there's a patch which marks all these things as __must_check,
  which causes around 1,500 new warnings.

  These are all bugs and they all need to be fixed.

  In some cases (eg, sysfs file removal) there's not a lot the caller can do
  apart from warn, so we should probably change those things to return void
  and put a diagnostic message into the callee itself.

  These new warnings can be turned off with CONFIG_ENABLE_MUST_CHECK=n, but
  I'll probably drop that patch.  There's just no excuse for ignoring error
  codes and then blundering on to crash.

- There are some improvements to the swsusp disk IO handling.  You should
  find that the suspend-time writeout and resume-time readin speeds are
  approximately doubled.

- reiser4 doesn't build, due to changes in

	vectorize-aio_read-aio_write-fileop-methods.patch
	remove-readv-writev-methods-and-use-aio_read-aio_write.patch
	streamline-generic_file_-interfaces-and-filemap.patch

- You'll probably see these:

	WARNING: drivers/net/3c59x ids 36 bad size (each on 16)
	WARNING: drivers/net/depca ids 24 bad size (each on 16)
	WARNING: drivers/net/dgrs ids 24 bad size (each on 16)
	WARNING: drivers/net/hp100 ids 84 bad size (each on 16)
	WARNING: drivers/net/ne3210 ids 36 bad size (each on 16)
	WARNING: drivers/net/tulip/de4x5 ids 24 bad size (each on 16)
	WARNING: drivers/scsi/aha1740 ids 60 bad size (each on 16)
	WARNING: drivers/scsi/aic7xxx/aic7xxx ids 84 bad size (each on 16)

  They're triggered by eisa-bus-modalias-attributes-support-1.patch but I
  don't know where the error lies.  But I love the error message!  Would be
  good to see on a tee shirt.

- powerpc (on Mac G5's at least) appears to be dead, probably due to the
  interrupt management changes in 2.6.18-rc1.

- please read the "Boilerplate", below.  Especially the last point.



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it is not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.




Changes since 2.6.17-mm6:


 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-cifs.patch
 git-cpufreq.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-jfs.patch
 git-klibc.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-sas.patch
 git-s390.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 git trees

-time-initialisation-fix.patch
-genirq-ia64-cleanup.patch
-lockdep-special-s390-print_symbol-version.patch
-bcm43xx-netlink-deadlock-fix.patch
-uml-build-fix.patch
-pnpacpi-support-shareable-interrupts.patch
-serial-allow-shared-8250_pnp-interrupts.patch
-zvc-zone_reclaim-leave-1%-of-unmapped-pagecache-pages-for-file-i-o.patch
-binfmt_elf-fix-checks-for-bad-address.patch
-kernel-doc-maintainers.patch
-add-mike-isely-as-pvrusb2-maintainer.patch
-fbdev-add-framebuffer-and-display-update-module-support.patch
-vt-decrement-ref-count-of-the-vt-backend-on-deallocation.patch
-make-more-file_operation-structs-static.patch
-sparc-i8042-build-fix.patch
-sparc-resource-warning-fixes.patch
-lockdep-floppyc-irq-release-fix.patch
-lockdep-console_init-after-local_irq_enable.patch
-lockdep-add-is_module_address.patch
-lockdep-add-print_ip_sym.patch
-lockdep-add-per_cpu_offset.patch
-lockdep-add-disable-enable_irq_lockdep-api.patch
-lockdep-add-local_irq_enable_in_hardirq-api.patch
-lockdep-add-declare_completion_onstack-api.patch
-lockdep-clean-up-rwsems.patch
-lockdep-remove-rwsem_debug-remnants.patch
-lockdep-rename-debug_warn_on.patch
-lockdep-remove-debug_bug_on.patch
-lockdep-remove-mutex-deadlock-checking-code.patch
-lockdep-better-lock-debugging.patch
-lockdep-mutex-section-binutils-workaround.patch
-lockdep-locking-init-debugging-improvement.patch
-lockdep-beautify-x86_64-stacktraces.patch
-lockdep-x86_64-document-stack-frame-internals.patch
-lockdep-i386-remove-multi-entry-backtraces.patch
-lockdep-stacktrace-subsystem-core.patch
-lockdep-s390-config_frame_pointer-support.patch
-lockdep-stacktrace-subsystem-i386-support.patch
-lockdep-stacktrace-subsystem-x86_64-support.patch
-lockdep-stacktrace-subsystem-s390-support.patch
-lockdep-irqtrace-subsystem-core.patch
-lockdep-irqtrace-subsystem-docs.patch
-lockdep-irqtrace-subsystem-i386-support.patch
-lockdep-irqtrace-cleanup-of-include-asm-i386-irqflagsh.patch
-lockdep-irqtrace-subsystem-x86_64-support.patch
-lockdep-irqtrace-cleanup-of-include-asm-x86_64-irqflagsh.patch
-lockdep-irqtrace-subsystem-s390-support.patch
-lockdep-locking-api-self-tests.patch
-lockdep-core.patch
-lockdep-allow-read_lock-recursion-of-same-class.patch
-lockdep-design-docs.patch
-lockdep-procfs.patch
-lockdep-prove-rwsem-locking-correctness.patch
-lockdep-prove-spinlock-rwlock-locking-correctness.patch
-lockdep-prove-mutex-locking-correctness.patch
-lockdep-kconfig.patch
-lockdep-print-all-lock-classes-on-sysrq-d.patch
-lockdep-x86_64-early-init.patch
-lockdep-x86-smp-alternatives-workaround.patch
-lockdep-do-not-recurse-in-printk.patch
-lockdep-fix-rt_hash_lock_sz.patch
-lockdep-s390-turn-validator-off-in-machine-check-handler.patch
-lockdep-enable-on-i386.patch
-lockdep-enable-on-x86_64.patch
-lockdep-enable-on-s390.patch
-lockdep-annotate-direct-io.patch
-lockdep-annotate-serial.patch
-lockdep-annotate-dcache.patch
-lockdep-annotate-i_mutex.patch
-lockdep-annotate-futex.patch
-lockdep-annotate-genirq.patch
-lockdep-annotate-waitqueues.patch
-lockdep-annotate-mm.patch
-lockdep-annotate-serio.patch
-lockdep-annotate-skb_queue_head_init.patch
-lockdep-annotate-timer-base-locks.patch
-lockdep-annotate-scheduler-runqueue-locks.patch
-lockdep-annotate-hrtimer-base-locks.patch
-lockdep-annotate-sock_lock_init.patch
-lockdep-annotate-af_unix-locking.patch
-lockdep-annotate-bh_lock_sock.patch
-lockdep-annotate-ieee1394-skb-queue-head-locking.patch
-lockdep-annotate-mmap_sem.patch
-lockdep-annotate-sunrpc-code.patch
-lockdep-annotate-ntfs-locking-rules.patch
-lockdep-annotate-the-quota-code.patch
-lockdep-annotate-usbfs.patch
-lockdep-annotate-sound-core-seq-seq_portsc.patch
-lockdep-annotate-sound-core-seq-seq_devicec.patch
-lockdep-annotate-8390c-disable_irq.patch
-lockdep-annotate-3c59xc-disable_irq.patch
-lockdep-annotate-enable_in_hardirq.patch
-lockdep-annotate-on-stack-completions.patch
-lockdep-annotate-qeth-driver.patch
-lockdep-annotate-s_lock.patch
-lockdep-annotate-sb-s_umount.patch
-lockdep-annotate-slab-code.patch
-lockdep-annotate-blkdev-nesting.patch
-lockdep-annotate-vlan-net-device-as-being-a-special-class.patch
-lockdep-annotate-on-stack-completions-mmc.patch
-lockdep-annotate-sk_locks.patch
-lockdep-annotate-hostap-netdev-xmit_lock.patch
-forcedeth-typecast-cleanup.patch
-lockdep-annotate-forcedethc-disable_irq.patch
-lockdep-irqtrace-subsystem-move-account_system_vtime-calls-into-kernel-softirqc.patch
-sched-clean-up-fallout-of-recent-changes.patch
-sched-cleanup-remove-task_t-convert-to-struct-task_struct.patch
-sched-cleanup-convert-schedc-internal-typedefs-to-struct.patch
-gfs2-get_sb_dev-fix.patch
-8139cp-printk-fix.patch
-git-e1000.patch
-git-e1000-fixup.patch
-lock-validator-fix-ns83820c-irq-flags-bug.patch
-ni5010-netcard-cleanup.patch
-remove-dead-entry-in-net-wan-kconfig.patch
-ioat-fix-sparse-ulong-warning.patch
-af_unix-datagram-getpeersec-fix.patch
-drivers-dma-iovlockc-make-num_pages_spanned-static.patch
-fix-a-warning-in-ioatdma.patch
-ioat-fix-header-file-kernel-doc.patch
-ioat-fix-kernel-doc-in-source-files.patch
-net-adduse-poison-defines.patch
-atm-adduse-poison-defines.patch
-drivers-scsi-megaraidc-add-a-dummy-mega_create_proc_entry-for-proc_fs=y.patch
-gregkh-usb-usb-serial-dynamic-id.patch
-gregkh-usb-usbip.patch
-gregkh-usb-usb-usbip-build-fix.patch
-gregkh-usb-usb-usbip-more-dead-code-fix.patch
-gregkh-usb-usb-usbip-warning-fixes.patch
-gregkh-usb-airprime_major_update.patch
-fix-sco-on-some-bluetooth-adapters-2.patch
-mm-x86_64-mm-init-rdtscp-warning-fix.patch
-sleazy-fpu-feature-x86_64-support-fix.patch
-x86_64-fix-calgary-copyright-statements-per-ibm-guidelines.patch
-x86_64-add-a-maintainers-entry-for-calgary.patch
-sched-fix-bug-in-__migrate_task.patch
-small-kernel-schedc-cleanup.patch
-enable-oprofile-on-pentium-d.patch
-valid_mmap_phys_addr_range-cleanup.patch
-reiserfsfix-journaling-issue-regarding-fsync.patch
-jmicron-pci-identifiers.patch
-vt-remove-vt-specific-declarations-and-definitions-from.patch
-vt-remove-vt-specific-declarations-and-definitions-from-fix.patch
-tty-remove-include-of-screen_infoh-from-ttyh.patch
-tty-remove-include-of-screen_infoh-from-ttyh-fix.patch
-tty-remove-include-of-screen_infoh-from-ttyh-fix-fix.patch
-md-oops-workaround.patch
-kernel-printkc-export_symbol_unused.patch
-mm-bootmemc-export_unused_symbol.patch
-mm-memoryc-export_unused_symbol.patch
-mm-mmzonec-export_unused_symbol.patch
-fs-read_writec-export_unused_symbol.patch
-kernel-softirqc-export_unused_symbol.patch

 Merged into mainline or a subsystem tree.

+dont-select-config_hotplug.patch
+x86_64-e820c-needs-pgtableh.patch
+acpi-bus-add-missing-newline.patch
+count_vm_events-fix.patch
+sched-fix-bug-in-__migrate_task.patch
+small-kernel-schedc-cleanup.patch
+selinux-decouple-fscontext-context-mount-options.patch
+selinux-add-rootcontext=-option-to-label-root-inode.patch
+reiserfsfix-journaling-issue-regarding-fsync.patch
+nfs-update-documentation-nfsroottxt-to-include-dhcp-syslinux-and-isolinux.patch
+add-computone-intelliport-plus-serial-hotplug-support.patch
+add-specialix-io8-card-support-hotplug-support.patch
+partitions-let-partitions-inherit-policy-from-disk.patch
+fadvise-remove-dead-comments.patch
+minor-cleanup-to-lockdepc.patch
+lockdep-add-more-rwsemh-documentation.patch
+improve-lockdep-debug-output.patch
+lockdep-core-reduce-per-lock-class-cache-size.patch
+lockdep-clean-up-completion-initializer-in-smpbootc.patch
+put-a-comment-at-register_die_notifier-that-the-export-is-used.patch
+rcu-documentation-fix.patch
+vfs-documentation-tweak.patch
+cdrom-fix-bad-cgcbuflen-assignment.patch
+release_firmware-fixes.patch
+updates-credits-file.patch
+hisax-fix-usage-of-__init.patch
+vt-remove-vt-specific-declarations-and-definitions-from.patch
+tty-remove-include-of-screen_infoh-from-ttyh.patch
+md-possible-fix-for-unplug-problem.patch
+md-set-desc_nr-correctly-for-version-1-superblocks.patch
+md-delay-starting-md-threads-until-array-is-completely-setup.patch
+md-fix-resync-speed-calculation-for-restarted-resyncs.patch
+md-fix-a-plug-unplug-race-in-raid5.patch
+md-fix-some-small-races-in-bitmap-plugging-in-raid5.patch
+md-fix-usage-of-wrong-variable-in-raid1.patch
+md-unify-usage-of-symbolic-names-for-perms.patch
+md-require-cap_sys_admin-for-re-configuring-md-devices-via-sysfs.patch
+md-include-sector-number-in-messages-about-corrected-read-errors.patch
+md-oops-workaround.patch
+kernel-printkc-export_symbol_unused.patch
+mm-bootmemc-export_unused_symbol.patch
+mm-memoryc-export_unused_symbol.patch
+mm-mmzonec-export_unused_symbol.patch
+fs-read_writec-export_unused_symbol.patch
+kernel-softirqc-export_unused_symbol.patch
+h8300-remove-duplicate-define.patch
+acpi-fix-fan-thermal-resume.patch
+pi-futex-validate-futex-type-instead-of-oopsing.patch
+zvc-add-__inc_zone_state-for-smp-configuration.patch
+vmstat-export-all_vm_events.patch
+acpi-init-dock-notifier-list.patch
+acpi-fix-boot-with-acpi=off.patch
+adjust-clock-for-lost-ticks.patch

 2.6.18-rc2 queue.

+acpi-do-not-abort-method-execution-if-asked-to-release.patch
+acpi-disable-sbs-by-default.patch
+acpi-initialise-cm_sbs_sem.patch
+acpi-resume-allocation-mode-fix.patch

 ACPI fixes.

+cpufreq-add-__find_governor-helper-and-clean-up-some.patch
+cpufreq-demand-load-governor-modules.patch

 cpufreq updates

+gregkh-driver-device_rename.patch
+gregkh-driver-network-class_device-to-device.patch
+gregkh-driver-class_device_rename-remove.patch

 driver tree updates.

+add-__must_check-to-device-management-code.patch
+add-config_enable_must_check.patch
+v4l-dev2-handle-__must_check.patch

 Add __must_check to lots of driver-layer API functions.

+allow-drm-detection-of-new-via-chipsets.patch

 DRM device support.

+videodev-check-return-values.patch

 Reduce the __must_check warning storm.

+gregkh-i2c-i2c-fix-ignore-module-parameter-handling-in-i2c-core.patch
+gregkh-i2c-i2c-iop3xx-avoid-addressing-self.patch
+gregkh-i2c-scx200_acb-fix-the-state-machine.patch
+gregkh-i2c-scx200_acb-fix-the-block-transactions.patch
+gregkh-i2c-i2c-powermac-fix-master-xfer-return.patch
+gregkh-i2c-i2c-plan-ite-bus-driver-for-removal.patch
+gregkh-i2c-i2c-new-mailing-list.patch
+gregkh-i2c-i2c-algo-error-handling-fix.patch
+gregkh-i2c-i2c-algo-bit-wipe-out-dead-code.patch
+gregkh-i2c-i2c-pca9539-force.patch
+gregkh-i2c-i2c-dev-cleanups.patch
+gregkh-i2c-i2c-dev-convert-array-to-list.patch
+gregkh-i2c-i2c-dev-drop-template-client.patch
+gregkh-i2c-i2c-dev-device.patch

 i2v tree updates.

-ieee1394-sbp2-enable-auto-spin-up-for-maxtor-disks.patch
-ieee1394-fix-calculation-of-csr-expire.patch
-ieee1394-fix-cosmetic-problem-in-speed-probe.patch
-ieee1394-skip-dummy-loop-in-build_speed_map.patch
-ieee1394-replace-__inline__-by-inline.patch
-ieee1394-coding-style-and-comment-fixes-in-midlayer.patch
-ieee1394-update-include-directives-in-midlayer-header.patch
-ieee1394-remove-redundant-code-from-ieee1394_hotplugh.patch
-ieee1394-remove-unused-macros-hpsb_panic-and.patch
-ieee1394-clean-up-declarations-of-hpsb__config_rom.patch
-ieee1394-dv1394-sem2mutex-conversion.patch
-ieee1394-raw1394-remove-redundant-counting-semaphore.patch
-ieee1394-nodemgr-remove-unnecessary-includes.patch
-ieee1394-nodemgr-do-not-spawn-kernel_thread-for-sysfs.patch
-ieee1394-nodemgr-make-module-parameter-ignore_drivers.patch
-ieee1394-nodemgr-switch-to-kthread-api-replace-reset.patch
-ieee1394-nodemgr-convert-nodemgr_serialize-semaphore.patch

 Merged.

+git-ieee1394-fixup.patch

 Fix reject due to git-ieee1394.patch

+git-input-list_for_each_entry-fix.patch

 Fix bug in git-input.patch

+drivers-usb-input-ati_remotec-autorepeat-fix.patch

 USB fix.

-git-hdrinstall2.patch

 Dropped.

+pata-jmicron-add-quirks-to-force-the-device-into-a-sane-mode.patch
+pata-jmicron-configuration.patch
+pata-ata_generic-generic-bios-setup-sff-ata-driver.patch
+pata-jmicron-ide-old-type-driver.patch
+sata-add-pci-id.patch

 PATA updates

-git-netdev-all-fixup.patch

 Unneeded.

+lockdep-fix-atm-ipcommonc-deadlock.patch
+lockdep-annotate-8390c-disable_irq-2.patch

 net fixes.

+8139cp-printk-fix.patch
+82596-section-fixes.patch
+ac3200-section-fixes.patch
+cops-section-fix.patch
+cs89x0-section-fix.patch
+at1700-section-fix.patch
+e2100-section-fix.patch
+eepro-section-fix.patch
+eexpress-section-fix.patch
+es3210-section-fix.patch
+eth16i-section-fix.patch
+smsc-ircc2-fix-section-reference-mismatches.patch
+lance-section-fix.patch
+lne390-section-fix.patch
+ni52-section-fix.patch
+ibmtr-section-fix.patch
+smctr-section-fix.patch
+wd-section-fix.patch
+ni65-section-fix.patch
+seeq8005-section-fix.patch
+winbond-840-section-fix.patch
+fealnx-section-fix.patch
+sundance-section-fix.patch

 Fix various __init section bloopers.  These were done quickly and need a
 second round.

+drivers-net-e1000-possible-cleanups.patch
+e1000_7033_dump_ring.patch
+forcedeth-deferral-fixup.patch
+forcedeth-watermark-fixup.patch
+freescale-qe-ucc-gigabit-ethernet-driver.patch

 Net driver updates.

+via-ircc-fix-memory-leak.patch
+lockdep-fix-sk_dst_check-deadlock.patch
+netlink-improve-string-attribute-validation.patch

 Net things.

+fs-nfs-make-code-static.patch

 NFS cleanup

+pcmcia-update-alloc_io_space-for-conflict-checking-for-multifunction-pc-card-for-linux-kernel-26154.patch

 PCMCIA update

+git-powerpc-briq_panel-Kconfig-fix.patch
+powermac-combined-fixes-for-backlight-code.patch

 powerpc fixes.

-gregkh-pci-msi-merge-existing-msi-disabling-quirks.patch
-gregkh-pci-msi-rename-pci_cap_id_ht_irqconf-into-pci_cap_id_ht.patch
-gregkh-pci-msi-blacklist-pci-e-chipsets-depending-on-hypertransport-msi-capabality.patch
-gregkh-pci-msi-factorize-common-msi-detection-code-from-pci_enable_msi-and-msix.patch
-gregkh-pci-msi-stop-inheriting-bus-flags-and-check-root-chipset-bus-flags-instead.patch
-gregkh-pci-msi-drop-pci_msi_quirk.patch
 gregkh-pci-resources-insert-identical-resources-above-existing-resources.patch
+gregkh-pci-msi-01-merge_msi_disabling_quirks.patch
+gregkh-pci-msi-02-factorize_pci_msi_supported.patch
+gregkh-pci-msi-03-use_root_chipset_dev_no_msi_instead_of_pci_bus_flags.patch
+gregkh-pci-msi-04-rename_pci_cap_id_ht_irqconf.patch
+gregkh-pci-msi-05-check_hypertransport_msi_capabilities.patch
+gregkh-pci-msi-06-drop_pci_msi_quirk.patch
+gregkh-pci-msi-07-drop_pci_bus_flags.patch
-revert-gregkh-pci-msi-drop-pci_msi_quirk.patch
-revert-gregkh-pci-msi-stop-inheriting-bus-flags-and-check-root-chipset-bus-flags-instead.patch
-revert-gregkh-pci-msi-factorize-common-msi-detection-code-from-pci_enable_msi-and-msix.patch
-revert-gregkh-pci-msi-blacklist-pci-e-chipsets-depending-on-hypertransport-msi-capabality.patch
-revert-gregkh-pci-msi-rename-pci_cap_id_ht_irqconf-into-pci_cap_id_ht.patch
-revert-gregkh-pci-msi-merge-existing-msi-disabling-quirks.patch

 New set of PCI MSI patches.

-git-scsi-misc-fixup.patch

 Unneeded.

+pci-initialize-struct-pci_dev-error_state.patch
+pcie-check-and-return-bus_register-errors.patch
+pcie-cleanup-on-probe-error.patch

 PCI later updates.

+make-drivers-scsi-aic7xxx-aic79xx_coreahd_set_tags-static.patch
+NCR_D700-section-fix.patch
+megaraid-fix-warnings-when-config_proc_fs=n.patch

 SCSI updates

+areca-raid-linux-scsi-driver-update7.patch
+areca-raid-linux-scsi-driver-update7-fix.patch

 Update drivers-scsi-arcmsr-cleanups.patch

+sparc64-of_device_register-error-checking-fix.patch

 Add missing error check.

+gregkh-usb-usb-remove-devfs-information-from-kconfig.patch
+gregkh-usb-usb-ipw.c-driver-fix.patch
+gregkh-usb-usb-add-support-for-wisegroup.-ltd-smartjoy-dual-plus-adapter.patch
+gregkh-usb-usbfs-private-mutex-for-open-release-and-remove.patch
+gregkh-usb-usbfs-detect-device-unregistration.patch
+gregkh-usb-usb-skeleton-don-t-submit-urbs-after-disconnection.patch

 USB tree udpates (part thereof - I dropped ten-odd patches due to oopsing)

+rtl8150_disconnect-needs-tasklet_kill.patch
+usb-storage-wait-for-urb-to-complete.patch

 USB fixes.

+x86_64-mm-tif-restore-sigmask.patch
+x86_64-mm-add-ppoll-pselect.patch
+x86_64-mm-bring-x86-64-ia32-emul-in-sync-with-i386-on-read_implies_exec-enabling.patch
+x86_64-mm-getcpu-vsyscall.patch
+x86_64-mm-tif-flags-for-debug-regs-and-io-bitmap-in-ctxsw.patch
+x86_64-mm-add-a-maintainers-entry-for-calgary.patch
+x86_64-mm-fix-calgary-copyright-statements-per-ibm-guidelines.patch
+x86_64-mm-fix-acpi-defaults.patch
+x86_64-mm-oprofile-p4-model.patch

 x86_64 updates

 Folded into sleazy-fpu-feature-x86_64-support.patch

+x86_64-wire-up-oops_enter-oops_exit.patch

 Implement pause_on_oops on x86_64.

+xfs-move-xfs_ioc_getversion-to-main-multiplexer.patch

 XFS cleanup

+mmap-zero-length-hugetlb-file-with-prot_none-to-protect-a.patch

 hugetlb fixlet.

+convert-i386-numa-kva-space-to-bootmem.patch
+convert-i386-numa-kva-space-to-bootmem-tidy.patch
+bootmem-remove-useless-__init-in-header-file.patch
+bootmem-mark-link_bootmem-as-part-of-the-__init-section.patch
+bootmem-remove-useless-parentheses-in-bootmem-header.patch
+bootmem-limit-to-80-columns-width.patch
+bootmem-remove-useless-headers-inclusions.patch
+bootmem-use-pfn-page-conversion-macros.patch
+bootmem-miscellaneous-coding-style-fixes.patch
+reduce-max_nr_zones-remove-two-strange-uses-of-max_nr_zones.patch
+reduce-max_nr_zones-fix-max_nr_zones-array-initializations.patch
+reduce-max_nr_zones-make-display-of-highmem-counters-conditional-on-config_highmem.patch
+reduce-max_nr_zones-make-display-of-highmem-counters-conditional-on-config_highmem-tidy.patch
+reduce-max_nr_zones-move-highmem-counters-into-highmemc-h.patch
+reduce-max_nr_zones-page-allocator-zone_highmem-cleanup.patch
+reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment.patch
+reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-cleanup.patch
+reduce-max_nr_zones-make-zone_dma32-optional.patch
+reduce-max_nr_zones-make-zone_highmem-optional.patch
+reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones.patch
+reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones-s390-fix.patch
+reduce-max_nr_zones-fix-i386-srat-check-for-max_nr_zones.patch

 Memory management updates.

+tiacx-build-fix.patch

 Fix acx1xx-wireless-driver.patch

+binfmt_elf-consistently-use-loff_t.patch

 binfmt_elf fixlet.

+fdpic-fix-fdpic-compile-errors-2.patch
+frv-fix-frv-arch-compile-errors.patch
+nommu-fix-execution-off-of-ramfs-with-mmap.patch
+fdpic-adjust-the-elf-fdpic-driver-to-conform-more-to-the-codingstyle.patch
+fdpic-define-seek_-constants-in-the-linux-kernel-headers.patch
+fdpic-move-roundup-into-linux-kernelh.patch
+fdpic-move-roundup-into-linux-kernelh-fix.patch
+fdpic-add-coredump-capability-for-the-elf-fdpic-binfmt.patch
+frv-introduce-asm-offsets-for-frv-arch.patch

 FRV/nommu updates

+i386-early-fault-handler.patch
+i386-require-acpi-for-numa-with-generic-architecture.patch
+add-seccomp_disable_tsc-config-option.patch
+i386-defconfig-set-config_pm_std_partition=.patch
+get_cmos_time-locking-fix.patch

 x86 updates

+swsusp-do-not-use-memcpy-for-snapshotting-memory.patch
+swsusp-warning-fix.patch
+fix-panic-when-swsusp-signature-cant-be-read.patch
+swsusp-write-timer.patch
+swsusp-write-speedup.patch
+swsusp-read-timer.patch
+swsusp-read-speedup.patch
+swsusp-read-speedup-fix.patch
+swsusp-read-speedup-cleanup.patch
+swsusp-read-speedup-cleanup-2.patch

 swsusp updates

+cris-switch-to-iminor-imajor.patch
+pcf8563-remove-mod_inc_use_count-mod_dec_use_count.patch

 cris fixlets.

+uml-clean-up-address-space-limits-code.patch
+uml-timer-initialization-cleanup.patch
+uml-timer-initialization-cleanup-fix.patch
+uml-remove-some-useless-exports.patch
+uml-fix-static-binary-segfault.patch
+uml-remove-useless-declaration.patch
+uml-signal-initialization-cleanup.patch
+uml-timer-handler-tidying.patch
+uml-ifdef-a-mode-specific-function.patch
+uml-mark-forward_interrupts-as-being-mode-specific.patch
+uml-remove-spinlock-wrapper-functions.patch
+uml-remove-os_isatty.patch
+uml-fix-exitcall-ordering-bug.patch
+uml-make-some-symbols-static.patch
+uml-remove-syscall-debugging.patch
+uml-move-_kernc-files.patch
+uml-move-_kernc-files-fix.patch
+uml-formatting-fixes.patch
+uml-add-some-eintr-protection.patch
+uml-remove-unused-variable.patch
+uml-make-mconsole-version-requests-happen-in-a-process.patch

 UML updates

+drivers-edac-make-code-static.patch

 EDAC cleanup

+inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-fix.patch

 Fix inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default.patch

-inode-diet-fix-size-of-i_blkbits-i_version-and-i_dnotify_mask.patch

 Dropped.

+x86-microcode-add-sysfs-and-hotplug-support-fix-fix.patch

 Fix x86-microcode-add-sysfs-and-hotplug-support.patch some more.

+consistently-use-max_errno-in-__syscall_return.patch
+consistently-use-max_errno-in-__syscall_return-fix.patch
+sanitize-3c589_cs.patch
+eisa-bus-modalias-attributes-support-1.patch
+add-address_space_operationsbatch_write.patch
+add-address_space_operationsbatch_write-tidy.patch
+null-terminate-over-long-proc-kallsyms-symbols.patch
+fix-weird-logic-in-alloc_fdtable.patch
+alloc_fdtable-cleanup.patch
+uninline-init_waitqueue_head.patch
+aoe-cleanup-i_rdev-usage.patch
+remove-leftover-ext3-acl-declarations.patch
+reiserfs-warn-about-the-useless-nolargeio-option.patch
+pata-pata_qdi-fix-return-code.patch
+pata-ide-jmicron-finish-writing.patch
+pata-jmicron-it-works-better-if-you-get-the-file-name-right.patch
+pata-jmicron-further-clean-up.patch
+pata-ata_jmicro-fix-an-escapee.patch
+pata-jmicron-jmicron-multifunction-setup.patch
+pata-jmicron-missed-one.patch
+pata-libata-enable-per-device-speed-setting.patch
+remove-kernel-kthreadckthread_stop_sem.patch
+include-__param-section-in-read-only-data-range.patch
+remove-open_max-check-from-poll-syscall.patch
+# led-class-support-for-soekris-net48xx.patch needs SOB
+led-class-support-for-soekris-net48xx.patch
+led-class-support-for-soekris-net48xx-fix.patch
+pc8736x_gpio-fix-re-modprobe-errors.patch
+pc8736x_gpio-fix-re-modprobe-errors-undo-region-reservation.patch
+pc8736x_gpio-fix-re-modprobe-errors-fix-finish-cdev-init.patch
+pc8736x_gpio-fix-re-modprobe-errors-fix-finish-cdev-init-tidy.patch
+snsc-switch-from-force_sig-to-kill_proc.patch
+disallow-modular-binfmt_elf32.patch
+remove-the-tasklist_lock-export.patch

 Misc updates.

+revert-pcmcia-make-ide_cs-work-with-the-memory-space-of-cf-cards-if-io-space-is-not-available.patch

 Revert possibly-broken IDE-CS patch.

+vectorize-aio_read-aio_write-fileop-methods.patch
+remove-readv-writev-methods-and-use-aio_read-aio_write.patch
+streamline-generic_file_-interfaces-and-filemap.patch

 Fiddle around with core pagecache APIs, break reiser4.

+per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks.patch
+per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix.patch

 Improve scalability of the task accounting infrastructure in -mm.

+isdn-cleanup-i_rdev-udage.patch

 ISDN cleanup

+knfsd-nfsd4-add-per-operation-server-stats.patch

 knfsd update

+reduce-max_nr_zones-swap_prefetch-remove-incorrect-use-of-zone_highmem.patch

 Update swap prefetch for other patches in -mm.

+ecryptfs-partial-signed-integer-to-size_t-conversion-updated-ii.patch

 Update ecryptfs.

+streamline-generic_file_-interfaces-and-filemap-ecryptfs.patch

 Fix ecryptfs for the pagecache fiiddling.

-drivers-ide-legacy-ide-csc-make-2-functions-static.patch

 IDE cleanup

+move-ide-to-unmaintained-drop-reference-to-old-git-tree.patch

 Seems we don't have an IDE maintainer.

+cirrus-logic-framebuffer-i2c-support.patch
+cirrus-logic-framebuffer-i2c-support-fix.patch

 fbdev updates (these need work)

+statistics-infrastructure-update-9.patch

 Update statistics-infrastructure.patch

+statistics-replace-inode-ugeneric_ip-with-i_private.patch

 Fix it for the inode-diet patches.

-srcu-rcu-variant-permitting-read-side-blocking.patch
-srcu-2-rcu-variant-permitting-read-side-blocking.patch
-srcu-add-srcu-operations-to-rcutorture.patch
-srcu-2-add-srcu-operations-to-rcutorture.patch
+srcu-3-rcu-variant-permitting-read-side-blocking.patch
+srcu-3-rcu-variant-permitting-read-side-blocking-fix.patch
+srcu-3-add-srcu-operations-to-rcutorture.patch

 Updated srcu patchset.

+the-scheduled-removal-of-some-oss-drivers-fix.patch

 Fix the-scheduled-removal-of-some-oss-drivers.patch

+serial-core-adds-atomic-context-debug-code.patch

 Little debugging aid.




All 807 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/patch-list



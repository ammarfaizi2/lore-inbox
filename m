Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWBCIHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWBCIHb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 03:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWBCIHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 03:07:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751110AbWBCIH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 03:07:28 -0500
Date: Fri, 3 Feb 2006 00:07:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc1-mm5
Message-Id: <20060203000704.3964a39f.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm5/


- The ntp/time rework patches from John Stultz have been resurrected and fixed.

- There's now a `hot-fixes' directory at the above URL.  Please look in
  there for any updates which should be applied.


Known problems:

- Sam has added a new check in the kbuild tree.  It detects multiple
  instances of EXPORT_SYMBOL(foo) across separate .o files.

  It catches a _lot_ of problems.   You'll see something like this:

WARNING: vmlinux: duplicate symbol '__down_interruptible' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol '__down' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol '__up' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'smp_call_function' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'iounmap' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol '__ioremap' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'ioremap' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'sys_ctrler' previous definition was in vmlinux

  There's probably not a lot of point in reporting this if you see it.

  Patches would be nice, but be warned that fixing these is not as trivial
  as one might think:

  - If one export is in generic code and the other is in arch code then

    - If you remove the export in generic code, you need to check all
      architectures for breakage.

    - If you remove the export in arch code then you need to be sure
      that the generic .o file a) always compiles in the offending function
      and b) is always linked into vmlinux.

  - If both exports are in arch code then you need to ensure that
    the export which isn't deleted is always included in vmlinux when
    the symbol which it exports is included in vmlinux.

  If possible, the best approach is to put the EXPORT_SYMBOL
  immediately after the symbol which is being exported.  And if it's
  a function, pleeeze don't put a blank line between the end of the
  function and the export - I've no idea why people do that...


Boilerplate:

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it's not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.



Changes since 2.6.15-mm4:


 linus.patch
 git-alsa.patch
 git-arm.patch
 git-audit.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cpufreq.patch
 git-dvb.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-all.patch
 git-mmc.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-parisc.patch
 git-powerpc.patch
 git-serial.patch
 git-sym2.patch
 git-pcmcia.patch
 git-sas-jg.patch
 git-watchdog.patch
 git-cryptodev.patch

 Git trees

-x86_64-compat_sys_futimesat-fix.patch
-config_isa-does-not-make-sense-for-config_ppc_pseries.patch
-prototypes-for-at-functions-typo-fix.patch
-knfsd-restore-recently-broken-acl-functionality-to-nfs-server.patch
-config_doublefault-kconfig-fix.patch -smbfs-readdir-vs-signal-fix.patch
-fuse-fix-async-read-for-legacy-filesystems.patch -sound-ppc-pmacc-typo.patch
-__cpuinit-functions-wrongly-marked-__meminit.patch
-wrongly-marked-__init-__initdata-for-cpu-hotplug.patch
-ide-scsi-fix-for-ide-probe-remove-ops-changes.patch
-powerpc-enable-irqs-for-platform-functions.patch
-tsunami_flash-fix-parse-error-before-token.patch
-lp486e-remove-slow_down_io.patch
-ipw2100-add-generic-geo-information-to-be-compliant-with-ieee80211-117-changes.patch
-move-timespec-validation-into-do_settimeofday.patch
-compat_sys_pselect7-fix.patch
-device-mapper-snapshot-load-metadata-on-creation.patch
-device-mapper-log-bitset-fix-endian.patch
-device-mapper-ioctl-reduce-pf_memalloc-usage.patch
-device-mapper-statistics-basic.patch
-device-mapper-disk-statistics-timing.patch
-device-mapper-snapshot-barriers-not-supported.patch
-dm-dm-table-warning-fix.patch -seclvl_settime-fix.patch
-alpha-dma-mappingh-add-struct-scatterlist.patch
-ipw2200-fix-eeprom-check.patch
-ipmi-remove-invalid-acpi-register-spacing-check.patch
-tpm_infineon-fix-printk-format-warning.patch
-tpm_bios-needs-more-securityfs_-functions.patch
-tpm_bios-securityfs-error-checking-fix.patch -tpm_bios-indexing-fix.patch
-tpm-tpm-bios-fix-module-license-issue.patch
-tpm-tpm_bios-fix-sparse-warnings.patch
-tpm-tpm_bios-remove-unused-variable.patch
-mips-gdb-stubc-fix-parse-error-before-token.patch
-uml-compilation-fix-when-mode_skas-disabled.patch
-git-blktrace-sparc64-fix.patch -git-block-revert-stuff.patch
-sem2mutex-drivers-char-drm.patch
-drivers-char-drm-make-some-functions-static.patch
-ipw2100_match_buf-warning-fix.patch
-ipw2200-stack-reduction.patch
-tweak-orinoco_cs-debugging-message.patch
-revert-NET-Do-not-lose-accepted-socket-when-ENFILE-EMFILE.patch
-sem2mutex-ipw2x00.patch
-af_key-set-message-type.patch
-sungem-make-pm-of-phys-more-reliable-2.patch
-net-do-not-export-inet_bind_bucket_create-twice.patch
-serial-initialize-spinlock-for-port-failed-to-setup.patch
-gregkh-pci-pci-schedule-pci_legacy_proc-for-removal.patch
-gregkh-pci-pci-schedule-removal-of-pci_module_init.patch
-gregkh-pci-pci-irq-and-pci_ids-patch-for-intel-ich8.patch
-gregkh-pci-pci-drivers-pci-pci.c-if-0-pci_find_ext_capability.patch
-gregkh-pci-pci-make-it-easier-to-see-that-set_msi_affinity-is-used.patch
-gregkh-pci-pci-hotplug-fix-up-coding-style-issues.patch
-gregkh-pci-pci-hotplug-fix-up-kconfig-help-text.patch
-gregkh-pci-pci-restore-2-missing-pci-ids.patch
-gregkh-pci-pci-pci_ids-remove-duplicates-gathered-during-merge-period.patch
-gregkh-pci-pci-hotplug-powerpc-module-build-break.patch
-gregkh-pci-pci-hotplug-pci-panic-on-dlpar-add.patch
-gregkh-pci-pci-hotplug-shpchp-amd-pogo-errata-fix.patch
-gregkh-pci-powerpc-pci-hotplug-remove-rpaphp_find_bus.patch
-gregkh-pci-powerpc-pci-hotplug-remove-rpaphp_fixup_new_pci_devices.patch
-gregkh-pci-powerpc-pci-hotplug-merge-config_pci_adapter.patch
-gregkh-pci-powerpc-pci-hotplug-remove-remove_bus_device.patch
-gregkh-pci-powerpc-pci-hotplug-de-convolute-rpaphp_unconfig_pci_adap.patch
-gregkh-pci-powerpc-pci-hotplug-merge-rpaphp_enable_pci_slot.patch
-gregkh-pci-powerpc-pci-hotplug-cleanup-add-prefix.patch
-gregkh-pci-powerpc-pci-hotplug-minor-cleanup-forward-decls.patch
-gregkh-pci-powerpc-pci-hotplug-shuffle-error-checking-to-better-location.patch
-gregkh-pci-pci-cyblafb-remove-pci_module_init-return-really.patch
-gregkh-pci-pci-handle-bogus-mcfg-entries.patch
-gregkh-pci-msi-vector-targeting-abstractions.patch
-gregkh-pci-altix-msi-support.patch
-gregkh-pci-pci-fix-msi-build-breakage-in-x86_64.patch
-gregkh-pci-pci-clean-up-msi.c-a-bit.patch
-fusion-update.patch
-fusion-unloading-the-driver-results-in-panic-fix.patch
-fusion-unloading-the-driver-only-set-asyn-narrow-for-configured-devices.patch
-fusion-sanity-check.patch
-fusion-add-support-for-raid-hot-add-del-support.patch
-fusion-target-reset-when-drive-is-being-removed.patch
-fusion-move-sas-persistent-event-handling-over-to-the-mptsas-module.patch
-fusion-fc-rport-code-fixes.patch
-fusion-bump-version.patch
-gregkh-usb-usb-fix-ehci-early-handoff-issues.patch
-gregkh-usb-usb-fix-ehci-early-handoff-issues-warning.patch
-gregkh-usb-usb-ub-03-oops-with-cfq.patch
-gregkh-usb-usb-ub-04-loss-of-timer-and-a-hang.patch
-gregkh-usb-usb-ub-05-bulk-reset.patch
-gregkh-usb-usb-new-id-for-ftdi_sio.c-and-ftdi_sio.h.patch
-gregkh-usb-usb-ftdi_sio-new-ids-for-westrex-devices.patch
-gregkh-usb-usb-ftdi_sio-new-pid-for-pcdj-dac2.patch
-gregkh-usb-ftdi-two-new-atik-based-usb-astronomical-ccd-cameras.patch
-gregkh-usb-usb-yealink.c-cleanup-device-matching-code.patch
-gregkh-usb-usb-usb-storage-add-support-for-rio-karma.patch
-gregkh-usb-usb-cleanup-of-usblp.patch
-gregkh-usb-usb-fix-oops-in-acm-disconnect.patch
-gregkh-usb-usb-usb-storage-support-for-sony-dsc-t5-still-camera.patch
-gregkh-usb-usb-sn9c10x-driver-updates-and-bugfixes.patch
-gregkh-usb-usb-asix-add-device-ids-for-0g0-cable-ethernet.patch
-gregkh-usb-usb-touchkitusb.c-fix.patch
-gregkh-usb-usb-pl2303-added-support-for-ca-42-clone-cable.patch
-gregkh-usb-usb-add-new-pl2303-device-ids.patch
-gregkh-usb-usb-cp2101-add-new-device-ids.patch
-gregkh-usb-usb-sn9c10x-driver-updates.patch
-gregkh-usb-usb-add-et61x51-video4linux2-driver.patch
-gregkh-usb-usbatm-trivial-modifications.patch
-gregkh-usb-usbatm-add-flags-field.patch
-gregkh-usb-usbatm-remove-.owner.patch
-gregkh-usb-usbatm-kzalloc-conversion.patch
-gregkh-usb-usbatm-xusbatm-rewrite.patch
-gregkh-usb-usbatm-shutdown-open-connections-when-disconnected.patch
-gregkh-usb-usbatm-return-correct-error-code-when-out-of-memory.patch
-gregkh-usb-usbatm-use-dev_kfree_skb_any-rather-than-dev_kfree_skb.patch
-gregkh-usb-usbatm-measure-buffer-size-in-bytes-force-valid-sizes.patch
-gregkh-usb-usbatm-allow-isochronous-transfer.patch
-gregkh-usb-usbatm-handle-urbs-containing-partial-cells.patch
-gregkh-usb-usbatm-bump-version-numbers.patch
-gregkh-usb-usbatm-eilseq-workaround.patch
-gregkh-usb-usbatm-semaphore-to-mutex-conversion.patch
-gregkh-usb-ueagle-add-iso-support.patch
-gregkh-usb-ueagle-cosmetic.patch
-gregkh-usb-ueagle-cmv-name-bug.patch
-gregkh-usb-usb-add-new-auerswald-device-ids.patch
-gregkh-usb-usb-hid-add-blacklist-entry-for-hp-keyboard.patch
-gregkh-usb-usb-ehci-another-full-speed-iso-fix.patch
-gregkh-usb-usb-uhci-no-fsbr-until-device-is-configured.patch
-gregkh-usb-usb-remove-misc-devfs-droppings.patch
-gregkh-usb-usb-net2280-warning-fix.patch
-gregkh-usb-add-might_sleep-to-usb_unlink_urb.patch
-gregkh-usb-usb-isp116x-hcd-replace-mdelay-by-msleep.patch
-gregkh-usb-usb-gadgetfs-set-zero-flag-for-short-control-in-response.patch
-gregkh-usb-usb-remove-linux_version_code-check-in-pwc-pwc-ctrl.c.patch
-gregkh-usb-usb-ehci-fix-gfp_t-sparse-warning.patch
-gregkh-usb-usb-drivers-usb-media-w9968cf.c-remove-hooks-for-the-vpp-module.patch
-gregkh-usb-usb-drivers-usb-media-ov511.c-remove-hooks-for-the-decomp-module.patch
-gregkh-usb-usb-remove-extra-newline-in-hid_init_reports.patch
-gregkh-usb-usb-au1xx0-replace-casual-readl-with-au_readl-in-the-drivers.patch
-gregkh-usb-usb-arm26-fix-compilation-of-drivers-usb-core-message.c.patch
-gregkh-usb-usb-libusual-fix-warning-on-64bit-boxes.patch
-gregkh-usb-usb-yealink-printk-warning-fix.patch
-gregkh-usb-usb-usb-authentication-states.patch
-gregkh-usb-usb-gadget-zero-and-dma-coherent-buffers.patch
-hrtimers-fixup-itimer-conversion.patch
-hrtimers-fix-possible-use-of-null-pointer-in.patch
-hrtimers-fix-oldvalue-return-in-setitimer.patch
-hrtimers-fix-posix-timer-requeue-race.patch
-hrtimers-cleanups-and-simplifications.patch
-hrtimers-add-back-lost-credit-lines.patch
-hrtimers-set-correct-initial-expiry-time-for-relative.patch
-hrtimers-set-correct-initial-expiry-time-for-relative-fix.patch
-kernel-posix-timersc-remove-do_posix_clock_notimer_create.patch
-fix-deadlock-in-drivers-pci-msic.patch
-fix-uidhash_lock-rcu-deadlock.patch
-fix-uidhash_lock-rcu-deadlock-fix.patch
-rcu_torture_lock-deadlock-fix.patch
-optimize-off-node-performance-of-zone-reclaim.patch
-zone_reclaim-reclaim-on-memory-only-node-support.patch
-zone_reclaim-reclaim-on-memory-only-node-support-fix.patch
-zone_reclaim-reclaim-on-memory-only-node-support-fix-tidy.patch
-gfp_zonetypes-add-commentry-on-how-to-calculate.patch
-gfp_zonetypes-calculate-from-gfp_zonemask.patch
-mm-improve-function-of-sc-may_writepage.patch
-zone_reclaim-minor-fixes.patch
-use-32-bit-division-in-slab_put_obj.patch
-mm-hugepage-accounting-fix.patch
-zone_reclaim-do-not-unmap-file-backed-pages.patch
-zone_reclaim-partial-scans-instead-of-full-scan.patch
-#shrink_list-use-of-instead-leads-to-unintended-writing.patch
-direct-migration-v9-pageswapcache-checks.patch
-direct-migration-v9-migrate_pages-extension.patch
-direct-migration-v9-migrate_pages-extension-fixes.patch
-direct-migration-v9-migrate_pages-extension-fix2.patch
-direct-migration-v9-migrate_pages-extension-fix3.patch
-direct-migration-v9-remove_from_swap-to-remove-swap-ptes.patch
-direct-migration-v9-remove_from_swap-to-remove-swap-ptes-fixes.patch
-direct-migration-v9-upgrade-mpol_mf_move-and-sys_migrate_pages.patch
-direct-migration-v9-upgrade-mpol_mf_move-and-sys_migrate_pages-fixes.patch
-direct-migration-v9-avoid-writeback--page_migrate-method.patch
-direct-migration-v9-avoid-writeback--page_migrate-method-remove-unused-export-for-migrate_pages-and-isolate_lru_page.patch
-direct-migration-v9-avoid-writeback--page_migrate-method-fixes.patch
-direct-migration-v9-avoid-writeback-page_migrate-method-locking-fix.patch
-slab-distinguish-between-object-and-buffer-size.patch
-slab-minor-cleanup-to-kmem_cache_alloc_node.patch
-slab-have-index_of-bug-at-compile-time.patch
-slab-cache_estimate-cleanup.patch
-slab-extract-slab_destroy_objs.patch
-slab-extract-slab_putget_obj.patch
-slab-reduce-inlining.patch
-slab-extract-virt_to_cacheslab.patch
-slab-rename-ac_data-to-cpu_cache_get.patch
-slab-replace-kmem_cache_t-with-struct-kmem_cache.patch
-dump_stack-in-oom.patch
-slab-fix-kzalloc-and-kstrdup-caller-report-for-config_debug_slab.patch
-mm-slab-add-kernel-doc-for-one-function.patch
-slab-fix-sparse-warning.patch
-selinux-fix-and-cleanup-mprotect-checks.patch
-selinux-change-file_alloc_security-to-use-gfp_kernel.patch
-selinux-remove-security-struct-magic-number-fields.patch
-powerpc-fix-for-kexec-ppc32.patch
-modalias=-for-macio.patch
-powerpc-fix-sigmask-handling-in-sys_sigsuspend.patch
-sh-sh4-202-microdev-updates.patch
-sh-make-peripheral-clock-frequency-setting-mandatory.patch
-sh-move-tra-expevt-intevt-definitions-for-reuse.patch
-sh-cleanup-struct-sh_cpuinfo-for-clock-framework-changes.patch
-sh-unknown-mach-type-updates.patch
-sh-drop-maskpos-from-make_ipr_irq-remove-duplicate-irq-definitions.patch
-sh-convert-voyagergx-to-platform-device-drop-sh-bus.patch
-sh-sh-sci-clock-framework-updates.patch
-sh-add-missing-timers-directory-rule-to-build.patch
-sh-machine_halt-machine_power_off-cleanups.patch
-sh-sh64-fix-bogus-tiocgicount-definitions.patch
-arch-sh64-kernel-timec-add-moduleh.patch
-vmsplit-config-options.patch
-alpha-fix-getxpid-on-alpha-so-it-works-for-threads.patch
-arm26-fix-find_first_zero_bit-related-warnings.patch
-arm26-fix-warnings-about-nr_irqs-being-not-defined.patch
-arm26-remove-irq_exit-from-hardirqh.patch
-arm26-select-system-type-via-choice.patch
-arm26-fixup-get_signal_to_deliver-call.patch
-arm26-fixup-asm-statement-in-kernel-fiqc.patch
-arm26-drop-local-task_running-copy.patch
-arm26-drop-first-arg-of-prepare_arch_switch-finish_arch_switch.patch
-arm26-add-__kernel_old_dev_t-for-nfsd.patch
-arm26-select-blk_dev_fd-only-on-a5k.patch
-swsusp-use-bytes-as-image-size-units.patch
-uml-add-a-build-dependency.patch
-uml-fix-some-typos.patch
-uml-typo-fixup.patch
-uml-comments-about-libc-conflict-guards.patch
-uml-fix-hugest-stack-users.patch
-uml-fix-apples-bananas-typo.patch
-uml-tt-syscall_debug-fix-buglet-introduced-in-cleanup.patch
-uml-skas0-hold-own-ldt-fixups-for-x86-64.patch
-uml-some-harmless-sparse-warning-fixes.patch
-uml-avoid-config_nr_cpus-undeclared-bogus-error-messages.patch
-xtensa-add-asm-futexh.patch
-s390-build-dasd_cmd-into-dasd_mod.patch
-s390-dasd-remove-dynamic-ioctl-registration.patch
-s390-dasd-remove-dynamic-ioctl-registration-fix.patch
-s390-remove-cvs-generated-information.patch
-s390-overflow-in-sched_clock.patch
-s390-monotonic_clock-interface.patch
-s390-hangcheck-timer-support.patch
-s390-ccw_device_probe_console-return-value.patch
-s390-dasd-open-counter.patch
-s390-dasd-wait-for-clear-i-o-interrupt.patch
-s390-new-default-configuration.patch
-s390-add-support-for-new-syscalls-tif_restore_sigmask.patch
-s390-fix-modalias-for-ccw-devices.patch
-s390-add-missing-memory-constraint-to-stcrw.patch
-define-bits_per_byte.patch
-introduce-__iowrite32_copy.patch
-add-faster-__iowrite32_copy-routine-for-x86_64.patch
-sem2mutex-infiniband-2.patch
-sem2mutex-jfs.patch
-reiserfs-remove-kmalloc-wrapper.patch
-reiserfs-use-__gfp_nofail-instead-of-yield-and-retry-loop.patch
-reiserfs-missing-kmalloc-failure-check.patch
-reiserfs-remove-reiserfs_permission_locked.patch
-reiserfs-use-generic_permission.patch
-reiserfs-fix-race-between-invalidatepage-checks-and-data=ordered-writeback.patch
-reiserfs-zero-b_private-when-allocating-buffer-heads.patch
-reiserfs-hang-and-performance-fix-for-data=journal-mode.patch
-reiserfs-write_ordered_buffers-should-not-oops-on-dirty-non-uptodate-bh.patch
-reiserfs-fix-journal-accounting-in-journal_transaction_should_end.patch
-reiserfs-check-for-files-2gb-on-35x-disks.patch
-kernel-kprobesc-fix-a-warning-ifndef-arch_supports_kretprobes.patch
-fbcon-fix-screen-artifacts-when-moving-cursor.patch
-video-hp680-backlight-driver.patch
-i810fb-do-not-probe-the-third-i2c-bus-by-default.patch
-fbdev-fix-usage-of-blank-value-passed-to-fb_blank.patch
-md-fix-device-size-updates-in-md.patch
-md-make-sure-array-geometry-changes-persist-with-version-1-superblocks.patch
-md-dont-remove-bitmap-from-md-array-when-switching-to-read-only.patch
-md-add-sysfs-access-to-raid6-stripe-cache-size.patch
-docbook-allow-even-longer-return-types.patch
-docbook-fix-some-kernel-doc-comments-in-net-sunrpc.patch
-docbook-fix-some-kernel-doc-comments-in-fs-and-block.patch
-doc-kernel-doc-add-more-usage-info.patch
-kernel-doc-clean-up-the-script-whitespace.patch

 Merged

+fix-rocketport-driver.patch
+cleanup-documentation-driver-model-overviewtxt.patch
+md-handle-overflow-of-mdu_array_info_t-size-better.patch
+md-assorted-little-md-fixes.patch
+md-make-sure-rdev-size-gets-set-for-version-1-superblocks.patch
+kernel-kprobesc-fix-a-warning-ifndef-arch_supports_kretprobes.patch
+kprobes-fix-deadlock-in-function-return-probes.patch
+fix-build-failure-in-recent-pm_prepare_-changes.patch
+documentation-updated-pci-error-recovery.patch
+fix-generic_fls64.patch
+fix-compilation-errors-in-maps-dc21285c.patch

 Fixes for 2.6.16-rc2

+multiple-exports-of-strpbrk.patch
+multiple-exports-of-strpbrk-fix.patch

 Fix multiple EXPORT_SYMBOLs

+i386-cpu-hotplug-dont-access-freed-memory.patch

 init sectoin fix

+pnpacpi-fix-non-memory-address-space-descriptor-handling.patch
+pnpacpi-remove-some-code-duplication.patch
+pnpacpi-whitespace-cleanup.patch

 pnpacpi updates

+simplify-audit_free-locking.patch

 audit locking cleanup

-powernow-k7-work-when-kernel-is-compiled-for-smp.patch

 Dropped, had problems.

+cpufreq-_ppc-frequency-change-issues-freq-already-lowered-by-bios.patch

 cpufreq fix

+gregkh-i2c-i2c-i801-i2c-patch-for-intel-ich8.patch

 i2c tree update

+fix-debug-statement-in-inftlcorec.patch

 mtd fix

+s2io-c99-warning-fix.patch
+sky2-fix-ethtool-ops.patch
+e100-remove-init_hw-call-to-fix-panic.patch
+8139too-fix-a-tx-timeout-watchdog-thread-against-napi-softirq-race.patch
+ipw2200-warning-fix.patch
+drivers-net-e1000-proper-prototypes.patch
+gianfar-fix-sparse-warnings.patch
+prism54-warning-fix.patch
+sky2-fix-hang-on-yukon-ec-0xb6-rev-1.patch

 net driver fixes
 
+net-convert-rtnl-to-mutex.patch

 mutex conversion

+appletalk-warning-fix.patch
+smctr-warning-fix.patch

 net fixlets

+gregkh-pci-altix-msi-support-git-ia64-fix.patch

 Fix a patch in the PCI tree

+gregkh-usb-usb-remove-usbcore-specific-wakeup-flags.patch

 USB tree update

+uhci-hcd-fix-mistaken-usage-of-list_prepare_entry.patch
+gregkh-usb-usb-remove-usbcore-specific-wakeup-flags-fix.patch

 USB fixes

+x86_64-pmtimer-variable-fallback.patch
+x86_64-apic-timer-only-with-cx.patch
+x86_64-even-more-cpuinit.patch
+x86_64-iommu-fallback.patch
+x86_64-switchto-no-kprobes.patch
+x86_64-apic-pmtimer-calibrate.patch
+x86_64-cpu_pda-array-to-macro-followup-correction.patch
+x86_64-small-fix-for-cfi-annotations.patch
+x86_64-disallow-multi-byte-hardware-execution-breakpoints.patch
+x86_64-eliminate-set_debug.patch
+x86_64-minor-odering-correction-to-dump_pagetable.patch
+x86_64-save-fpu-context-slightly-later.patch
+x86_64-cleanup-allocating-logical-cpu-numbers-in-x86_64.patch
+x86_64-dont-record-local-apic-ids-when-they-are-disabled-in-madt.patch
+x86_64-pmtimer-dont-touch-pit.patch
+x86_64-boot-report-apicid.patch
+x86_64-bad-apic-ack.patch#X86_64-END

 x86_64 updates

+oom-kill-children-accounting.patch
+slab-object-to-index-mapping-cleanup.patch

 mm updates

+update-mm-acx-driver-to-version-0331.patch

 ACX wireless driver update

+x86-smp-alternatives-fix.patch
+x86-smp-alternatives-fix-2.patch

 Fix x86-smp-alternatives.patch

+i386-add-a-temporary-to-make-put_user-more-type-safe-fix.patch

 Fix i386-add-a-temporary-to-make-put_user-more-type-safe.patch

+i386-instead-of-poisoning-init-zone-change-protection.patch

 x86 debugging

+x86_64-print-the-offset-in-hex-as-opposed-to-decimal-in-stack-dump.patch

 Make x86_64 oopses saner-lookng

+s390-dasd-extended-error-reporting-module.patch
+s390-timer-interface-visibility.patch
+s390-compile-fix-missing-defines-in-asm-s390-ioh.patch
+s390-fix-compat-syscall-wrapper.patch
+s390-fix-to_channelpath-macro.patch

 s390 update

+kernel-modulec-semaphore-to-mutex-conversion-for-module_mutex.patch

 Mutex conversion

-add-trylock_kernel.patch
-add-trylock_kernel-fix.patch
-turn-on-might_sleep-in-early-bootup-code-too.patch

 Dropped - a bit messy, scary warnings, not very pointful.

+__generic_per_cpu-changes.patch

 per-cpu data changes

-exec-cleanup-exec-from-a-non-thread-group-leader.patch

 Dropped

+fat-replace-an-own-implementation-with-ll_rw_blockswrite.patch
+trivial-optimization-of-ll_rw_block.patch
+fat-fix-truncate-write-ordering.patch
+edac_mc-remove-include-of-versionh.patch
+tvec_bases-too-large-for-per-cpu-data.patch
+tvec_bases-too-large-for-per-cpu-data-fix.patch
+remove-drivers-mca-mca-procc.patch
+fix-keyctl-usage-of-strnlen_user.patch
+ip2main-warning-fixes.patch
+i4l-warning-fixes.patch
+debugfs-hard-link-count-wrong.patch
+kconfig-detect-if-lintl-is-needed-when-linking-confmconf.patch
+kconfig-detect-if-lintl-is-needed-when-linking-confmconf-fix.patch
+unify-pxm_to_node-id-ver2-generic-code.patch
+unify-pxm_to_node-id-ver2-for-ia64.patch
+unify-pxm_to_node-id-ver2-for-x86_64.patch
+unify-pxm_to_node-id-ver2-for-i386.patch
+extract-ikconfig-use-mktemp1.patch
+extract-ikconfig-be-sure-binoffset-exists-before-extracting.patch
+extract-ikconfig-dont-use-long-options.patch
+vfs-ensure-lookup_continue-flag-is-preserved-by.patch

 Misc

+exec-allow-init-to-exec-from-any-thread.patch
+simplify-exec-from-inits-subthread.patch
-pid-dont-hash-pid-0.patch
+pidhash-dont-count-idle-threads.patch
+pidhash-dont-use-zero-pids.patch
+dont-touch-current-tasks-in-de_thread.patch
+choose_new_parent-remove-unused-arg-sanitize-exit_state-check.patch

 Various core kernel cleanups from Oleg and Eric.

+mempool-add-page-allocator.patch
+mempool-add-page-allocator-fix.patch
+mempool-add-page-allocator-fix-2.patch
+mempool-use-common-mempool-page-allocator.patch
+mempool-add-kmalloc-allocator.patch
+mempool-use-common-mempool-kmalloc-allocator.patch
+mempool-add-kzalloc-allocator.patch
+mempool-add-kmalloc-allocator-fix.patch
+mempool-use-common-mempool-kzalloc-allocator.patch
+mempool-add-mempool_create_slab_pool.patch
+mempool-add-mempool_create_slab_pool-fix.patch
+mempool-add-mempool_create_slab_pool-update.patch
+mempool-use-mempool_create_slab_pool.patch

 mempool code librarification

+time-reduced-ntp-rework-part-1.patch
+time-reduced-ntp-rework-part-2.patch
+time-reduced-ntp-rework-part-2-fix.patch
+time-clocksource-infrastructure.patch
+time-clocksource-infrastructure-fix-clocksource_lock-deadlock.patch
+time-generic-timekeeping-infrastructure.patch
+time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
+time-i386-conversion-part-2-rework-tsc-support.patch
+time-i386-conversion-part-2-rework-tsc-support-c2-fix.patch
+time-i386-conversion-part-3-enable-generic-timekeeping.patch
+time-i386-conversion-part-4-remove-old-timer_opts-code.patch
+time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change.patch
+time-i386-clocksource-drivers.patch
+time-fix-cpu-frequency-detection.patch
+time-delay-clocksource-selection-until-later-in-boot.patch
+x86-blacklist-tsc-from-systems-where-it-is-known-to-be-bad.patch

 Bring back John's time-reqork patches.  New, improved, fixed.

+kprobes-clean-up-resume_execute.patch
+x86-kprobes-booster.patch
+kretprobe-kretprobe-booster.patch

 kprobes cleanup and speedups

+sched-new-sched-domain-for-representing-multi-core.patch
+sched-new-sched-domain-for-representing-multi-core-fix.patch
+sched-new-sched-domain-for-representing-multi-core-default-y.patch

 Multicore support in the CPU scheduler.

+sis5513-support-sis-965l.patch

 Bring back this IDE fix

+vgacon-add-support-for-soft-scrollback-fix.patch

 Fix vgacon-add-support-for-soft-scrollback.patch

+pidhash-temporal-debug-checks.patch

 pid debugging



All 869 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm5/patch-list



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbTIEI6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 04:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTIEI6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 04:58:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:20695 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262279AbTIEI6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 04:58:33 -0400
Date: Fri, 5 Sep 2003 01:59:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test4-mm6
Message-Id: <20030905015927.472aa760.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/


This is only faintly tested.  It's mainly a syncup with people..

. Initial support for kgdb-over-ethernet.  Mainly from Robert Walsh, based
  on work by San Mehat.

  It's pretty simple to use - read Documentation/i386/kgdb/kgdbeth.txt
  carefully.

  This uses the same ethernet driver hooks as netconsole, and is designed
  to work alongside netconsole.

  Currently it "supports" e100, eepro100, 3c59x, tlan and tulip.  Only e100
  has been tested.

. More preparation for the larger dev_t, from Al.

. Dropped out Nick's CPU scheduler changes, brought back Con's interactivity
  work.

  We didn't get many reports from this in -mm5.  I'd prefer to stick with
  Con's patches because they're tweaks, rather than fundamental changes and
  they have had more testing and are more widely understood.

  But the performance regressions with specjbb and volanomark are a
  problem.  We need to understand this and get it fixed up.

. The dev_t changes broke the feral driver.  The version in -mm is
  fairly out of date anyway and I probably need to drop it or get a fresh
  version from James..


Changes since 2.6.0-test4-mm5:
 

-misc34.patch
-fix-strange-code-in-bio_add_page.patch
-convert-proc-stat-to-seq_file.patch
-get_rtc_time-fix.patch
-visws-qla1280-needs-pio.patch
-elv-insertion-fix.patch
-8250_acpi-taints-kernel.patch
-proc_misc-build-fix.patch
-slab-check-PG_slab.patch
-might_sleep-improvements.patch
-MODULE_ALIAS-in-block-devices.patch
-MODULE_ALIAS-in-char-devices.patch
-unpercpuify-in_flight-counter.patch
-enable-selinux-with-boot-parameter.patch
-pty-devfs-fix.patch
-i8042-free_irq-fix.patch
-netlink-warning-fixes.patch

 Merged

+kgdb-over-ethernet.patch
+kgdb-over-ethernet-fixes.patch
+kgdb-CONFIG_NET_POLL_CONTROLLER.patch
+kgdb-handle-stopped-NICs.patch
+eepro100-poll-controller.patch
+tlan-poll_controller.patch
+tulip-poll_controller.patch
+kgdb-eth-smp-fix.patch

 kgdb-over-ethernet support

+fix-io-hangs.patch

 Hopefully fix the tasks-stuck-in-D-state bug

+as-insert-here-fix.patch

 Anticipatory scheduler fix

+no-unit-at-a-time.patch

 gcc-3.4 workaround

+calibrate_tsc-consolidation.patch

 calibrate_tsc() fixes

+large-dev_t-2nd-01.patch
+large-dev_t-2nd-02.patch
+large-dev_t-2nd-03.patch
+large-dev_t-2nd-04.patch
+large-dev_t-2nd-05.patch
+large-dev_t-2nd-06.patch
+large-dev_t-2nd-07.patch
+large-dev_t-2nd-08.patch
+large-dev_t-2nd-09.patch
+large-dev_t-2nd-10.patch
+large-dev_t-2nd-11.patch
+large-dev_t-2nd-12.patch
+large-dev_t-2nd-13.patch
+large-dev_t-2nd-14.patch
+large-dev_t-2nd-15.patch

 large dev_t work

+swsusp-fpu-fix.patch

 software suspend fix

+dac960-warning-fixes.patch

 Warning fix

+ikconfig-gzipped-2.patch

 Reworked

+joydev-exclusions.patch

 Joystick fix

+might_sleep-diags.patch

 More might_sleep() info

+imm-fix-fix.patch

 SCSI driver fix

+selinux-option-config-option.patch

 SELinux: select the boot-time selectability at compile time.

+sound-remove-duplicate-includes.patch
+kernel-remove-duplicate-includes.patch

 janitorial work

+utime-on-immutable-file-fix.patch

 Disallow utime() on immutable and append-only files.

+remove-version_h.patch
+remove-__SMP__.patch
+make-init_mister-static.patch
+skfddi-copy_user-checks.patch
+ll_rw_blk-comment-corrections.patch
+sc520_wdt-ioremap-checking.patch
+paride-error-return-handling.patch
+add-daniele-to-credits.patch
+init-exit-cleanups.patch
+qla1280-pci-alloc-free-checking.patch
+saa7134-core-ioremap-checking.patch

 janitorial work

+NR_CPUS-overflow-fix.patch

 Avoid overflows of NR_CPUS-sized arrays.

-ia32-mknod64.patch
-ext2-64-bit-special-inodes.patch
-ext3-64-bit-special-inodes.patch
-64-bit-dev_t-kdev_t.patch
-64-bit-dev_t-other-archs.patch
-mknod64-64-bit-fix.patch
-ustat64.patch
-ppc-64-bit-stat.patch
-64-bit-dev_t-init_rd-fixes.patch
-arch-dev_t-stat-fixes.patch

 64-bit dev_t stuff dropped for now.

-np-sched-01-sched-fork-cleanup.patch
-np-sched-02-sched-migrate-fix.patch
-np-sched-03-sched-balance-tuning.patch
-np-sched-04-sched-policy-10b.patch

 Drop Nick's CPU scheduler things

+sched-CAN_MIGRATE_TASK-fix.patch
+sched-balance-fix-2.6.0-test3-mm3-A0.patch
+sched-2.6.0-test2-mm2-A3.patch
+ppc-sched_clock.patch
+ppc64-sched_clock.patch
+sparc64_sched_clock.patch
+x86_64-sched_clock.patch
+sched-warning-fix.patch
+sched-balance-tuning.patch
+sched-no-tsc-on-numa.patch
+o12.2int.patch
+o12.3.patch
+o13int.patch
+o13.1int.patch
+o14int.patch
+o14int-div-fix.patch
+o14.1int.patch
+o15int.patch
+o16int.patch
+o16.1int.patch
+o16.2int.patch
+o16.3int.patch
+o18int.patch
+o18.1int.patch
+sched-cpu-migration-fix.patch
+o19int.patch
+o20int.patch

 Con's CPU scheduler things.

+4g4g-cyclone-timer-fix.patch

 Compile fix






All 186 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix

kgdb-warning-fix.patch
  kgdbL warning fix

kgdb-build-fix.patch

kgdb-spinlock-fix.patch

kgdb-fix-debug-info.patch
  kgdb: CONFIG_DEBUG_INFO fix

kgdb-cpumask_t.patch

kgdb-x86_64-fixes.patch
  x86_64 fixes

kgdb-over-ethernet.patch
  kgdb-over-ethernet patch

kgdb-over-ethernet-fixes.patch
  kgdb-over-ethernet fixlets

kgdb-CONFIG_NET_POLL_CONTROLLER.patch
  kgdb: replace CONFIG_KGDB with CONFIG_NET_RX_POLL in net drivers

kgdb-handle-stopped-NICs.patch
  kgdb: handle netif_stopped NICs

eepro100-poll-controller.patch

tlan-poll_controller.patch

tulip-poll_controller.patch

kgdb-eth-smp-fix.patch
  kgdb-over-ethernet: fix SMP

fix-io-hangs.patch
  fix IO hangs

as-insert-here-fix.patch
  AS: insert_here fallout

no-unit-at-a-time.patch
  Use -fno-unit-at-a-time if gcc supports it

calibrate_tsc-consolidation.patch
  calibrate_tsc() fix and consolidation

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-build-fixes.patch
  Fix ppc64 breakage

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

ppc64-local.patch
  ppc64: local.h implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

rt-tasks-special-vm-treatment.patch
  real-time enhanced page allocator and throttling

rt-tasks-special-vm-treatment-2.patch

input-use-after-free-checks.patch
  input layer debug checks

fbdev.patch
  framebbuffer driver update

cursor-flashing-fix.patch
  fbdev: fix cursor letovers

slab-hexdump.patch
  slab: hexdump structures when things go wrong

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

thread-pgrp-fix-2.patch
  Fix setpgid and threads

ramdisk-cleanup.patch

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

intel8x0-cleanup.patch
  intel8x0 cleanups

claim-serio-early.patch
  Serio: claim serio early

mark-devfs-obsolete.patch
  mark devfs obsolete

cfq-3.patch
  CFQ io scheduler

cfq-3-fixes.patch
  CFQ fixes

sysfs-memleak-fix.patch
  Fix sysfs memory leak

VT8231-router-detection.patch
  VT8231 IRQ router detection

block-devfs-conversions.patch
  Initialise devfs_name in various block drivers

large-dev_t-2nd-01.patch
  (1/15) large dev_t - second series

large-dev_t-2nd-02.patch
  (2/15) large dev_t - second series

large-dev_t-2nd-03.patch
  (3/15) large dev_t - second series

large-dev_t-2nd-04.patch
  (4/15) large dev_t - second series

large-dev_t-2nd-05.patch
  (5/15) large dev_t - second series

large-dev_t-2nd-06.patch
  (6/15) large dev_t - second series

large-dev_t-2nd-07.patch
  (7/15) large dev_t - second series

large-dev_t-2nd-08.patch
  (8/15) large dev_t - second series

large-dev_t-2nd-09.patch
  (9/15) large dev_t - second series

large-dev_t-2nd-10.patch
  (10/15) large dev_t - second series

large-dev_t-2nd-11.patch
  (11/15) large dev_t - second series

large-dev_t-2nd-12.patch
  (12/15) large dev_t - second series

large-dev_t-2nd-13.patch
  (13/15) large dev_t - second series

large-dev_t-2nd-14.patch
  (14/15) large dev_t - second series

large-dev_t-2nd-15.patch
  (15/15) large dev_t - second series

timer_tsc-cyc2ns_scale-fix.patch
  monolitic_clock, timer_{tsc,hpet} and CPUFREQ

test4-pm1.patch
  power management update

ide-pm-oops-fix.patch
  IDE power management oops fix

kobject-unlimited-name-lengths.patch
  kobject: Support unlimited name lengths.

kobject-unlimited-name-lengths-use-after-free-fix.patch
  kobject_cleanup() use-after-free-fix

swsusp-fpu-fix.patch
  swsusp fpu management fix

ricoh-mask-fix.patch
  pcmcia: ricoh.h mask fix
  EDEC
  From: KOMURO <komujun@nifty.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
  
  RL5C4XX_16BIT_MEM_0 was wrong.

dac960-devfs_name-fix.patch
  dac960 devfs_name initialisation fix

dac960-warning-fixes.patch
  compiler warning fixes for DAC960 on alpha

ikconfig-gzipped-2.patch
  Move ikconfig to /proc/config.gz
  ikconfig cleanup

flush-invalidate-fixes.patch
  memory writeback/invalidation fixes

flush-invalidate-fixes-warning-fix.patch

ide_floppy-maybe-fix.patch
  might fix ide_floppy

reiserfs-direct-io.patch
  resierfs direct-IO support

pdflush-diag.patch

joydev-exclusions.patch
  joydev is too eager claiming input devices

might_sleep-diags.patch

imm-fix-fix.patch
  Fix imm.c again

selinux-option-config-option.patch
  make selinux enable param config option, enabled by default

sound-remove-duplicate-includes.patch
  sound: remove duplicate includes

kernel-remove-duplicate-includes.patch
  remove duplicate includes in kernel/

utime-on-immutable-file-fix.patch
  disallow utime{s}() on immutable or append-only files

remove-version_h.patch
  remove unneeded <linux/version.h>

remove-__SMP__.patch
  Subject: [PATCH] janitor: remove remaining __SMP__ references

make-init_mister-static.patch
  Subject: [PATCH] janitor: make init function static

skfddi-copy_user-checks.patch
  skfddi: copy*user error handling

ll_rw_blk-comment-corrections.patch
  blk_ll_rw comment corrections

sc520_wdt-ioremap-checking.patch
  handle ioremap() failure case

paride-error-return-handling.patch
  paride error return handling fixes

add-daniele-to-credits.patch
  add Daniele to CREDITS

init-exit-cleanups.patch
  more init/exit cleanups

qla1280-pci-alloc-free-checking.patch
  qla1280 pci alloc/free consistent checking

saa7134-core-ioremap-checking.patch
  saa7134 pci alloc/free consistent checking

NR_CPUS-overflow-fix.patch
  Handle NR_CPUS overflow

really-use-english-date-in-version-string.patch
  really use english date in version string

acpi-pci-routing-fixes.patch
  Fixing USB interrupt problems with ACPI enabled

p00001_synaptics-restore-on-close.patch

p00002_psmouse-reset-timeout.patch

p00003_synaptics-multi-button.patch

p00004_synaptics-optional.patch

p00005_synaptics-pass-through.patch

p00006_psmouse-suspend-resume.patch

p00007_synaptics-old-proto.patch

synaptics-mode-set.patch
  Synaptics mode setting

syn-multi-btn-fix.patch
  synaptics multibutton fix

keyboard-resend-fix.patch
  keyboard resend fix

psmouse_ipms2-option.patch
  Force mouse detection as imps/2 (and fix my KVM switch)

i8042-history.patch
  debug: i8042 history dumping

linux-isp-2.patch

linux-isp-2-fix-again.patch
  lost feral fix

feral-bounce-fix.patch
  Feral driver - highmem issues

feral-bounce-fix-2.patch
  Feral driver bouncing fix

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch
  print a few config options on oops

show_task-free-stack-fix.patch
  show_task() fix and cleanup

put_task_struct-debug.patch

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

sparc64-lockmeter-fix.patch

sparc64-lockmeter-fix-2.patch
  Fix lockmeter on sparc64

printk-oops-mangle-fix.patch
  disentangle printk's whilst oopsing on SMP

20-odirect_enable.patch

21-odirect_cruft.patch

22-read_proc.patch

23-write_proc.patch

24-commit_proc.patch

25-odirect.patch

nfs-O_DIRECT-always-enabled.patch
  Force CONFIG_NFS_DIRECTIO

sched-CAN_MIGRATE_TASK-fix.patch
  CAN_MIGRATE fix

sched-balance-fix-2.6.0-test3-mm3-A0.patch
  sched-balance-fix-2.6.0-test3-mm3-A0

sched-2.6.0-test2-mm2-A3.patch
  sched-2.6.0-test2-mm2-A3

ppc-sched_clock.patch

ppc64-sched_clock.patch
  ppc64: sched_clock()

sparc64_sched_clock.patch

x86_64-sched_clock.patch
  Add sched_clock for x86-64

sched-warning-fix.patch

sched-balance-tuning.patch
  CPU scheduler balancing fix

sched-no-tsc-on-numa.patch
  Subject: Re: Fw: Re: 2.6.0-test2-mm3

o12.2int.patch
  O12.2int for interactivity

o12.3.patch
  O12.3 for interactivity

o13int.patch
  O13int for interactivity

o13.1int.patch
  O13.1int

o14int.patch
  O14int

o14int-div-fix.patch
  o14int 64-bit-divide fix

o14.1int.patch
  O14.1int

o15int.patch
  O15int for interactivity

o16int.patch
  From: Con Kolivas <kernel@kolivas.org>
  Subject: [PATCH] O16int for interactivity

o16.1int.patch
  O16.1int for interactivity

o16.2int.patch
  O16.2int

o16.3int.patch
  O16.3int

o18int.patch
  O18int

o18.1int.patch
  O18.1int

sched-cpu-migration-fix.patch
  sched: task migration fix

o19int.patch
  O19int

o20int.patch
  O20int

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

4g4g-cyclone-timer-fix.patch

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

aio-01-retry.patch
  AIO: Core retry infrastructure

io_submit_one-EINVAL-fix.patch
  Fix aio process hang on EINVAL

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-05-fs_write-fix.patch

aio-06-bread_wq.patch
  AIO: Async block read

aio-06-bread_wq-fix.patch

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

O_SYNC-speedup-2.patch
  speed up O_SYNC writes

aio-09-o_sync.patch
  aio O_SYNC

aio-10-BUG-fix.patch
  AIO: fix a BUG

aio-11-workqueue-flush.patch
  AIO: flush workqueues before destroying ioctx'es

aio-12-readahead.patch
  AIO: readahead fixes

aio-dio-no-readahead.patch
  aio O_DIRECT no readahead

lock_buffer_wq-fix.patch
  lock_buffer_wq fix

unuse_mm-locked.patch
  AIO: hold the context lock across unuse_mm

aio-take-task_lock.patch
  From: Suparna Bhattacharya <suparna@in.ibm.com>
  Subject: Re: 2.5.72-mm1 - Under heavy testing with AIO,.. vmstat seems to blow the kernel

aio-O_SYNC-fix.patch
  Unify o_sync changes for aio and regular writes

aio-O_SYNC-fix-missing-bit.patch
  aio-O_SYNC-fix bits got lost

O_SYNC-speedup-nolock-fix.patch

aio-writev-nsegs-fix.patch
  aio: writev nr_segs fix

aio-remove-lseek-triggerable-BUG_ONs.patch

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup

aio-osync-fix-2.patch
  More AIO O_SYNC related fixes




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWDOVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWDOVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWDOVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 17:52:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965155AbWDOVw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 17:52:58 -0400
Date: Sat, 15 Apr 2006 14:52:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: Clear performance regression on reaim7 in 2.6.15-git6
Message-Id: <20060415145227.5d1249bd.akpm@osdl.org>
In-Reply-To: <44416616.10908@google.com>
References: <4441452F.3060009@google.com>
	<20060415141744.042231a8.akpm@osdl.org>
	<44416616.10908@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@google.com> wrote:
>
> drilling down into the results directories can get you the command line,
>  looks like "reaim -f workfile.short -s 1 -e 10 -i 2" to me. Buggered if
>  I can recall what that did though.
> 
>  (http://test.kernel.org/abat/20229/004.reaim.test/results/cmdline)
> 
>  I *think* it's only ia32 NUMA boxes, at least as far as I can see from
>  a quick poke around. Which would make me guess at scheduler code. Gitweb
>  would be nice to use, but it doesn't tag the -git snapshots, AFAICS, 
>  which is a real shame. Nor does the git snapshot include the git tag,
>  as far as I know. Grrrr. I guess I'll download the snapshots and diff
>  them, and try to pull out the sched changes by hand. Much suckage.

The diffstat for 2.6.15-git5 -> 2.6.15-git6 is at
http://www.zip.com.au/~akpm/linux/patches/stuff/2 - only a single line
changed in sched.c:

diff -uNr 2.6.15-git5/kernel/sched.c 2.6.15-git6/kernel/sched.c
--- 2.6.15-git5/kernel/sched.c	2006-04-15 14:10:43.000000000 -0700
+++ 2.6.15-git6/kernel/sched.c	2006-04-15 14:10:52.000000000 -0700
@@ -4386,6 +4386,7 @@
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+	mutex_debug_show_all_locks();
 }
 
 /**

The below patches went from -mm into mainline on that day.  It'll be pretty
simple to bisection search these once we have a testcase.


"tiny-make-id16-support-optional" fixes
nvidiafb: Fixes for new G5
printk levels for i386 oops code.
ipmi: fix compile errors with PROC_FS=n
Remove set_fs() in stop_machine()
spufs: fix for recent "shrink dentry_struct" patch
printk levels for spinlock debug
kdump: i386 save ss esp bug fix
kdump: dynamic per cpu allocation of memory for saving cpu registers
kdump: export per cpu crash notes pointer through sysfs (fix)
dump_thread() cleanup
Kdump: i386 compiler warning fix
Add list_for_each_entry_safe_reverse()
fix /sys/class/net/<if>/wireless without dev->get_wireless_stats
kexec: increase max segment limit
Kdump documentation update
kdump: x86_64 kexec on panic
kdump: export per cpu crash notes pointer through sysfs
remove ext3 xattr permission checks
Kdump: powerpc and s390 build failure fix
kdump: save registers early (inline functions)
Disable rio on 64-bit platforms
kdump: x86_64: add memmmap command line option
remove ext2 xattr permission checks
kdump: x86_64: add elfcorehdr command line option
remove reiserfs xattr permission checks
kprobes: cleanup include/asm/kprobes.h
remove xfs xattr permission checks
move xattr permission checks into the VFS
remove jfs xattr permission checks
i386: GPIO driver for AMD CS5535/CS5536
per-mountpoint noatime/nodiratime
switch autofs4 to touch_atime()
->compat_ioctl for 390 tape_char
kdump: read previous kernel's memory
remove update_atime
hrtimer: coding style and white space cleanup
remove asm/serial.h from synclink_gt.
media-radio: Maestro types change
kdump: x86_64 save cpu registers upon crash
kprobes: arch_remove_kprobe
hrtimer: clean up mktime and make arguments const
kprobes-changed-from-using-spinlock-to-mutex fix
hrtimer: remove unused clock constants
hrtimer: move div_long_long_rem out of jiffies.h
hrtimer: hrtimer documentation
9p: remove superflous MS_NODIRATIME assignment
hrtimer: hrtimer core code
nvidiafb: i2c bus name beautification
__deprecated_for_modules the lookup_hash() prototype
switch fs3270 to ->compat_ioctl
media-radio: Pci probing for maestro radio
kprobes: enable funcions only for required arch
fbcon: Sanitize fbcon
kexec: change CONFIG_PHYSICAL_START dependency
fbdev: rivafb: Driver cleanups
hrtimer: introduce ktime_t time format
hrtimer: switch itimers to hrtimer
hrtimer: coding style and white space cleanup 2
hrtimer: make clockid_t arguments const
Generic ioctl.h
remove TIOCGSERIAL/TIOCSSERIAL compat_ioctl entries for 390
hrtimer: validate timespec of do_sys_settimeofday
sanitize building of fs/compat_ioctl.c
matroxfb: Remove fbcon.h from the main header file
ntfs: remove superflous MS_NOATIME/MS_NODIRATIME assignments
don't include ioctl32.h in drivers
replace inode_update_time with file_update_time
hrtimer: coding style clean up of clock constants
hrtimer: switch sys_nanosleep to hrtimer
fbcon: Store struct display when setting all vcs
kprobes: changed from using spinlock to mutex
hrtimer: export deinlined mktime
hrtimer: create and use timespec_valid macro
vesafb: Drop blank hook
add vfs_* helpers for xattr operations
d_instantiate_unique / NFS inode leakage
Kprobes: conversion from kcalloc to kzalloc
media-radio: Maestro avoid accessing private structures directly
nfs: sleep_on() removal
Switch getnstimestamp() calls to ktime_get_ts()
savagefb: One more I2C-enabled device in savagefb
common compat_sys_timer_create
media-radio: Maestro radio delete owner line from video device
Remove getnstimestamp()
kprobes: fix build breakage
Export ktime_get_ts()
move rtc compat ioctl handling to fs/compat_ioctl.c
add ->compat_ioctl to dasd
hrtimer: convert posix timers completely
hrtimer: switch clock_nanosleep to hrtimer nanosleep API
fbdev: i810fb: Driver cleanups
hrtimer: deinline mktime and set_normalized_timespec
aty: remove unnecessary CONFIG_PCI
media-radio: Maestro radio Lindent
hrtimer: remove duplicate div_long_long_rem implementation
Add sysfs entry to disable framebuffer access
hrtimer: create hrtimer nanosleep API
hrtimer: introduce nsec_t type and conversion functions
fbdev: savagefb: Driver cleanup
fbdev: neofb: Driver cleanups
fbdev: tdfxfb: Driver cleanups
fbdev: hgafb: Convert to platform device
fbdev: asiliantfb: Driver cleanups
atyfb: Fix spelling
Fix vesafb display panning regression
nvidiafb: Add support for some pci-e chipsets
DocBook: fix kernel-doc comments
Docs update: remove obsolete patch from locks.txt
turn "const static" into "static const"
Fix console blanking
fbdev: Fix return code of fb_read and fb_write
fbdev: imsttfb: Driver cleanups
fbdev: nvidiafb: Driver cleanup
Docs update: small spelling, formating etc fixes for filesystems/ext3.txt
char/isicom: Other little changes
vga16fb: Trim vga16fb_pan_display
rivafb: Trim rivafb_pan_display
Docs update: small fixes to stable_kernel_rules.txt
Serial: disable jsm in ppc64 defconfig
fbdev: sstfb: Driver cleanups
vesafb: Trim vesafb_pan_display
skeletonfb: Documentation update
fs/binfmt_elf: Remove unneeded kmalloc() return value casts
fbdev: pm2fb: Driver cleanups
Add git tree for DocBook
CodingStyle correction
char/isicom: Type conversion and variables deletion
include/video/newport.h: "extern inline" -> "static inline"
DocBook: warn for missing macro parameters
fs/ext3/: small cleanups
fbcon: Code cleanups
fbdev: fbdev: Cleanup
nvidiafb: Add boot option 'bpp'
savagefb: Trim savagefb_pan_display
drivers/video/: possible cleanups
DocBook: add .gitignore file
non-linear frame buffer read/write access
fs/ext2/bitmap.c: ext2_count_free() is only required #ifdef EXT2FS_DEBUG
fbdev: Reduce stack usage
s3c2410fb: cleanup and fix
fbdev: atyfb: Remove BIOS-less booting
drivers/char: Use ARRAY_SIZE macro
fbcon: disable ywrap if not supported by fbcon  scrolling code
atyfb: Reduce verbosity
Docs update: typos, corrections and additions to applying-patches.txt
i810fb: Fix suspend and resume hooks
atyfb: LT/LG cleanup
atyfb: Rage XL/XC cleanup
include/asm-sh64/: "extern inline" -> "static inline"
tty-layer-buffering-revamp: jsm is broken
atyfb: VT/GT cleanup
atyfb: Don't stretch with CRT
atyfb: Set ECP divider
fbdev: kyrofb: Driver cleanups
fbdev: Replace kmalloc with kzalloc
fs/hfsplus/: remove the hfsplus_inode_check() debug function
Decrease number of pointer derefs in exit.c
atyfb: Fix CRTC_FIFO_LWM mask
video/matrox/matroxfb_misc.c: remove dead code
atyfb: Fix interlaced modes
nvidiafb: Reduce stack usage
vr41xx: ARRAY_SIZE cleanup
char/isicom: Firmware loading
include/linux/sched.h: no need to guard the normalize_rt_tasks() prototype
char/isicom: Whitespace cleanup
char/isicom: More whitespaces and coding style
char/isicom: Pci probing added
Decrease number of pointer derefs in multipath.c
drivers/net/irda/irport.c: cleanups
kernel/resource.c: __check_region(): remove pointless __deprecated
fbdev: Typos in Kconfig
let MAGIC_SYSRQ no longer depend on DEBUG_KERNEL
lib/zlib*: cleanups
atyfb: Improve blanking
selinux: Remove unneeded k[cm]alloc() return value casts
n_hdlc.c: remove unused declaration
clean up computone remaining cli use
TTY layer buffering revamp



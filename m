Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbTJUXs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 19:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTJUXs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 19:48:58 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:7384 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263109AbTJUXs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 19:48:27 -0400
Date: Tue, 21 Oct 2003 16:48:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: pge99gwy@studserv.uni-leipzig.de
Subject: [Bug 1397] New: free_hot_cold_page error on mm test8-mm1
Message-ID: <77810000.1066780111@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1397

           Summary: free_hot_cold_page error on mm test8-mm1
    Kernel Version: 2.6.0-test8-mm1
            Status: NEW
          Severity: high
             Owner: akpm@digeo.com
         Submitter: pge99gwy@studserv.uni-leipzig.de


Output of scripts/ver_linux is:
Linux hal 2.4.20-xfs-r3 #1 Sat Oct 18 18:56:51 CEST 2003 i686 AMD Athlon(tm) XP
2000+ AuthenticAMD GNU/Linux
 
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre2
e2fsprogs              1.34
xfsprogs               2.3.9
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.13
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         cmpci

This may look a bit strange, as i report a bug on test8-mm1, but i run a 2.4.20
kernel now because of heavy loss of data with the testing kernel.

I include a bugreport i filed at bugs.gentoo.org, as they told me there i should
assign it to this list.

http://bugs.gentoo.org/show_bug.cgi?id=31650

           Summary: mm-sources behave strange: Bad page state at
                    free_hot_cold_page
           Product: Gentoo Linux
           Version: unspecified
          Platform: x86
        OS/Version: Linux
            Status: NEW
          Severity: critical
          Priority: P2
         Component: Core system
        AssignedTo: bug-wranglers@gentoo.org
        ReportedBy: pge99gwy@studserv.uni-leipzig.de


hm, i don't know if this bug is for you, for the kernel mailing list or if it is
just due to some misconfiguration of my box, but anyway: i'll file it here
first, because i think it is kernel-related. my problem is:
there are randomly strange segfaults of different programms. most of the time it
seems to start with portage, but i'm not sure if always. then other programs
start to segfault. in my /var/log/messages appear a lot of lines like:
Oct 21 08:17:18 hal login(pam_unix)[3112]: session opened for user root by (uid=0)
Oct 21 08:20:48 hal Bad page state at free_hot_cold_page
Oct 21 08:20:48 hal flags:0x01000014 mapping:00000000 mapped:1 count:0
Oct 21 08:20:48 hal Backtrace:
Oct 21 08:20:48 hal Call Trace:
Oct 21 08:20:48 hal [<c0131bcb>] bad_page+0x41/0x64
Oct 21 08:20:48 hal [<c013219b>] free_hot_cold_page+0x48/0xd8
Oct 21 08:20:48 hal [<c013923b>] zap_pte_range+0x13c/0x174
Oct 21 08:20:48 hal [<c01392b7>] zap_pmd_range+0x44/0x50
Oct 21 08:20:48 hal [<c0139300>] unmap_page_range+0x3d/0x59
Oct 21 08:20:48 hal [<c01393f5>] unmap_vmas+0xd9/0x1c7
Oct 21 08:20:48 hal [<c013c7de>] exit_mmap+0x61/0x14c
Oct 21 08:20:48 hal [<c01194e7>] mmput+0x7b/0xb8
Oct 21 08:20:48 hal [<c011ca1e>] do_exit+0x152/0x33d
Oct 21 08:20:48 hal [<c011ccd7>] sys_exit_group+0x0/0x11
Oct 21 08:20:48 hal [<c0123ee7>] get_signal_to_deliver+0x2bd/0x2e2
Oct 21 08:20:48 hal [<c010a55e>] do_signal+0x4f/0xbc
Oct 21 08:20:48 hal [<c011d27a>] sys_wait4+0x205/0x20f
Oct 21 08:20:48 hal [<c0117fb4>] default_wake_function+0x0/0x18
Oct 21 08:20:48 hal [<c0117fb4>] default_wake_function+0x0/0x18
Oct 21 08:20:48 hal [<c011633b>] do_page_fault+0x0/0x451
Oct 21 08:20:48 hal [<c010a5f2>] do_notify_resume+0x27/0x35
Oct 21 08:20:48 hal [<c02bc83e>] work_notifysig+0x13/0x15
Oct 21 08:20:48 hal 
Oct 21 08:20:48 hal Trying to fix it up, but a reboot is needed
Oct 21 08:20:48 hal Bad page state at free_hot_cold_page
Oct 21 08:20:48 hal flags:0x01000014 mapping:00000000 mapped:1 count:0
Oct 21 08:20:48 hal Backtrace:
Oct 21 08:20:48 hal Call Trace:
Oct 21 08:20:48 hal [<c0131bcb>] bad_page+0x41/0x64
Oct 21 08:20:48 hal [<c013219b>] free_hot_cold_page+0x48/0xd8
Oct 21 08:20:48 hal [<c013923b>] zap_pte_range+0x13c/0x174
Oct 21 08:20:48 hal [<c01392b7>] zap_pmd_range+0x44/0x50
Oct 21 08:20:48 hal [<c0139300>] unmap_page_range+0x3d/0x59
Oct 21 08:20:48 hal [<c01393f5>] unmap_vmas+0xd9/0x1c7
Oct 21 08:20:48 hal [<c013c7de>] exit_mmap+0x61/0x14c
Oct 21 08:20:48 hal [<c01194e7>] mmput+0x7b/0xb8
Oct 21 08:20:48 hal [<c011ca1e>] do_exit+0x152/0x33d
Oct 21 08:20:48 hal [<c011ccd7>] sys_exit_group+0x0/0x11
Oct 21 08:20:48 hal [<c0123ee7>] get_signal_to_deliver+0x2bd/0x2e2
Oct 21 08:20:48 hal [<c010a55e>] do_signal+0x4f/0xbc
Oct 21 08:20:48 hal [<c011d27a>] sys_wait4+0x205/0x20f
Oct 21 08:20:48 hal [<c0117fb4>] default_wake_function+0x0/0x18
Oct 21 08:20:48 hal [<c0117fb4>] default_wake_function+0x0/0x18
Oct 21 08:20:48 hal [<c011633b>] do_page_fault+0x0/0x451
Oct 21 08:20:48 hal [<c010a5f2>] do_notify_resume+0x27/0x35
Oct 21 08:20:48 hal [<c02bc83e>] work_notifysig+0x13/0x15
Oct 21 08:20:48 hal 
Oct 21 08:20:48 hal Trying to fix it up, but a reboot is needed
Oct 21 08:20:48 hal Bad page state at free_hot_cold_page
Oct 21 08:20:48 hal flags:0x01000014 mapping:00000000 mapped:1 count:0
Oct 21 08:20:48 hal Backtrace:
Oct 21 08:20:48 hal Call Trace:
Oct 21 08:20:48 hal [<c0131bcb>] bad_page+0x41/0x64
Oct 21 08:20:48 hal [<c013219b>] free_hot_cold_page+0x48/0xd8
Oct 21 08:20:48 hal [<c013923b>] zap_pte_range+0x13c/0x174
Oct 21 08:20:48 hal [<c01392b7>] zap_pmd_range+0x44/0x50
Oct 21 08:20:48 hal [<c0139300>] unmap_page_range+0x3d/0x59
Oct 21 08:20:48 hal [<c01393f5>] unmap_vmas+0xd9/0x1c7
Oct 21 08:20:48 hal [<c013c7de>] exit_mmap+0x61/0x14c
Oct 21 08:20:48 hal [<c01194e7>] mmput+0x7b/0xb8
Oct 21 08:20:48 hal [<c011ca1e>] do_exit+0x152/0x33d
Oct 21 08:20:48 hal [<c011ccd7>] sys_exit_group+0x0/0x11
Oct 21 08:20:48 hal [<c0123ee7>] get_signal_to_deliver+0x2bd/0x2e2
Oct 21 08:20:48 hal [<c010a55e>] do_signal+0x4f/0xbc
Oct 21 08:20:48 hal [<c011d27a>] sys_wait4+0x205/0x20f
Oct 21 08:20:48 hal [<c0117fb4>] default_wake_function+0x0/0x18
Oct 21 08:20:48 hal [<c0117fb4>] default_wake_function+0x0/0x18
Oct 21 08:20:48 hal [<c011633b>] do_page_fault+0x0/0x451
Oct 21 08:20:48 hal [<c010a5f2>] do_notify_resume+0x27/0x35
Oct 21 08:20:48 hal [<c02bc83e>] work_notifysig+0x13/0x15
Oct 21 08:20:48 hal 
Oct 21 08:20:48 hal Trying to fix it up, but a reboot is needed
Oct 21 08:20:48 hal Bad page state at free_hot_cold_page
Oct 21 08:20:48 hal flags:0x0102000c mapping:d3b5d9f4 mapped:0 count:0
Oct 21 08:20:48 hal Backtrace:
Oct 21 08:20:48 hal Call Trace:
Oct 21 08:20:48 hal [<c0131bcb>] bad_page+0x41/0x64
Oct 21 08:20:48 hal [<c013219b>] free_hot_cold_page+0x48/0xd8
Oct 21 08:20:48 hal [<c013923b>] zap_pte_range+0x13c/0x174
Oct 21 08:20:48 hal [<c01392b7>] zap_pmd_range+0x44/0x50
Oct 21 08:20:48 hal [<c0139300>] unmap_page_range+0x3d/0x59
Oct 21 08:20:48 hal [<c01393f5>] unmap_vmas+0xd9/0x1c7
Oct 21 08:20:48 hal [<c013c7de>] exit_mmap+0x61/0x14c
Oct 21 08:20:48 hal [<c01194e7>] mmput+0x7b/0xb8
Oct 21 08:20:48 hal [<c011ca1e>] do_exit+0x152/0x33d
Oct 21 08:20:48 hal [<c011ccd7>] sys_exit_group+0x0/0x11
Oct 21 08:20:48 hal [<c0123ee7>] get_signal_to_deliver+0x2bd/0x2e2
Oct 21 08:20:48 hal [<c010a55e>] do_signal+0x4f/0xbc
Oct 21 08:20:48 hal [<c011d27a>] sys_wait4+0x205/0x20f
Oct 21 08:20:48 hal [<c0117fb4>] default_wake_function+0x0/0x18
Oct 21 08:20:48 hal [<c0117fb4>] default_wake_function+0x0/0x18
Oct 21 08:20:48 hal [<c011633b>] do_page_fault+0x0/0x451
Oct 21 08:20:48 hal [<c010a5f2>] do_notify_resume+0x27/0x35
Oct 21 08:20:48 hal [<c02bc83e>] work_notifysig+0x13/0x15
Oct 21 08:20:48 hal 
Oct 21 08:20:48 hal Trying to fix it up, but a reboot is needed
Oct 21 08:20:48 hal swap_free: Bad swap file entry 40ead110
Oct 21 08:20:48 hal swap_free: Bad swap file entry 80eac120
Oct 21 08:20:48 hal Bad page state at free_hot_cold_page
Oct 21 08:20:48 hal flags:0x0102001c mapping:c9ce20f4 mapped:0 count:0
Oct 21 08:20:48 hal Backtrace:
Oct 21 08:20:48 hal Call Trace:
Oct 21 08:20:48 hal [<c0131bcb>] bad_page+0x41/0x64
Oct 21 08:20:48 hal [<c013219b>] free_hot_cold_page+0x48/0xd8
Oct 21 08:20:48 hal [<c013923b>] zap_pte_range+0x13c/0x174
Oct 21 08:20:48 hal [<c01392b7>] zap_pmd_range+0x44/0x50
Oct 21 08:20:48 hal [<c0139300>] unmap_page_range+0x3d/0x59
Oct 21 08:20:48 hal [<c01393f5>] unmap_vmas+0xd9/0x1c7
Oct 21 08:20:48 hal [<c013c7de>] exit_mmap+0x61/0x14c
Oct 21 08:20:48 hal [<c01194e7>] mmput+0x7b/0xb8
Oct 21 08:20:48 hal [<c011ca1e>] do_exit+0x152/0x33d
Oct 21 08:20:48 hal [<c011ccd7>] sys_exit_group+0x0/0x11
Oct 21 08:20:48 hal [<c0123ee7>] get_signal_to_deliver+0x2bd/0x2e2
Oct 21 08:20:48 hal [<c010a55e>] do_signal+0x4f/0xbc
Oct 21 08:20:48 hal [<c011d27a>] sys_wait4+0x205/0x20f
Oct 21 08:20:48 hal [<c0117fb4>] default_wake_function+0x0/0x18
Oct 21 08:20:48 hal [<c0117fb4>] default_wake_function+0x0/0x18
Oct 21 08:20:48 hal [<c011633b>] do_page_fault+0x0/0x451
Oct 21 08:20:48 hal [<c010a5f2>] do_notify_resume+0x27/0x35
Oct 21 08:20:48 hal [<c02bc83e>] work_notifysig+0x13/0x15
Oct 21 08:20:48 hal 
Oct 21 08:20:48 hal Trying to fix it up, but a reboot is needed
Oct 21 08:20:48 hal mm/memory.c:100: bad pmd 09800000.
Oct 21 08:21:28 hal Bad page state at prep_new_page
Oct 21 08:21:28 hal flags:0x01000004 mapping:00000000 mapped:1 count:0
Oct 21 08:21:28 hal Backtrace:
Oct 21 08:21:28 hal Call Trace:
Oct 21 08:21:28 hal [<c0131bcb>] bad_page+0x41/0x64
Oct 21 08:21:28 hal [<c0131eaa>] prep_new_page+0x24/0x3c
Oct 21 08:21:28 hal [<c0132361>] buffered_rmqueue+0x125/0x12e
Oct 21 08:21:28 hal [<c01323fd>] __alloc_pages+0x93/0x2ad
Oct 21 08:21:28 hal [<c013a482>] do_anonymous_page+0xd4/0x1db
Oct 21 08:21:28 hal [<c013a9d0>] handle_mm_fault+0x6c/0x106
Oct 21 08:21:28 hal [<c0116461>] do_page_fault+0x126/0x451
Oct 21 08:21:28 hal [<c0121474>] update_process_times+0x29/0x2f
Oct 21 08:21:28 hal [<c012136c>] update_wall_time+0xb/0x33
Oct 21 08:21:28 hal [<c0121672>] do_timer+0x4c/0xc1
Oct 21 08:21:28 hal [<c010eeb7>] timer_interrupt+0x48/0x112
Oct 21 08:21:28 hal [<c010b657>] handle_IRQ_event+0x27/0x4a
Oct 21 08:21:28 hal [<c011decd>] do_softirq+0x45/0x87
Oct 21 08:21:28 hal [<c011633b>] do_page_fault+0x0/0x451
Oct 21 08:21:28 hal [<c02bd1ff>] error_code+0x2f/0x38
Oct 21 08:21:28 hal 
Oct 21 08:21:28 hal Trying to fix it up, but a reboot is needed
Oct 21 08:21:28 hal Bad page state at prep_new_page
Oct 21 08:21:28 hal flags:0x01000004 mapping:00000000 mapped:1 count:0
Oct 21 08:21:28 hal Backtrace:
Oct 21 08:21:28 hal Call Trace:
Oct 21 08:21:28 hal [<c0131bcb>] bad_page+0x41/0x64
Oct 21 08:21:28 hal [<c0131eaa>] prep_new_page+0x24/0x3c
Oct 21 08:21:28 hal [<c0132361>] buffered_rmqueue+0x125/0x12e
Oct 21 08:21:28 hal [<c01323fd>] __alloc_pages+0x93/0x2ad
Oct 21 08:21:28 hal [<c013a482>] do_anonymous_page+0xd4/0x1db
Oct 21 08:21:28 hal [<c013a9d0>] handle_mm_fault+0x6c/0x106
Oct 21 08:21:28 hal [<c0116461>] do_page_fault+0x126/0x451
Oct 21 08:21:28 hal [<c0121474>] update_process_times+0x29/0x2f
Oct 21 08:21:28 hal [<c012136c>] update_wall_time+0xb/0x33
Oct 21 08:21:28 hal [<c0121672>] do_timer+0x4c/0xc1
Oct 21 08:21:28 hal [<c0117b22>] schedule+0x66/0x4b7
Oct 21 08:21:28 hal [<c011decd>] do_softirq+0x45/0x87
Oct 21 08:21:28 hal [<c011633b>] do_page_fault+0x0/0x451
Oct 21 08:21:28 hal [<c02bd1ff>] error_code+0x2f/0x38
Oct 21 08:21:28 hal 
Oct 21 08:21:28 hal Trying to fix it up, but a reboot is needed
Oct 21 08:21:53 hal init: Switching to runlevel: 6


As you see, i wanted to reboot at the end, but the box stopped with a screen,
presenting me some information and told me to snip it and drop it at the kernel
mailing list. Unfortunately at that state my box was nearly shut down, so i
wasn't able to snip this information and drop it anywhere.
This happened to me on mm-sources during the test6 series, then i had to
reinstall as these crashes caused so massive corruption on my hd that
fsck.reiserfs was unable to repair it. Now i am on the test8 series of
mm-sources and it is happening again. i will switch back to xfs-sources until
this problem is solved for me.

Reproducible: Always
Steps to Reproduce:
1.emerge mm-sources
2.work with your box
3.see it happen - five minutes, sometimes five hours without problems

Actual Results:  
i have to shut down the box, then do a reset as it stops at the end


Portage 2.0.49-r13-2 (default-x86-1.4, gcc-3.3.1, glibc-2.3.2-r6, 2.4.20-xfs-r3)
=================================================================
System uname: 2.4.20-xfs-r3 i686 AMD Athlon(tm) XP 2000+
Gentoo Base System version 1.4.3.11
ccache version 2.3 [enabled]
ACCEPT_KEYWORDS="x86 ~x86"
AUTOCLEAN="yes"
CFLAGS="-march=athlon-xp -O3 -pipe -fstack-protector -fomit-frame-pointer
-funroll-loops"
CHOST="i686-pc-linux-gnu"
COMPILER="gcc3"
CONFIG_PROTECT="/etc /var/qmail/control /usr/kde/2/share/config
/usr/kde/3/share/config /usr/X11R6/lib/X11/xkb /usr/kde/3.1/share/config
/usr/share/config"
CONFIG_PROTECT_MASK="/etc/gconf /etc/env.d"
CXXFLAGS="-march=athlon-xp -O3 -pipe -fstack-protector -fomit-frame-pointer
-funroll-loops"
DISTDIR="/usr/portage/distfiles"
FEATURES="autoaddcvs sandbox buildpkg ccache"
GENTOO_MIRRORS="http://gentoo.inode.at/ ftp://ftp.easynet.nl/mirror/gentoo/
http://ftp.easynet.nl/mirror/gentoo/
http://mirrors.sec.informatik.tu-darmstadt.de/gentoo"
MAKEOPTS="-j2"
PKGDIR="/usr/portage/packages"
PORTAGE_TMPDIR="/var/tmp"
PORTDIR="/usr/portage"
PORTDIR_OVERLAY="/usr/local/portage"
SYNC="rsync://rsync.europe.gentoo.org/gentoo-portage"
USE="x86 oss avi crypt cups encode foomaticdb gif jpeg libwww mad mikmod mpeg
ncurses nls pdflib png quicktime spell truetype xml2 xmms xv zlib gdbm berkdb
slang readline X gpm tcpd pam ssl python imlib oggvorbis gtk opengl 3dnow cdr
dga -nptl dv dvd faad ffmpeg flac gtk2 java javascript lcms matroska md5sum mmx
mozilla offensive pic samba slp sse tcltk tiff transcode unicode wmf xfs xosd
xvid -apm -arts -kde -gnome -libg++ -motif -qt -sdl -svga -perl -esd"

Also, i will include my .config of the kernel:
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
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
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

# 
# Loadable module support
# 
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

# 
# Processor type and features
# 
CONFIG_X86_PC=y
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
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
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
CONFIG_X86_USE_3DNOW=y
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
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_BOOT_IOREMAP=y

# 
# Power management options (ACPI, APM)
# 
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

# 
# ACPI (Advanced Configuration and Power Interface) Support
# 
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_EFI is not set
# CONFIG_ACPI_RELAXED_AML is not set

# 
# APM (Advanced Power Management) BIOS Support
# 
# CONFIG_APM is not set

# 
# CPU Frequency scaling
# 
# CONFIG_CPU_FREQ is not set

# 
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
# 
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_USE_VECTOR is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

# 
# Executable file formats
# 
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=y

# 
# Device Drivers
# 

# 
# Generic Driver Options
# 

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
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

# 
# Plug and Play support
# 
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

# 
# Protocols
# 
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

# 
# Block devices
# 
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
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
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

# 
# IDE chipset support/bugfixes
# 
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
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
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SGIIOC4 is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
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
CONFIG_BLK_DEV_SD=m
CONFIG_MAX_SD_DISKS=256
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

# 
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
# 
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# 
# SCSI low-level drivers
# 
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

# 
# Multi-device support (RAID and LVM)
# 
# CONFIG_MD is not set

# 
# Fusion MPT device support
# 
# CONFIG_FUSION is not set

# 
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
# 
# CONFIG_IEEE1394 is not set

# 
# I2O device support
# 
# CONFIG_I2O is not set

# 
# Networking support
# 
CONFIG_NET=y

# 
# Networking options
# 
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

# 
# SCTP Configuration (EXPERIMENTAL)
# 
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
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
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

# 
# Ethernet (10 or 100Mbit)
# 
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

# 
# Tulip family network device support
# 
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

# 
# Ethernet (1000 Mbit)
# 
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

# 
# Ethernet (10000 Mbit)
# 
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
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
# CONFIG_NET_POLL_CONTROLLER is not set

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
# CONFIG_BT is not set

# 
# ISDN subsystem
# 
# CONFIG_ISDN_BOOL is not set

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
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

# 
# Input I/O drivers
# 
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

# 
# Input Device Drivers
# 
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

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
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

# 
# Non-8250 serial port support
# 
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

# 
# I2C support
# 
# CONFIG_I2C is not set

# 
# I2C Algorithms
# 

# 
# I2C Hardware Bus support
# 

# 
# I2C Hardware Sensors Chip support
# 
# CONFIG_I2C_SENSOR is not set

# 
# Mice
# 
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

# 
# IPMI
# 
# CONFIG_IPMI_HANDLER is not set

# 
# Watchdog Cards
# 
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

# 
# Ftape, the floppy tape device driver
# 
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

# 
# Multimedia devices
# 
# CONFIG_VIDEO_DEV is not set

# 
# Digital Video Broadcasting Devices
# 
# CONFIG_DVB is not set

# 
# Graphics support
# 
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

# 
# Console display driver support
# 
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

# 
# Sound
# 
CONFIG_SOUND=y

# 
# Advanced Linux Sound Architecture
# 
# CONFIG_SND is not set

# 
# Open Sound System
# 
CONFIG_SOUND_PRIME=y
# CONFIG_SOUND_BT878 is not set
CONFIG_SOUND_CMPCI=y
# CONFIG_SOUND_CMPCI_FM is not set
# CONFIG_SOUND_CMPCI_MIDI is not set
# CONFIG_SOUND_CMPCI_JOYSTICK is not set
CONFIG_SOUND_CMPCI_CM8738=y
# CONFIG_SOUND_CMPCI_SPDIFINVERSE is not set
# CONFIG_SOUND_CMPCI_SPDIFLOOP is not set
CONFIG_SOUND_CMPCI_SPEAKERS=2
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_AD1980 is not set

# 
# USB support
# 
# CONFIG_USB is not set
# CONFIG_USB_GADGET is not set

# 
# File systems
# 
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

# 
# CD-ROM/DVD Filesystems
# 
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

# 
# DOS/FAT/NT Filesystems
# 
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

# 
# Pseudo filesystems
# 
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

# 
# Miscellaneous filesystems
# 
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

# 
# Network File Systems
# 
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

# 
# Partition Types
# 
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

# 
# Native Language Support
# 
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
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
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

# 
# Profiling support
# 
# CONFIG_PROFILING is not set

# 
# Kernel hacking
# 
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

# 
# Security options
# 
# CONFIG_SECURITY is not set

# 
# Cryptographic options
# 
# CONFIG_CRYPTO is not set

# 
# Library routines
# 
CONFIG_CRC32=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y


If you need some more info, let me know.

Yours,
Daniel


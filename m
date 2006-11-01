Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946889AbWKAOHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946889AbWKAOHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 09:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946892AbWKAOHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 09:07:33 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:10690 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S1946889AbWKAOHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 09:07:31 -0500
Date: Wed, 1 Nov 2006 15:07:29 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

on my system I'm having the usual (already known from Con Kolivas
earlier dynticks patches) problems with missed ticks: I have to generate
keyboard or mouse interrupts to let my system proceed with booting
(semi-)properly.
Once in X11 it's better (due to many IRQs being triggered here, I assume),
but still not perfect.

This did "work properly" (for whatever reason) with 2.6.19-rc1-mm* and got
broken once going to -rc2-mm*, IIRC. -rc4-mm1 is stock version without
any local patches (for accurate bug reporting).

x86 UP Athlon 1200, VIA chipset.

Probably some problem with VIA chipsets and APIC, PIT, ...?

Would be nice to get this to work properly, anything I should try to debug?

Andreas Mohr


00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (
rev 46)
00:0a.0 Multimedia audio controller: Aureal Semiconductor Vortex 2 (rev fe)
00:0c.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev
 08)
00:0d.0 Multimedia audio controller: Aztech System Ltd 3328 Audio (rev 10)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
 (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
 (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
 (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/
C PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 A
C97 Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If [Radeon
9000] (rev 01)
01:00.1 Display controller: ATI Technologies Inc Radeon RV250 [Radeon 9000] (Sec
ondary) (rev 01)


$ cat /proc/acpi/processor/CPU0/*
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        yes
throttling control:      no
limit interface:         no
<not supported>
active state:            C2
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000 usec
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[000] usage[00012840] duration[00000000000000000000]
   *C2:                  type[C2] promotion[--] demotion[C1] latency[100] usage[00087632] duration[00000000002335220011]
<not supported>


# cat /proc/timer_stats
Timerstats sample period: 9.36316 s
 474,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
   4,  3172 konsole          schedule_timeout (process_timeout)
  21,  2547 Xorg             do_setitimer (it_real_fn)
 188,  3149 knotify          schedule_timeout (process_timeout)
  13,     0 swapper          hrtimer_restart_sched_tick (hrtimer_sched_tick)
  56,  3141 artsd            schedule_timeout (process_timeout)
  37,  1515 modprobe         usb_hcd_submit_urb (rh_timer_func)
  10,  3141 artsd            do_setitimer (it_real_fn)
   2,  2547 Xorg             schedule_timeout (process_timeout)
  19,  3134 kicker           schedule_timeout (process_timeout)
   1,  3079 ssh-agent        do_setitimer (it_real_fn)
   1,  3078 ssh-agent        do_setitimer (it_real_fn)
   5,     0 swapper          __netdev_watchdog_up (dev_watchdog)
   5,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
   1,  2937 preload          schedule_timeout (process_timeout)
  10,  3153 klipper          schedule_timeout (process_timeout)
   9,  3130 kwin             schedule_timeout (process_timeout)
   9,  3127 kwrapper         do_nanosleep (hrtimer_wakeup)
   3,  2481 cupsd            schedule_timeout (process_timeout)
   9,  2925 apache           schedule_timeout (process_timeout)
   1,  2496 hald             schedule_timeout (process_timeout)
   4,  2147 ifconfig         e100_up (e100_watchdog)
   4,  2513 hald-addon-stor  do_nanosleep (hrtimer_wakeup)
   1,  3446 bash             start_this_handle (commit_timeout)
   1,  3446 cat              start_this_handle (commit_timeout)
   1,  2905 cron             do_nanosleep (hrtimer_wakeup)
   2,  3122 kded             schedule_timeout (process_timeout)
   1,  2859 chronyd          schedule_timeout (process_timeout)
   1,   131 pdflush          start_this_handle (commit_timeout)
   1,     1 init             schedule_timeout (process_timeout)
   1,     0 swapper          page_writeback_init (wb_timer_fn)
   1,     4 events/0         do_cache_clean (delayed_work_timer_fn)
   1,     1 swapper          init_nonfatal_mce_checker (delayed_work_timer_fn)
   1,  3120 klauncher        schedule_timeout (process_timeout)
   1,     1 swapper          neigh_table_init_no_netlink (neigh_periodic_timer)
   1,     1 swapper          rekey_seq_generator (delayed_work_timer_fn)
   1,  2621 nmbd             schedule_timeout (process_timeout)
901 total events, 100.19 events/sec


.config excerpt (timer-related settings mostly):

CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y

#
# Processor type and features
#
CONFIG_HIGH_RES_TIMERS=y
CONFIG_NO_HZ=y
# CONFIG_SMP is not set
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
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/hda2"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_SONY is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m
# CONFIG_ACPI_SBS is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

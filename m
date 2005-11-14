Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVKNVWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVKNVWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKNVWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:22:44 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:27667 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S932139AbVKNVWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:22:43 -0500
Message-ID: <4378FFFF.4010706@tuxrocks.com>
Date: Mon, 14 Nov 2005 14:22:07 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

john stultz wrote:
> All,
> 	I had hoped to submit this to -mm today, but since Ingo pointed
> out an issue in the __delay code, I'm going to wait a week so the new fix
> can be better tested.

I replaced the TOD parts of the kthrt patchset with TOD B10.  It seems
there is something wrong with 'c3tsc' and 'pit', though.

c3tsc appears to run fast:
14 Nov 12:02:13         offset: -0.00247        drift: -2502.0 ppm
14 Nov 12:03:14         offset: -0.145203       drift: -2342.5 ppm
14 Nov 12:04:14         offset: -0.329381       drift: -2700.10655738 ppm
14 Nov 12:05:14         offset: -0.532767       drift: -2927.46703297 ppm
14 Nov 12:06:15         offset: -0.638096       drift: -2626.04115226 ppm

and 'pit' seems to produce errors (system will not switch from pit to
another clocksource anymore):

[    7.976858] Time: tsc clocksource has been installed.
[    7.977855] Ktimers: Switched to high resolution mode CPU 0
[   11.443804] Falling back to C3 safe TSC
[   11.504408] check_periodic_interval: Long interval! 177494381.
[   11.510560]          Something may be blocking interrupts.
[   20.223000] Time: acpi_pm clocksource has been installed.
[   20.223000] Ktimers: Switched to high resolution mode CPU 0
[ 2990.834000] Time: c3tsc clocksource has been installed.
[ 2990.835000] Ktimers: Switched to high resolution mode CPU 0
[ 3289.320000] Time: pit clocksource has been installed.
[ 3289.365000] check_monotonic_clock: monotonic inconsistency detected!
[ 3289.365000]  from      2fe277e9c61 (3290607557729) to
2fe2775a556 (3290606970198).
[ 3289.365000] Badness in check_monotonic_clock at
kernel/time/timeofday.c:156
[ 3289.365000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[ 3289.365000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[ 3289.365000]  [<c013642b>] ktimer_interrupt+0x2b/0x2e0
[ 3289.365000]  [<c02d4b4b>] acpi_hw_low_level_write+0xc0/0xd1
[ 3289.365000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.365000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.365000]  [<c0137c48>] handle_nextevent_profile+0x8/0x20
[ 3289.365000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[ 3289.365000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[ 3289.365000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[ 3289.365000]  [<c01010f2>] cpu_idle+0x42/0x60
[ 3289.365000]  [<c05a9855>] start_kernel+0x175/0x1e0
[ 3289.365000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[ 3289.367000] check_monotonic_clock: monotonic inconsistency detected!
[ 3289.367000]  from      2fe27944675 (3290608977525) to
2fe279428fe (3290608969982).
[ 3289.367000] Badness in check_monotonic_clock at
kernel/time/timeofday.c:156
[ 3289.367000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[ 3289.367000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[ 3289.367000]  [<c013642b>] ktimer_interrupt+0x2b/0x2e0
[ 3289.367000]  [<c02d4b4b>] acpi_hw_low_level_write+0xc0/0xd1
[ 3289.367000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.367000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.367000]  [<c0137c48>] handle_nextevent_profile+0x8/0x20
[ 3289.367000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[ 3289.367000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[ 3289.367000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[ 3289.367000]  [<c01010f2>] cpu_idle+0x42/0x60
[ 3289.367000]  [<c05a9855>] start_kernel+0x175/0x1e0
[ 3289.367000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[ 3289.371000] check_monotonic_clock: monotonic inconsistency detected!
[ 3289.371000]  from      2fe27da658d (3290613573005) to
2fe27d1304e (3290612969550).
[ 3289.371000] Badness in check_monotonic_clock at
kernel/time/timeofday.c:156
[ 3289.371000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[ 3289.371000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[ 3289.371000]  [<c013642b>] ktimer_interrupt+0x2b/0x2e0
[ 3289.371000]  [<c02d4a7b>] acpi_hw_low_level_read+0xbb/0xcb
[ 3289.371000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.371000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.371000]  [<c0137c48>] handle_nextevent_profile+0x8/0x20
[ 3289.371000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[ 3289.371000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[ 3289.371000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[ 3289.371000]  [<c01010f2>] cpu_idle+0x42/0x60
[ 3289.371000]  [<c05a9855>] start_kernel+0x175/0x1e0
[ 3289.371000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[ 3289.423000] check_monotonic_clock: monotonic inconsistency detected!
[ 3289.423000]  from      2fe2aeada9c (3290664983196) to
2fe2aea8f4f (3290664963919).
[ 3289.423000] Badness in check_monotonic_clock at
kernel/time/timeofday.c:156
[ 3289.423000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[ 3289.423000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[ 3289.423000]  [<c013642b>] ktimer_interrupt+0x2b/0x2e0
[ 3289.423000]  [<c02d4a7b>] acpi_hw_low_level_read+0xbb/0xcb
[ 3289.423000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.423000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.423000]  [<c0137c48>] handle_nextevent_profile+0x8/0x20
[ 3289.423000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[ 3289.423000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[ 3289.423000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[ 3289.423000]  [<c01010f2>] cpu_idle+0x42/0x60
[ 3289.423000]  [<c05a9855>] start_kernel+0x175/0x1e0
[ 3289.423000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[ 3289.507000] check_monotonic_clock: monotonic inconsistency detected!
[ 3289.507000]  from      2fe2ff461ee (3290749493742) to
2fe2fec28c7 (3290748954823).
[ 3289.507000] Badness in check_monotonic_clock at
kernel/time/timeofday.c:156
[ 3289.507000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[ 3289.507000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[ 3289.507000]  [<c013642b>] ktimer_interrupt+0x2b/0x2e0
[ 3289.507000]  [<c02d4b4b>] acpi_hw_low_level_write+0xc0/0xd1
[ 3289.507000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.507000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.507000]  [<c0137c48>] handle_nextevent_profile+0x8/0x20
[ 3289.507000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[ 3289.507000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[ 3289.507000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[ 3289.507000]  [<c01010f2>] cpu_idle+0x42/0x60
[ 3289.507000]  [<c05a9855>] start_kernel+0x175/0x1e0
[ 3289.507000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[ 3289.509000] check_monotonic_clock: monotonic inconsistency detected!
[ 3289.509000]  from      2fe300aeaa3 (3290750970531) to
2fe300aac6f (3290750954607).
[ 3289.509000] Badness in check_monotonic_clock at
kernel/time/timeofday.c:156
[ 3289.509000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[ 3289.509000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[ 3289.509000]  [<c013642b>] ktimer_interrupt+0x2b/0x2e0
[ 3289.509000]  [<c02d4a7b>] acpi_hw_low_level_read+0xbb/0xcb
[ 3289.509000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.509000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.509000]  [<c0137c48>] handle_nextevent_profile+0x8/0x20
[ 3289.509000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[ 3289.509000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[ 3289.509000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[ 3289.509000]  [<c01010f2>] cpu_idle+0x42/0x60
[ 3289.509000]  [<c05a9855>] start_kernel+0x175/0x1e0
[ 3289.509000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[ 3289.525000] check_monotonic_clock: monotonic inconsistency detected!
[ 3289.525000]  from      2fe30ff1b84 (3290766973828) to
2fe30fec9aa (3290766952874).
[ 3289.525000] Badness in check_monotonic_clock at
kernel/time/timeofday.c:156
[ 3289.525000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[ 3289.525000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[ 3289.525000]  [<c013642b>] ktimer_interrupt+0x2b/0x2e0
[ 3289.525000]  [<c02d4a7b>] acpi_hw_low_level_read+0xbb/0xcb
[ 3289.525000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.525000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.525000]  [<c0137c48>] handle_nextevent_profile+0x8/0x20
[ 3289.525000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[ 3289.525000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[ 3289.525000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[ 3289.525000]  [<c01010f2>] cpu_idle+0x42/0x60
[ 3289.525000]  [<c05a9855>] start_kernel+0x175/0x1e0
[ 3289.525000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[ 3289.541000] check_monotonic_clock: monotonic inconsistency detected!
[ 3289.541000]  from      2fe31f4adfa (3290783067642) to
2fe31f2e6e6 (3290782951142).
[ 3289.541000] Badness in check_monotonic_clock at
kernel/time/timeofday.c:156
[ 3289.541000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[ 3289.541000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[ 3289.541000]  [<c013642b>] ktimer_interrupt+0x2b/0x2e0
[ 3289.541000]  [<c02d4b4b>] acpi_hw_low_level_write+0xc0/0xd1
[ 3289.541000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.541000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.541000]  [<c0137c48>] handle_nextevent_profile+0x8/0x20
[ 3289.541000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[ 3289.541000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[ 3289.541000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[ 3289.541000]  [<c01010f2>] cpu_idle+0x42/0x60
[ 3289.541000]  [<c05a9855>] start_kernel+0x175/0x1e0
[ 3289.541000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[ 3289.543000] check_monotonic_clock: monotonic inconsistency detected!
[ 3289.543000]  from      2fe32117aec (3290784955116) to
2fe32116a8d (3290784950925).
[ 3289.543000] Badness in check_monotonic_clock at
kernel/time/timeofday.c:156
[ 3289.543000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[ 3289.543000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[ 3289.543000]  [<c013642b>] ktimer_interrupt+0x2b/0x2e0
[ 3289.543000]  [<c02d4a7b>] acpi_hw_low_level_read+0xbb/0xcb
[ 3289.543000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.543000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.543000]  [<c0137c48>] handle_nextevent_profile+0x8/0x20
[ 3289.543000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[ 3289.543000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[ 3289.543000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[ 3289.543000]  [<c01010f2>] cpu_idle+0x42/0x60
[ 3289.543000]  [<c05a9855>] start_kernel+0x175/0x1e0
[ 3289.543000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[ 3289.545000] check_monotonic_clock: monotonic inconsistency detected!
[ 3289.545000]  from      2fe322ffe93 (3290786954899) to
2fe322fee35 (3290786950709).
[ 3289.545000] Badness in check_monotonic_clock at
kernel/time/timeofday.c:156
[ 3289.545000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[ 3289.545000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[ 3289.545000]  [<c013642b>] ktimer_interrupt+0x2b/0x2e0
[ 3289.545000]  [<c02d4a7b>] acpi_hw_low_level_read+0xbb/0xcb
[ 3289.545000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.545000]  [<c02e258f>] acpi_ut_status_exit+0x48/0x56
[ 3289.545000]  [<c0137c48>] handle_nextevent_profile+0x8/0x20
[ 3289.545000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[ 3289.545000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[ 3289.545000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[ 3289.545000]  [<c01010f2>] cpu_idle+0x42/0x60
[ 3289.545000]  [<c05a9855>] start_kernel+0x175/0x1e0
[ 3289.545000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[ 3695.183000] check_periodic_interval: Long interval! 106988521.
[ 3695.183000]          Something may be blocking interrupts.
[ 3716.931000] check_periodic_interval: Long interval! 102989788.
[ 3716.931000]          Something may be blocking interrupts.
[ 3731.137000] check_periodic_interval: Long interval! 101989057.
[ 3731.137000]          Something may be blocking interrupts.
[ 3739.737000] check_periodic_interval: Long interval! 101000060.
[ 3739.737000]          Something may be blocking interrupts.
[ 3741.268000] check_periodic_interval: Long interval! 106989359.
[ 3741.268000]          Something may be blocking interrupts.
[ 3741.990000] check_periodic_interval: Long interval! 100990002.
[ 3741.990000]          Something may be blocking interrupts.
[ 3772.714000] check_periodic_interval: Long interval! 104811889.
[ 3772.714000]          Something may be blocking interrupts.
[ 3779.810000] check_periodic_interval: Long interval! 101989057.
[ 3779.810000]          Something may be blocking interrupts.
[ 3781.311000] check_periodic_interval: Long interval! 109989037.
[ 3781.311000]          Something may be blocking interrupts.




Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDeP//aI0dwg4A47wRAkOZAKDTpjo/+xOdOmwvOXQX++IHMEytvQCgxfu+
ct9J4Rt7zIkwQx6a8FpWgwo=
=iVge
-----END PGP SIGNATURE-----

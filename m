Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUKRPMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUKRPMa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUKRPMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:12:16 -0500
Received: from mail.onestepahead.de ([62.96.100.59]:43416 "EHLO
	mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S262141AbUKRPKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:10:08 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041118155411.GB12483@elte.hu>
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
	 <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <1100732223.3472.10.camel@localhost>
	 <20041118155411.GB12483@elte.hu>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 16:07:55 +0100
Message-Id: <1100790475.3397.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 16:54 +0100, Ingo Molnar wrote:
> * Christian Meder <chris@onestepahead.de> wrote:
> 
> > after successfully running the last couple of rt patches on my Dell
> > Inspiron laptop I thought I'd give it a try on my combined vdr/router
> > box which is probably more interesting from a rt point of view. This
> > box is bridging wireless/ADSL and working as a digital vdr using the
> > kernel DVB-S drivers.
> > 
> > I got the appended logging messages with the appended config.  Is
> > there anything else I should provide for debugging purposes or are the
> > messages just harmless ?
> 
> the messages mean that i havent converted the bridge code's RCU locking
> to PREEMPT_RT yet. I've done this in the -V0.7.28-2 patch that i've just
> uploaded to:
> 
>         http://redhat.com/~mingo/realtime-preempt/
> 
> does bridging work fine with this patch, and if yes, do you get any
> (other) warning messages?

Thanks, will try soon and report. There was another trace in my log of
the vdr/router box which seemed unrelated to the bridging traces.


				Christian


Nov 17 22:44:41 verena kernel: dvb-ttpci: found av7110-0.
Nov 17 22:44:43 verena kernel: ves1x93: Detected ves1893a rev2
Nov 17 22:44:43 verena kernel: DVB: registering frontend 0 (VES1893)...
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel:
==========================================
Nov 17 22:44:44 verena kernel: [ BUG: lock recursion deadlock detected!
|
Nov 17 22:44:44 verena kernel:
------------------------------------------
Nov 17 22:44:44 verena kernel: already locked:  [c9c8fa10] {&fe->sem}
Nov 17 22:44:44 verena kernel: .. held by:               vdr: 2147
[ca3a6950, 118]
Nov 17 22:44:44 verena kernel: ... acquired at:  dvb_frontend_start
+0x75/0x100
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: ------------------------------
Nov 17 22:44:44 verena kernel: | showing all locks held by: |  (vdr/2147
[ca3a6950, 118]):
Nov 17 22:44:44 verena kernel: ------------------------------
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #001:             [c9c8fa10] {&fe->sem}
Nov 17 22:44:44 verena kernel: ... acquired at:  dvb_frontend_start
+0x75/0x100
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #002:             [c045e444]
{kernel_sem.lock}
Nov 17 22:44:44 verena kernel: ... acquired at:  lock_kernel+0x27/0x50
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: -{current task's
backtrace}----------------->
Nov 17 22:44:44 verena kernel:  [check_deadlock+608/640] check_deadlock
+0x260/0x280 (8)
Nov 17 22:44:44 verena kernel:  [dvb_frontend_ioctl+171/832]
dvb_frontend_ioctl+0xab/0x340 (28)
Nov 17 22:44:44 verena kernel:  [dvb_frontend_ioctl+171/832]
dvb_frontend_ioctl+0xab/0x340 (8)
Nov 17 22:44:44 verena kernel:  [task_blocks_on_lock+243/256]
task_blocks_on_lock+0xf3/0x100 (12)
Nov 17 22:44:44 verena kernel:  [dvb_frontend_ioctl+171/832]
dvb_frontend_ioctl+0xab/0x340 (16)
Nov 17 22:44:44 verena kernel:  [__down_interruptible+534/1072]
__down_interruptible+0x216/0x430 (4)
Nov 17 22:44:44 verena kernel:  [dvb_frontend_ioctl+171/832]
dvb_frontend_ioctl+0xab/0x340 (4)
Nov 17 22:44:44 verena kernel:  [pg0+264556013/1068020736]
av7110_send_fw_cmd+0x4d/0xc0 [dvb_ttpci] (12)
Nov 17 22:44:44 verena kernel:  [up+190/256] up+0xbe/0x100 (24)
Nov 17 22:44:44 verena kernel:  [down_interruptible+173/480]
down_interruptible+0xad/0x1e0 (36)
Nov 17 22:44:44 verena kernel:  [lru_cache_add_active+13/64]
lru_cache_add_active+0xd/0x40 (4)
Nov 17 22:44:44 verena kernel:  [dvb_frontend_ioctl+171/832]
dvb_frontend_ioctl+0xab/0x340 (40)
Nov 17 22:44:44 verena kernel:  [__kmalloc+133/272] __kmalloc+0x85/0x110
(52)
Nov 17 22:44:44 verena kernel:  [dvb_usercopy+132/272] dvb_usercopy
+0x84/0x110 (32)
Nov 17 22:44:44 verena kernel:  [__down+470/800] __down+0x1d6/0x320 (44)
Nov 17 22:44:44 verena kernel:  [lock_kernel+39/80] lock_kernel
+0x27/0x50 (4)
Nov 17 22:44:44 verena kernel:  [__down_mutex+470/864] __down_mutex
+0x1d6/0x360 (12)
Nov 17 22:44:44 verena kernel:  [fget+47/96] fget+0x2f/0x60 (4)
Nov 17 22:44:44 verena kernel:  [__down_mutex+470/864] __down_mutex
+0x1d6/0x360 (4)
Nov 17 22:44:44 verena kernel:  [kmem_cache_free+53/208] kmem_cache_free
+0x35/0xd0 (4)
Nov 17 22:44:44 verena kernel:  [down+173/480] down+0xad/0x1e0 (48)
Nov 17 22:44:44 verena kernel:  [fget+72/96] fget+0x48/0x60 (16)
Nov 17 22:44:44 verena kernel:  [dvb_generic_ioctl+62/80]
dvb_generic_ioctl+0x3e/0x50 (24)
Nov 17 22:44:44 verena kernel:  [dvb_frontend_ioctl+0/832]
dvb_frontend_ioctl+0x0/0x340 (8)
Nov 17 22:44:44 verena kernel:  [sys_ioctl+184/528] sys_ioctl+0xb8/0x210
(12)
Nov 17 22:44:44 verena kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
(36)
Nov 17 22:44:44 verena kernel: ---------------------------
Nov 17 22:44:44 verena kernel: | preempt count: 00000002 ]
Nov 17 22:44:44 verena kernel: | 2-level deep critical section nesting:
Nov 17 22:44:44 verena kernel: ----------------------------------------
Nov 17 22:44:44 verena kernel: .. [__down_interruptible+1057/1072] ....
__down_interruptible+0x421/0x430
Nov 17 22:44:44 verena kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 17 22:44:44 verena kernel: .. [print_traces+13/64] .... print_traces
+0xd/0x40
Nov 17 22:44:44 verena kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: showing all tasks:
Nov 17 22:44:44 verena kernel: s            init:    1 [c1239370, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s           IRQ 0:    2 [c1238d00,  50]
(not blocked)
Nov 17 22:44:44 verena kernel: s     ksoftirqd/0:    3 [c1238690, 105]
(not blocked)
Nov 17 22:44:44 verena kernel: s       desched/0:    4 [c1238020, 105]
(not blocked)
Nov 17 22:44:44 verena kernel: s        events/0:    5 [cf7db390,  98]
(not blocked)
Nov 17 22:44:44 verena kernel: s         khelper:    6 [cf7dad20, 113]
(not blocked)
Nov 17 22:44:44 verena kernel: s         kthread:   11 [cf7da6b0, 110]
(not blocked)
Nov 17 22:44:44 verena kernel: s          kacpid:   19 [cf7da040, 120]
(not blocked)
Nov 17 22:44:44 verena kernel: s          IRQ 11:   20 [cf64d3b0,  58]
(not blocked)
Nov 17 22:44:44 verena kernel: s       kblockd/0:   91 [cf64cd40, 110]
(not blocked)
Nov 17 22:44:44 verena kernel: s           khubd:  104 [cf64c6d0, 115]
(not blocked)
Nov 17 22:44:44 verena kernel: s         pdflush:  183 [cf64c060, 117]
(not blocked)
Nov 17 22:44:44 verena kernel: s         pdflush:  184 [cf6c53d0, 115]
(not blocked)
Nov 17 22:44:44 verena kernel: s           aio/0:  186 [cf6c46f0, 112]
(not blocked)
Nov 17 22:44:44 verena kernel: s         kswapd0:  185 [cf6c4d60, 125]
(not blocked)
Nov 17 22:44:44 verena kernel: s           IRQ 8:  775 [cf6c4080,  56]
(not blocked)
Nov 17 22:44:44 verena kernel: s          IRQ 12:  785 [c139ed80,  54]
(not blocked)
Nov 17 22:44:44 verena kernel: s           IRQ 7:  804 [c139e710, 112]
(not blocked)
Nov 17 22:44:44 verena kernel: s         kseriod:  779 [c139f3f0, 125]
(not blocked)
Nov 17 22:44:44 verena kernel: s           IRQ 6:  807 [c139e0a0,  51]
(not blocked)
Nov 17 22:44:44 verena kernel: s          IRQ 14:  821 [c13e9450,  52]
(not blocked)
Nov 17 22:44:44 verena kernel: s          IRQ 15:  824 [c13dc0e0,  53]
(not blocked)
Nov 17 22:44:44 verena kernel: s       scsi_eh_0:  837 [c13dcdc0, 117]
blocked on: [c13e1fac] {sem.lock}
Nov 17 22:44:44 verena kernel: .. held by:         scsi_eh_0:  837
[c13dcdc0, 117]
Nov 17 22:44:44 verena kernel: ... acquired at:  scsi_error_handler
+0x50/0x100
Nov 17 22:44:44 verena kernel: s           IRQ 1:  864 [c13cd410,  55]
(not blocked)
Nov 17 22:44:44 verena kernel: s       kjournald:  903 [c13e8770, 115]
(not blocked)
Nov 17 22:44:44 verena kernel: s           IRQ 5: 1074 [c13dc750,  57]
(not blocked)
Nov 17 22:44:44 verena kernel: s          IRQ 10: 1116 [c13e8100,  59]
(not blocked)
Nov 17 22:44:44 verena kernel: s       kjournald: 1153 [cf439470, 120]
(not blocked)
Nov 17 22:44:44 verena kernel: s         portmap: 1320 [ce6ace20, 115]
(not blocked)
Nov 17 22:44:44 verena kernel: s           IRQ 4: 1328 [c13cc0c0, 112]
(not blocked)
Nov 17 22:44:44 verena kernel: s           IRQ 3: 1331 [cf438e00, 112]
(not blocked)
Nov 17 22:44:44 verena kernel: s         syslogd: 1433 [c13ccda0, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s           klogd: 1436 [ce6ac7b0, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s            pppd: 1448 [cdbb2e40, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s           pppoe: 1451 [c13dd430, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s           gnugk: 1484 [c13e8de0, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s           gnugk: 1508 [cd366e60, 120]
(not blocked)
Nov 17 22:44:44 verena kernel: s           gnugk: 1509 [cd3667f0, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s           gnugk: 1510 [cd366180, 120]
(not blocked)
Nov 17 22:44:44 verena kernel: s           gnugk: 1511 [cc5014f0, 120]
(not blocked)
Nov 17 22:44:44 verena kernel: s           inetd: 1489 [cdbb34b0, 122]
(not blocked)
Nov 17 22:44:44 verena kernel: s         jabberd: 1492 [ce6ad490, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s           ip-up: 1502 [cd3674d0, 118]
(not blocked)
Nov 17 22:44:44 verena kernel: s       run-parts: 1504 [cdbb27d0, 118]
(not blocked)
Nov 17 22:44:44 verena kernel: s            exim: 1506 [cdbb2160, 119]
(not blocked)
Nov 17 22:44:44 verena kernel: s            exim: 1507 [cf438120, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s         jabberd: 1516 [cc5001a0, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s         jabberd: 1519 [c13cc730, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s            nfsd: 1907 [cc500e80, 119]
(not blocked)
Nov 17 22:44:44 verena kernel: s            nfsd: 1908 [cc58eea0, 119]
(not blocked)
Nov 17 22:44:44 verena kernel: s            nfsd: 1909 [cc58e830, 119]
(not blocked)
Nov 17 22:44:44 verena kernel: s            nfsd: 1910 [cf438790, 119]
(not blocked)
Nov 17 22:44:44 verena kernel: s            nfsd: 1911 [cc58e1c0, 119]
(not blocked)
Nov 17 22:44:44 verena kernel: s            nfsd: 1912 [cc7a7530, 120]
(not blocked)
Nov 17 22:44:44 verena kernel: s            nfsd: 1913 [cc7a6ec0, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s            nfsd: 1914 [cc7a6850, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s           lockd: 1916 [cc7a61e0, 121]
(not blocked)
Nov 17 22:44:44 verena kernel: s        rpciod/0: 1917 [cc783550, 111]
(not blocked)
Nov 17 22:44:44 verena kernel: s      rpc.mountd: 1920 [cc782ee0, 119]
(not blocked)
Nov 17 22:44:44 verena kernel: s      postmaster: 1962 [cc58f510, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s      postmaster: 1966 [cc7fc890, 121]
(not blocked)
Nov 17 22:44:44 verena kernel: s      postmaster: 1967 [cc7fcf00, 122]
(not blocked)
Nov 17 22:44:44 verena kernel: s            slpd: 1981 [cc7fd570, 120]
(not blocked)
Nov 17 22:44:44 verena kernel: s            sshd: 1987 [cc500810, 120]
(not blocked)
Nov 17 22:44:44 verena kernel: s   vdrconvert.sh: 1996 [cbcd8f20, 135]
(not blocked)
Nov 17 22:44:44 verena kernel: s       rpc.statd: 2004 [cc782870, 117]
(not blocked)
Nov 17 22:44:44 verena kernel: s            Xvfb: 2005 [cbcd9590, 131]
(not blocked)
Nov 17 22:44:44 verena kernel: s             atd: 2018 [cbcd8240, 118]
(not blocked)
Nov 17 22:44:44 verena kernel: s            cron: 2021 [cc782200, 118]
(not blocked)
Nov 17 22:44:44 verena kernel: s           fcron: 2024 [cbee6f40, 118]
(not blocked)
Nov 17 22:44:44 verena kernel: s          apache: 2031 [cbee68d0, 116]
(not blocked)
Nov 17 22:44:44 verena kernel: s             vdr: 2039 [cb1f4f60, 118]
(not blocked)
Nov 17 22:44:44 verena kernel: s           getty: 2040 [cb1f48f0, 117]
(not blocked)
Nov 17 22:44:44 verena kernel: s           getty: 2043 [ce6ac140, 117]
(not blocked)
Nov 17 22:44:44 verena kernel: s           getty: 2044 [cbee75b0, 117]
(not blocked)
Nov 17 22:44:44 verena kernel: s           getty: 2045 [cbcd88b0, 117]
(not blocked)
Nov 17 22:44:44 verena kernel: s           getty: 2046 [cb1f55d0, 117]
(not blocked)
Nov 17 22:44:44 verena kernel: s           lircd: 2059 [cbee6260, 118]
(not blocked)
Nov 17 22:44:44 verena kernel: s     wait2enc.py: 2060 [cb2815f0, 135]
(not blocked)
Nov 17 22:44:44 verena kernel: s          apache: 2063 [cb280f80, 119]
(not blocked)
Nov 17 22:44:44 verena kernel: s          apache: 2064 [cb280910, 120]
(not blocked)
Nov 17 22:44:44 verena kernel: s          apache: 2065 [cb2802a0, 121]
(not blocked)
Nov 17 22:44:44 verena kernel: s          apache: 2066 [caead610, 122]
(not blocked)
Nov 17 22:44:44 verena kernel: s          apache: 2067 [caeacfa0, 123]
(not blocked)
Nov 17 22:44:44 verena kernel: s    vdradmind.pl: 2078 [caeac2c0, 118]
(not blocked)
Nov 17 22:44:44 verena kernel: s          runvdr: 2079 [cb1f4280, 118]
(not blocked)
Nov 17 22:44:44 verena kernel: s         arm_mon: 2119 [ca3a7630, 119]
(not blocked)
Nov 17 22:44:44 verena kernel: s           sleep: 2139 [c9de0fe0, 136]
(not blocked)
Nov 17 22:44:44 verena kernel: s             vdr: 2147 [ca3a6950, 118]
(not blocked)
Nov 17 22:44:44 verena kernel: R             vdr: 2148 [caeac930, 119]
(not blocked)
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: ---------------------------
Nov 17 22:44:44 verena kernel: | showing all locks held: |
Nov 17 22:44:44 verena kernel: ---------------------------
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #001:             [c053ee6c]
{&hwif->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x8e/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #002:             [c053ea90]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #003:             [c053ec64]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #004:             [c053f4b4]
{&hwif->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x8e/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #005:             [c053f0d8]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #006:             [c053f2ac]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #007:             [c053fafc]
{&hwif->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x8e/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #008:             [c053f720]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #009:             [c053f8f4]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #010:             [c0540144]
{&hwif->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x8e/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #011:             [c053fd68]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #012:             [c053ff3c]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #013:             [c054078c]
{&hwif->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x8e/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #014:             [c05403b0]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #015:             [c0540584]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #016:             [c0540dd4]
{&hwif->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x8e/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #017:             [c05409f8]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #018:             [c0540bcc]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #019:             [c054141c]
{&hwif->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x8e/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #020:             [c0541040]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #021:             [c0541214]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #022:             [c0541a64]
{&hwif->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x8e/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #023:             [c0541688]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #024:             [c054185c]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #025:             [c05420ac]
{&hwif->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x8e/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #026:             [c0541cd0]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #027:             [c0541ea4]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #028:             [c05426f4]
{&hwif->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x8e/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #029:             [c0542318]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #030:             [c05424ec]
{&drive->gendev_rel_sem}
Nov 17 22:44:44 verena kernel: .. held by:           swapper:    0
[c044cd80, 140]
Nov 17 22:44:44 verena kernel: ... acquired at:  init_hwif_data
+0x160/0x180
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #031:             [ccd3dcf0]
{&tty->atomic_read}
Nov 17 22:44:44 verena kernel: .. held by:             getty: 2040
[cb1f48f0, 117]
Nov 17 22:44:44 verena kernel: ... acquired at:  read_chan+0x6f1/0x750
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #032:             [cd66acf0]
{&tty->atomic_read}
Nov 17 22:44:44 verena kernel: .. held by:             getty: 2044
[cbee75b0, 117]
Nov 17 22:44:44 verena kernel: ... acquired at:  read_chan+0x6f1/0x750
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #033:             [cda85cf0]
{&tty->atomic_read}
Nov 17 22:44:44 verena kernel: .. held by:             getty: 2045
[cbcd88b0, 117]
Nov 17 22:44:44 verena kernel: ... acquired at:  read_chan+0x6f1/0x750
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #034:             [cdfe6cf0]
{&tty->atomic_read}
Nov 17 22:44:44 verena kernel: .. held by:             getty: 2046
[cb1f55d0, 117]
Nov 17 22:44:44 verena kernel: ... acquired at:  read_chan+0x6f1/0x750
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #035:             [cb22ccf0]
{&tty->atomic_read}
Nov 17 22:44:44 verena kernel: .. held by:             getty: 2043
[ce6ac140, 117]
Nov 17 22:44:44 verena kernel: ... acquired at:  read_chan+0x6f1/0x750
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #036:             [c9c8fa10] {&fe->sem}
Nov 17 22:44:44 verena kernel: .. held by:               vdr: 2147
[ca3a6950, 118]
Nov 17 22:44:44 verena kernel: ... acquired at:  dvb_frontend_start
+0x75/0x100
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: #037:             [c045e444]
{kernel_sem.lock}
Nov 17 22:44:44 verena kernel: .. held by:               vdr: 2147
[ca3a6950, 118]
Nov 17 22:44:44 verena kernel: ... acquired at:  lock_kernel+0x27/0x50
Nov 17 22:44:44 verena kernel:
=============================================
Nov 17 22:44:44 verena kernel: 
Nov 17 22:44:44 verena kernel: [ turning off deadlock detection. Please
report this trace. ]


-- 
Christian Meder, email: chris@onestepahead.de

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)


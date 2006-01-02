Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWABXPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWABXPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 18:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWABXPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 18:15:54 -0500
Received: from mail.gmx.net ([213.165.64.21]:31369 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751124AbWABXPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 18:15:53 -0500
X-Authenticated: #4399952
Date: Tue, 3 Jan 2006 00:15:50 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nedko Arnaudov <nedko@arnaudov.name>, linux-kernel@vger.kernel.org
Subject: Re: patch-2.6.15-rc7-rt2 (realtime-preempt) report
Message-ID: <20060103001550.43e525ce@mango.fruits.de>
In-Reply-To: <20060102214516.GA12850@elte.hu>
References: <87ek3ug314.fsf@arnaudov.name>
	<87mzie2tzu.fsf@arnaudov.name>
	<20060102214516.GA12850@elte.hu>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2006 22:45:16 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> could you try -rt3?

-rt3 gives me this BUG, when running rosegarden (btw: i forgot to
mention, that i use debian unstable and thus gcc 4.0.3):

==========================================
[ BUG: lock recursion deadlock detected! |
------------------------------------------
already locked:  [c0331b20] {rtc_task_lock}
.. held by:             IRQ 8:   18 [efd1ce90,   1]
... acquired at:               rtc_interrupt+0x79/0x130
-{current task's backtrace}----------------->
 [<c0130cf7>] check_deadlock+0x307/0x340 (8)
 [<c02377d9>] rtc_interrupt+0x79/0x130 (8)
 [<c02d9b52>] __schedule+0x392/0x710 (4)
 [<c0238854>] rtc_control+0x24/0x80 (16)
 [<c0131ae1>] task_blocks_on_lock+0x41/0x130 (12)
 [<c0238854>] rtc_control+0x24/0x80 (16)
 [<c02db2a8>] __down_mutex+0x498/0x910 (24)
 [<c0238854>] rtc_control+0x24/0x80 (16)
 [<c0238854>] rtc_control+0x24/0x80 (80)
 [<c0142370>] do_irqd+0x0/0xa0 (8)
 [<c02dd9c3>] _spin_lock_irq+0x23/0x50 (4)
 [<c0238854>] rtc_control+0x24/0x80 (8)
 [<c0238854>] rtc_control+0x24/0x80 (16)
 [<f09f70f9>] rtctimer_stop+0x29/0x60 [snd_rtctimer] (16)
 [<f081e20e>] snd_timer_interrupt+0x2ae/0x2f0 [snd_timer] (16)
 [<c0142370>] do_irqd+0x0/0xa0 (56)
 [<f09f7147>] rtctimer_interrupt+0x17/0x20 [snd_rtctimer] (4)
 [<c02377ec>] rtc_interrupt+0x8c/0x130 (12)
 [<c0141126>] handle_IRQ_event+0x76/0xf0 (20)
 [<c0142370>] do_irqd+0x0/0xa0 (44)
 [<c0142215>] thread_edge_irq+0x85/0x130 (4)
 [<c01422f7>] do_hardirq+0x37/0xb0 (32)
 [<c01423d7>] do_irqd+0x67/0xa0 (16)
 [<c012c3d6>] kthread+0xb6/0xc0 (28)
 [<c012c320>] kthread+0x0/0xc0 (24)
 [<c0100ded>] kernel_thread_helper+0x5/0x18 (16)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c013948a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x60)
.. [<c013948a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x60)


showing all tasks:
S            init:    1 [c16fb500, 116] (not blocked)
S  softirq-high/0:    2 [c16fae10,   0] (not blocked)
S softirq-timer/0:    3 [c16fa720,   0] (not blocked)
S softirq-net-tx/:    4 [c16fa030,  98] (not blocked)
S softirq-net-rx/:    5 [c1709520,  98] (not blocked)
S  softirq-scsi/0:    6 [c1708e30,  98] (not blocked)
S softirq-tasklet:    7 [c1708740,  98] (not blocked)
S      watchdog/0:    8 [c1708050,   0] (not blocked)
S       desched/0:    9 [c1715540, 105] (not blocked)
S        events/0:   10 [c1714e50,   0] (not blocked)
S         khelper:   11 [c1714760, 110] (not blocked)
S         kthread:   12 [c1714070, 111] (not blocked)
S       kblockd/0:   13 [efcf9560, 110] (not blocked)
S         pdflush:   14 [efcf8e70, 125] (not blocked)
S         pdflush:   15 [efcf8780, 115] (not blocked)
S           aio/0:   17 [efd1d580, 120] (not blocked)
S         kswapd0:   16 [efcf8090, 125] (not blocked)
S           IRQ 8:   18 [efd1ce90,   1] (not blocked)
S         kseriod:   19 [efd1c7a0, 110] (not blocked)
S          IRQ 12:   20 [efd1c0b0,  51] (not blocked)
S          IRQ 14:   21 [efe235a0,  44] (not blocked)
S          IRQ 15:   22 [efe22eb0,  44] (not blocked)
S           IRQ 1:   23 [efe227c0,   0] (not blocked)
S       kjournald:   24 [efe220d0, 115] (not blocked)
S      kgameportd:  186 [ef062800, 111] (not blocked)
S           IRQ 4:  189 [ee8e9600,  17] (not blocked)
S           khubd:  209 [ef062110, 110] (not blocked)
S           IRQ 5:  210 [ef65c0f0,  56] (not blocked)
S          IRQ 10:  211 [ee8e8f10,  89] (not blocked)
S       kjournald:  284 [ef062ef0, 115] (not blocked)
S       kjournald:  287 [ef201620, 119] (not blocked)
S       kjournald:  288 [ef65c7e0, 120] (not blocked)
S       kjournald:  289 [ef200f30, 119] (not blocked)
S       kjournald:  290 [ef200840, 119] (not blocked)
S         portmap:  413 [ee8e8130, 116] (not blocked)
S         syslogd:  531 [ef65ced0, 116] (not blocked)
S           klogd:  537 [edc69640, 116] (not blocked)
S            pppd:  547 [ee8e8820, 116] (not blocked)
S           pppoe:  551 [edc68f50, 116] (not blocked)
S           IRQ 3:  557 [edc68170,  58] (not blocked)
S       automount:  649 [edc68860, 116] (not blocked)
S   dbus-daemon-1:  655 [ed8ccf90, 115] (not blocked)
S            hald:  660 [ed9856a0, 116] (not blocked)
S           exim4:  733 [ed8b6880, 121] (not blocked)
S             gpm:  741 [ed8b6f70, 115] (not blocked)
S            sshd:  753 [ef200150, 118] (not blocked)
S             xfs:  762 [ed984fb0, 116] (not blocked)
S            cron:  798 [ed8cc1b0, 116] (not blocked)
S     rt_watchdog:  854 [ef0635e0,   1] (not blocked)
S     rt_watchdog:  855 [ed9848c0,  98] (not blocked)
S             gdm:  864 [ed8cc8a0, 115] (not blocked)
R             gdm:  865 [ed8cd680, 115] (not blocked)
S            Xorg:  874 [eca096c0, 115] (not blocked)
S           getty:  886 [ed8b7660, 117] (not blocked)
S           getty:  887 [ed8b6190, 117] (not blocked)
S           getty:  888 [eca08fd0, 117] (not blocked)
S           getty:  889 [ef65d5c0, 117] (not blocked)
S           getty:  890 [ed9841d0, 117] (not blocked)
S           getty:  891 [eca088e0, 117] (not blocked)
S              sh:  924 [ebfacff0, 122] (not blocked)
S       ssh-agent:  994 [ebfad6e0, 116] (not blocked)
S       ssh-agent:  995 [ebae7700, 116] (not blocked)
S              sh:  999 [ebfac210, 121] (not blocked)
S   xfce4-session: 1004 [eca081f0, 116] (not blocked)
S    xscreensaver: 1002 [ebfac900, 115] (not blocked)
S xfce-mcs-manage: 1009 [ebae6920, 115] (not blocked)
S           xfwm4: 1012 [ebae6230, 115] (not blocked)
S      xftaskbar4: 1014 [e8a1b720, 116] (not blocked)
S       xfdesktop: 1016 [e8a1b030, 115] (not blocked)
S     xfce4-panel: 1019 [e8a1a940, 115] (not blocked)
S         gkrellm: 1022 [e8a1a250, 115] (not blocked)
S       evolution: 1024 [e7fe1740, 116] (not blocked)
S       evolution: 1077 [e3fa49c0, 115] (not blocked)
S  sylpheed-claws: 1026 [e7fe1050, 115] (not blocked)
S        qjackctl: 1028 [e7fe0960, 115] (not blocked)
S            gaim: 1030 [e7fe0270, 116] (not blocked)
R            xmms: 1032 [e7a0b760, 115] (not blocked)
S            xmms: 1039 [e7a0b070, 115] (not blocked)
S            xmms: 1060 [ebae7010, 115] (not blocked)
S        gconfd-2: 1043 [e7a0a980, 116] (not blocked)
S bonobo-activati: 1058 [e3d809a0, 115] (not blocked)
S evolution-data-: 1065 [e3d81780, 115] (not blocked)
S evolution-data-: 1071 [e3fa50b0, 115] (not blocked)
S evolution-data-: 1104 [e18c5800, 116] (not blocked)
S evolution-alarm: 1089 [e3fa57a0, 116] (not blocked)
S evolution-alarm: 1091 [e23502f0, 117] (not blocked)
S evolution-alarm: 1108 [e3fa42d0, 118] (not blocked)
S           xterm: 1116 [e18cf7e0, 116] (not blocked)
S            bash: 1117 [e18c4a20, 117] (not blocked)
S           xterm: 1489 [e18c5110, 116] (not blocked)
S            bash: 1490 [e23510d0, 115] (not blocked)
S           xterm: 1520 [e23509e0, 116] (not blocked)
S            bash: 1521 [e18cea00, 116] (not blocked)
S            htop: 1614 [e18ce310, 117] (not blocked)
R     rosegarden4: 1635 [e3d81090, 116] (not blocked)
S         kdeinit: 1637 [e23517c0, 116] (not blocked)
R      dcopserver: 1641 [e18c4330, 116] (not blocked)
S       klauncher: 1643 [dd98b130, 115] (not blocked)
S            kded: 1645 [e18cf0f0, 115] (not blocked)
R rosegardenseque: 1651 [dd98b820, 115] (not blocked)
S           jackd: 1653 [e3d802b0, 119] (not blocked)
S           jackd: 1656 [dd98aa40, 119] (not blocked)
S           jackd: 1657 [e7a0a290, 120] (not blocked)
S           jackd: 1658 [dd98a350,  19] (not blocked)
S           jackd: 1659 [d7381840,  29] (not blocked)

=============================================

[ turning off deadlock detection. Please report this trace. ]

The bootup swapper BUG also persists:

BUG: swapper:0 task might have lost a preemption check!
 [<c0100b3b>] cpu_idle+0x6b/0xb0 (8)
 [<c010026b>] _stext+0x4b/0x60 (4)
 [<c0364831>] start_kernel+0x191/0x210 (16)
 [<c0364350>] unknown_bootoption+0x0/0x200 (20)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (swapper/0 [c0319d20, 140]):
------------------------------

.config identical to -rt2

Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org

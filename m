Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWHMI6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWHMI6V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 04:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWHMI6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 04:58:21 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:61675 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750756AbWHMI6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 04:58:20 -0400
Date: Sun, 13 Aug 2006 04:53:09 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on
  suspend
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-netdev <netdev@vger.kernel.org>, Keith Owens <kaos@sgi.com>
Message-ID: <200608130456_MC3-1-C7EE-44C8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060812052853.f9e5d648.akpm@osdl.org>

On Sat, 12 Aug 2006 05:28:53 -0700, Andrew Morton wrote:

> > general protection fault: 0000 [1] PREEMPT
> > last sysfs file: /devices/pci0000:00/0000:00:0a.0/0000:02:02.0/subsystem_device
> > CPU 0
> > Modules linked in: ide_cd cdrom usbserial asus_acpi thermal ipv6 processor fan button battery ac af_packet snd_pcm_oss snd_mixer_oss snd_seq
> > snd_seq_device bcm43xx ieee80211softmac ieee80211 ieee80211_crypt pcmcia firmware_class ohci1394 ieee1394 skge yenta_socket rsrc_nonstatic pc
> > mcia_core usbhid ff_memless snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd ohci_hcd i2c_nfo
> > rce2 i2c_core parport_pc lp parport dm_mod
> > Pid: 4, comm: events/0 Not tainted 2.6.18-rc3-mm2 #17
> > RIP: 0010:[<ffffffff88107287>]  [<ffffffff88107287>] :skge:skge_poll+0x547/0x570
> > RSP: 0018:ffffffff80621e70  EFLAGS: 00010202
> > RAX: 6b6b6b6b6b6b6b6b RBX: 0000000000000000 RCX: 0000000000000040
> 
> RAX doesn't look good.
> 
> > RDX: ffff81005addf128 RSI: ffffffff80621eec RDI: ffff81005addeb60
> > RBP: ffffffff80621ed0 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000040 R11: 0000000000000000 R12: ffff81005addf0a0
> > R13: 0000000000000000 R14: ffff810057fe9180 R15: 00000000ffffffff
> > FS:  00002b4b98df4b00(0000) GS:ffffffff808c2000(0000) knlGS:00000000558b4d00
> > CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> > CR2: 00002adeb0d7d0b0 CR3: 0000000025147000 CR4: 00000000000006e0
> > Process events/0 (pid: 4, threadinfo ffff810037f44000, task ffff810037fef100)
> > Stack:  ffffffff80621eb0 ffffffff80621eec ffff81005addeb60 ffff81005ad61488
> >  ffff81005addf128 000000400000000a 00000001008e6a25 0000000000000000
> >  ffff81005addeb60 0000000000000000 00000001008e6a25 00000000ffffffff
> > Call Trace:
> >  [<ffffffff8040b1ba>] net_rx_action+0xba/0x1f0
> >  [<ffffffff80233640>] __do_softirq+0x70/0xf0
> >  [<ffffffff8020aa7c>] call_softirq+0x1c/0x30
> > DWARF2 unwinder stuck at call_softirq+0x1c/0x30
> > Leftover inexact backtrace:
> >  <IRQ> [<ffffffff8020ca4d>] do_softirq+0x3d/0xb0
> >  [<ffffffff8023349e>] irq_exit+0x4e/0x60
> >  [<ffffffff8020cbf5>] do_IRQ+0x135/0x140
> >  [<ffffffff80427b9e>] rt_run_flush+0x8e/0xd0
> >  [<ffffffff8020a266>] ret_from_intr+0x0/0xf
> >  <EOI> [<ffffffff80233367>] local_bh_enable_ip+0xe7/0x110
> >  [<ffffffff804718b9>] _spin_unlock_bh+0x39/0x40
> >  [<ffffffff80427b9e>] rt_run_flush+0x8e/0xd0
> >  [<ffffffff80427c8b>] rt_cache_flush+0xab/0x100
> >  [<ffffffff8045a1c9>] fib_netdev_event+0xa9/0xc0
> >  [<ffffffff8023c2af>] notifier_call_chain+0x2f/0x50
> >  [<ffffffff8023c4b9>] raw_notifier_call_chain+0x9/0x10
> >  [<ffffffff80409789>] netdev_state_change+0x29/0x40
> >  [<ffffffff80415122>] linkwatch_run_queue+0x162/0x190
> >  [<ffffffff8041517a>] linkwatch_event+0x2a/0x40
> >  [<ffffffff8023fd72>] run_workqueue+0xc2/0x120
> >  [<ffffffff80415150>] linkwatch_event+0x0/0x40
> >  [<ffffffff8023fff1>] worker_thread+0x121/0x160
> >  [<ffffffff80229370>] default_wake_function+0x0/0x10
> >  [<ffffffff8023fed0>] worker_thread+0x0/0x160
> >  [<ffffffff802436f9>] kthread+0xd9/0x110
> >  [<ffffffff8024b1ad>] trace_hardirqs_on+0x11d/0x150
> >  [<ffffffff8020a706>] child_rip+0x8/0x12
> >  [<ffffffff80471e5b>] _spin_unlock_irq+0x2b/0x60
> >  [<ffffffff8020a2c0>] restore_args+0x0/0x30
> >  [<ffffffff80243620>] kthread+0x0/0x110
> >  [<ffffffff8020a6fe>] child_rip+0x0/0x12
> > Code: 44 8b 28 c7 45 d0 00 00 00 00 45 85 ed 0f 89 29 fb ff ff e9
> > RIP  [<ffffffff88107287>] :skge:skge_poll+0x547/0x570
> >  RSP <ffffffff80621e70>
>
> ksymoops says:
> 
> Code;  ffffffff88107287 <_end+7ac9287/7efc2000>
> 00000000 <_EIP>:
> Code;  ffffffff88107287 <_end+7ac9287/7efc2000>   <=====
>    0:   44                        inc    %esp   <=====
> Code;  ffffffff88107288 <_end+7ac9288/7efc2000>
>    1:   8b 28                     mov    (%eax),%ebp

0x44 is a REX prefix in 64-bit mode, so somehow ksymoops got it
wrong and gave you an i386-mode decode instead of 64-bit mode.
Did you run it on a i386 machine and it assumed i386? Maybe you
need to use "-a x86-64"?  (I can't make it work on my setup.)

So it's really "mov (%r8),%ebp" if I am reading the manual right.

-- 
Chuck


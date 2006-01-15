Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWAOUlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWAOUlu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWAOUlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:41:50 -0500
Received: from depni.sinp.msu.ru ([213.131.7.21]:42426 "EHLO depni.sinp.msu.ru")
	by vger.kernel.org with ESMTP id S1750728AbWAOUlu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:41:50 -0500
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Vitaly V. Bursov" <vitalyb@telenet.dn.ua>
Subject: Re: linux 2.6.15.1 ppp_async panic on x86-64.
In-Reply-To: <20060115210948.4e2990a7.diegocg@gmail.com>
References: <20060115214838.2034a56c.vitalyb@telenet.dn.ua>
            <20060115210948.4e2990a7.diegocg@gmail.com>
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
Date: Sun, 15 Jan 2006 23:41:48 +0300
Message-ID: <56slrpz0j7.fsf@depni.sinp.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja <diegocg@gmail.com> writes:

> El Sun, 15 Jan 2006 21:48:38 +0200,
> "Vitaly V. Bursov" <vitalyb@telenet.dn.ua> escribió:
...
>> PPP doesn't work for me on a x86-64 kernel. Kernel panics with a message
...
>> Jan 15 20:24:12 vb skb_over_panic: text:ffffffff886700d9 len:1 put:1
>> head:ffff81002b7ed000 data:ffff81012b7ed000 tail:ffff81012b7ed001
>> end:ffff81002b7ed600 dev:<NULL>
...
> Just for the record, there're more people hitting this
> http://bugzilla.kernel.org/show_bug.cgi?id=5857

I can confirm this with a similar oops:

[  273.950666] skb_over_panic: text:ffffffff882d8c19 len:54 put:54 head:ffff81001cfecd60 data:ffff81011cfecd63 tail:ffff81011cfecd99 end:ffff81001cfed360 dev:<NULL>
[  273.950681] ----------- [cut here ] --------- [please bite here ] ---------
[  273.950684] Kernel BUG at net/core/skbuff.c:94
[  273.950686] invalid operand: 0000 [1] PREEMPT 
[  273.950689] CPU 0 
[  273.950691] Modules linked in: ppp_deflate bsd_comp ppp_async ppp_generic slhc pl2303 usbserial radeon drm af_packet ipv6 pcmcia firmware_class bridge deflate zlib_deflate zlib_inflate twofish serpent aes blowfish des sha256 sha1 af_key binfmt_misc dm_mod asus_acpi button thermal processor battery evdev eth1394 snd_intel8x0 snd_intel8x0m snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm irtty_sir snd_timer ohci1394 snd sir_dev irda 8250_pci ide_cd yenta_socket rsrc_nonstatic pcmcia_core amd64_agp ehci_hcd psmouse pcspkr parport_pc parport 8250 serial_core ieee1394 cdrom ohci_hcd usbcore crc_ccitt i2c_nforce2 i2c_core soundcore snd_page_alloc rtc agpgart unix
[  273.950728] Pid: 4, comm: events/0 Not tainted 2.6.15-ssb1dbg #3
[  273.950731] RIP: 0010:[skb_over_panic+96/112] <ffffffff8027c160>{skb_over_panic+96}
[  273.950739] RSP: 0018:ffff81001fe19d78  EFLAGS: 00010096
[  273.950742] RAX: 00000000000000ab RBX: 0000000000000036 RCX: ffffffff803b5d58
[  273.950745] RDX: ffff81001ff38080 RSI: 0000000000000082 RDI: 0000000000000001
[  273.950749] RBP: ffff81001fe19d98 R08: 0000000000000005 R09: 0000000000000000
[  273.950752] R10: 0000000000000000 R11: 0000000000000000 R12: ffff81000c4c18e8
[  273.950755] R13: 000000000000003f R14: ffff8100164a8801 R15: ffff81011cfecd63
[  273.950759] FS:  00002aaaab3a96d0(0000) GS:ffffffff80575800(0000) knlGS:0000000000000000
[  273.950763] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[  273.950766] CR2: 0000000000c55000 CR3: 0000000019e81000 CR4: 00000000000006e0
[  273.950770] Process events/0 (pid: 4, threadinfo ffff81001fe18000, task ffff81001ff38080)
[  273.950772] Stack: ffff81011cfecd99 ffff81001cfed360 ffffffff80323edb ffff81000c4c18e8 
[  273.950779]        ffff81001fe19df8 ffffffff882d8c23 ffff81000c4c19a0 ffff81000c4c1918 
[  273.950785]        ffff8100164a8401 ffff8100164a8000 
[  273.950789] Call Trace:<ffffffff882d8c23>{:ppp_async:ppp_asynctty_receive+579}
[  273.950800]        <ffffffff80238593>{flush_to_ldisc+291} <ffffffff80142e40>{worker_thread+512}
[  273.950816]        <ffffffff80238470>{flush_to_ldisc+0} <ffffffff8012d9c0>{default_wake_function+0}
[  273.950827]        <ffffffff802fb3a1>{thread_return+191} <ffffffff80142c40>{worker_thread+0}
[  273.950839]        <ffffffff801477d9>{kthread+217} <ffffffff802fc7b4>{_spin_unlock_irq+20}
[  273.950848]        <ffffffff8012de39>{schedule_tail+73} <ffffffff8010f7d6>{child_rip+8}
[  273.950858]        <ffffffff80147700>{kthread+0} <ffffffff8010f7ce>{child_rip+0}
[  273.950871]        
[  273.950874] 
[  273.950875] Code: 0f 0b 68 fe fe 32 80 c2 5e 00 c9 c3 66 66 66 90 55 49 89 d2 
[  273.950885] RIP <ffffffff8027c160>{skb_over_panic+96} RSP <ffff81001fe19d78>
[  273.950891]  <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
[  273.950895] in_atomic():1, irqs_disabled():1
[  273.950897] 
[  273.950898] Call Trace:<ffffffff8012c9eb>{__might_sleep+187} <ffffffff801328ed>{profile_task_exit+29}
[  273.950907]        <ffffffff801339e5>{do_exit+37} <ffffffff802fc7fd>{_spin_unlock_irqrestore+29}
[  273.950917]        <ffffffff80110654>{die+84} <ffffffff802fce4d>{do_trap+269}
[  273.950929]        <ffffffff80110e6d>{do_invalid_op+157} <ffffffff8027c160>{skb_over_panic+96}
[  273.950941]        <ffffffff8010f621>{error_exit+0} <ffffffff8027c160>{skb_over_panic+96}
[  273.950962]        <ffffffff8027c160>{skb_over_panic+96} <ffffffff882d8c23>{:ppp_async:ppp_asynctty_receive+579}
[  273.950975]        <ffffffff80238593>{flush_to_ldisc+291} <ffffffff80142e40>{worker_thread+512}
[  273.950990]        <ffffffff80238470>{flush_to_ldisc+0} <ffffffff8012d9c0>{default_wake_function+0}
[  273.950999]        <ffffffff802fb3a1>{thread_return+191} <ffffffff80142c40>{worker_thread+0}
[  273.951011]        <ffffffff801477d9>{kthread+217} <ffffffff802fc7b4>{_spin_unlock_irq+20}
[  273.951020]        <ffffffff8012de39>{schedule_tail+73} <ffffffff8010f7d6>{child_rip+8}
[  273.951029]        <ffffffff80147700>{kthread+0} <ffffffff8010f7ce>{child_rip+0}
[  273.951042]        
[  273.951046] note: events/0[4] exited with preempt_count 1

(this is 2.6.15-ck2 + few local hacks with debugging config)

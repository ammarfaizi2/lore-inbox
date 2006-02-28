Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWB1Xtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWB1Xtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWB1Xtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:49:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932454AbWB1Xtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:49:41 -0500
Date: Tue, 28 Feb 2006 15:48:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, ak@suse.de,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060228154805.1f1ed781.akpm@osdl.org>
In-Reply-To: <200602282334.05360.rjw@sisk.pl>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<200602282334.05360.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Tuesday 28 February 2006 13:24, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/
> > 
> > 
> > - A large procfs rework from Eric Biederman.
> > 
> > - The swap prefetching patch is back.
> 
> With this kernel something that causes the appended trace to appear happens on
> my box (Asus L5D, 1 CPU, x86-64) 100% of the time during boot.
> 
> usbcore: registered new driver usbserial
> usbserial: USB Serial support registered for generic
> usbcore: registered new driver usbserial_generic
> usbserial: USB Serial Driver core
> BUG: warning at kernel/fork.c:113/__put_task_struct()
> 
> Call Trace: <IRQ> <ffffffff80229c2b>{__put_task_struct+59}
>        <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
>        <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
>        <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
>        <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
>        <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
> BUG: warning at kernel/fork.c:114/__put_task_struct()
> 
> ...
> general protection fault: 0000 [1] PREEMPT
> last sysfs file: /class/vc/vcsa2/dev
> CPU 0
> Modules linked in: usbserial asus_acpi thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device af_packet p
> cmcia firmware_class ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core usbhid sk98lin snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_
> pcm ip6t_REJECT xt_tcpudp snd_timer snd ipt_REJECT xt_state soundcore iptable_mangle snd_page_alloc iptable_nat ip_nat iptable_filter i2c_n
> force2 ip6table_mangle i2c_core ehci_hcd ohci_hcd ip_conntrack ip_tables ip6table_filter ip6_tables x_tables ipv6 parport_pc lp parport dm_
> mod
> Pid: 820, comm: kjournald Not tainted 2.6.16-rc5-mm1 #70
> RIP: 0010:[<ffffffff8046747c>] <ffffffff8046747c>{schedule+1164}
> RSP: 0000:ffff810001c53c38  EFLAGS: 00010007
> RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 949494959493a4ca
> RDX: ffff810027ce1050 RSI: 0000000000000000 RDI: ffff810027ce1050
> RBP: ffff810001c53c98 R08: ffff810001a83040 R09: 0000000000000009
> R10: 00000000ffffffff R11: 0000000000000001 R12: ffff81002c8de4c8
> R13: ffff81002fdf72f8 R14: ffff810001a83040 R15: 000000000000390b
> FS:  00002adb23959b00(0000) GS:ffffffff8068d000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 00002b5b92aa91de CR3: 0000000027329000 CR4: 00000000000006e0
> Process kjournald (pid: 820, threadinfo ffff810001c52000, task ffff81002fdf7090)
> Stack: ffff81002fdf7090 ffff810027ce1050 ffff810001c53d18 ffff810001f2af10
>        ffff810001c53c78 ffff810001f2af10 ffff810001c53c78 ffff810001c53d08
>        ffff810001c53d18 0000000000000002
> Call Trace: <ffffffff804676df>{io_schedule+15} <ffffffff8027efeb>{sync_buffer+59}
>        <ffffffff80468015>{__wait_on_bit_lock+69} <ffffffff8027efb0>{sync_buffer+0}
>        <ffffffff8027efb0>{sync_buffer+0} <ffffffff804680c8>{out_of_line_wait_on_bit_lock+120}
>        <ffffffff80242690>{wake_bit_function+0} <ffffffff8027e574>{__lock_buffer+36}
>        <ffffffff8027fdc1>{ll_rw_block+65} <ffffffff8030a3ab>{journal_commit_transaction+1659}
>        <ffffffff804697d4>{_spin_unlock_irq+20} <ffffffff8046981d>{_spin_unlock_irqrestore+29}
>        <ffffffff8030e5c3>{kjournald+339} <ffffffff80242520>{autoremove_wake_function+0}
>        <ffffffff8030e470>{kjournald+0} <ffffffff80242309>{kthread+217}
>        <ffffffff804697d4>{_spin_unlock_irq+20} <ffffffff80228929>{schedule_tail+73}
>        <ffffffff8020a85e>{child_rip+8} <ffffffff80242230>{kthread+0}
>        <ffffffff8020a856>{child_rip+0}

I'd be suspecting the /proc patches.   Can you send the .config please?

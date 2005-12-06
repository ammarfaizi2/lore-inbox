Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbVLFDFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVLFDFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVLFDFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:05:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751415AbVLFDFS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 22:05:18 -0500
Date: Tue, 6 Dec 2005 14:04:53 +1100
From: Andrew Morton <akpm@osdl.org>
To: Carlos =?ISO-8859-1?Q?Mart=EDn?= <carlos@cmartin.tk>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rc5-mm1
Message-Id: <20051206140453.11e72d89.akpm@osdl.org>
In-Reply-To: <200512050749.03673.carlos@cmartin.tk>
References: <20051204232153.258cd554.akpm@osdl.org>
	<200512050749.03673.carlos@cmartin.tk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Martín <carlos@cmartin.tk> wrote:
>
> On Monday 05 December 2005 08:21, Andrew Morton wrote:
> > 
> > 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/
> 
> Hi,
> 
>  I've been getting these:
> 
> Dec 27 14:32:45 kiopa kernel: BUG: soft lockup detected on CPU#1!
> Dec 27 14:32:45 kiopa kernel: CPU 1:
> Dec 27 14:32:45 kiopa kernel: Modules linked in: ipv6 parport_pc parport 
> psmouse ns558 analog pcspkr snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm 
> gameport ohci_hcd snd_timer ide_cd cdrom forcedeth snd ehci_hcd usbcore 
> snd_page_alloc evdev unix
> Dec 27 14:32:45 kiopa kernel: Pid: 0, comm: swapper Not tainted 2.6.15-rc5-mm1 
> #2
> Dec 27 14:32:45 kiopa kernel: RIP: 0010:[<ffffffff80311453>] 
> <ffffffff80311453>{_spin_unlock_irq+19}
> Dec 27 14:32:45 kiopa kernel: RSP: 0000:ffff810001ffbf08  EFLAGS: 00000246
> Dec 27 14:32:45 kiopa kernel: RAX: ffff810001ff3fd8 RBX: ffff810001ffbe58 RCX: 
> ffffffff8040fba0
> Dec 27 14:32:45 kiopa kernel: RDX: 0000000000000001 RSI: ffff810001e19ad8 RDI: 
> ffff810001e18c20
> Dec 27 14:32:45 kiopa kernel: RBP: ffffffff8010e354 R08: 00000000000000e9 R09: 
> 0000000000000000
> Dec 27 14:32:45 kiopa kernel: R10: 0000000000000000 R11: ffff810001e17660 R12: 
> ffffffff8014cd49
> Dec 27 14:32:45 kiopa kernel: R13: ffffffff801106ff R14: ffff810001ff3f18 R15: 
> ffff810001ffbf18
> Dec 27 14:32:45 kiopa kernel: FS:  0000000000000000(0000) GS:ffffffff8041c080
> (0000) knlGS:00000000556b26c0
> Dec 27 14:32:45 kiopa kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 
> 000000008005003b
> Dec 27 14:32:45 kiopa kernel: CR2: 0000000056b8d012 CR3: 000000003cc2c000 CR4: 
> 00000000000006e0
> Dec 27 14:32:45 kiopa kernel: 
> Dec 27 14:32:45 kiopa kernel: Call Trace: <IRQ> 
> <ffffffff80311449>{_spin_unlock_irq+9} 
> <ffffffff8810db70>{:ipv6:addrconf_verify+0}
> Dec 27 14:32:45 kiopa kernel:        
> <ffffffff8014d0e2>{run_ktimeout_softirq+370} 
> <ffffffff801394c4>{__do_softirq+100}
> Dec 27 14:32:45 kiopa kernel:        <ffffffff8010f166>{call_softirq+30} 
> <ffffffff801106bc>{do_softirq+44}
> Dec 27 14:32:45 kiopa kernel:        <ffffffff801391a8>{irq_exit+72} 
> <ffffffff8010e9ca>{apic_timer_interrupt+98}
> Dec 27 14:32:45 kiopa kernel:         <EOI> 
> <ffffffff80311449>{_spin_unlock_irq+9} <ffffffff8030fed0>{thread_return+95}
> Dec 27 14:32:45 kiopa kernel:        <ffffffff8010c69d>{default_idle+45} 
> <ffffffff8010c731>{cpu_idle+97}
> Dec 27 14:32:45 kiopa kernel:        <ffffffff80433ea5>{start_secondary+1253}

At a guess I'd say the new ktimeout code is playing up.

> The full log is at http://www.cmartin.tk/linux/dmesg.bz2 which is 7.9M 
> uncompressed, with just the logs from the last boot.
> 
> The date is wrong because this is a second boot. Time goes extremely fast. 
> When I rebooted into an older kernel it said it was the 8th July 2006!
> 
> The system halts for up to a minute (I got a console login timeout out after 
> 60secs). The keyboard lights still change, but the cursor on the screen stays 
> put. After a bit things return to normal for a bit, repeat until reboot.
> 
>    cmn
> -- 
> Carlos Martín       http://www.cmartin.tk

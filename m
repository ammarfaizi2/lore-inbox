Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVK2Wxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVK2Wxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 17:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVK2Wxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 17:53:32 -0500
Received: from hera.kernel.org ([140.211.167.34]:55220 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932443AbVK2Wxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 17:53:31 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Linux 2.6.15-rc3
Date: Tue, 29 Nov 2005 14:53:28 -0800
Organization: OSDL
Message-ID: <20051129145328.3e5964a4@dxpl.pdx.osdl.net>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
	<200511292247.09243.rjw@sisk.pl>
	<200511292342.36228.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1133304808 15429 10.8.0.74 (29 Nov 2005 22:53:28 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 29 Nov 2005 22:53:28 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2005 23:42:35 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Update:
> 
> On Tuesday, 29 of November 2005 22:47, Rafael J. Wysocki wrote:
> > On Tuesday, 29 of November 2005 05:11, Linus Torvalds wrote:
> > > 
> > > I just pushed 2.6.15-rc3 out there, and here are both the shortlog and 
> > > diffstats appended.
> > 
> > Hangs solid on boot on dual-core Athlon64.  No details yet, but I'm working
> > on them.  I wonder if anyone else is seeing this.
> 
> The problem is caused by the ehci_hcd driver and fixed by the David
> Brownell's ehci-hang-fix.patch that's already in -mm.

I assume this is that bug:
-- 
[   47.145873] kjournald starting.  Commit interval 5 seconds
[   47.187797] EXT3-fs: mounted filesystem with ordered data mode.
[   48.395152] usbcore: registered new driver usbfs
[   48.433382] usbcore: registered new driver hub
[   58.733294] NMI Watchdog detected LOCKUP on CPU 1
[   58.770674] CPU 1 
[   58.799348] Modules linked in: ehci_hcd i2c_amd8111 i2c_amd756 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc sky2 tg3 usbcore
[   58.950846] Pid: 2042, comm: modprobe Not tainted 2.6.15-rc3-sky2 #1
[   58.996375] RIP: 0010:[<ffffffff803c145b>] <ffffffff803c145b>{.text.lock.spinlock+34}
[   59.022530] RSP: 0018:ffff81007fb39bb0  EFLAGS: 00000086
[   59.090005] RAX: 0000000000000296 RBX: 0000000000002301 RCX: 0000000000000005
[   59.138990] RDX: 0000000000000008 RSI: 0000000000002301 RDI: ffff81007cf84554
[   59.187922] RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
[   59.236698] R10: 0000000000000037 R11: 000000000000000a R12: ffff81007cf84400
[   59.285266] R13: 0000000000002395 R14: 0000000000000008 R15: ffff81007cf84538
[   59.333549] FS:  00002aaaaaac53c0(0000) GS:ffffffff805c6880(0000) knlGS:0000000000000000
[   59.385260] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   59.429103] CR2: 0000003d49a92660 CR3: 000000007d1c3000 CR4: 00000000000006e0
[   59.477671] Process modprobe (pid: 2042, threadinfo ffff81007fb38000, task ffff81007c001060)
[   59.530809] Stack: ffffffff88114d8a ffff810037cae1b0 0000000000000000 0000000000040000 
[   59.557613]        0000000000004283 0000000000000016 ffffffff8811ac60 ffff810037cae1b0 
[   59.609531]        0000000000000004 0000000000000002 
[   59.651373] Call Trace:<ffffffff88114d8a>{:ehci_hcd:ehci_hub_control+90} <ffffffff80257d38>{pci_bus_read_config_word+136}
[   59.713317]        <ffffffff80257c84>{pci_bus_read_config_byte+116} <ffffffff8811555d>{:ehci_hcd:ehci_port_power+157}
[   59.775028]        <ffffffff8811590d>{:ehci_hcd:ehci_pci_reinit+909} <ffffffff88117724>{:ehci_hcd:ehci_pci_reset+1156}
[   59.837778]        <ffffffff8030af1f>{pci_conf1_read+223} <ffffffff88008ee5>{:usbcore:usb_add_hcd+117}
[   59.896527]        <ffffffff8030a9ce>{pcibios_set_master+30} <ffffffff88012a4d>{:usbcore:usb_hcd_pci_probe+653}
[   59.958237]        <ffffffff8025c639>{pci_device_probe+89} <ffffffff802b867d>{driver_probe_device+77}
[   60.017091]        <ffffffff802b8760>{__driver_attach+0} <ffffffff802b87a0>{__driver_attach+64}
[   60.074566]        <ffffffff802b8760>{__driver_attach+0} <ffffffff802b7a49>{bus_for_each_dev+73}
[   60.132538]        <ffffffff802b7f80>{bus_add_driver+128} <ffffffff8025c130>{__pci_register_driver+160}
[   60.192379]        <ffffffff80150a22>{sys_init_module+258} <ffffffff8010dcee>{system_call+126}
[   60.249856]        
[   60.315333] 
[   60.315334] Code: 83 3f 00 7e f9 e9 2e fe ff ff f3 90 83 3f 00 7e f9 e9 30 fe 
[   60.404781] console shuts up ...
[   60.445767]  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

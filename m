Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754772AbWKITFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbWKITFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756AbWKITFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:05:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49304 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754758AbWKITFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:05:00 -0500
Date: Thu, 9 Nov 2006 11:04:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Benoit Boissinot" <bboissin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1
Message-Id: <20061109110453.4d2195dc.akpm@osdl.org>
In-Reply-To: <40f323d00611091043g407231e2nfcd7ed3fc06e711a@mail.gmail.com>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<40f323d00611091043g407231e2nfcd7ed3fc06e711a@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(added linux-scsi)

On Thu, 9 Nov 2006 19:43:17 +0100
"Benoit Boissinot" <bboissin@gmail.com> wrote:

> On 11/8/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > Temporarily at
> >
> > http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/
> >
> > will turn up at
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/
> >
> > when kernel.org mirroring catches up.
> >
> 
> I got the following oops when undocking my laptop:
> 
> [27525.704000] ACPI: undocking
> [27526.076000] usb 3-1: USB disconnect, address 2
> [27526.228000] usb 4-3: USB disconnect, address 2
> [27526.232000] BUG: unable to handle kernel paging request at virtual
> address 00200200
> [27526.232000]  printing eip:
> [27526.232000] e8074e26
> [27526.232000] *pde = 00000000
> [27526.232000] Oops: 0002 [#1]
> [27526.232000] last sysfs file: /class/net/eth0/carrier
> [27526.232000] Modules linked in: af_packet binfmt_misc rfcomm l2cap
> bluetooth ipv6 capability commoncap i915 drm acpi_cpufreq
> cpufreq_userspace cpufreq_stats cpufreq_powersave cpufreq_ondemand
> freq_table cpufreq_conservative video output sr_mod cdrom sbs
> sony_acpi i2c_ec i2c_core button dock battery container ac backlight
> dm_mod md_mod sbp2 lp shpchp pci_hotplug sg usb_storage joydev tsdev
> libusual pcmcia usbhid irda evdev crc_ccitt psmouse serio_raw
> snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss
> ata_generic snd_pcm snd_timer ipw2200 parport_pc parport snd soundcore
> snd_page_alloc intel_agp agpgart pcspkr ieee80211 ieee80211_crypt
> yenta_socket rsrc_nonstatic pcmcia_core tg3 iTCO_wdt rtc ext3 jbd
> mbcache ohci1394 ieee1394 ehci_hcd uhci_hcd usbcore sd_mod ata_piix
> libata scsi_mod thermal processor fan
> [27526.232000] CPU:    0
> [27526.232000] EIP:    0060:[<e8074e26>]    Not tainted VLI
> [27526.232000] EFLAGS: 00010002   (2.6.19-rc5-mm1 #18)
> [27526.232000] EIP is at
> scsi_device_dev_release_usercontext+0x36/0x100 [scsi_mod]
> [27526.232000] eax: e3d88890   ebx: e3d88808   ecx: 00100100   edx: 00200200
> [27526.232000] esi: 00000286   edi: e3d88800   ebp: e45bd014   esp: dfdb1e3c
> [27526.232000] ds: 007b   es: 007b   ss: 0068
> [27526.232000] Process khubd (pid: 1739, ti=dfdb0000 task=dfe4f030
> task.ti=dfdb0000)
> [27526.232000] Stack: e3d88a64 e8074df0 c0374580 e45bd07c c01280e2
> e3d888f8 c03745dc c0233182
> [27526.232000]        c03745dc e3d888f8 c03745dc c0374580 c01d53e9
> e3d88910 c01d5430 e425ec28
> [27526.232000]        ffffffed c01d6065 e3d88890 e425ec28 ffffffed
> e8074667 e425ec00 00000202
> [27526.232000] Call Trace:
> [27526.232000]  [<e8074df0>]
> scsi_device_dev_release_usercontext+0x0/0x100 [scsi_mod]
> [27526.232000]  [execute_in_process_context+34/112]
> execute_in_process_context+0x22/0x70
> [27526.232000]  [device_release+18/112] device_release+0x12/0x70
> [27526.232000]  [kobject_cleanup+73/144] kobject_cleanup+0x49/0x90
> [27526.232000]  [kobject_release+0/16] kobject_release+0x0/0x10
> [27526.232000]  [kref_put+53/160] kref_put+0x35/0xa0
> [27526.232000]  [<e8074667>] __scsi_remove_device+0x67/0x80 [scsi_mod]
> [27526.232000]  [<e8073a33>] scsi_forget_host+0x43/0x50 [scsi_mod]
> [27526.232000]  [<e806c6f2>] scsi_remove_host+0x32/0xb0 [scsi_mod]
> [27526.232000]  [<e83c9c5e>] storage_disconnect+0xe/0x20 [usb_storage]
> [27526.232000]  [<e80e095f>] usb_unbind_interface+0x4f/0xa0 [usbcore]
> [27526.232000]  [__device_release_driver+100/144]
> __device_release_driver+0x64/0x90
> [27526.232000]  [device_release_driver+34/64] device_release_driver+0x22/0x40
> [27526.232000]  [bus_remove_device+92/144] bus_remove_device+0x5c/0x90
> [27526.232000]  [device_del+327/416] device_del+0x147/0x1a0
> [27526.232000]  [<e80ddf78>] usb_disable_device+0x78/0xe0 [usbcore]
> [27526.232000]  [<e80da614>] usb_disconnect+0x94/0xe0 [usbcore]
> [27526.232000]  [<e80db260>] hub_thread+0x200/0xc40 [usbcore]
> [27526.232000]  [autoremove_wake_function+0/80]
> autoremove_wake_function+0x0/0x50
> [27526.232000]  [<e80db060>] hub_thread+0x0/0xc40 [usbcore]
> [27526.232000]  [kthread+169/224] kthread+0xa9/0xe0
> [27526.232000]  [kthread+0/224] kthread+0x0/0xe0
> [27526.232000]  [kernel_thread_helper+7/28] kernel_thread_helper+0x7/0x1c
> [27526.232000]  =======================
> [27526.232000] Code: ff ff 89 1c 24 89 74 24 04 89 6c 24 0c 8b 68 64
> 8d 55 ec 9c 5e fa ff 82 58 01 00 00 8d 98 78 ff ff ff 8b 53 04 8b 88
> 78 ff ff ff <89> 0a 89 51 04 b9 00 01 10 00 c7 43 04 00 02 20 00 8d 58
> 80 8b
> [27526.232000] EIP: [<e8074e26>]
> scsi_device_dev_release_usercontext+0x36/0x100 [scsi_mod] SS:ESP
> 0068:dfdb1e3c
> 
> full dmesg attached, I can test patches and provide any useful
> information if needed (just not now because the dock is at work).

You're the second or third person to report this (to no effect, btw). 
Other reports have been with USB-unplug, so I doubt if the docking code is
involved.


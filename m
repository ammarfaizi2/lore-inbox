Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWDCTJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWDCTJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWDCTJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:09:19 -0400
Received: from mail.charite.de ([160.45.207.131]:5552 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S964848AbWDCTJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:09:18 -0400
Date: Mon, 3 Apr 2006 21:09:15 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.17-rc1
Message-ID: <20060403190915.GA10584@charite.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20060403180207.E849EE007A12@knarzkiste.dyndns.org> <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060403180207.E849EE007A12@knarzkiste.dyndns.org> <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org>:
> 
> Ok, 
>  it's two weeks since 2.6.16, and the merge window is closed.

loading an unloading the powernow-k8 modules causes an EIP:

% modprobe powernow_k8

> Apr  3 19:52:32 knarzkiste kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.1)
> Apr  3 19:52:32 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
> Apr  3 19:52:32 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
> Apr  3 19:52:32 knarzkiste kernel: cpu_init done, current fid 0x8, vid 0x2
> Apr  3 19:52:32 knarzkiste kernel: powernow-k8: ph2 null fid transition 0x8

% rmmod powernow_k8

> Apr  3 19:52:58 knarzkiste kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000002c
> Apr  3 19:52:58 knarzkiste kernel:  printing eip:
> Apr  3 19:52:58 knarzkiste kernel: ded6db09
> Apr  3 19:52:58 knarzkiste kernel: *pde = 00000000
> Apr  3 19:52:58 knarzkiste kernel: Oops: 0000 [#1]
> Apr  3 19:52:58 knarzkiste kernel: PREEMPT
> Apr  3 19:52:58 knarzkiste kernel: Modules linked in: powernow_k8 freq_table thermal fan button processor ac battery af_packet ide_scsi sata_sil libata scsi_mod eeprom saa7134_dvb mt352 saa7134 compat_ioctl32 v4l2_common v4l1_compat ir_kbd_i2c ir_common videodev video_buf_dvb dvb_core video_buf nxt200x dvb_pll tda1004x usbhid usbmouse pcmcia firmware_class tsdev 8250_pci 8250 serial_core 8139too evdev psmouse yenta_socket rsrc_nonstatic pcmcia_core ehci_hcd ohci_hcd snd_atiixp_modem snd_atiixp usbcore ide_cd snd_ac97_codec snd_ac97_bus ati_agp agpgart snd_pcm snd_timer snd soundcore snd_page_alloc cdrom unix
> Apr  3 19:52:58 knarzkiste kernel: CPU:    0
> Apr  3 19:52:58 knarzkiste kernel: EIP:    0060:[pg0+513383177/1069720576]    Not tainted VLI
> Apr  3 19:52:58 knarzkiste kernel: EFLAGS: 00010286   (2.6.17-rc1 #1)
> Apr  3 19:52:58 knarzkiste kernel: EIP is at acpi_processor_unregister_performance+0x1e/0x3e [processor]
> Apr  3 19:52:58 knarzkiste kernel: eax: 00000000   ebx: dd1f5000   ecx: 00000001   edx: 00000000
> Apr  3 19:52:58 knarzkiste kernel: esi: dca68980   edi: 00000286   ebp: dca68a0c   esp: dd002f1c
> Apr  3 19:52:58 knarzkiste kernel: ds: 007b   es: 007b   ss: 0068
> Apr  3 19:52:58 knarzkiste kernel: Process rmmod (pid: 4806, threadinfo=dd002000 task=ddd6f070)
> Apr  3 19:52:58 knarzkiste kernel: Stack: <0>dc1d1640 ded684d6 dca68980 dca689a8 c0296582 c03adf88 c034ca50 c0349d9c
> Apr  3 19:52:58 knarzkiste kernel:        c0349d80 c0274eb7 00000880 ded6a100 00000000 dd002000 c02953f5 c0136706
> Apr  3 19:52:58 knarzkiste kernel:        65776f70 776f6e72 00386b5f da8999bc c0149d89 b7fa0000 dd62bac0 c014b198
> Apr  3 19:52:58 knarzkiste kernel: Call Trace:
> Apr  3 19:52:58 knarzkiste kernel:  <ded684d6> powernowk8_cpu_exit+0x26/0x50 [powernow_k8]   <c0296582> cpufreq_remove_dev+0xb2/0x120
> Apr  3 19:52:58 knarzkiste kernel:  <c0274eb7> sysdev_driver_unregister+0x67/0x80   <c02953f5> cpufreq_unregister_driver+0x25/0x60
> Apr  3 19:52:58 knarzkiste kernel:  <c0136706> sys_delete_module+0x146/0x1c0   <c0149d89> remove_vma+0x39/0x50
> Apr  3 19:52:58 knarzkiste kernel:  <c014b198> do_munmap+0x198/0x1f0   <c0102e93> sysenter_past_esp+0x54/0x75
> Apr  3 19:52:58 knarzkiste kernel: Code: 01 00 00 31 c0 83 c4 2c 5b 5e 5f 5d c3 53 ff 0d e0 00 d7 de 0f 88 f8 01 00 00 8b 1c 95 8c 02 d7 de 85 db 74 18 8b 83 6c 02 00 00 <8b> 40 2c e8 ff 83 3e e1 c7 83 6c 02 00 00 00 00 00 00 ff 05 e0

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de

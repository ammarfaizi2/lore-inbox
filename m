Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWDBSHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWDBSHA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 14:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWDBSHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 14:07:00 -0400
Received: from mail.charite.de ([160.45.207.131]:51608 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932409AbWDBSG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 14:06:59 -0400
Date: Sun, 2 Apr 2006 20:06:57 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: EIP when unloading powernow_k8 on 2.6.16-git18
Message-ID: <20060402180656.GI14747@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060402180205.DA56FE0016DD@knarzkiste.dyndns.org> <20060402162504.GA14747@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060402180205.DA56FE0016DD@knarzkiste.dyndns.org> <20060402162504.GA14747@charite.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> Got an EIP today when unloading powernow_k8 on 2.6.16-git18:
> 
> % rmmod powernow_k8 
> 
> resulted in:

Also on 2.6.16-git20, I just retried that:

Apr  2 20:01:30 knarzkiste kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000002c
Apr  2 20:01:30 knarzkiste kernel:  printing eip:
Apr  2 20:01:30 knarzkiste kernel: ded21b09
Apr  2 20:01:30 knarzkiste kernel: *pde = 00000000
Apr  2 20:01:30 knarzkiste kernel: Oops: 0000 [#1]
Apr  2 20:01:30 knarzkiste kernel: PREEMPT
Apr  2 20:01:30 knarzkiste kernel: Modules linked in: rt2500 thermal fan button ac battery af_packet ide_scsi sata_sil libata scsi_mod eeprom powernow_k8 freq_table processor saa7134_dvb mt352 saa7134 compat_ioctl32 v4l2_common v4l1_compat ir_kbd_i2c ir_common videodev video_buf_dvb dvb_core video_buf nxt200x dvb_pll tda1004x usbhid usbmouse pcmcia firmware_class 8250_pci tsdev 8250 serial_core 8139too evdev psmouse yenta_socket rsrc_nonstatic pcmcia_core ehci_hcd ohci_hcd snd_atiixp_modem snd_atiixp ide_cd usbcore snd_ac97_codec ati_agp agpgart snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc cdrom unix
Apr  2 20:01:30 knarzkiste kernel: CPU:    0
Apr  2 20:01:30 knarzkiste kernel: EIP:    0060:[pg0+513071881/1069720576]    Not tainted VLI
Apr  2 20:01:30 knarzkiste kernel: EFLAGS: 00010286   (2.6.16-git20 #1)
Apr  2 20:01:30 knarzkiste kernel: EIP is at acpi_processor_unregister_performance+0x1e/0x3e [processor]
Apr  2 20:01:30 knarzkiste kernel: eax: 00000000   ebx: dd14e800   ecx: 00000001   edx: 00000000
Apr  2 20:01:30 knarzkiste kernel: esi: dd40b8c0   edi: 00000286   ebp: dd40b94c   esp: dde18f1c
Apr  2 20:01:30 knarzkiste kernel: ds: 007b   es: 007b   ss: 0068
Apr  2 20:01:30 knarzkiste kernel: Process rmmod (pid: 5299, threadinfo=dde18000 task=dde25570)
Apr  2 20:01:30 knarzkiste kernel: Stack: <0>dd647cc0 ded194d6 dd40b8c0 dd40b8e8 c0296132 c03adf88 c034c8b0 c034a3dc
Apr  2 20:01:30 knarzkiste kernel:        c034a3c0 c02779d7 00000880 ded1b100 00000000 dde18000 c0294fa5 c01366f6
Apr  2 20:01:30 knarzkiste kernel:        65776f70 776f6e72 00386b5f d99754ec c0149d79 b7f51000 dd61ee40 c014b1a8
Apr  2 20:01:30 knarzkiste kernel: Call Trace:
Apr  2 20:01:30 knarzkiste kernel:  <ded194d6powernowk8_cpu_exit+0x26/0x50 [powernow_k8]   <c0296132cpufreq_remove_dev+0xb2/0x120
Apr  2 20:01:30 knarzkiste kernel:  <c02779d7sysdev_driver_unregister+0x67/0x80   <c0294fa5cpufreq_unregister_driver+0x25/0x60
Apr  2 20:01:30 knarzkiste kernel:  <c01366f6sys_delete_module+0x146/0x1c0   <c0149d79remove_vma+0x39/0x50
Apr  2 20:01:30 knarzkiste kernel:  <c014b1a8do_munmap+0x198/0x1f0   <c0102e93sysenter_past_esp+0x54/0x75
Apr  2 20:01:30 knarzkiste kernel: Code: 01 00 00 31 c0 83 c4 2c 5b 5e 5f 5d c3 53 ff 0d e0 40 d2 de 0f 88 f8 01 00 00 8b 1c 95 8c 42 d2 de 85 db 74 18 8b 83 6c 02 00 00 <8b40 2c e8 0f 44 43 e1 c7 83 6c 02 00 00 00 00 00 00 ff 05 e0

After that I could not reboot the machine. I tried "reboot", all
processes were killed, but the final "reboot -d -f -i" command would
not restart the machine. Had to use the magic sysreq key.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de

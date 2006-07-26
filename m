Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWGZIMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWGZIMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWGZIMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:12:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:29429 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932522AbWGZIMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:12:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=GsUAmSO+ATwZMT6Bk73uPjT4dR10yQvHjy4ZS0t0p2GrfSRo9chrWutoiESSTrPWe+ojcaSDCmQWmYh95c5fFyLYsK/KDXsg0AsOpgskTHN3KFadcaObe3Ld+tmhUkInECpdoVcpIetVhMxF0KV+BjOqUqD76HPVyZtUsMAGpds=
Date: Wed, 26 Jul 2006 12:20:03 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [BUG] usb: device unconnect cause oops
Message-Id: <20060726122003.8f99cdea.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I used 2.6.18-rc1-mm2.

I have HP LaserJet 1010, it connected to computer via USB,
I switched on it, printed something and swithched off it,
after that I got in /var/log/messages:


Jul 25 23:06:15 localhost fill_kobj_path: path = '/devices/pci0000:00/0000:00:02.1/usb3/3-2/3-2:1.0/usbdev3.3_ep01'
Jul 25 23:06:15 localhost kobject usbdev3.3_ep01: cleaning up
Jul 25 23:06:15 localhost kobject_uevent
Jul 25 23:06:15 localhost fill_kobj_path: path = '/devices/pci0000:00/0000:00:02.1/usb3/3-2/3-2:1.0/usbdev3.3_ep81'
Jul 25 23:06:15 localhost kobject usbdev3.3_ep81: cleaning up
Jul 25 23:06:15 localhost kobject_uevent
Jul 25 23:06:15 localhost fill_kobj_path: path = '/devices/pci0000:00/0000:00:02.1/usb3/3-2/3-2:1.0/lp0'
Jul 25 23:06:15 localhost kobject lp0: cleaning up
Jul 25 23:06:15 localhost subsystem usb: unregistering
Jul 25 23:06:15 localhost kobject usb: unregistering
Jul 25 23:06:15 localhost kobject_uevent
Jul 25 23:06:15 localhost fill_kobj_path: path = '/class/usb'
Jul 25 23:06:15 localhost kobject usb: cleaning up
Jul 25 23:06:15 localhost drivers/usb/class/usblp.c: usblp0: removed
Jul 25 23:06:15 localhost kobject_uevent
Jul 25 23:06:15 localhost fill_kobj_path: path = '/devices/pci0000:00/0000:00:02.1/usb3/3-2/3-2:1.0'
Jul 25 23:06:15 localhost kobject 3-2:1.0: cleaning up
Jul 25 23:06:15 localhost BUG: unable to handle kernel NULL pointer dereference at virtual address 00000010
Jul 25 23:06:15 localhost printing eip:
Jul 25 23:06:15 localhost c0232e02
Jul 25 23:06:15 localhost *pde = 00000000
Jul 25 23:06:15 localhost Oops: 0000 [#1]
Jul 25 23:06:15 localhost 8K_STACKS DEBUG_PAGEALLOC
Jul 25 23:06:15 localhost last sysfs file: /devices/pci0000:00/0000:00:02.1/usb3/3-2/3-2:1.0/modalias
Jul 25 23:06:15 localhost Modules linked in: usblp ppp_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc lp ipt_LOG xt_state ip_conntrack iptable_filter ip_tables x_tables snd_seq_midi snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq vfat fat kqemu nvidia_agp hsfpcibasic2 forcedeth snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm nvidia snd_timer hsfserial hsfengine hsfosspec hsfsoar snd_page_alloc agpgart snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device snd parport_pc parport dm_mod ata_piix sata_qstor sata_vsc sata_uli sata_sx4 sata_svw sata_promise ohci_hcd uhci_hcd usb_storage libusual usbhid ehci_hcd usbcore
Jul 25 23:06:15 localhost CPU:    0
Jul 25 23:06:15 localhost EIP:    0060:[<c0232e02>]    Tainted: P      VLI
Jul 25 23:06:15 localhost EFLAGS: 00210286   (2.6.18-rc1-mm2 #8)
Jul 25 23:06:15 localhost EIP is at _raw_spin_lock+0x12/0x170
Jul 25 23:06:15 localhost eax: dfeee590   ebx: 00000000   ecx: 00000000   edx: 00000000
Jul 25 23:06:15 localhost esi: c4a9dd10   edi: e0ad5020   ebp: de397e84   esp: de397e60
Jul 25 23:06:15 localhost ds: 007b   es: 007b   ss: 0068
Jul 25 23:06:15 localhost Process khubd (pid: 1271, ti=de396000 task=dfeee590 task.ti=de396000)
Jul 25 23:06:15 localhost Stack: c4a9dd10 e0ad5020 de397e84 00200246 00000000 00000002 00000000 c4a9dd10
Jul 25 23:06:15 localhost e0ad5020 de397ea8 c0363fb3 00000000 00000000 00000000 00000000 00000002
Jul 25 23:06:15 localhost c0360f79 00000000 de397eb8 c0360f79 c4a9dd58 c4a9dc50 de397ed4 c029c863
Jul 25 23:06:15 localhost Call Trace:
Jul 25 23:06:15 localhost [<c0363fb3>] _spin_lock+0x43/0x50
Jul 25 23:06:15 localhost [<c0360f79>] klist_remove+0x19/0x40
Jul 25 23:06:15 localhost [<c029c863>] bus_remove_device+0xa3/0xd0
Jul 25 23:06:15 localhost [<c029b057>] device_del+0x157/0x1a0
Jul 25 23:06:15 localhost [<e0ab55a1>] usb_disconnect+0xd1/0x110 [usbcore]
Jul 25 23:06:15 localhost [<e0ab61ed>] hub_thread+0x1ed/0xbb0 [usbcore]
Jul 25 23:06:15 localhost [<c0130389>] kthread+0xe9/0xf0
Jul 25 23:06:15 localhost [<c0101005>] kernel_thread_helper+0x5/0x10
Jul 25 23:06:15 localhost Code: c7 43 14 ff ff ff ff 89 03 83 c4 10 5b c9 c3 8d 76 00 8d bc 27 00 00 00 00 55 89 e5 83 ec 24 89 5d f4 8b 5d 08 89 75 f8 89 7d fc <81> 7b 10 ad 4e ad de 75 48 89 e2 8b 43 18 81 e2 00 e0 ff ff 3b
Jul 25 23:06:15 localhost EIP: [<c0232e02>] _raw_spin_lock+0x12/0x170 SS:ESP 0068:de397e60
Jul 25 23:08:27 localhost <7>kobject_uevent
Jul 25 23:08:27 localhost fill_kobj_path: path = '/class/vc/vcs7'
Jul 25 23:08:27 localhost kobject vcs7: cleaning up

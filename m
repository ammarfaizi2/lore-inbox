Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVIWNBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVIWNBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 09:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbVIWNBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 09:01:46 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:45246 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750961AbVIWNBp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 09:01:45 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.14-rc2: USB storage-related #GP on x86-64
Date: Fri, 23 Sep 2005 15:02:01 +0200
User-Agent: KMail/1.8.2
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200509231502.02344.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just triggered a general protection fault on Asus L5D (x86-64) by unplugging a USB floppy.
>From dmesg:

ohci_hcd 0000:00:02.0: wakeup
usb 1-2: new full speed USB device using ohci_hcd and address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
  Vendor: TEAC      Model: FD-05PUB          Rev: 3000
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
SCSI device sda: 2880 512-byte hdwr sectors (1 MB)
sda: Write Protect is off
sda: Mode Sense: 00 46 94 00
sda: assuming drive cache: write through
SCSI device sda: 2880 512-byte hdwr sectors (1 MB)
sda: Write Protect is off
sda: Mode Sense: 00 46 94 00
sda: assuming drive cache: write through
 sda: unknown partition table
usb 1-2: USB disconnect, address 2
general protection fault: 0000 [1] PREEMPT 
CPU 0 
Modules linked in: usb_storage battery usbserial thermal processor fan button ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 af_packet pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core usbhid ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 108, comm: khubd Not tainted 2.6.14-rc2 #34
RIP: 0010:[<ffffffff8805194c>] <ffffffff8805194c>{:scsi_mod:scsi_remove_device+44}
RSP: 0018:ffff81002fc77c98  EFLAGS: 00010296
RAX: 6b6b6b6b6b6b6b6b RBX: ffff810022772108 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff80237bb0 RDI: 6b6b6b6b6b6b6beb
RBP: ffff810025f43538 R08: 0000000000000000 R09: ffff810022772108
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff810025f43528
R13: ffff810024991ba8 R14: 0000000000000002 R15: ffff81002f11c348
FS:  00002aaaaade8b00(0000) GS:ffffffff804b2800(0000) knlGS:000000005617d560
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaac500d0 CR3: 000000001fb58000 CR4: 00000000000006e0
Process khubd (pid: 108, threadinfo ffff81002fc76000, task ffff810001dfc860)
Stack: ffff810022772108 ffffffff880519f1 ffff810025f43548 ffff810025f43540 
       ffff810025f43538 ffff810025f43540 ffff810025f43548 ffffffff8804f017 
       ffffffff8029b9b0 ffff810025f43538 
Call Trace:<ffffffff880519f1>{:scsi_mod:__scsi_remove_target+145}
       <ffffffff8804f017>{:scsi_mod:scsi_forget_host+71} <ffffffff8029b9b0>{klist_devices_put+0}
       <ffffffff88049093>{:scsi_mod:scsi_remove_host+67} <ffffffff8824d010>{:usb_storage:storage_disconnect+16}
       <ffffffff802c1cd3>{usb_unbind_interface+83} <ffffffff8029b4ee>{__device_release_driver+110}
       <ffffffff8029b611>{device_release_driver+49} <ffffffff8029acf4>{bus_remove_device+180}
       <ffffffff80299aa8>{device_del+56} <ffffffff802c77e2>{usb_disable_device+162}
       <ffffffff802c3f85>{usb_disconnect+197} <ffffffff802c486a>{hub_thread+810}
       <ffffffff8012ed09>{deactivate_task+25} <ffffffff80149c00>{autoremove_wake_function+0}
       <ffffffff80149c00>{autoremove_wake_function+0} <ffffffff80149940>{keventd_create_kthread+0}
       <ffffffff802c4540>{hub_thread+0} <ffffffff80149940>{keventd_create_kthread+0}
       <ffffffff80149a8d>{kthread+205} <ffffffff8010f536>{child_rip+8}
       <ffffffff80149940>{keventd_create_kthread+0} <ffffffff801499c0>{kthread+0}
       <ffffffff8010f52e>{child_rip+0} 

Code: ff 80 80 00 00 00 0f 8e 77 04 00 00 5b c3 66 66 90 66 66 90 
RIP <ffffffff8805194c>{:scsi_mod:scsi_remove_device+44} RSP <ffff81002fc77c98>
 
Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

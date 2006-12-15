Return-Path: <linux-kernel-owner+w=401wt.eu-S1752991AbWLORub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbWLORub (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbWLORub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:50:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990AbWLORua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:50:30 -0500
Date: Fri, 15 Dec 2006 12:50:27 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Subject: 2.6.18.5 usb/sysfs bug.
Message-ID: <20061215175027.GA17987@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happens during every boot, though bootup continues afterwards.
I'll give .20rc1 a shot real soon.

		Dave

BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000b
 printing eip:
c04a4dea
*pde = 31b81001
Oops: 0000 [#1]
SMP 
last sysfs file: /devices/pci0000:00/0000:00:00.0/irq
Modules linked in: hidp l2cap sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink iptable_filter ip_tables ip6t_REJECT xt_tcpudp ip6table_filter ip6_tables x_tables ipv6 cpufreq_ondemand dm_multipath video sbs i2c_ec dock button battery asus_acpi ac parport_pc lp parport snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event sg snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss joydev ide_cd i2c_i801 tg3 pcspkr snd_pcm i2c_core snd_timer snd ohci1394 soundcore hci_usb ieee1394 serio_raw cdrom snd_page_alloc bluetooth dm_snapshot dm_zero dm_mirror dm_mod ata_piix libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
CPU:    1
EIP:    0060:[<c04a4dea>]    Not tainted VLI
EFLAGS: 00010286   (2.6.18-1.2849.fc6PAE #1) 
EIP is at sysfs_hash_and_remove+0x18/0xfd
eax: fffffff3   ebx: c0699d8c   ecx: c068099c   edx: fffffff3
esi: fffffff3   edi: fffffff3   ebp: c1df9c14   esp: f151be64
ds: 007b   es: 007b   ss: 0068
Process pcscd (pid: 2674, ti=f151b000 task=f1af17b0 task.ti=f151b000)
Stack: c0632028 fffffff3 c1df9c14 c0699d8c fffffff3 fffffff3 c1df9c14 c04a6e11 
       c0699d80 f7e38cb0 c04a6e60 f7e38c08 f6fc2980 f7e38c08 c0554ab3 f7e38cb0 
       c055071f f7e38c08 f74ca5c0 00000001 f7273e08 c055074e f151bed0 c0585cf0 
Call Trace:
 [<c04a6e11>] remove_files+0x15/0x1e
 [<c04a6e60>] sysfs_remove_group+0x46/0x5c
 [<c0554ab3>] device_pm_remove+0x2b/0x62
 [<c055071f>] device_del+0x11a/0x141
 [<c055074e>] device_unregister+0x8/0x10
 [<c0585cf0>] usb_remove_ep_files+0x5b/0x7b
 [<c0585866>] usb_remove_sysfs_intf_files+0x1d/0x54
 [<c05839fd>] usb_set_interface+0xef/0x178
 [<c0583ee7>] usb_unbind_interface+0x4a/0x6a
 [<c0551d58>] __device_release_driver+0x60/0x78
 [<c0551fa5>] device_release_driver+0x2b/0x3a
 [<c057d7e6>] usb_driver_release_interface+0x3b/0x63
 [<c0585fe9>] releaseintf+0x4b/0x5b
 [<c058880e>] usbdev_release+0x67/0x9e
 [<c046f18a>] __fput+0xba/0x188
 [<c046c9e9>] filp_close+0x52/0x59
 [<c0403fa9>] sysenter_past_esp+0x56/0x79
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x79
Leftover inexact backtrace:
 =======================
Code: 8b 40 20 8b 40 30 c3 8b 40 14 8b 00 c3 8b 40 14 8b 00 c3 55 57 56 53 83 ec 0c 85 c0 89 44 24 04 89 14 24 0f 84 df 00 00 00 89 c2 <8b> 40 18 85 c0 0f 84 d2 00 00 00 8b 52 60 83 e8 80 89 54 24 08 
EIP: [<c04a4dea>] sysfs_hash_and_remove+0x18/0xfd SS:ESP 0068:f151be64


-- 
http://www.codemonkey.org.uk

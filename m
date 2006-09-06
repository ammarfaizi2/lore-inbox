Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWIFVEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWIFVEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 17:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWIFVEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 17:04:01 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:26260 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751457AbWIFVEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 17:04:00 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc5-mm1: BUG in pci_disable_msi on attempts to rmmod snd_hda_intel (64-bit kernel)
Date: Wed, 6 Sep 2006 23:07:17 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609062307.17902.rjw@sisk.pl>
X-Length: 4029
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the appended BUG when I try to rmmod snd_hda_intel on 2.6.18-rc5-mm1
(the box is an HPC nx6325).

The driver also breaks the suspend to disk (causes an oops to appear during
the suspend phase, but I haven't been able to catch it yet).

Greetings,
Rafael


Kernel BUG at drivers/pci/msi.c:910
invalid opcode: 0000 [1] SMP 
last sysfs file: /power/disk
CPU 0 
Modules linked in: cpufreq_ondemand cpufreq_userspace cpufreq_powersave powernow_k8 freq_table af_packet button edd snd_pcm_oss snd_mixer_oss battery snd_seq snd_seq_device ac ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables ipv6 loop dm_mod usbhid ff_memless hci_usb bluetooth snd_hda_intel bcm43xx shpchp snd_hda_codec pcmcia pci_hotplug snd_pcm firmware_class ieee80211softmac ohci1394 sdhci snd_timer snd soundcore snd_page_alloc ieee1394 mmc_core ohci_hcd i2c_piix4 yenta_socket rsrc_nonstatic pcmcia_core ide_cd i2c_core cdrom k8temp hwmon ehci_hcd usbcore ieee80211 ieee80211_crypt tg3 ext3 jbd fan thermal processor atiixp ide_disk ide_core sg
Pid: 3684, comm: rmmod Tainted: G   M  2.6.18-rc5-mm1 #14
RIP: 0010:[<ffffffff80326c7b>]  [<ffffffff80326c7b>] pci_disable_msi+0xdf/0x11a
RSP: 0018:ffff810035559c68  EFLAGS: 00010202
RAX: 0000000000000052 RBX: ffff810037145620 RCX: ffffffff804e7048
RDX: ffff810035559a78 RSI: 0000000000000092 RDI: ffffffff804e7040
RBP: ffff810035559c88 R08: ffffffff804e7048 R09: 0000000000000002
R10: ffff810035559938 R11: 0000000000000000 R12: ffff810037ba7678
R13: 0000000000000008 R14: 0000000000000880 R15: 00007fff6dc093c0
FS:  00002ba63d1ea6d0(0000) GS:ffffffff8064e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002ba63d0c6e40 CR3: 000000002f1f1000 CR4: 00000000000006e0
Process rmmod (pid: 3684, threadinfo ffff810035558000, task ffff810034552790)
Stack:  ffff810035559c78 0081ffff8025e80c ffff810035588b50 0000000000000280
 ffff810035559cb8 ffffffff882f4405 ffff810035559cc8 ffff810034a25878
 0000000000002000 0000000000002fff ffff810035559cc8 ffffffff882f449a
Call Trace:
 [<ffffffff882f4405>] :snd_hda_intel:azx_free+0xc3/0x14b
 [<ffffffff882f449a>] :snd_hda_intel:azx_dev_free+0xd/0xf
 [<ffffffff881a688b>] :snd:snd_device_free+0xea/0x157
 [<ffffffff881a696b>] :snd:snd_device_free_all+0x73/0x98
 [<ffffffff881a1735>] :snd:snd_card_do_free+0x7f/0x10f
 [<ffffffff881a21ef>] :snd:snd_card_free+0xa4/0xb4
 [<ffffffff882f4321>] :snd_hda_intel:azx_remove+0x18/0x27
 [<ffffffff80320610>] pci_device_remove+0x25/0x3c
 [<ffffffff80377671>] __device_release_driver+0x80/0x9c
 [<ffffffff80377acb>] driver_detach+0xac/0xee
 [<ffffffff80376b74>] bus_remove_driver+0x75/0x97
 [<ffffffff80377b4a>] driver_unregister+0x15/0x21
 [<ffffffff803207be>] pci_unregister_driver+0x13/0x8e
 [<ffffffff882f5988>] :snd_hda_intel:alsa_card_azx_exit+0x10/0x12
 [<ffffffff8029ada1>] sys_delete_module+0x1b5/0x1e6
 [<ffffffff8025910e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:



Code: 0f 0b 68 9e c3 42 80 c2 8e 03 eb 27 48 c7 c7 44 98 50 80 8b 
RIP  [<ffffffff80326c7b>] pci_disable_msi+0xdf/0x11a
 RSP <ffff810035559c68>
 


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

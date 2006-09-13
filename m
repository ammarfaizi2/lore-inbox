Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWIMN6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWIMN6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWIMN6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:58:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:15823 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750778AbWIMN6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:58:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.18-rc6-mm2: rmmod ohci_hcd oopses on HPC 6325
Date: Wed, 13 Sep 2006 15:58:02 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <20060912000618.a2e2afc0.akpm@osdl.org>
In-Reply-To: <20060912000618.a2e2afc0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609131558.03391.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 12 September 2006 09:06, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/

'rmmod ohci_hcd' causes the following oops to appear on my HPC 6325 every
time (happens also on -rc6-mm1, does not happen on -rc7):

Unable to handle kernel NULL pointer dereference at 0000000000000274 RIP:
 [<ffffffff8822c185>] :ohci_hcd:ohci_hub_status_data+0x25/0x27b
PGD 35ca9067 PUD 369a4067 PMD 0
Oops: 0000 [1] SMP
last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
CPU 0
Modules linked in: netconsole cpufreq_ondemand cpufreq_userspace cpufreq_powersa
ve powernow_k8 freq_table button af_packet edd battery snd_pcm_oss snd_mixer_oss
 snd_seq snd_seq_device ac ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_man
gle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_
tables ip6table_filter ip6_tables x_tables ipv6 loop dm_mod usbhid ff_memless hc
i_usb bluetooth snd_hda_intel snd_hda_codec bcm43xx ohci1394 ohci_hcd shpchp pci
_hotplug pcmcia ehci_hcd i2c_piix4 ieee1394 firmware_class ieee80211softmac usbc
ore tg3 sdhci ieee80211 ieee80211_crypt mmc_core ide_cd k8temp yenta_socket rsrc
_nonstatic pcmcia_core i2c_core hwmon snd_pcm snd_timer snd soundcore snd_page_a
lloc cdrom ext3 jbd fan thermal processor atiixp ide_disk ide_core sg
Pid: 3667, comm: rmmod Tainted: G   M  2.6.18-rc6-mm2 #19
RIP: 0010:[<ffffffff8822c185>]  [<ffffffff8822c185>] :ohci_hcd:ohci_hub_status_d
ata+0x25/0x27b
RSP: 0018:ffffffff805c7e18  EFLAGS: 00010296
RAX: 0000000000000000 RBX: ffff81003485c508 RCX: 0000000000000000
RDX: 0000000000000064 RSI: ffffffff805c7e68 RDI: ffff81003485c640
RBP: ffffffff805c7e58 R08: 0000000000000000 R09: ffff810037438138
R10: ffffffff80701c40 R11: ffff81003263bc88 R12: ffff81003485c640
R13: ffffffff805c7e68 R14: ffffc2000003c000 R15: ffff81003485c508
FS:  00002ba0d06fa6d0(0000) GS:ffffffff8066f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000274 CR3: 000000002f153000 CR4: 00000000000006e0
Process rmmod (pid: 3667, threadinfo ffff81003263a000, task ffff81003697c810)
Stack:  ffffffff802813b0 ffffffff805c7e40 ffffffff80281258 ffff81003485c508
 ffff81003485c508 ffff81003485c508 ffffc2000003c000 ffffffff805c7e68
 ffffffff805c7ea8 ffffffff8818e03f 003d09e3f5998950 ffffffff80509860
Call Trace:
 [<ffffffff8818e03f>] :usbcore:usb_hcd_poll_rh_status+0x40/0x13b
 [<ffffffff8822c01b>] :ohci_hcd:ohci_irq+0xcb/0x210
 [<ffffffff8818e78b>] :usbcore:usb_hcd_irq+0x2f/0x5f
 [<ffffffff8020ef13>] handle_IRQ_event+0x33/0x66
 [<ffffffff802af5f8>] handle_fasteoi_irq+0x9d/0xe3
 [<ffffffff80267c85>] do_IRQ+0x104/0x11f
 [<ffffffff80259621>] ret_from_intr+0x0/0xa
DWARF2 unwinder stuck at ret_from_intr+0x0/0xa

Leftover inexact backtrace:

 <IRQ>  <EOI>  [<ffffffff802ee4ac>] sysfs_hash_and_remove+0x9/0x137
 [<ffffffff802eed13>] sysfs_remove_file+0x10/0x12
 [<ffffffff8038baf7>] class_device_remove_file+0x12/0x14
 [<ffffffff8822aa02>] :ohci_hcd:ohci_stop+0xf5/0x17b
 [<ffffffff8818d9d2>] :usbcore:usb_remove_hcd+0xdc/0x114
 [<ffffffff8040f8eb>] klist_release+0x0/0x82
 [<ffffffff88197f45>] :usbcore:usb_hcd_pci_remove+0x1e/0x7d
 [<ffffffff803204d8>] pci_device_remove+0x25/0x3c
 [<ffffffff8038b1b5>] __device_release_driver+0x80/0x9c
 [<ffffffff8038b617>] driver_detach+0xac/0xee
 [<ffffffff8038ad92>] bus_remove_driver+0x75/0x98
 [<ffffffff8038b696>] driver_unregister+0x15/0x21
 [<ffffffff80320686>] pci_unregister_driver+0x13/0x8e
 [<ffffffff8822cd1c>] :ohci_hcd:ohci_hcd_pci_cleanup+0x10/0x12
 [<ffffffff8029b281>] sys_delete_module+0x1b5/0x1e6
 [<ffffffff8025910e>] system_call+0x7e/0x83


Code: 8a 98 74 02 00 00 e8 d6 3b 03 f8 48 89 45 d0 41 8b 84 24 e4
RIP  [<ffffffff8822c185>] :ohci_hcd:ohci_hub_status_data+0x25/0x27b
 RSP <ffffffff805c7e18>
CR2: 0000000000000274
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

where

(gdb) l *ohci_hub_status_data+0x25
0x4185 is in ohci_hub_status_data (drivers/usb/host/ohci-hub.c:316).
311             struct ohci_hcd *ohci = hcd_to_ohci (hcd);
312             int             i, changed = 0, length = 1;
313             int             can_suspend;
314             unsigned long   flags;
315
316             can_suspend = device_may_wakeup(&hcd->self.root_hub->dev);
317             spin_lock_irqsave (&ohci->lock, flags);
318
319             /* handle autosuspended root:  finish resuming before
320              * letting khubd or root hub timer see state changes.

I guess it may be related to the suspend issues?

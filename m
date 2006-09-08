Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752019AbWIHBVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbWIHBVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 21:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbWIHBVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 21:21:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:51444 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752019AbWIHBVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 21:21:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OMpQn5uvP94yxpn/Z391Ty7nCiplM3CQmQksLXOJtqnNinwJQcWkP0EjOmdhWXxXvRBumXwyPXUJoXdRMtU+MBGRhMN5V2Poe+0u3GvJCLln/U89KLqBzPa7QVKNzLD5I6l4fCEKR2aEl86cc0Uy9V5L/zqSEMFuXJAx3OVzXrk=
Message-ID: <a44ae5cd0609071821h515753f5wdd3ceecc39434e91@mail.gmail.com>
Date: Thu, 7 Sep 2006 18:21:45 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>,
       "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net
Subject: 2.6.18-rc5-git1 + "ieee1394: nodemgr" patches -- BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried testing the patches from
http://groups.google.com/group/linux.kernel/browse_thread/thread/e25d2d810b7cf9cb
applied to 2.6.18-rc5-git1.  Things went pretty well, until I ran
"pccardctl eject" and then popped out the Firewire card.

ieee1394: Node changed: 1-02:1023 -> 1-00:1023
ieee1394: Node suspended: ID:BUS[1-00:1023]  GUID[0080880002103eae]
ieee1394: Node suspended: ID:BUS[1-01:1023]  GUID[0090a950000b2255]
pccard: card ejected from slot 0
ieee1394: Node removed: ID:BUS[1-00:1023]  GUID[0080880002103eae]
PM: Removing info for ieee1394:0080880002103eae-0
PM: Removing info for ieee1394:0080880002103eae
ieee1394: Node removed: ID:BUS[1-01:1023]  GUID[0090a950000b2255]
PM: Removing info for ieee1394:0090a950000b2255-0
PM: Removing info for ieee1394:0090a950000b2255
ieee1394: Node removed: ID:BUS[1-00:1023]  GUID[0090a94000007475]
PM: Removing info for ieee1394:0090a94000007475-0
PM: Removing info for ieee1394:0090a94000007475
BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000000
 printing eip:
f955b309
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: dv1394 raw1394 binfmt_misc apm i915 drm ipv6
speedstep_centrino freq_table cpufreq_powersave cpufreq_performance
cpufreq_ondemand cpufreq_conservative video thermal processor fan
button battery ac nls_ascii nls_cp437 vfat fat nls_utf8 ntfs nls_base
sr_mod sbp2 scsi_mod parport_pc lp parport 8139cp pcmcia 8139too
ipw2200 sdhci mmc_core ohci1394 ieee1394 yenta_socket rsrc_nonstatic
pcmcia_core mii snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss
snd_mixer_oss ide_cd snd_pcm snd_timer cdrom psmouse shpchp
pci_hotplug snd soundcore snd_page_alloc ehci_hcd uhci_hcd intel_agp
agpgart usbcore rtc evdev
CPU:    0
EIP:    0060:[<f955b309>]    Not tainted VLI
EFLAGS: 00010282   (2.6.18-rc5-git1 #4)
EIP is at dv1394_remove_host+0x17/0xad [dv1394]
eax: f91ac0f4   ebx: 00000001   ecx: 00000000   edx: f955b2f2
esi: 00000000   edi: f955c4d9   ebp: f955d980   esp: eab03e74
ds: 007b   es: 007b   ss: 0068
Process pccardctl (pid: 7111, ti=eab02000 task=f0a02ab0 task.ti=eab02000)
Stack: f955d980 ed5c4000 ed5c4000 f91788c2 00000000 f955d980 ed5c4000 f91310cc
       f7c0b448 f9178945 ed5c4000 ed5c5d48 f9177e65 ed5c5f64 f912c9f2 f52ae800
       f52ae848 f91310cc c10c5d24 f52ae8b0 c111dcbd f52ae848 f52ae848 c11f4aa0
Call Trace:
 [<f91788c2>] __unregister_host+0x17/0x79 [ieee1394]
 [<f9178945>] highlevel_remove_host+0x21/0x42 [ieee1394]
 [<f9177e65>] hpsb_remove_host+0x37/0x56 [ieee1394]
 [<f912c9f2>] ohci1394_pci_remove+0x41/0x1cd [ohci1394]
 [<c10c5d24>] pci_device_remove+0x16/0x28
 [<c111dcbd>] __device_release_driver+0x5a/0x72
 [<c111de8f>] device_release_driver+0x1b/0x29
 [<c111d705>] bus_remove_device+0x78/0x8a
 [<c111c8a7>] device_del+0xe9/0x11a
 [<c111c8e0>] device_unregister+0x8/0x10
 [<c10c3ee5>] pci_remove_bus_device+0x39/0xcf
 [<c10c3f95>] pci_remove_behind_bridge+0x1a/0x2d
 [<f910d5ae>] socket_shutdown+0x89/0xdd [pcmcia_core]
 [<f910d675>] pcmcia_eject_card+0x56/0x65 [pcmcia_core]
 [<f9110070>] pccard_store_eject+0x19/0x20 [pcmcia_core]
 [<c111e2e7>] class_device_attr_store+0x1b/0x1f
 [<c1075495>] sysfs_write_file+0x97/0xbe
 [<c1044a48>] vfs_write+0xa6/0x14b
 [<c10452d4>] sys_write+0x3c/0x63
 [<c10029a5>] sysenter_past_esp+0x56/0x79
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x79
Leftover inexact backtrace:
Code: c2 ff c7 87 90 01 00 00 00 00 00 00 83 c4 10 5b 5e 5f 5d c3 57
56 53 8b 98 44 1d 00 00 8b 80 3c 1d 00 00 8b 70 04 bf d9 c4 55 f9 <ac>
ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 7e 9c
EIP: [<f955b309>] dv1394_remove_host+0x17/0xad [dv1394] SS:ESP 0068:eab03e74

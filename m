Return-Path: <linux-kernel-owner+w=401wt.eu-S964842AbWL1AyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWL1AyI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWL1AyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:54:07 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:45759 "EHLO
	sccrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964842AbWL1AyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:54:06 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Dec 2006 19:54:06 EST
From: kernel-stuff@comcast.net (Parag Warudkar)
To: linux-kernel@vger.kernel.org
Cc: avi@qumranet.com
Subject: OOPS - KVM in 2.6.20-rc2
Date: Thu, 28 Dec 2006 00:49:02 +0000
Message-Id: <122820060049.5177.4593147E000B4D2C0000143922007621949D0E050B9A9D0E99@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Oct  4 2006)
X-Authenticated-Sender: d2FydWRrYXJAY29tY2FzdC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running qemu with 512M ram out of available 480M total invoked the OOM killer (that's obvious along with other OOM-killer stupidities like killing totally irrelevant processes) followed by the below OOPS.

Killed process 19271 (trashapplet)Out of memory: kill process 12475 (qemu) score 7899 or a childOut of memory: kill process 12475 (qemu) score 7899 or a childKilled process 12475 (qemu)Killed process 12475 (qemu)

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000004 printing eip:c0153aa2*pde = 17339067*pte = 00000000Oops: 0002 [#1]SMPModules linked in: kvm_intel kvm cpufreq_ondemand i915 drm hci_usb autofs4 hidp rfcomm l2cap bluetooth cpufreq_userspace acpi_cpufreq freq_table binfmt_misc nls_utf8 ntfs dm_mirror dm_multipath sbs i2c_ec sbp2 snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm ohci1394 ieee1394 shpchp snd_timer snd intel_agp i2c_i801 agpgart soundcore i2c_core snd_page_alloc ata_piix
CPU:    0
EIP:    0060:[<c0153aa2>]    Not tainted VLI
EFLAGS: 00010206   (2.6.20-rc2-dirty #4)
EIP is at __free_pages+0x2/0x30
eax: 00000000   ebx: 0001c0c9   ecx: 00000000   edx: 00000000
esi: c95aff20   edi: c95aff34   ebp: c7e5c000   esp: c95afd6c
ds: 007b   es: 007b   ss: 0068
Process qemu (pid: 12475, ti=c95ae000 task=ddcff030 task.ti=c95ae000)
Stack: df443723 fffffff4 df4d8320 0001c0c8 df444d41 00000000 20793000 00000000
       000207a0 bf8436d8 00000000 c94c9140 c1684a00 c01c56d9 00000000 c01b55d9
       ce2f89e8 00000580 00000006 00000000 00020793 00000001 c7e5c008 00020793
Call Trace:
 [<df443723>] kvm_free_physmem_slot+0x33/0x80 [kvm]
 [<df444d41>] kvm_dev_ioctl+0xf11/0x1080 [kvm]
 [<c01c56d9>] journal_stop+0x159/0x1e0
 [<c01b55d9>] ext3_mark_inode_dirty+0x29/0x40
 [<c0189edc>] __mark_inode_dirty+0x5c/0x190
 [<c014faba>] do_generic_mapping_read+0x44a/0x550
 [<c0153d57>] get_page_from_freelist+0x257/0x320
 [<c0153e77>] __alloc_pages+0x57/0x2f0
 [<c015c276>] __handle_mm_fault+0x7c6/0x8f0
 [<c015e176>] unmap_region+0xf6/0x110
 [<df443e30>] kvm_dev_ioctl+0x0/0x1080 [kvm]
 [<c01797bb>] do_ioctl+0x2b/0x90
 [<c017987c>] vfs_ioctl+0x5c/0x2a0
 [<c0179afd>] sys_ioctl+0x3d/0x70
 [<c01030f2>] sysenter_past_esp+0x5f/0x85
 =======================
Code: e9 ad fd ff ff 8b 4b 0c 90 e9 7d fd ff ff 0f 0b eb fe 89 f2 89 e8 e8 0e f8 ff ff e9 5d fe ff ff 8b 4c 24 04 e9 72 ff ff ff 89 c1 <f0> ff 48 04 0f 94 c0 84 c0 74 13 85 d2 74 07 89 c8 e9 08 fd ff
EIP: [<c0153aa2>] __free_pages+0x2/0x30 SS:ESP 0068:c95afd6c

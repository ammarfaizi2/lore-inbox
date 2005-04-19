Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVDSNsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVDSNsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 09:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVDSNsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 09:48:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51924 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261519AbVDSNsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 09:48:12 -0400
X-Sasl-enc: LGoYjXoX9t3eHUr33J+4GULgp0xYLKUPodPLzm62yu9v 1113918485
From: Robert Freund <rfreund@uos.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOps] 2.6.11-rc3 rmmod ide-scsi
Date: Tue, 19 Apr 2005 15:48:03 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504191548.03486.rfreund@uos.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> got this oops while unloading ide-scsi (rmmod segfaulted)

This happens to me too, reliably. I'm using vanilla 2.6.11 with the 
swsusp2-patchset. "Preemtible" is turned on here. I have an ide disk and an 
ide dvd/cd drive. My kernel boot options contain "hdc=ide-scsi".

Regards,
Robert

Unable to handle kernel NULL pointer dereference at virtual address 000001e8
 printing eip:
e0ab6579
*pde = 00000000
Oops: 0000 [#2]
PREEMPT 
Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event 
snd_seq snd_seq_device eth1394 ohci1394 ieee1394 yenta_socket rsrc_nonstatic 
pcmcia_
core ehci_hcd ide_scsi sg acerhk cpufreq_ondemand ieee80211_crypt_tkip 
ieee80211_crypt_ccmp ieee80211_crypt_wep ipw2100 firmware_class ieee80211 
ieee80211_crypt snd_intel8x0 snd_ac97_codec snd_pc
m snd_timer snd snd_page_alloc radeon drm intel_agp agpgart usbhid uhci_hcd 
usbcore sr_mod scsi_mod cdrom
CPU:    0
EIP:    0060:[pg0+543069561/1068700672]    Not tainted VLI
EIP:    0060:[<e0ab6579>]    Not tainted VLI
EFLAGS: 00010092   (2.6.11Y) 
EIP is at idescsi_queue+0x119/0x430 [ide_scsi]
eax: 00000000   ebx: ddeb71c0   ecx: e0973430   edx: dead7040
esi: 00001388   edi: c04bfbec   ebp: dead7094   esp: deb0def8
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 6488, threadinfo=deb0c000 task=de975020)
Stack: dff6f380 00000020 dead7040 ddeb71c0 00000000 00000246 c0123d55 df562080 
       000001dc c04bfbec 00000292 dead7040 dea02a00 00000001 e097352a dead7040 
       e0973430 e0973410 00000000 00000000 deb0df48 deb0df48 dead7040 dead7100 
Call Trace:
 [__mod_timer+309/448] __mod_timer+0x135/0x1c0
 [<c0123d55>] __mod_timer+0x135/0x1c0
 [pg0+541746474/1068700672] scsi_send_eh_cmnd+0x9a/0x170 [scsi_mod]
 [<e097352a>] scsi_send_eh_cmnd+0x9a/0x170 [scsi_mod]
 [pg0+541746224/1068700672] scsi_eh_done+0x0/0x60 [scsi_mod]
 [<e0973430>] scsi_eh_done+0x0/0x60 [scsi_mod]
 [pg0+541746192/1068700672] scsi_eh_times_out+0x0/0x20 [scsi_mod]
 [<e0973410>] scsi_eh_times_out+0x0/0x20 [scsi_mod]
 [pg0+541747525/1068700672] scsi_eh_tur+0x95/0xd0 [scsi_mod]
 [<e0973945>] scsi_eh_tur+0x95/0xd0 [scsi_mod]
 [pg0+541747689/1068700672] scsi_eh_abort_cmds+0x69/0x80 [scsi_mod]
 [<e09739e9>] scsi_eh_abort_cmds+0x69/0x80 [scsi_mod]
 [pg0+541750801/1068700672] scsi_unjam_host+0xa1/0xd0 [scsi_mod]
 [<e0974611>] scsi_unjam_host+0xa1/0xd0 [scsi_mod]
 [complete+82/128] complete+0x52/0x80
 [<c0117942>] complete+0x52/0x80
 [pg0+541751007/1068700672] scsi_error_handler+0x9f/0xd0 [scsi_mod]
 [<e09746df>] scsi_error_handler+0x9f/0xd0 [scsi_mod]
 [pg0+541750848/1068700672] scsi_error_handler+0x0/0xd0 [scsi_mod]
 [<e0974640>] scsi_error_handler+0x0/0xd0 [scsi_mod]
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
 [<c01012fd>] kernel_thread_helper+0x5/0x18
Code: 8b 54 24 3c 8b 42 64 89 53 2c 89 43 14 89 43 0c 8b 4c 24 40 89 4b 30 a1 
a0 ad 3e c0 8b 72 3c 01 f0 89 43 38 8b 7c 24 24 8b 47 20 <8b> 80 e8 01 00 00 
a8 01
 74 05 0f ba 6b 34 02 8b 43 1c 89 44 24 
<6>note: scsi_eh_0[6488] exited with preempt_count 1
-- 
Please encrypt email you send to me. My GnuPG public key: 
http://www-lehre.inf.uos.de/~rfreund/rfreund-pub.gpg
Fingerprint: A05B 5EC4 285E 2592 F748 BDDC EC48 5948 6792 DBA4

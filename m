Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272868AbVBEQAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272868AbVBEQAd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 11:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272710AbVBEQAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 11:00:32 -0500
Received: from adsl-69-210-207-6.dsl.klmzmi.ameritech.net ([69.210.207.6]:49024
	"EHLO jkd.jeetkunedomaster.net") by vger.kernel.org with ESMTP
	id S272958AbVBEQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 11:00:04 -0500
From: Jason Straight <jason@jeetkunedomaster.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: sbp2 oops with external ieee1394 burner
Date: Sat, 5 Feb 2005 11:00:05 -0500
User-Agent: KMail/1.7.2
Cc: linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051100.05479.jason@jeetkunedomaster.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Searched and didn't find anything on archives for this, but I probably just 
missed it.

Upgraded from 2.6.8.1 today to 2.6.10, and using my external firewire DVD-RW I 
get oopsed. I patched to 2.6.11-rc3 and it's still there, I can't speak for 
2.6.9 at this point, I can try later if I have to narrow it down. Just 
wondered if anyone else had this prob?

Feb  5 07:55:18 jkd kernel: f9aee36b
Feb  5 07:55:18 jkd kernel: PREEMPT
Feb  5 07:55:18 jkd kernel: Modules linked in: sg spca50x videodev ath_pci 
ath_rate_onoe wlan ath_hal ipt_MASQUERADE iptable_nat iptable_
filter ip_tables ipv6 snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss 
snd_mixer_oss snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_p
age_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore parport_pc 
lp parport cls_route cls_u32 cls_fw sch_prio sch_sfq sch_tb
f sch_cbq sr_mod sbp2 sd_mod eth1394 r8169 ohci1394 ieee1394 usbhid 
usb_storage scsi_mod loop pcspkr evdev ehci_hcd ohci_hcd uhci_hcd usb
core video
Feb  5 07:55:18 jkd kernel: CPU:    0
Feb  5 07:55:18 jkd kernel: EIP:    0060:[pg0+962773867/1068745728]    
Tainted: P      VLI
Feb  5 07:55:18 jkd kernel: EIP:    0060:[<f9aee36b>]    Tainted: P      VLI
Feb  5 07:55:18 jkd kernel: EFLAGS: 00010013   (2.6.11-rc3)
Feb  5 07:55:18 jkd kernel: EIP is at 
sbp2util_find_command_for_SCpnt+0x2b/0xb0 [sbp2]
Feb  5 07:55:18 jkd kernel: eax: 00000001   ebx: 00000001   ecx: 00000001   
edx: f742df88
Feb  5 07:55:18 jkd kernel: esi: 00000086   edi: f6ccdfb4   ebp: f69ca7c0   
esp: f6ccdf4c
Feb  5 07:55:18 jkd kernel: ds: 007b   es: 007b   ss: 0068
Feb  5 07:55:18 jkd kernel: Process scsi_eh_1 (pid: 4417, threadinfo=f6ccd000 
task=f6defaa0)
Feb  5 07:55:19 jkd kernel: Stack: f69ca7c0 f742df00 f6ccdfb4 f6ccdfac 
f9af0a9b f742df00 f69ca7c0 00000206
Feb  5 07:55:19 jkd kernel:        f69ca7c0 f98849fd f69ca7c0 f69ca7c0 
f69ca658 f9884b49 f69ca7c0 f6ccdfe0
Feb  5 07:55:19 jkd kernel:        f69bb430 00000286 f6ccdfac f6ccdfb4 
f98857fc f6ccdfb4 f6ccdfac f6defbf4
Feb  5 07:55:19 jkd kernel: Call Trace:
Feb  5 07:55:19 jkd kernel:  [pg0+962783899/1068745728] 
sbp2scsi_abort+0x3b/0xa0 [sbp2]
Feb  5 07:55:19 jkd kernel:  [<f9af0a9b>] sbp2scsi_abort+0x3b/0xa0 [sbp2]
Feb  5 07:55:19 jkd kernel:  [pg0+960244221/1068745728] 
scsi_try_to_abort_cmd+0x4d/0x90 [scsi_mod]
Feb  5 07:55:19 jkd kernel:  [<f98849fd>] scsi_try_to_abort_cmd+0x4d/0x90 
[scsi_mod]
Feb  5 07:55:19 jkd kernel:  [pg0+960244553/1068745728] 
scsi_eh_abort_cmds+0x39/0x90 [scsi_mod]
Feb  5 07:55:19 jkd kernel:  [<f9884b49>] scsi_eh_abort_cmds+0x39/0x90 
[scsi_mod]
Feb  5 07:55:19 jkd kernel:  [pg0+960247804/1068745728] 
scsi_unjam_host+0xbc/0xf0 [scsi_mod]
Feb  5 07:55:19 jkd kernel:  [<f98857fc>] scsi_unjam_host+0xbc/0xf0 [scsi_mod]
Feb  5 07:55:19 jkd kernel:  [pg0+960248017/1068745728] 
scsi_error_handler+0xa1/0xd0 [scsi_mod]
Feb  5 07:55:19 jkd kernel:  [<f98858d1>] scsi_error_handler+0xa1/0xd0 
[scsi_mod]
Feb  5 07:55:19 jkd kernel:  [pg0+960247856/1068745728] 
scsi_error_handler+0x0/0xd0 [scsi_mod]
Feb  5 07:55:19 jkd kernel:  [<f9885830>] scsi_error_handler+0x0/0xd0 
[scsi_mod]
Feb  5 07:55:19 jkd kernel:  [kernel_thread_helper+5/16] 
kernel_thread_helper+0x5/0x10
Feb  5 07:55:19 jkd kernel:  [<c01012f5>] kernel_thread_helper+0x5/0x10
Feb  5 07:55:19 jkd kernel: Code: 55 57 56 53 8b 5c 24 14 8b 6c 24 18 9c 5e fa 
b8 01 00 00 00 e8 97 b2 62 c6 8b 83 88 00 00 00 8d 93 88 0
0 00 00 39 d0 74 2b 89 c3 <8b> 00 0f 18 00 90 39 da 74 1f bf 00 f0 ff ff 21 e7 
8d 74 26 00
Feb  5 07:55:19 jkd kernel:  <6>note: scsi_eh_1[4417] exited with 
preempt_count 2


-- 
http://www.skycon.net/
AIM: JasonRStraight
ICQ: 1796276

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUHHPL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUHHPL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 11:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUHHPL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 11:11:59 -0400
Received: from hermes.gsix.se ([193.11.224.52]:57287 "EHLO hermes.gsix.se")
	by vger.kernel.org with ESMTP id S265492AbUHHPLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 11:11:53 -0400
Subject: Bug in 2.6.8-rc3 at mm/page_alloc.c:792 and mm/rmap.c:407
From: Oskar Berggren <beo@sgs.o.se>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1091977911.7221.13.camel@pitr.ekb.sgsnet.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 08 Aug 2004 17:11:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two BUG's I've been seeing, one in page_alloc.c and one in rmap.c.

Please CC any replies to me.

Everything seems to work fine, until this happens. This occured in
rc1 as well, seemed to get worse with rc2 (or there was some unrelated
problem in rc2) and then I think it got somewhat better again with rc3.
However, this still occurs several times a day.

I've been seeing this on 2.6.8-rc1 - 3. I'm running this on some
Asus Pundit-Rs, and must use 2.6.8-rc1 or later in order to have
support for the network card.

There are frequent OOPSes as well, but I don't have the output
of one right now.

I have not been able to identify any particular action to trigger
this.

Regards,
Oskar


kernel BUG at mm/page_alloc.c:792!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: ds lp parport ipv6 nfs lockd sunrpc yenta_socket
pcmcia_core 3c59x snd_atiixp snd_ac97_codec snd_pcm
 snd_timer snd soundcore snd_page_alloc ehci_hcd tsdev mousedev usbhid
ohci_hcd usbcore shpchp pciehp pci_hotplug ati_agp agpgart eth1394 evdev
ide_s
csi scsi_mod ohci1394 ieee1394 ide_cd cdrom genrtc xfs reiserfs jfs
isofs vfat fat ext2 ext3 jbd mbcache ide_generic via82cxxx trm290
triflex slc90e6
6 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old opti621
ns87415 hpt366 ide_disk hpt34x generic cy82c693 cs5530 cs5520 cmd64x
atiixp amd
74xx alim15x3 aec62xx pdc202xx_new ide_core unix
CPU:    0
EIP:    0060:[__free_pages+61/71]    Not tainted
EFLAGS: 00010246   (2.6.8-rc3.p4-20040805.01) 
EIP is at __free_pages+0x3d/0x47
eax: ffffffff   ebx: cbbe8a80   ecx: c115e3a0   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000297   esp: cda11eec
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=cda10000 task=cda04b50)
Stack: 00000000 00000000 c0209254 cbbe8a80 c020a128 cbbe8a80 cbbe8a80
c5389380 
       c0251758 cbbe8a80 00000000 c5389380 cda10000 c02066d5 c5389380
cda3c400 
       cda10000 cda3c540 ced0ac28 c5389380 cda11f94 cda3c53c cda10000
c01299b9 
Call Trace:
 [sk_free+191/258] sk_free+0xbf/0x102
 [sk_common_release+87/203] sk_common_release+0x57/0xcb
 [inet_release+82/96] inet_release+0x52/0x60
 [sock_release+149/225] sock_release+0x95/0xe1
 [__crc_bio_get_nr_vecs+4158660/6507043] xprt_socket_autoclose+0x26/0x63
[sunrpc]
 [worker_thread+464/655] worker_thread+0x1d0/0x28f
 [__crc_bio_get_nr_vecs+4158622/6507043] xprt_socket_autoclose+0x0/0x63
[sunrpc]
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [worker_thread+0/655] worker_thread+0x0/0x28f
 [kthread+165/171] kthread+0xa5/0xab
 [kthread+0/171] kthread+0x0/0xab
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
Code: 0f 0b 18 03 9f fe 27 c0 eb cd 85 c0 74 28 05 00 00 00 40 c1 




kernel BUG at mm/rmap.c:407!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: ds lp parport ipv6 nfs lockd sunrpc yenta_socket
pcmcia_core 3c59x snd_atiixp snd_ac97_codec snd_pcm
 snd_timer snd soundcore snd_page_alloc ehci_hcd tsdev mousedev usbhid
ohci_hcd usbcore shpchp pciehp pci_hotplug ati_agp agpgart eth1394 evdev
ide_s
csi scsi_mod ohci1394 ieee1394 ide_cd cdrom genrtc xfs reiserfs jfs
isofs vfat fat ext2 ext3 jbd mbcache ide_generic via82cxxx trm290
triflex slc90e6
6 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old opti621
ns87415 hpt366 ide_disk hpt34x generic cy82c693 cs5530 cs5520 cmd64x
atiixp amd
74xx alim15x3 aec62xx pdc202xx_new ide_core unix
CPU:    0
EIP:    0060:[page_remove_rmap+115/135]    Not tainted
EFLAGS: 00013246   (2.6.8-rc3.p4-20040805.01) 
EIP is at page_remove_rmap+0x73/0x87
eax: 00000000   ebx: 00023000   ecx: cda49800   edx: c10ad220
esi: c7d7348c   edi: c10ad220   ebp: 00041000   esp: c83ebe7c
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 2668, threadinfo=c83ea000 task=cb719770)
Stack: c0141077 c10ad220 c83cd468 c83ea000 087c49c8 05691067 08d00000
c83c908c 
       08941000 00000000 c01411d6 c034cf74 c83c9088 08900000 00041000
00000000 
       c034cf74 08900000 c83c908c 08941000 00000000 c014123d c034cf74
c83c9088 
Call Trace:
 [zap_pte_range+305/569] zap_pte_range+0x131/0x239
 [zap_pmd_range+87/115] zap_pmd_range+0x57/0x73
 [unmap_page_range+75/113] unmap_page_range+0x4b/0x71
 [unmap_vmas+248/438] unmap_vmas+0xf8/0x1b6
 [unmap_region+123/230] unmap_region+0x7b/0xe6
 [do_munmap+320/420] do_munmap+0x140/0x1a4
 [sys_brk+249/253] sys_brk+0xf9/0xfd
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 0f 0b 97 01 b3 04 28 c0 eb 95 0f 0b 96 01 b3 04 28 c0 eb 84 
 <6>note: XFree86[2668] exited with preempt_count 1
bad: scheduling while atomic!
 [schedule+1152/1157] schedule+0x480/0x485
 [call_console_drivers+105/287] call_console_drivers+0x69/0x11f
 [rwsem_down_read_failed+143/380] rwsem_down_read_failed+0x8f/0x17c
 [.text.lock.exit+107/201] .text.lock.exit+0x6b/0xc9
 [do_invalid_op+0/203] do_invalid_op+0x0/0xcb
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_invalid_op+201/203] do_invalid_op+0xc9/0xcb
 [page_remove_rmap+115/135] page_remove_rmap+0x73/0x87
 [scheduler_tick+348/1049] scheduler_tick+0x15c/0x419
 [update_process_times+70/82] update_process_times+0x46/0x52
 [error_code+45/56] error_code+0x2d/0x38
 [page_remove_rmap+115/135] page_remove_rmap+0x73/0x87
 [zap_pte_range+305/569] zap_pte_range+0x131/0x239
 [zap_pmd_range+87/115] zap_pmd_range+0x57/0x73
 [unmap_page_range+75/113] unmap_page_range+0x4b/0x71
 [unmap_vmas+248/438] unmap_vmas+0xf8/0x1b6
 [unmap_region+123/230] unmap_region+0x7b/0xe6
 [do_munmap+320/420] do_munmap+0x140/0x1a4
 [sys_brk+249/253] sys_brk+0xf9/0xfd
 [syscall_call+7/11] syscall_call+0x7/0xb



-- 
Oskar Berggren <beo@sgs.o.se>


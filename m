Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUGJMn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUGJMn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUGJMn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:43:59 -0400
Received: from mail.aei.ca ([206.123.6.14]:38899 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266236AbUGJMnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:43:55 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: oops 2.6.7-mm7
Date: Sat, 10 Jul 2004 08:43:48 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407100843.49441.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

During startup of mm7 with ingo's H3 preemption patch added I get the following oops:

Jul 10 08:05:48 bert kernel: Modules linked in: snd_es18xx snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_o
pl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore nfs lockd sunrpc md dm_mod p
cspkr e100 mii autofs4 af_packet ext3 jbd nls_iso8859_1 nls_cp437 apm rtc
Jul 10 08:05:48 bert kernel: CPU:    0
Jul 10 08:05:48 bert kernel: EIP:    0060:[dma_alloc_coherent+28/256]    Not tainted VLI
Jul 10 08:05:48 bert kernel: EFLAGS: 00010282   (2.6.7-mm7)
Jul 10 08:05:48 bert kernel: EIP is at dma_alloc_coherent+0x1c/0x100
Jul 10 08:05:48 bert kernel: eax: 00000000   ebx: ffffffff   ecx: c15813a8   edx: 0000001f
Jul 10 08:05:48 bert kernel: esi: 00010000   edi: c15813a8   ebp: deb08e8c   esp: deb08e70
Jul 10 08:05:48 bert kernel: ds: 007b   es: 007b   ss: 0068
Jul 10 08:05:48 bert kernel: Process modprobe (pid: 922, threadinfo=deb08000 task=deadb390)
Jul 10 08:05:48 bert kernel: Stack: 00000246 deb08e80 c15813a8 00000000 00000004 00000000 c15813a8 deb08ea4
Jul 10 08:05:48 bert kernel:        e097d369 000002d0 c15813a4 00010000 c1581398 deb08ebc e097d534 e097d738
Jul 10 08:05:48 bert kernel:        00010000 00010000 c15813a4 deb08ed0 e0adc7eb c1581360 00010000 00000001
Jul 10 08:05:48 bert kernel: Call Trace:
Jul 10 08:05:48 bert kernel:  [show_stack+122/144] show_stack+0x7a/0x90
Jul 10 08:05:48 bert kernel:  [show_registers+329/448] show_registers+0x149/0x1c0
Jul 10 08:05:48 bert kernel:  [die+141/256] die+0x8d/0x100
Jul 10 08:05:48 bert kernel:  [do_page_fault+951/1439] do_page_fault+0x3b7/0x59f
Jul 10 08:05:48 bert kernel:  [error_code+45/56] error_code+0x2d/0x38
Jul 10 08:05:48 bert kernel:  [pg0+542995305/1069907968] snd_malloc_dev_pages+0x49/0x60 [snd_page_alloc]
Jul 10 08:05:48 bert kernel:  [pg0+542995764/1069907968] snd_dma_alloc_pages+0x94/0xb0 [snd_page_alloc]
Jul 10 08:05:48 bert kernel:  [pg0+544434155/1069907968] preallocate_pcm_pages+0x4b/0x80 [snd_pcm]
Jul 10 08:05:48 bert kernel:  [pg0+544434935/1069907968] snd_pcm_lib_preallocate_pages1+0xa7/0xc0 [snd_pcm]
Jul 10 08:05:48 bert kernel:  [pg0+544435161/1069907968] snd_pcm_lib_preallocate_pages_for_all+0x39/0x60 [snd_pcm]
Jul 10 08:05:48 bert kernel:  [pg0+544114233/1069907968] snd_es18xx_pcm+0x119/0x170 [snd_es18xx]
Jul 10 08:05:48 bert kernel:  [pg0+544116762/1069907968] snd_audiodrive_probe+0x17a/0x3e0 [snd_es18xx]
Jul 10 08:05:48 bert kernel:  [pg0+543035457/1069907968] alsa_card_es18xx_init+0x41/0xa6 [snd_es18xx]
Jul 10 08:05:48 bert kernel:  [sys_init_module+271/672] sys_init_module+0x10f/0x2a0
Jul 10 08:05:48 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 10 08:05:48 bert kernel: Code: 00 59 e9 6d ff ff ff 90 90 90 90 90 90 90 90 55 89 e5 57 56 89 d6 8d 52 ff 53
c1 ea 0b 83 ec 10 89 45 f0 bb ff ff ff ff 89 4d ec <8b> 80 b8 00 00 00 89 55 e4 89 45 e8 90 8d b4 26 00 00 00 00 43

Followed shortly by:

Jul 10 08:05:59 bert kernel: Modules linked in: parport_pc parport snd_es18xx snd_pcm_oss snd_mixer_oss snd_pcm s
nd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore nfs lockd
 sunrpc md dm_mod pcspkr e100 mii autofs4 af_packet ext3 jbd nls_iso8859_1 nls_cp437 apm rtc
Jul 10 08:05:59 bert kernel: CPU:    0
Jul 10 08:05:59 bert kernel: EIP:    0060:[dma_alloc_coherent+28/256]    Not tainted VLI
Jul 10 08:05:59 bert kernel: EFLAGS: 00010282   (2.6.7-mm7)
Jul 10 08:05:59 bert kernel: EIP is at dma_alloc_coherent+0x1c/0x100
Jul 10 08:05:59 bert kernel: eax: 00000000   ebx: ffffffff   ecx: ddce93fc   edx: 00000001
Jul 10 08:05:59 bert kernel: esi: 00001000   edi: 00000000   ebp: dd019e74   esp: dd019e58
Jul 10 08:05:59 bert kernel: ds: 007b   es: 007b   ss: 0068
Jul 10 08:05:59 bert kernel: Process modprobe (pid: 1221, threadinfo=dd019000 task=dd002090)
Jul 10 08:05:59 bert kernel: Stack: 00000002 dd019e74 ddce93fc 00000000 dffd2600 ddce93e0 00000000 dd019eac
Jul 10 08:05:59 bert kernel:        e0affbc3 00000020 dffd2600 e0b012bf ddce9404 ddee3300 ddee3320 ffffffff
Jul 10 08:05:59 bert kernel:        00000778 00000378 dff25c00 00000003 00000007 dd019ed0 e0b00635 00000003
Jul 10 08:05:59 bert kernel: Call Trace:
Jul 10 08:05:59 bert kernel:  [show_stack+122/144] show_stack+0x7a/0x90
Jul 10 08:05:59 bert kernel:  [show_registers+329/448] show_registers+0x149/0x1c0
Jul 10 08:05:59 bert kernel:  [die+141/256] die+0x8d/0x100
Jul 10 08:05:59 bert kernel:  [do_page_fault+951/1439] do_page_fault+0x3b7/0x59f
Jul 10 08:05:59 bert kernel:  [error_code+45/56] error_code+0x2d/0x38
Jul 10 08:05:59 bert kernel:  [pg0+544578499/1069907968] parport_pc_probe_port+0x483/0x6b0 [parport_pc]
Jul 10 08:05:59 bert kernel:  [pg0+544581173/1069907968] parport_pc_pnp_probe+0xb5/0x130 [parport_pc]
Jul 10 08:05:59 bert kernel:  [pnp_device_probe+164/192] pnp_device_probe+0xa4/0xc0
Jul 10 08:05:59 bert kernel:  [bus_match+53/128] bus_match+0x35/0x80
Jul 10 08:05:59 bert kernel:  [driver_attach+77/144] driver_attach+0x4d/0x90
Jul 10 08:05:59 bert kernel:  [bus_add_driver+153/208] bus_add_driver+0x99/0xd0
Jul 10 08:05:59 bert kernel:  [driver_register+43/48] driver_register+0x2b/0x30
Jul 10 08:05:59 bert kernel:  [pnp_register_driver+61/112] pnp_register_driver+0x3d/0x70
Jul 10 08:05:59 bert kernel:  [pg0+543793537/1069907968] parport_pc_find_ports+0x61/0x80 [parport_pc]
Jul 10 08:05:59 bert kernel:  [pg0+543794379/1069907968] parport_pc_init+0xcb/0xcf [parport_pc]
Jul 10 08:05:59 bert kernel:  [sys_init_module+271/672] sys_init_module+0x10f/0x2a0
Jul 10 08:05:59 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 10 08:05:59 bert kernel: Code: 00 59 e9 6d ff ff ff 90 90 90 90 90 90 90 90 55 89 e5 57 56 89 d6 8d 52 ff 53
c1 ea 0b 83 ec 10 89 45 f0 bb ff ff ff ff 89 4d ec <8b> 80 b8 00 00 00 89 55 e4 89 45 e8 90 8d b4 26 00 00 00 00
43

Kernel was compiled with debian gcc 3.4 from testing.

Hope this helps

Ed




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263280AbUJ2Amf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbUJ2Amf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbUJ2AkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:40:15 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:11416 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263252AbUJ2AZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:25:18 -0400
Subject: [2.6.9] oops in sock_fasync and __sock_create
From: =?ISO-8859-1?Q?Beno=EEt?= Dejean <benoit.dejean@placenet.org>
Reply-To: TazForEver@dlfp.org
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Oct 2004 02:23:05 +0200
Message-Id: <1099009385.8588.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, today i got this two oops


Oct 29 01:32:45 athlon kernel: c0257943
Oct 29 01:32:45 athlon kernel: PREEMPT 
Oct 29 01:32:45 athlon kernel: Modules linked in: nfsd exportfs lockd
sunrpc ipt_ttl ipt_limit ipt_state iptable_mangle ipt_LOG ipt_MASQUERADE
ipt_TOS ipt_REDIRECT iptable_nat ipt_REJECT ip_conntrack_irc
ip_conntrack_ftp ip_conntrack iptable_filter ip_tables binfmt_misc md5
ipv6 snd_via82xx snd_mpu401_uart snd_emu10k1 snd_rawmidi snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd_ac97_codec snd_page_alloc
snd_util_mem snd_hwdep snd w83781d i2c_sensor i2c_isa i2c_viapro
i2c_core emu10k1 soundcore ac97_codec usblp uhci_hcd ehci_hcd sd_mod
usb_storage usbcore scsi_mod rtc
Oct 29 01:32:45 athlon kernel: CPU:    0
Oct 29 01:32:45 athlon kernel: EIP:    0060:[unix_gc+291/1060]    Not
tainted VLI
Oct 29 01:32:45 athlon kernel: EFLAGS: 00010246   (2.6.9) 
Oct 29 01:32:45 athlon kernel: EIP is at unix_stream_sendmsg+0x203/0x380
Oct 29 01:32:45 athlon kernel: eax: 00000000   ebx: dcb55700   ecx:
00000000   edx: 00000000
Oct 29 01:32:45 athlon kernel: esi: 00000044   edi: d2abd338   ebp:
d62ed900   esp: d5df8e34
Oct 29 01:32:45 athlon gconfd (benoit-1282): Réception du signal 15,
arrêt correct
Oct 29 01:32:45 athlon kernel: ds: 007b   es: 007b   ss: 0068
Oct 29 01:32:45 athlon kernel: Process bubblemon-gnome (pid: 1373,
threadinfo=d5df8000 task=d5e17810)
Oct 29 01:32:45 athlon kernel: Stack: d5df8e48 00000000 d62eda78
d5df8e84 d5df8ea4 00000000 0000055d 000003e8 
Oct 29 01:32:45 athlon kernel:        000003e8 00000000 00000000
01baa5b4 000132b2 00000000 c02a9440 d5df8ef0 
Oct 29 01:32:45 athlon kernel:        00000044 0807b800 c02028bd
00000044 dd213006 000011ed 00000000 00000044 
Oct 29 01:32:45 athlon kernel: Call Trace:
Oct 29 01:32:45 athlon kernel:  [__sock_create+525/608] sock_aio_write
+0xdd/0x100
Oct 29 01:32:45 athlon kernel:  [filp_ctor+4/48] do_sync_write+0xa4/0xe0
Oct 29 01:32:45 athlon kernel:  [kmem_cache_create+840/1360] poison_obj
+0x28/0x50
Oct 29 01:32:45 athlon kernel:  [kmem_cache_create+840/1360] poison_obj
+0x28/0x50
Oct 29 01:32:45 athlon kernel:  [mm_init+176/192]
autoremove_wake_function+0x0/0x50
Oct 29 01:32:45 athlon kernel:  [s_show+78/528] cache_free_debugcheck
+0x10e/0x200
Oct 29 01:32:46 athlon kernel:  [dcache_dir_lseek+254/384]
single_release+0x1e/0x30
Oct 29 01:32:46 athlon kernel:  [__find_get_block_slow+263/304] __fput
+0xa7/0x110
Oct 29 01:32:46 athlon kernel:  [get_empty_filp+183/208] vfs_write
+0xd7/0x100
Oct 29 01:32:46 athlon kernel:  [__fput+183/272] sys_write+0x47/0x80
Oct 29 01:32:46 athlon kernel:  [work_notifysig+8/21] syscall_call
+0x7/0xb
Oct 29 01:32:46 athlon kernel: Code: 00 00 00 89 83 a4 00 00 00 0f 87 51
01 00 00 8b 44 24 10 89 f1 8b 50 08 89 f8 e8 d9 04 fb ff 85 c0 89 44 24
14 0f 85 16 01 00 00 <bf> 00 f0 ff ff 21 e7 ff 47 14 8b 45 74 a8 01 75
7d f6 45 1d 01 
Oct 29 01:32:46 athlon kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Oct 29 01:32:46 athlon kernel: c0257943
Oct 29 01:32:46 athlon kernel: PREEMPT 
Oct 29 01:32:46 athlon kernel: Modules linked in: nfsd exportfs lockd
sunrpc ipt_ttl ipt_limit ipt_state iptable_mangle ipt_LOG ipt_MASQUERADE
ipt_TOS ipt_REDIRECT iptable_nat ipt_REJECT ip_conntrack_irc
ip_conntrack_ftp ip_conntrack iptable_filter ip_tables binfmt_misc md5
ipv6 snd_via82xx snd_mpu401_uart snd_emu10k1 snd_rawmidi snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd_ac97_codec snd_page_alloc
snd_util_mem snd_hwdep snd w83781d i2c_sensor i2c_isa i2c_viapro
i2c_core emu10k1 soundcore ac97_codec usblp uhci_hcd ehci_hcd sd_mod
usb_storage usbcore scsi_mod rtc
Oct 29 01:32:46 athlon kernel: CPU:    0
Oct 29 01:32:46 athlon kernel: EIP:    0060:[unix_gc+291/1060]    Not
tainted VLI
Oct 29 01:32:46 athlon kernel: EFLAGS: 00013246   (2.6.9) 
Oct 29 01:32:46 athlon kernel: EIP is at unix_stream_sendmsg+0x203/0x380
Oct 29 01:32:46 athlon kernel: eax: 00000000   ebx: db51db30   ecx:
00000000   edx: 00000000
Oct 29 01:32:46 athlon kernel: esi: 000000e0   edi: d2abd750   ebp:
d8289110   esp: dac74da4
Oct 29 01:32:46 athlon kernel: ds: 007b   es: 007b   ss: 0068
Oct 29 01:32:46 athlon kernel: Process XFree86 (pid: 1174,
threadinfo=dac74000 task=dd2c4c90)
Oct 29 01:32:46 athlon kernel: Stack: dac74db8 00000000 d7d79e68
dac74df4 dac74ed8 00000000 00000496 00000000 
Oct 29 01:32:46 athlon kernel:        00000000 00000000 00000000
c12a8160 00003202 dff3e5b4 c02a9440 dac74e44 
Oct 29 01:32:46 athlon kernel:        dac74ed8 dbd66ab8 c020252c
000000e0 c01325cc c12a8160 00000002 000000e0 
Oct 29 01:32:46 athlon kernel: Call Trace:
Oct 29 01:32:46 athlon kernel:  [sock_fasync+92/368] sock_sendmsg
+0xcc/0xf0
Oct 29 01:32:46 athlon kernel:  [show_free_areas+12/1008] __pagevec_free
+0x1c/0x30
Oct 29 01:32:46 athlon kernel:  [rb_replace_node+33/80]
radix_tree_gang_lookup+0x41/0x60
Oct 29 01:32:46 athlon kernel:  [mm_init+176/192]
autoremove_wake_function+0x0/0x50
Oct 29 01:32:46 athlon kernel:  [sys_socket+60/80] sock_readv_writev
+0x6c/0xa0
Oct 29 01:32:46 athlon kernel:  [sys_socketpair+149/304] sock_writev
+0x35/0x40
Oct 29 01:32:46 athlon kernel:  [sys_socketpair+96/304] sock_writev
+0x0/0x40
Oct 29 01:32:46 athlon kernel:  [__lock_buffer+19/176] do_readv_writev
+0x1d3/0x220
Oct 29 01:32:46 athlon kernel:  [mqueue_poll_file+66/144] sys_shmdt
+0xb2/0x140
Oct 29 01:32:46 athlon kernel:  [__wait_on_buffer+57/160] vfs_writev
+0x49/0x60
Oct 29 01:32:46 athlon kernel:  [buffer_io_error+39/64] sys_writev
+0x47/0x80
Oct 29 01:32:46 athlon kernel:  [work_notifysig+8/21] syscall_call
+0x7/0xb
Oct 29 01:32:46 athlon kernel: Code: 00 00 00 89 83 a4 00 00 00 0f 87 51
01 00 00 8b 44 24 10 89 f1 8b 50 08 89 f8 e8 d9 04 fb ff 85 c0 89 44 24
14 0f 85 16 01 00 00 <bf> 00 f0 ff ff 21 e7 ff 47 14 8b 45 74 a8 01 75
7d f6 45 1d 01 
Oct 29 01:32:46 athlon gconfd (benoit-1282): Sortie
Oct 29 01:32:50 athlon kernel:  <4>mtrr: 0xd0000000,0x8000000 overlaps
existing 0xd0000000,0x800000




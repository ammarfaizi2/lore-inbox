Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422875AbWBIITl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422875AbWBIITl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422869AbWBIITl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:19:41 -0500
Received: from mail.gmx.net ([213.165.64.21]:62907 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422854AbWBIITk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:19:40 -0500
X-Authenticated: #14349625
Subject: [k2.6.16-rc1-mm5] kernel BUG at include/linux/mm.h:302!
From: MIke Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-zVn+p7cHxQydI11RSzwQ"
Date: Thu, 09 Feb 2006 09:24:23 +0100
Message-Id: <1139473463.8028.13.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zVn+p7cHxQydI11RSzwQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Greetings,

Excuse me if this is already known, I've been too busy tinkering to read
lkml.

If I compile this kernel as SMP on my P4 box, I receive this BUG on
boot.  Trying to start amaroK tipped me off that something was screwy,
and I thought it was some scheduler changes I'm working on, but I'm
innocent.  The below is Virgin source.

gzipped config attached.  AmaroK isn't very happy after the BUG... and
neither is just about anything else it seems.  Hopefully I'm not just
wasting electrons typing this :)  We'll see.

	-Mike

kernel BUG at include/linux/mm.h:302!
invalid opcode: 0000 [#1]
PREEMPT SMP 
last sysfs file: /devices/pci0000:00/0000:00:1e.0/0000:02:09.0/subsystem_device
Modules linked in: xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss button battery snd_seq snd_seq_device ac edd ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack ip_tables ip6table_filter ip6_tables x_tables tda9887 at76c651 prism54 saa7134 ohci1394 ieee1394 bt878 ir_kbd_i2c snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc i2c_i801 tuner bttv video_buf firmware_class btcx_risc ir_common tveeprom nls_iso8859_1 nls_cp437 nls_utf8 sd_mod fan thermal processor
CPU:    0
EIP:    0060:[<c01461cb>]    Not tainted VLI
EFLAGS: 00210246   (2.6.16-rc1-mm5 #1) 
EIP is at release_pages+0x165/0x196
eax: 00000000   ebx: c16f3220   ecx: 00000000   edx: 00000008
esi: c18077d0   edi: c18077b4   ebp: 00000000   esp: f6644e74
ds: 007b   es: 007b   ss: 0068
Process knotify (pid: 7482, threadinfo=f6644000 task=f658b030)
Stack: <0>00000008 00000008 00000001 00000000 00000000 c161e920 c161e940 c161e960 
       c161e980 c161e9a0 c057f600 f6644edc 00000001 00000002 f6644ed4 c01446de 
       c161e9a0 c18077d0 00000008 c16f32e0 c18077d0 00000008 00000008 c01521b5 
Call Trace:
 <c01446de> __pagevec_free+0x1f/0x2e   <c01521b5> free_pages_and_swap_cache+0x74/0xb6
 <c014afd4> unmap_vmas+0x5da/0x642   <c014de7d> unmap_region+0xa7/0x131
 <c014e5cd> do_munmap+0x139/0x1cc   <c014e6a0> sys_munmap+0x40/0x59
 <c0102bc3> sysenter_past_esp+0x54/0x75  
Code: e8 65 de fb ff e9 01 ff ff ff 83 ad a4 05 00 00 01 eb 85 85 ed 0f 84 c6 fe ff ff 8d 85 80 05 00 00 e8 05 64 32 00 e9 b6 fe ff ff <0f> 0b 2e 01 e6 fd 49 c0 eb b4 0f 0b 00 01 66 fe 49 c0 e9 14 ff 
 <6>note: knotify[7482] exited with preempt_count 1
BUG: scheduling while atomic: knotify/0x00000001/7482
 <c046aea3> schedule+0xaf1/0xe6e   <c011bd98> __call_console_drivers+0x38/0x44
 <c011c01f> release_console_sem+0x177/0x1e2   <c011ca3c> vprintk+0x266/0x36e
 <c011c058> release_console_sem+0x1b0/0x1e2   <c046bf21> rwsem_down_read_failed+0x92/0x200
 <c011f923> .text.lock.exit+0x7/0x64   <c011e498> do_exit+0x115/0x8d9
 <c0104362> do_simd_coprocessor_error+0x0/0x163   <c010477d> do_invalid_op+0x0/0xab
 <c010481f> do_invalid_op+0xa2/0xab   <c01461cb> release_pages+0x165/0x196
 <c0114715> __wake_up+0x32/0x43   <c03b0168> sock_def_readable+0x3c/0x69
 <c01037bb> error_code+0x4f/0x54   <c01461cb> release_pages+0x165/0x196
 <c01446de> __pagevec_free+0x1f/0x2e   <c01521b5> free_pages_and_swap_cache+0x74/0xb6
 <c014afd4> unmap_vmas+0x5da/0x642   <c014de7d> unmap_region+0xa7/0x131
 <c014e5cd> do_munmap+0x139/0x1cc   <c014e6a0> sys_munmap+0x40/0x59
 <c0102bc3> sysenter_past_esp+0x54/0x75  

SysRq-T

amarokapp     X C0132967     0  7898      1          7929  7767 (L-TLB)
e563ce6c 00000001 00000000 c0132967 7fffffff 00000000 f16b1b9a 000000e1 
       00000202 e563c000 f6531ab0 f669c580 dff0b740 00000a07 f664b164 f664b030 
       e458e030 c18084c0 f174a51c 000000e1 00000000 e563c000 00000000 e458e030 
Call Trace:
 <c0132967> sys_futex+0x50/0x108   <c011d870> exit_mm+0x10c/0x129
 <c011e894> do_exit+0x511/0x8d9   <c011ec85> do_group_exit+0x29/0x86
 <c0127d65> get_signal_to_deliver+0x271/0x4a9   <c0102508> do_notify_resume+0x87/0x673
 <c0418823> unix_ioctl+0x98/0xb8   <c03ac335> sock_ioctl+0xb4/0x1ec
 <c01704b6> sys_select+0xd2/0x1ac   <c0102cae> work_notifysig+0x13/0x19
amarokapp     D 00000001     0  7929      1  7927    7804  7898 (L-TLB)
e4156bf8 00000002 e4156be4 00000001 00001ef9 00000000 f1c78b0c 000000e1 
       00000000 e4156000 00000000 e4156d30 1e2c31bc 0003a1bf e458e6a4 e458e570 
       c0579000 c18084c0 f1cddb08 000000e1 00000000 e4156000 e458e570 f1c78b0c 
Call Trace:
 <c011ec11> do_exit+0x88e/0x8d9   <c01036f0> apic_timer_interrupt+0x1c/0x24
 <c0104362> do_simd_coprocessor_error+0x0/0x163   <c010477d> do_invalid_op+0x0/0xab
 <c010481f> do_invalid_op+0xa2/0xab   <c01461cb> release_pages+0x165/0x196
 <c0143a3d> free_pages_bulk+0x2f/0x2f5   <c01037bb> error_code+0x4f/0x54
 <c014007b> generic_file_buffered_write+0x3e2/0x670   <c01461cb> release_pages+0x165/0x196
 <c01521b5> free_pages_and_swap_cache+0x74/0xb6   <c014afd4> unmap_vmas+0x5da/0x642
 <c014d750> exit_mmap+0x82/0x114   <c01198f3> mmput+0x31/0xef
 <c011e498> do_exit+0x115/0x8d9   <c011ec85> do_group_exit+0x29/0x86
 <c0127d65> get_signal_to_deliver+0x271/0x4a9   <c0102508> do_notify_resume+0x87/0x673
 <c0116cbc> default_wake_function+0x0/0xc   <c0132967> sys_futex+0x50/0x108
 <c0102cae> work_notifysig+0x13/0x19  
amarokapp     X 00000000     0  7927   7929          7928       (L-TLB)
e4fa9e6c 00000000 0000000f 00000000 00000001 e53edaa8 f198dea3 000000e1 
       f38d0480 e4fa9000 e458e570 00000000 f67d7580 00016bd0 e4df6164 e4df6030 
       dffb4ab0 c18104c0 f1a636e9 000000e1 00000001 e4fa9000 00000000 dffb4ab0 
Call Trace:
 <c011e894> do_exit+0x511/0x8d9   <c046a708> schedule+0x356/0xe6e
 <c046a733> schedule+0x381/0xe6e   <c011ec85> do_group_exit+0x29/0x86
 <c0127d65> get_signal_to_deliver+0x271/0x4a9   <c0102508> do_notify_resume+0x87/0x673
 <c016926c> pipe_wait+0x85/0x8c   <c012e9c4> autoremove_wake_function+0x0/0x37
 <c0169ce7> pipe_read+0x0/0x29   <c0169d07> pipe_read+0x20/0x29
 <c015d7dd> vfs_read+0xa2/0x158   <c015e280> sys_read+0x41/0x6a
 <c0102cae> work_notifysig+0x13/0x19  
amarokapp     X 00000000     0  7928   7929                7927 (L-TLB)
e458fe6c 00000000 0000000f 00000000 00000001 e53ed92c f189a1fc 000000e1 
       f627bd80 e458f000 f6531030 dffe3580 dff0b900 00001ccc e458ebe4 e458eab0 
       e4df6030 c18104c0 f18c9ee2 000000e1 00000001 e458f000 00000000 e4df6030 
Call Trace:
 <c011e894> do_exit+0x511/0x8d9   <c046a97d> schedule+0x5cb/0xe6e
 <c011ec85> do_group_exit+0x29/0x86   <c0127d65> get_signal_to_deliver+0x271/0x4a9
 <c0102508> do_notify_resume+0x87/0x673   <c016926c> pipe_wait+0x85/0x8c
 <c012e9c4> autoremove_wake_function+0x0/0x37   <c0169ce7> pipe_read+0x0/0x29
 <c0169d07> pipe_read+0x20/0x29   <c015d7dd> vfs_read+0xa2/0x158
 <c015e280> sys_read+0x41/0x6a   <c0102cae> work_notifysig+0x13/0x19


--=-zVn+p7cHxQydI11RSzwQ
Content-Disposition: attachment; filename=config-2.6.16-rc1-mm5.gz
Content-Type: application/x-gzip; name=config-2.6.16-rc1-mm5.gz
Content-Transfer-Encoding: base64

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
w8qm1lHJjsLxbXZSaFee7D/Q9ksnprkAAO==


--=-zVn+p7cHxQydI11RSzwQ--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUEVSGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUEVSGr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 14:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEVSGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 14:06:47 -0400
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:13696 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S261724AbUEVSGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 14:06:32 -0400
Message-ID: <01ef01c44027$7cb90920$d100a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Kernel" <linux-kernel@vger.kernel.org>
Subject: Trouble with NFS with -mm3, -mm4, and -mm5
Date: Sat, 22 May 2004 11:06:20 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I keep getting the following oops using NFS with -mm3 thru -mm5.

May 22 00:25:27 server ------------[ cut here ]------------
May 22 00:25:27 server kernel BUG at include/linux/dcache.h:276!
May 22 00:25:27 server invalid operand: 0000 [#1]
May 22 00:25:27 server PREEMPT SMP
May 22 00:25:27 server Modules linked in: vfat fat isofs zlib_inflate floppy
ext2 videodev nfsd exportfs lockd sunrpc parport_pc lp parport ipt_TOS
ipt_TCPMSS ipt_LOG ipt_limit iptable_mangle iptable_nat ip_conntrack_irc
ip_conntrack_ftp ipt_REJECT ipt_state ip_conntrack af_packet bonding 8250
serial_core ohci_hcd usbcore psmouse tulip crc32 iptable_filter ip_tables
ovcamchip i2c_core rtc supermount unix aic7xxx megaraid sd_mod scsi_mod
May 22 00:25:27 server CPU:    0
May 22 00:25:27 server EIP:    0060:[<f922823c>]    Not tainted VLI
May 22 00:25:27 server EFLAGS: 00010246   (2.6.6-lfs-6)
May 22 00:25:27 server EIP is at nfsd_acceptable+0xfc/0x110 [nfsd]
May 22 00:25:27 server eax: 00000000   ebx: f7f91a10   ecx: 00000002   edx:
e69cfce4
May 22 00:25:27 server esi: 00000002   edi: ffffff8c   ebp: ece47094   esp:
f7221b18
May 22 00:25:27 server ds: 007b   es: 007b   ss: 0068
May 22 00:25:27 server Process nfsd (pid: 3728, threadinfo=f7221000
task=f71ec330)
May 22 00:25:27 server Stack: f7f3b200 743cc608 00000000 f7f91a10 00000002
ffffff8c 00000000 f912607a
May 22 00:25:27 server c02112e9 00000000 f7861000 f7221b58 c021cec0 80000000
00000000 f7386240
May 22 00:25:27 server c034b060 c021cec0 c028bf28 ffffff8c f7861000 e69cfce4
f7221d94 f7f3b200
May 22 00:25:27 server Call Trace:
May 22 00:25:27 server [<f912607a>] find_exported_dentry+0x7a/0x800
[exportfs]
May 22 00:25:27 server [<c02112e9>] nf_hook_slow+0x119/0x130
May 22 00:25:27 server [<c021cec0>] ip_finish_output2+0x0/0x1e0
May 22 00:25:27 server [<c021cec0>] ip_finish_output2+0x0/0x1e0
May 22 00:25:27 server [<c021cec0>] ip_finish_output2+0x0/0x1e0
May 22 00:25:27 server [<c021cc6b>] dst_output+0xb/0x20
May 22 00:25:27 server [<c02112e9>] nf_hook_slow+0x119/0x130
May 22 00:25:27 server [<c021cc60>] dst_output+0x0/0x20
May 22 00:25:27 server [<c021cc60>] dst_output+0x0/0x20
May 22 00:25:27 server [<c021eea6>] ip_push_pending_frames+0x3a6/0x450
May 22 00:25:27 server [<c021cc60>] dst_output+0x0/0x20
May 22 00:25:27 server [<c023d319>] udp_push_pending_frames+0x139/0x260
May 22 00:25:27 server [<c023d797>] udp_sendmsg+0x317/0x760
May 22 00:25:27 server [<c0201c0f>] sock_alloc_send_pskb+0xaf/0x1a0
May 22 00:25:27 server [<c021df30>] ip_generic_getfrag+0x0/0xb0
May 22 00:25:27 server [<c021828d>] __ip_route_output_key+0x1d/0xe0
May 22 00:25:27 server [<c023d797>] udp_sendmsg+0x317/0x760
May 22 00:25:27 server [<c02460ca>] inet_sendmsg+0x4a/0x70
May 22 00:25:27 server [<f9126b9e>] export_decode_fh+0x5e/0xc7 [exportfs]
May 22 00:25:27 server [<f9228140>] nfsd_acceptable+0x0/0x110 [nfsd]
May 22 00:25:27 server [<f9126b40>] export_decode_fh+0x0/0xc7 [exportfs]
May 22 00:25:27 server [<f9228671>] fh_verify+0x421/0x5d0 [nfsd]
May 22 00:25:27 server [<f9228140>] nfsd_acceptable+0x0/0x110 [nfsd]
May 22 00:25:27 server [<f9229a41>] nfsd_open+0x31/0x160 [nfsd]
May 22 00:25:27 server [<f922a192>] nfsd_write+0x62/0x370 [nfsd]
May 22 00:25:27 server [<c0203eb2>] skb_copy_and_csum_bits+0x222/0x300
May 22 00:25:27 server [<c01191f0>] scheduler_tick+0x190/0x500
May 22 00:25:27 server [<c0112865>] smp_apic_timer_interrupt+0x165/0x170
May 22 00:25:27 server [<f922ed20>] nfssvc_decode_writeargs+0x0/0xe0 [nfsd]
May 22 00:25:27 server [<c010659a>] apic_timer_interrupt+0x1a/0x20
May 22 00:25:27 server [<f922ed20>] nfssvc_decode_writeargs+0x0/0xe0 [nfsd]
May 22 00:25:27 server [<f92274f7>] nfsd_proc_write+0xa7/0xf0 [nfsd]
May 22 00:25:27 server [<f922ed20>] nfssvc_decode_writeargs+0x0/0xe0 [nfsd]
May 22 00:25:27 server [<f92267ba>] nfsd_dispatch+0x8a/0x1f0 [nfsd]
May 22 00:25:27 server [<f924678d>] svc_authenticate+0x4d/0x90 [sunrpc]
May 22 00:25:27 server [<f924396d>] svc_process+0x56d/0x5fb [sunrpc]
May 22 00:25:27 server [<c010659a>] apic_timer_interrupt+0x1a/0x20
May 22 00:25:27 server [<f92264d8>] nfsd+0x208/0x460 [nfsd]
May 22 00:25:27 server [<f92262d0>] nfsd+0x0/0x460 [nfsd]
May 22 00:25:27 server [<c0103d75>] kernel_thread_helper+0x5/0x10
May 22 00:25:27 server
May 22 00:25:27 server Code: f9 eb 88 8b 46 1c 89 74 24 04 c7 04 24 50 06 23
f9 89 44 24 08 e8 85 5c ef c6 8b 45 20 eb b2 89 d8 e8 89 7b f4 c6 8b 45 20
eb 99 <0f> 0b 14 01 7f ff 22 f9 e9 1d ff ff ff 8d b4 26 00 00 00 00 83
May 22 01:30:33 server ------------[ cut here ]------------
May 22 01:30:33 server kernel BUG at include/linux/dcache.h:276!
May 22 01:30:33 server invalid operand: 0000 [#1]
May 22 01:30:33 server PREEMPT SMP
May 22 01:30:33 server Modules linked in: vfat fat isofs zlib_inflate floppy
ext2 ov511 videodev v4l2_common nfsd exportfs lockd sunrpc parport_pc lp
parport ipt_TOS ipt_TCPMSS ipt_LOG ipt_limit iptable_mangle iptable_nat
ip_conntrack_irc ip_conntrack_ftp ipt_REJECT ipt_state ip_conntrack
af_packet bonding 8250 serial_core ohci_hcd usbcore psmouse tulip crc32
iptable_filter ip_tables ovcamchip i2c_core rtc supermount unix aic7xxx
megaraid sd_mod scsi_mod
May 22 01:30:33 server CPU:    0
May 22 01:30:33 server EIP:    0060:[<f922823c>]    Not tainted VLI
May 22 01:30:33 server EFLAGS: 00010246   (2.6.6-lfs-6)
May 22 01:30:33 server EIP is at nfsd_acceptable+0xfc/0x110 [nfsd]
May 22 01:30:33 server eax: 00000000   ebx: f7f90610   ecx: 00000002   edx:
edceb89c
May 22 01:30:33 server esi: 00000002   edi: ffffff8c   ebp: f7d5e154   esp:
f72e4b18
May 22 01:30:33 server ds: 007b   es: 007b   ss: 0068
May 22 01:30:33 server Process nfsd (pid: 3732, threadinfo=f72e4000
task=f71e6370)
May 22 01:30:33 server Stack: f7f67600 743cc01f 00000000 f7f90610 00000002
ffffff8c 00000000 f912607a
May 22 01:30:33 server c02112e9 00000000 f7ba8000 f72e4b58 c021cec0 80000000
00000000 f7cef5c0
May 22 01:30:33 server c034b060 c021cec0 c028bf28 ffffff8c f7ba8000 edceb89c
f72e4d94 f7f67600
May 22 01:30:33 server Call Trace:
May 22 01:30:33 server [<f912607a>] find_exported_dentry+0x7a/0x800
[exportfs]
May 22 01:30:33 server [<c02112e9>] nf_hook_slow+0x119/0x130
May 22 01:30:33 server [<c021cec0>] ip_finish_output2+0x0/0x1e0
May 22 01:30:33 server [<c021cec0>] ip_finish_output2+0x0/0x1e0
May 22 01:30:33 server [<c021cec0>] ip_finish_output2+0x0/0x1e0
May 22 01:30:33 server [<c021cc6b>] dst_output+0xb/0x20
May 22 01:30:33 server [<c02112e9>] nf_hook_slow+0x119/0x130
May 22 01:30:33 server [<c021cc60>] dst_output+0x0/0x20
May 22 01:30:33 server [<c021cc60>] dst_output+0x0/0x20
May 22 01:30:33 server [<c021eea6>] ip_push_pending_frames+0x3a6/0x450
May 22 01:30:33 server [<c021cc60>] dst_output+0x0/0x20
May 22 01:30:33 server [<c023d319>] udp_push_pending_frames+0x139/0x260
May 22 01:30:33 server [<c023d797>] udp_sendmsg+0x317/0x760
May 22 01:30:33 server [<c0201c0f>] sock_alloc_send_pskb+0xaf/0x1a0
May 22 01:30:33 server [<c021df30>] ip_generic_getfrag+0x0/0xb0
May 22 01:30:33 server [<c021828d>] __ip_route_output_key+0x1d/0xe0
May 22 01:30:33 server [<c023d797>] udp_sendmsg+0x317/0x760
May 22 01:30:33 server [<c02460ca>] inet_sendmsg+0x4a/0x70
May 22 01:30:33 server [<f9126b9e>] export_decode_fh+0x5e/0xc7 [exportfs]
May 22 01:30:33 server [<f9228140>] nfsd_acceptable+0x0/0x110 [nfsd]
May 22 01:30:33 server [<f9126b40>] export_decode_fh+0x0/0xc7 [exportfs]
May 22 01:30:33 server [<f9228671>] fh_verify+0x421/0x5d0 [nfsd]
May 22 01:30:33 server [<f9228140>] nfsd_acceptable+0x0/0x110 [nfsd]
May 22 01:30:33 server [<c010659a>] apic_timer_interrupt+0x1a/0x20
May 22 01:30:33 server [<f9229a41>] nfsd_open+0x31/0x160 [nfsd]
May 22 01:30:33 server [<f922a192>] nfsd_write+0x62/0x370 [nfsd]
May 22 01:30:33 server [<c0203eb2>] skb_copy_and_csum_bits+0x222/0x300
May 22 01:30:33 server [<c02029f2>] __kfree_skb+0x72/0xf0
May 22 01:30:33 server [<f9247bfc>] svcauth_unix_accept+0x27c/0x2b0 [sunrpc]
May 22 01:30:33 server [<f92274f7>] nfsd_proc_write+0xa7/0xf0 [nfsd]
May 22 01:30:33 server [<f922ed20>] nfssvc_decode_writeargs+0x0/0xe0 [nfsd]
May 22 01:30:33 server [<f92267ba>] nfsd_dispatch+0x8a/0x1f0 [nfsd]
May 22 01:30:33 server [<f924678d>] svc_authenticate+0x4d/0x90 [sunrpc]
May 22 01:30:33 server [<f924396d>] svc_process+0x56d/0x5fb [sunrpc]
May 22 01:30:33 server [<f92264d8>] nfsd+0x208/0x460 [nfsd]
May 22 01:30:33 server [<f92262d0>] nfsd+0x0/0x460 [nfsd]
May 22 01:30:33 server [<c0103d75>] kernel_thread_helper+0x5/0x10
May 22 01:30:33 server
May 22 01:30:33 server Code: f9 eb 88 8b 46 1c 89 74 24 04 c7 04 24 50 06 23
f9 89 44 24 08 e8 85 5c ef c6 8b 45 20 eb b2 89 d8 e8 89 7b f4 c6 8b 45 20
eb 99 <0f> 0b 14 01 7f ff 22 f9 e9 1d ff ff ff 8d b4 26 00 00 00 00 83
May 22 08:41:52 server ------------[ cut here ]------------
May 22 08:41:52 server kernel BUG at include/linux/dcache.h:276!
May 22 08:41:52 server invalid operand: 0000 [#1]
May 22 08:41:52 server PREEMPT SMP
May 22 08:41:52 server Modules linked in: ov511 videodev v4l2_common nfsd
exportfs lockd sunrpc parport_pc lp parport ipt_TOS ipt_TCPMSS ipt_LOG
ipt_limit iptable_mangle iptable_nat ip_conntrack_irc ip_conntrack_ftp
ipt_REJECT ipt_state ip_conntrack af_packet bonding 8250 serial_core
ohci_hcd usbcore psmouse tulip crc32 iptable_filter ip_tables ovcamchip
i2c_core rtc supermount unix aic7xxx megaraid sd_mod scsi_mod
May 22 08:41:52 server CPU:    0
May 22 08:41:52 server EIP:    0060:[<f922823c>]    Not tainted VLI
May 22 08:41:52 server EFLAGS: 00010246   (2.6.6-lfs-6)
May 22 08:41:52 server EIP is at nfsd_acceptable+0xfc/0x110 [nfsd]
May 22 08:41:52 server eax: 00000000   ebx: f7f90e10   ecx: 00000002   edx:
f1149934
May 22 08:41:52 server esi: 00000002   edi: ffffff8c   ebp: f7d5cad4   esp:
f7213b18
May 22 08:41:52 server ds: 007b   es: 007b   ss: 0068
May 22 08:41:52 server Process nfsd (pid: 3748, threadinfo=f7213000
task=f747e8d0)
May 22 08:41:52 server Stack: f7f2d200 743cbfbc 00000000 f7f90e10 00000002
ffffff8c 00000000 f912607a
May 22 08:41:52 server c02112e9 00000000 f7af6800 f7213b58 c021cec0 80000000
00000000 f73a28c0
May 22 08:41:52 server c034b060 c021cec0 c028bf28 ffffff8c f7af6800 f1149934
f7213d94 f7f2d200
May 22 08:41:52 server Call Trace:
May 22 08:41:52 server [<f912607a>] find_exported_dentry+0x7a/0x800
[exportfs]
May 22 08:41:52 server [<c02112e9>] nf_hook_slow+0x119/0x130
May 22 08:41:52 server [<c021cec0>] ip_finish_output2+0x0/0x1e0
May 22 08:41:52 server [<c021cec0>] ip_finish_output2+0x0/0x1e0
May 22 08:41:52 server [<c021cec0>] ip_finish_output2+0x0/0x1e0
May 22 08:41:52 server [<c021cc6b>] dst_output+0xb/0x20
May 22 08:41:52 server [<c02112e9>] nf_hook_slow+0x119/0x130
May 22 08:41:52 server [<c021cc60>] dst_output+0x0/0x20
May 22 08:41:52 server [<c021cc60>] dst_output+0x0/0x20
May 22 08:41:52 server [<c021eea6>] ip_push_pending_frames+0x3a6/0x450
May 22 08:41:52 server [<c021cc60>] dst_output+0x0/0x20
May 22 08:41:52 server [<c023d319>] udp_push_pending_frames+0x139/0x260
May 22 08:41:52 server [<c023d797>] udp_sendmsg+0x317/0x760
May 22 08:41:52 server [<c0201c0f>] sock_alloc_send_pskb+0xaf/0x1a0
May 22 08:41:52 server [<c024f743>] schedule+0x213/0x660
May 22 08:41:52 server [<c021df30>] ip_generic_getfrag+0x0/0xb0
May 22 08:41:52 server [<c021828d>] __ip_route_output_key+0x1d/0xe0
May 22 08:41:52 server [<c023d797>] udp_sendmsg+0x317/0x760
May 22 08:41:52 server [<c02460ca>] inet_sendmsg+0x4a/0x70
May 22 08:41:52 server [<f9126b9e>] export_decode_fh+0x5e/0xc7 [exportfs]
May 22 08:41:52 server [<f9228140>] nfsd_acceptable+0x0/0x110 [nfsd]
May 22 08:41:52 server [<f9126b40>] export_decode_fh+0x0/0xc7 [exportfs]
May 22 08:41:52 server [<f9228671>] fh_verify+0x421/0x5d0 [nfsd]
May 22 08:41:52 server [<f9228140>] nfsd_acceptable+0x0/0x110 [nfsd]
May 22 08:41:52 server [<f9229a41>] nfsd_open+0x31/0x160 [nfsd]
May 22 08:41:52 server [<f922a192>] nfsd_write+0x62/0x370 [nfsd]
May 22 08:41:52 server [<c0203eb2>] skb_copy_and_csum_bits+0x222/0x300
May 22 08:41:52 server [<c0108379>] do_IRQ+0x199/0x200
May 22 08:41:52 server [<c0106518>] common_interrupt+0x18/0x20
May 22 08:41:52 server [<f9247bfc>] svcauth_unix_accept+0x27c/0x2b0 [sunrpc]
May 22 08:41:52 server [<f92274f7>] nfsd_proc_write+0xa7/0xf0 [nfsd]
May 22 08:41:52 server [<f922ed20>] nfssvc_decode_writeargs+0x0/0xe0 [nfsd]
May 22 08:41:52 server [<f92267ba>] nfsd_dispatch+0x8a/0x1f0 [nfsd]
May 22 08:41:52 server [<f924678d>] svc_authenticate+0x4d/0x90 [sunrpc]
May 22 08:41:52 server [<f924396d>] svc_process+0x56d/0x5fb [sunrpc]
May 22 08:41:52 server [<c0106518>] common_interrupt+0x18/0x20
May 22 08:41:52 server [<f92264d8>] nfsd+0x208/0x460 [nfsd]
May 22 08:41:52 server [<f92262d0>] nfsd+0x0/0x460 [nfsd]
May 22 08:41:52 server [<c0103d75>] kernel_thread_helper+0x5/0x10
May 22 08:41:52 server
May 22 08:41:52 server Code: f9 eb 88 8b 46 1c 89 74 24 04 c7 04 24 50 06 23
f9 89 44 24 08 e8 85 5c ef c6 8b 45 20 eb b2 89 d8 e8 89 7b f4 c6 8b 45 20
eb 99 <0f> 0b 14 01 7f ff 22 f9 e9 1d ff ff ff 8d b4 26 00 00 00 00 83

----
Jim Gifford
maillist@jg555.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWCZCVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWCZCVV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 21:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWCZCVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 21:21:21 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:4574 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751153AbWCZCVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 21:21:20 -0500
Subject: 2.6.15-rt21, BUG at net/ipv4/netfilter/ip_conntrack_core.c:124
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU
Content-Type: text/plain
Date: Sat, 25 Mar 2006 18:20:28 -0800
Message-Id: <1143339628.5527.3.camel@cmn2.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo... I'm seeing a few freezes with 2.6.15-rt21, they seem to be
few and far between and most of the time they don't leave traces behind
in the logs (and the reset button is the only way out). Here's one that
apparently did leave something behind:

Mar 23 15:22:48 host kernel: BUG at
net/ipv4/netfilter/ip_conntrack_core.c:124!
Mar 23 15:22:48 host kernel: ------------[ cut here ]------------
Mar 23 15:22:48 host kernel: kernel BUG at
net/ipv4/netfilter/ip_conntrack_core.c:124!
Mar 23 15:22:48 host kernel: invalid operand: 0000 [#1]
Mar 23 15:22:48 host kernel: PREEMPT SMP 
Mar 23 15:22:48 host kernel: last sysfs
file: /devices/pci0000:00/0000:00:0b.0/0000:01:00.0/modalias
Mar 23 15:22:48 host kernel: Modules linked in: radeon drm parport_pc lp
parport snd_seq_midi(U) autofs4 ipt_REJECT ipt_LOG ipt_state ipt_pkttype
ipt_CONNMARK ipt_MARK ipt_connmark ipt_owner ipt_recent ipt_iprange
ipt_physdev ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc
ip_nat_tftp ip_nat_ftp iptable_nat ip_nat ip_conntrack_irc
ip_conntrack_tftp ip_conntrack_ftp ip_conntrack nfnetlink iptable_filter
ip_tables nfs lockd nfs_acl rfcomm l2cap bluetooth sunrpc dm_mod video
button battery ac ipv6 ohci1394 ieee1394 ohci_hcd ehci_hcd i2c_nforce2
i2c_core snd_intel8x0(U) snd_ac97_codec(U) snd_ac97_bus(U) skge
snd_hdsp(U) snd_rawmidi(U) snd_seq_dummy(U) snd_seq_oss(U)
snd_seq_midi_event(U) snd_seq(U) snd_seq_device(U) snd_pcm_oss(U)
snd_mixer_oss(U) snd_pcm(U) snd_timer(U) snd_page_alloc(U) snd_hwdep(U)
snd(U) soundcore sk98lin floppy ext3 jbd sata_nv sata_sil libata sd_mod
scsi_mod
Mar 23 15:22:48 host kernel: CPU:    1
Mar 23 15:22:48 host kernel: EIP:    0060:[<f8ca8bbe>]    Not tainted
VLI
Mar 23 15:22:48 host kernel: EFLAGS: 00010292
(2.6.15-1.1833.4.rrt.rhfc4.ccrmasmp) 
Mar 23 15:22:48 host kernel: EIP is at __ip_ct_event_cache_init
+0x9b/0xaa [ip_conntrack]
Mar 23 15:22:48 host kernel: eax: 00000036   ebx: c2e34ec0   ecx:
00000000   edx: c335c270
Mar 23 15:22:48 host kernel: esi: f4035888   edi: 00000000   ebp:
f4035888   esp: f7a078d0
Mar 23 15:22:48 host kernel: ds: 007b   es: 007b   ss: 0068   preempt:
00000001
Mar 23 15:22:48 host kernel: Process ardour (pid: 13156,
threadinfo=f7a07000 task=c335c270 stack_left=2200 worst_left=-1)
Mar 23 15:22:48 host kernel: Stack: f8caddad f8cad80c 0000007c c2e24ec0
c044df40 f8caabb5 8bc540ab 97c540ab 
Mar 23 15:22:48 host kernel:        00000000 dfcddd40 00000000 00000808
f4035888 dfcddd40 f7a079dc f4035888 
Mar 23 15:22:49 host kernel:        f8cac890 0002bf20 00000001 f8cb52e0
f4035888 f7a079dc f4035888 f8ca9ffb 
Mar 23 15:22:49 host kernel: Call Trace:
Mar 23 15:22:49 host kernel:  [<f8caabb5>] __ip_ct_refresh_acct
+0x92/0x164 [ip_conntrack] (24)
Mar 23 15:22:49 host kernel:  [<f8cac890>] udp_packet+0x2d/0xc2
[ip_conntrack] (44)
Mar 23 15:22:49 host kernel:  [<f8ca9ffb>] ip_conntrack_in+0x142/0x3a4
[ip_conntrack] (28)
Mar 23 15:22:49 host kernel:  [<c02e958d>] nf_iterate+0x60/0x84 (64)
Mar 23 15:22:49 host kernel:  [<c02f232d>] dst_output+0x0/0x18 (8)
Mar 23 15:22:49 host kernel:  [<c02e9603>] nf_hook_slow+0x52/0xf5 (28)
Mar 23 15:22:49 host kernel:  [<c02f232d>] dst_output+0x0/0x18 (16)
Mar 23 15:22:49 host kernel:  [<c02f501e>] ip_push_pending_frames
+0x315/0x4dd (28)
Mar 23 15:22:49 host kernel:  [<c02f232d>] dst_output+0x0/0x18 (12)
Mar 23 15:22:49 host kernel:  [<c030f3e7>] udp_push_pending_frames
+0x131/0x26b (40)
Mar 23 15:22:49 host kernel:  [<c030f90d>] udp_sendmsg+0x3b0/0x69f (40)
Mar 23 15:22:49 host kernel:  [<c03165bc>] inet_sendmsg+0x2b/0x49 (164)
Mar 23 15:22:49 host kernel:  [<c02c7e93>] sock_sendmsg+0xde/0xf9 (24)
Mar 23 15:22:49 host kernel:  [<c0332e84>] __schedule+0x314/0x9ac (88)
Mar 23 15:22:49 host kernel:  [<c013a864>] autoremove_wake_function
+0x0/0x37 (12)
Mar 23 15:22:49 host kernel:  [<c03336d5>] preempt_schedule_irq
+0x3e/0x58 (68)
Mar 23 15:22:49 host kernel:  [<c02c7ed4>] kernel_sendmsg+0x26/0x2c (48)
Mar 23 15:22:49 host kernel:  [<f8c6929f>] xs_udp_send_request
+0x229/0x396 [sunrpc] (12)
Mar 23 15:22:49 host kernel:  [<c0332e84>] __schedule+0x314/0x9ac (12)
Mar 23 15:22:49 host kernel:  [<f8c68496>] xprt_transmit+0x48/0x1dc
[sunrpc] (88)
Mar 23 15:22:49 host kernel:  [<f8c66bc0>] call_encode+0x94/0xfe
[sunrpc] (12)
Mar 23 15:22:49 host kernel:  [<f8c66f77>] call_transmit+0x47/0xc0
[sunrpc] (32)
Mar 23 15:22:49 host kernel:  [<f8c6b75f>] __rpc_execute+0x5a/0x22d
[sunrpc] (20)
Mar 23 15:22:49 host kernel:  [<c03355db>] lock_kernel+0x1d/0x23 (12)
Mar 23 15:22:49 host kernel:  [<f8cd78c3>] nfs_execute_read+0x34/0x49
[nfs] (12)
Mar 23 15:22:49 host kernel:  [<f8cd7bdb>] nfs_pagein_one+0xe8/0x100
[nfs] (24)
Mar 23 15:22:49 host kernel:  [<f8cd7c35>] nfs_pagein_list+0x42/0x69
[nfs] (28)
Mar 23 15:22:49 host kernel:  [<f8cd81a9>] nfs_readpages+0x86/0xf6 [nfs]
(32)
Mar 23 15:22:49 host kernel:  [<f8cd8123>] nfs_readpages+0x0/0xf6 [nfs]
(48)
Mar 23 15:22:49 host kernel:  [<c0157304>] read_pages+0x2a/0x13d (16)
Mar 23 15:22:49 host kernel:  [<c01575a8>] __do_page_cache_readahead
+0x191/0x1bf (80)
Mar 23 15:22:49 host kernel:  [<c03336d5>] preempt_schedule_irq
+0x3e/0x58 (12)
Mar 23 15:22:49 host kernel:  [<c01576e9>]
blockable_page_cache_readahead+0x53/0xbc (60)
Mar 23 15:22:49 host kernel:  [<c01577ad>] make_ahead_window+0x5b/0x98
(24)
Mar 23 15:22:49 host kernel:  [<c015786f>] page_cache_readahead
+0x85/0x15f (32)
Mar 23 15:22:49 host kernel:  [<c0150e92>] file_read_actor+0x6d/0xd0 (8)
Mar 23 15:22:49 host kernel:  [<c0150d02>] do_generic_mapping_read
+0x412/0x535 (32)
Mar 23 15:22:49 host kernel:  [<c013defd>] hrtimer_interrupt+0x151/0x231
(12)
Mar 23 15:22:49 host kernel:  [<c015106d>] __generic_file_aio_read
+0x178/0x24c (112)
Mar 23 15:22:49 host kernel:  [<c0150e25>] file_read_actor+0x0/0xd0 (12)
Mar 23 15:22:49 host kernel:  [<c015117f>] generic_file_aio_read
+0x3e/0x6b (72)
Mar 23 15:22:49 host kernel:  [<c0170f19>] do_sync_read+0xbb/0x116 (36)
Mar 23 15:22:49 host kernel:  [<c01d0166>] selinux_file_permission
+0xe3/0x15a (56)
Mar 23 15:22:49 host kernel:  [<c013a864>] autoremove_wake_function
+0x0/0x37 (52)
Mar 23 15:22:49 host kernel:  [<c0170e5e>] do_sync_read+0x0/0x116 (40)
Mar 23 15:22:49 host kernel:  [<c0171014>] vfs_read+0xa0/0x158 (4)
Mar 23 15:22:49 host kernel:  [<c017146e>] sys_pread64+0x5e/0x62 (24)
Mar 23 15:22:49 host kernel:  [<c0104241>] syscall_call+0x7/0xb (20)
Mar 23 15:22:49 host kernel: Code: c7 8b 0b eb b9 89 c8 ff 51 04 8d 76
00 eb c4 c7 44 24 08 7c 00 00 00 c7 44 24 04 0c d8 ca f8 c7 04 24 ad dd
ca f8 e8 77 dc 47 c7 <0f> 0b 7c 00 0c d8 ca f8 8b 0b e9 79 ff ff ff 53
a1 ac 75 39 c0 

-- Fernando



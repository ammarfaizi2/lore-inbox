Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVJRPUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVJRPUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 11:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVJRPUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 11:20:15 -0400
Received: from send.forptr.21cn.com ([202.105.45.50]:12940 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1750798AbVJRPUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 11:20:14 -0400
Message-ID: <435512F5.1040502@21cn.com>
Date: Tue, 18 Oct 2005 23:21:25 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [BUG]NULL pointer dereference in ipv6_get_saddr()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I use command "ip -f inet6 route get fec0::1", kernel Oops occurs.
I found it's due to ip_route_output return address of ip6_null_entry, ip6_null_entry.rt6i_idev is NULL.


====================================================================================================
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
e0fc7991
*pde = 1759f067
Oops: 0000 [#1]
Modules linked in: vmnet(U) parport_pc parport vmmon(U) iptable_nat ppp_synctty ppp_async crc_ccitt ppp_generic slhc fglrx(U) kqemu(U) autofs4 ip_conntrack_ftp ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables reiserfs dm_mod video button battery ac ipv6 uhci_hcd ehci_hcd i2c_viapro i2c_core snd_via82xx gameport snd_ac97_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore via_rhine mii ext3 jbd
CPU:    0
EIP:    0060:[<e0fc7991>]    Tainted: P      VLI
EFLAGS: 00010282   (2.6.13-1.1526_FC4) 
EIP is at ipv6_get_saddr+0xd/0x17 [ipv6]
eax: 00000000   ebx: 00000000   ecx: d5786c2c   edx: d5786c80
esi: c38d1ee0   edi: e1005b20   ebp: d187f088   esp: d5786bec
ds: 007b   es: 007b   ss: 0068
Process ip (pid: 11718, threadinfo=d5786000 task=c23a9000)
Stack: badc0ded d5786c2c e0fd22a1 d5786c80 00000000 00000286 d5786c80 d5786c80 
       00000232 d5786c78 d5786c78 e0fd04cb df7458d0 00000000 dfffb920 dfffb920 
       00000030 d5786c90 d5786c78 d5786c80 00000003 00002dc6 ce7e2638 c7b5f400 
Call Trace:
 [<e0fd22a1>] rt6_fill_node+0x428/0x4d5 [ipv6]
 [<e0fd04cb>] ip6_route_output+0xf1/0x2d4 [ipv6]
 [<e0fd2675>] inet6_rtm_getroute+0x125/0x193 [ipv6]
 [<e0fd2550>] inet6_rtm_getroute+0x0/0x193 [ipv6]
 [<c038fe53>] rtnetlink_rcv+0x21b/0x3a4
 [<c03a26b7>] netlink_data_ready+0x12/0x54
 [<c03a1c05>] netlink_sendskb+0x19/0x34
 [<c03a23cc>] netlink_sendmsg+0x26d/0x318
 [<c03781e4>] sock_sendmsg+0xe4/0xff
 [<c01519c2>] autoremove_wake_function+0x0/0x37
 [<c018ca56>] anon_vma_prepare+0x466/0x4ff
 [<c01519c2>] autoremove_wake_function+0x0/0x37
 [<c025e0c4>] copy_from_user+0x4c/0x88
 [<c03799dc>] sys_sendmsg+0x11e/0x213
 [<c0165659>] audit_sockaddr+0x39/0x78
 [<c0185f55>] __handle_mm_fault+0x303/0x4b0
 [<c011e401>] do_page_fault+0x260/0x5cd
 [<c01876f9>] vma_link+0x10d/0x53f
 [<c0379f18>] sys_socketcall+0x270/0x292
 [<c0109b52>] do_syscall_trace+0xef/0x123
 [<c0104465>] syscall_call+0x7/0xb
Code: f3 e8 ff ff e9 8e fe ff ff c7 44 24 04 00 00 00 00 c7 44 24 08 ff ff ff ff e9 94 fe ff ff 53 31 db 85 c0 74 08 8b 80 88 00 00 00 <8b> 18 89 d8 5b e9 a1 fd ff ff 57 56 8b 88 f0 00 00 00 be 9d ff 
 

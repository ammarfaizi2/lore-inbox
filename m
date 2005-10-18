Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVJRPaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVJRPaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 11:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVJRPaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 11:30:12 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:49413 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750716AbVJRPaJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 11:30:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <435512F5.1040502@21cn.com>
References: <435512F5.1040502@21cn.com>
X-OriginalArrivalTime: 18 Oct 2005 15:30:08.0222 (UTC) FILETIME=[D238DFE0:01C5D3F8]
Content-class: urn:content-classes:message
Subject: Re: [BUG]NULL pointer dereference in ipv6_get_saddr()
Date: Tue, 18 Oct 2005 11:30:07 -0400
Message-ID: <Pine.LNX.4.61.0510181128290.27751@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG]NULL pointer dereference in ipv6_get_saddr()
Thread-Index: AcXT+NJAlTXETpGUQJ2X8fzjPTBhNA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Yan Zheng" <yanzheng@21cn.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Oct 2005, Yan Zheng wrote:

> When I use command "ip -f inet6 route get fec0::1", kernel Oops occurs.
> I found it's due to ip_route_output return address of ip6_null_entry, ip6_null_entry.rt6i_idev is NULL.
>
>
> ====================================================================================================
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> printing eip:
> e0fc7991
> *pde = 1759f067
> Oops: 0000 [#1]
> Modules linked in: vmnet(U) parport_pc parport vmmon(U) iptable_nat ppp_synctty ppp_async crc_ccitt ppp_generic slhc fglrx(U) kqemu(U) autofs4 ip_conntrack_ftp ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables reiserfs dm_mod video button battery ac ipv6 uhci_hcd ehci_hcd i2c_viapro i2c_core snd_via82xx gameport snd_ac97_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore via_rhine mii ext3 jbd
> CPU:    0
> EIP:    0060:[<e0fc7991>]    Tainted: P      VLI
> EFLAGS: 00010282   (2.6.13-1.1526_FC4)
> EIP is at ipv6_get_saddr+0xd/0x17 [ipv6]
> eax: 00000000   ebx: 00000000   ecx: d5786c2c   edx: d5786c80
> esi: c38d1ee0   edi: e1005b20   ebp: d187f088   esp: d5786bec
> ds: 007b   es: 007b   ss: 0068
> Process ip (pid: 11718, threadinfo=d5786000 task=c23a9000)
> Stack: badc0ded d5786c2c e0fd22a1 d5786c80 00000000 00000286 d5786c80 d5786c80
>       00000232 d5786c78 d5786c78 e0fd04cb df7458d0 00000000 dfffb920 dfffb920
>       00000030 d5786c90 d5786c78 d5786c80 00000003 00002dc6 ce7e2638 c7b5f400
> Call Trace:
> [<e0fd22a1>] rt6_fill_node+0x428/0x4d5 [ipv6]
> [<e0fd04cb>] ip6_route_output+0xf1/0x2d4 [ipv6]
> [<e0fd2675>] inet6_rtm_getroute+0x125/0x193 [ipv6]
> [<e0fd2550>] inet6_rtm_getroute+0x0/0x193 [ipv6]
> [<c038fe53>] rtnetlink_rcv+0x21b/0x3a4
> [<c03a26b7>] netlink_data_ready+0x12/0x54
> [<c03a1c05>] netlink_sendskb+0x19/0x34
> [<c03a23cc>] netlink_sendmsg+0x26d/0x318
> [<c03781e4>] sock_sendmsg+0xe4/0xff
> [<c01519c2>] autoremove_wake_function+0x0/0x37
> [<c018ca56>] anon_vma_prepare+0x466/0x4ff
> [<c01519c2>] autoremove_wake_function+0x0/0x37
> [<c025e0c4>] copy_from_user+0x4c/0x88
> [<c03799dc>] sys_sendmsg+0x11e/0x213
> [<c0165659>] audit_sockaddr+0x39/0x78
> [<c0185f55>] __handle_mm_fault+0x303/0x4b0
> [<c011e401>] do_page_fault+0x260/0x5cd
> [<c01876f9>] vma_link+0x10d/0x53f
> [<c0379f18>] sys_socketcall+0x270/0x292
> [<c0109b52>] do_syscall_trace+0xef/0x123
> [<c0104465>] syscall_call+0x7/0xb
> Code: f3 e8 ff ff e9 8e fe ff ff c7 44 24 04 00 00 00 00 c7 44 24 08 ff ff ff ff e9 94 fe ff ff 53 31 db 85 c0 74 08 8b 80 88 00 00 00 <8b> 18 89 d8 5b e9 a1 fd ff ff 57 56 8b 88 f0 00 00 00 be 9d ff
>

Same with linux-2.6.14.4

Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
f0928630
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: nls_iso8859_1 vfat floppy snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc soundcore parport_pc lp parport nfsd exportfs lockd sunrpc e100 mii ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables microcode nls_cp437 msdos fat dm_mod uhci_hcd ehci_hcd video container button battery ac rtc ipv6 ext3 jbd ata_piix libata aic7xxx scsi_transport_spi sd_mod scsi_mod
CPU:    0
EIP:    0060:[<f0928630>]    Not tainted VLI
EFLAGS: 00010286   (2.6.13.4)
EIP is at ipv6_get_saddr+0x10/0x20 [ipv6]
eax: 00000000   ebx: dab29bbc   ecx: 00000000   edx: f095b760
esi: d8e69b80   edi: e3b49078   ebp: f095b760   esp: dab29ba0
ds: 007b   es: 007b   ss: 0068
Process ip (pid: 27746, threadinfo=dab28000 task=ee2f2020)
Stack: f093115b f095b760 dab29c34 dab29bbc dab29c34 dab29bb8 00000282 dab29c34
        d8e69b80 00000000 d8e69b80 f092efc4 f095b838 dab29c34 dab29c44 00000014
        dab29c44 dab29c34 00000003 d8e69b80 ffffffa6 00000000 dab29c2c f0931635
Call Trace:
  [<f093115b>] rt6_fill_node+0x43b/0x560 [ipv6]
  [<f092efc4>] ip6_route_output+0x114/0x360 [ipv6]
  [<f0931635>] inet6_rtm_getroute+0x135/0x1c0 [ipv6]
  [<c02e83a7>] rtnetlink_rcv+0x307/0x3d0
  [<c02f587b>] netlink_data_ready+0x6b/0x70
  [<c02f4c12>] netlink_sendskb+0x32/0x60
  [<c02f54ba>] netlink_sendmsg+0x20a/0x340
  [<c02f579c>] netlink_recvmsg+0x1ac/0x220
  [<c02d3a05>] sock_sendmsg+0x115/0x120
  [<c018477c>] update_atime+0x9c/0xd0
  [<c02d3a05>] sock_sendmsg+0x115/0x120
  [<c01e25ac>] copy_from_user+0x6c/0xb0
  [<c0135f10>] autoremove_wake_function+0x0/0x60
  [<c02d578f>] sys_sendmsg+0x18f/0x1f0
  [<c02d3408>] move_addr_to_kernel+0x48/0x70
  [<c0157ccd>] __handle_mm_fault+0x11d/0x1a0
  [<c015ad3e>] do_brk+0x22e/0x2e0
  [<c01e25ac>] copy_from_user+0x6c/0xb0
  [<c02d5c52>] sys_socketcall+0x262/0x280
  [<c010314b>] sysenter_past_esp+0x54/0x75
Code: c5 fe ff ff 89 14 24 e8 3f f3 ff ff eb ce 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 54 24 04 31 c0 85 d2 74 08 8b 82 88 00 00 00 <8b> 00 89 44 24 04 e9 75 fd ff ff 90 8d 74 26 00 55 b8 34 af 95



Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.46 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

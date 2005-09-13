Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVIMKdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVIMKdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 06:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVIMKdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 06:33:01 -0400
Received: from main.gmane.org ([80.91.229.2]:21633 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750796AbVIMKdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 06:33:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nuutti Kotivuori <naked@iki.fi>
Subject: Re: netfilter QUEUE target and packet socket interactions buggy or not
Date: Tue, 13 Sep 2005 13:54:05 +0300
Organization: Ye 'Ol Disorganized NNTPCache groupie
Message-ID: <877jdl9r1u.fsf@aka.i.naked.iki.fi>
References: <87fysa9bqt.fsf@aka.i.naked.iki.fi>
	<20050912.151120.104514011.davem@davemloft.net>
	<87br2xap9o.fsf@aka.i.naked.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: naked.iki.fi
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
Cancel-Lock: sha1:rw9zcyqqlEF33CzIJ0jZUbCmK2s=
Cache-Post-Path: aka.i.naked.iki.fi!unknown@aka.i.naked.iki.fi
X-Cache: nntpcache 3.0.1 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuutti Kotivuori wrote:
> David S. Miller wrote:
>> Please use the tg3 driver that actually comes with
>> the kernel :-)

[...]

> I am doubtful the network card driver would be at fault here, but
> that'll be confirmed once I manage to narrow this down more.

Appended here is a backtrace with the tg3 driver. Also, it seems that
the bug cannot be reproduced with uniprocessor, only SMP.

Unable to handle kernel NULL pointer dereference at virtual address 00000018
 printing eip:
c01a387f
*pde = 36ee0001
Oops: 0000 [#1]
SMP
Modules linked in: arpt_mangle arptable_filter arp_tables iptable_filter ip_tables ip_queue parport_pc lp parport netconsole netdump autofs4 i2c_dev i2c_core sunrpc dm_mod button battery acEIP is at selinux_ip_postroute_last+0x6a/0x1de
eax: 00000000   ebx: 00000000   ecx: f7a91bb0   edx: 00000003
esi: efb8f080   edi: c0455780   ebp: 00000004   esp: f7a91b8c
ds: 007b   es: 007b   ss: 0068
Process dispatcher (pid: 2748, threadinfo=f7a91000 task=f31ed830)
Stack: 00000000 e9011280 00000000 e9bfdb80 00000002 f88a965a 01ade49e 00000000
       00000206 000000f5 f88a983c c026f163 f6878680 f7538b68 c02c3188 000000c7
       00000042 00000206  [<f88a965a>] tg3_start_xmit+0x27e/0x476 [tg3]
 [<f88a983c>] tg3_start_xmit+0x460/0x476 [tg3] __kfree_skb+0xf4/0xf7
 [<c02c3188>] packet_rcv+0x2ca/0x2d4
 [<c011d270>] find_busiest_group+0xf1/0x2e0
 [<c01a3a02>] selinux_ipv4_postroute_last+0xf/0x13
 [<c028d11f>] ip_finish_output2+0x0/0x16d
 [<c027cb23>] nf_iterate+0x40/0x81
 [<c028d11f>] ip_finish_output2+0x0/0x16d
 [<c027ce21>] nf_hook_slow+0x47/0xb4
 [<c028d11f>] ip_finish_output2+0x0/0x16d
 [<c028d116>] ip_finish_output+0x1a5/0x1ae
 [<c028d11f>] ip_finish_output2+0x0/0x16d
 [<c028cf66>] dst_output+0xf/0x1a
 [<c027cfdb>] nf_reinject+0x14d/0x1a9
 [<f891401e>] ipq_issue_verdict+0x1e/0x2b [ip_queue]
 [<f8914676>] ipq_set_verdict+0x53/0x5a [ip_queue]
 [<f891472c>] ipq_receive_peer+0x3d/0x46 [ip_queue]
 [<f891487d>] ipq_rcv_sk+0xfc/0x175 [ip_queue]
 [<c0285b11>] netlink_data_ready+0x14/0x44
 [<c028525b>] netlink_sendskb+0x52/0x6c
 [<c028592c>] netlink_sendmsg+0x254/0x263
 [<c011dcf5>] __wake_up+0x29/0x3c
 [<c026b92d>] sock_sendmsg+0xdb/0xf7
 [<c0285ae9>] netlink_recvmsg+0x1ae/0x1c2
 [<c026ba64>] sock_recvmsg+0xef/0x10c
 [<c011f6ee>] autoremove_wake_function+0x0/0x2d
 [<c02709ba>] verify_iovec+0x76/0xc2
 [<c026d07c>] sys_sendmsg+0x1ee/0x23b
 [<c026b4fe>] move_addr_to_user+0x67/0x7f
 [<c02c7d56>] reschedule_interrupt+0x1a/0x20
 [<c01116de>] sched_clock+0x46/0x73
 [<c011caf1>] finish_task_switch+0x30/0x66
 [<c02c5604>] schedule+0x844/0x87a
 [<c026d465>] sys_socketcall+0x1c1/0x1dd
 [<c0125351>] sys_gettimeofday+0x53/0xac
 [<c02c7377>] syscall_call+0x7/0xb
 [<c02c007b>] unix_release_sock+0x15a/0x201
Code: 89 d3 83 c3 2c 0f 84 8c 01 00 00 8b 44 24 7c 31 c9 8d 54 24 24 e8 df 29 00 00 85 c0 0f 85

-- Naked


Return-Path: <linux-kernel-owner+w=401wt.eu-S1755165AbWL2D7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbWL2D7d (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 22:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182AbWL2D7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 22:59:32 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:20174 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbWL2D71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 22:59:27 -0500
Subject: BUG: at arch/i386/mm/highmem.c:50 kmap_atomic()
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 28 Dec 2006 19:58:40 -0800
Message-Id: <1167364720.14081.57.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Got several of the messages below on 2.6.20-rc2-mm1 .


Dec 29 03:34:08 10 kernel: [  264.519401] BUG: at arch/i386/mm/highmem.c:50 kmap_atomic()
Dec 29 03:34:08 10 kernel: [  264.524973]  [<c0105206>] show_trace_log_lvl+0x1a/0x2f
Dec 29 03:34:08 10 kernel: [  264.530129]  [<c01057cf>] show_trace+0x12/0x14
Dec 29 03:34:08 10 kernel: [  264.534583]  [<c0105853>] dump_stack+0x16/0x18
Dec 29 03:34:08 10 kernel: [  264.539030]  [<c0125610>] kmap_atomic+0xcc/0x1e4
Dec 29 03:34:08 10 kernel: [  264.543668]  [<c1166548>] skb_copy_and_csum_bits+0x13f/0x31a
Dec 29 03:34:08 10 kernel: [  264.549340]  [<c1167767>] skb_copy_and_csum_dev+0x94/0xcc
Dec 29 03:34:08 10 kernel: [  264.554741]  [<c08c0c91>] rtl8139_start_xmit+0x73/0x12b
Dec 29 03:34:08 10 kernel: [  264.559987]  [<c116b948>] dev_hard_start_xmit+0x21c/0x29d
Dec 29 03:34:08 10 kernel: [  264.565395]  [<c118776a>] __qdisc_run+0x107/0x1d2
Dec 29 03:34:08 10 kernel: [  264.570104]  [<c116d42a>] dev_queue_xmit+0x15c/0x26e
Dec 29 03:34:08 10 kernel: [  264.575071]  [<c11c59aa>] ip_output+0x20b/0x245
Dec 29 03:34:08 10 kernel: [  264.579622]  [<c11c3290>] ip_push_pending_frames+0x338/0x422
Dec 29 03:34:08 10 kernel: [  264.585285]  [<c11df1b7>] udp_push_pending_frames+0x2b9/0x2db
Dec 29 03:34:08 10 kernel: [  264.591034]  [<c11e0507>] udp_sendmsg+0x496/0x5e8
Dec 29 03:34:08 10 kernel: [  264.595759]  [<c11e5977>] inet_sendmsg+0x3e/0x49
Dec 29 03:34:08 10 kernel: [  264.600381]  [<c1161943>] sock_sendmsg+0xe7/0x104
Dec 29 03:34:08 10 kernel: [  264.605093]  [<c1162ba2>] kernel_sendmsg+0x28/0x37
Dec 29 03:34:08 10 kernel: [  264.609889]  [<c12c08c3>] xs_send_kvec+0x73/0x7b
Dec 29 03:34:08 10 kernel: [  264.614514]  [<c12c0a6a>] xs_sendpages+0x19f/0x1c4
Dec 29 03:34:08 10 kernel: [  264.619325]  [<c12c1cd0>] xs_udp_send_request+0x40/0xf6
Dec 29 03:34:08 10 kernel: [  264.624554]  [<c12bfae5>] xprt_transmit+0xdb/0x1d9
Dec 29 03:34:08 10 kernel: [  264.629349]  [<c12bd4a9>] call_transmit+0x1fc/0x228
Dec 29 03:34:08 10 kernel: [  264.634232]  [<c12c328d>] __rpc_execute+0x9b/0x20d
Dec 29 03:34:08 10 kernel: [  264.639026]  [<c12c3429>] rpc_execute+0x1b/0x1e
Dec 29 03:34:08 10 kernel: [  264.643575]  [<c0353c06>] nfs_execute_write+0x36/0x46
Dec 29 03:34:08 10 kernel: [  264.648628]  [<c03552cc>] nfs_flush_one+0xc4/0x109
Dec 29 03:34:08 10 kernel: [  264.653427]  [<c0353813>] nfs_flush_list+0x82/0xce
Dec 29 03:34:08 10 kernel: [  264.658221]  [<c0354504>] nfs_sync_mapping_wait+0x111/0x1fe
Dec 29 03:34:08 10 kernel: [  264.663803]  [<c0354d9c>] nfs_wb_all+0x53/0x6f
Dec 29 03:34:08 10 kernel: [  264.668254]  [<c034b6d5>] nfs_file_flush+0x44/0x77
Dec 29 03:34:08 10 kernel: [  264.673059]  [<c018d18a>] filp_close+0x35/0x5c
Dec 29 03:34:08 10 kernel: [  264.677509]  [<c0199f96>] sys_dup2+0xd0/0xfc
Dec 29 03:34:08 10 kernel: [  264.681789]  [<c01041dc>] syscall_call+0x7/0xb



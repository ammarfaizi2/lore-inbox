Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUCUJ6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 04:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUCUJ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 04:58:41 -0500
Received: from mail.epost.de ([193.28.100.187]:33413 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id S263624AbUCUJ6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 04:58:38 -0500
From: Gregor Jasny <Gregor.Jasny@epost.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [ISDN] Badness in local_bh_enable at kernel/softirq.c:122
Date: Sun, 21 Mar 2004 10:58:49 +0100
User-Agent: KMail/1.5.4
Cc: Karsten Keil <kkeil@suse.de>
X-PGP-fingerprint: 5A65 E2CC EB06 F110 4F45  AB34 DE58 C135 1361 35BD
X-PGP-public-key: finger gjasny@hell.wh8.tu-dresden.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403211058.49778.Gregor.Jasny@epost.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my ISDN Router (running with vanilla 2.6.4 / gcc-3.3) I get lots of this 
error messages. They vary from time to time, but  isdn_ppp_xmit is always on 
top of the list. My system is a P4 with Hyperthreading (SMP) and preemption 
enabled. My NIC is a 3C200 (sk98lin). Accessing the Internet from the LAN is 
nearly impossible. From the router itself it's OK.

Please contact me if you need more info.

Regards,
-G. Jasny

Badness in local_bh_enable at kernel/softirq.c:122
Call Trace:
 [local_bh_enable+140/142] local_bh_enable+0x8c/0x8e
 [_end+944915077/1068922016] isdn_ppp_xmit+0x123/0x7c5 [isdn]
 [_end+945069245/1068922016] ip_nat_cheat_check+0x34/0x4c [iptable_nat]
 [_end+944844645/1068922016] isdn_net_xmit+0x223/0x26e [isdn]
 [_end+945069245/1068922016] ip_nat_cheat_check+0x34/0x4c [iptable_nat]
 [_end+944845808/1068922016] isdn_net_start_xmit+0x33a/0x34d [isdn]
 [qdisc_restart+343/543] qdisc_restart+0x157/0x21f
 [dev_queue_xmit+576/751] dev_queue_xmit+0x240/0x2ef
 [neigh_connected_output+182/254] neigh_connected_output+0xb6/0xfe
 [ip_finish_output2+231/445] ip_finish_output2+0xe7/0x1bd
 [ip_finish_output2+0/445] ip_finish_output2+0x0/0x1bd
 [nf_hook_slow+248/327] nf_hook_slow+0xf8/0x147
 [ip_finish_output2+0/445] ip_finish_output2+0x0/0x1bd
 [ip_finish_output+529/534] ip_finish_output+0x211/0x216
 [ip_finish_output2+0/445] ip_finish_output2+0x0/0x1bd
 [ip_forward_finish+51/89] ip_forward_finish+0x33/0x59
 [nf_hook_slow+248/327] nf_hook_slow+0xf8/0x147
 [ip_forward_finish+0/89] ip_forward_finish+0x0/0x59
 [ip_forward+461/679] ip_forward+0x1cd/0x2a7
 [ip_forward_finish+0/89] ip_forward_finish+0x0/0x59
 [ip_rcv_finish+513/639] ip_rcv_finish+0x201/0x27f
 [ip_rcv_finish+0/639] ip_rcv_finish+0x0/0x27f
 [nf_hook_slow+248/327] nf_hook_slow+0xf8/0x147
 [ip_rcv_finish+0/639] ip_rcv_finish+0x0/0x27f
 [ip_rcv+1047/1246] ip_rcv+0x417/0x4de
 [ip_rcv_finish+0/639] ip_rcv_finish+0x0/0x27f
 [netif_receive_skb+365/422] netif_receive_skb+0x16d/0x1a6
 [_end+945790282/1068922016] FillRxDescriptor+0x25/0xb0 [sk98lin]
 [process_backlog+126/267] process_backlog+0x7e/0x10b
 [net_rx_action+133/289] net_rx_action+0x85/0x121
 [do_softirq+192/194] do_softirq+0xc0/0xc2
 [do_IRQ+318/402] do_IRQ+0x13e/0x192
 [_end+945069245/1068922016] ip_nat_cheat_check+0x34/0x4c [iptable_nat]
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [_end+945069245/1068922016] ip_nat_cheat_check+0x34/0x4c [iptable_nat]


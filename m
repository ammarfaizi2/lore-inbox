Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVAVQFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVAVQFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 11:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVAVQFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 11:05:24 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:7892 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S262491AbVAVQFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 11:05:01 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200501221604.j0MG4vnm001308@clem.clem-digital.net>
Subject: ppp in 2.6.11-rc2 Badness in local_bh_enable at kernel/softirq.c
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sat, 22 Jan 2005 11:04:57 -0500 (EST)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
Get the following with 2.6.11-rc2 and ppp (pppoe), continuous. 
Non-ppp boxes fine.  Last prior kernel 2.6.11-rc1-bk5 is good
(have not tried bk6 - bk9).

 Badness in local_bh_enable at kernel/softirq.c:140
  [local_bh_enable+44/104] local_bh_enable+0x2c/0x68
  [ppp_async_push+358/372] ppp_async_push+0x166/0x174
  [ppp_async_send+13/72] ppp_async_send+0xd/0x48
  [ppp_push+70/176] ppp_push+0x46/0xb0
  [ppp_send_frame+941/992] ppp_send_frame+0x3ad/0x3e0
  [ppp_xmit_process+54/172] ppp_xmit_process+0x36/0xac
  [ppp_start_xmit+459/520] ppp_start_xmit+0x1cb/0x208
  [qdisc_restart+102/236] qdisc_restart+0x66/0xec
  [dev_queue_xmit+199/476] dev_queue_xmit+0xc7/0x1dc
  [ip_finish_output+340/456] ip_finish_output+0x154/0x1c8
  [ip_forward_finish+0/68] ip_forward_finish+0x0/0x44
  [ip_output+86/92] ip_output+0x56/0x5c
  [ip_forward_finish+37/68] ip_forward_finish+0x25/0x44
  [nf_hook_slow+165/240] nf_hook_slow+0xa5/0xf0
  [ip_forward+492/572] ip_forward+0x1ec/0x23c
  [ip_forward_finish+0/68] ip_forward_finish+0x0/0x44
  [ip_rcv+881/1024] ip_rcv+0x371/0x400
  [netif_receive_skb+284/332] netif_receive_skb+0x11c/0x14c
  [process_backlog+112/248] process_backlog+0x70/0xf8
  [net_rx_action+118/244] net_rx_action+0x76/0xf4
  [gcc2_compiled.+58/136] __do_softirq+0x3a/0x88
  [do_softirq+34/44] do_softirq+0x22/0x2c
  [irq_exit+39/40] irq_exit+0x27/0x28
  [do_IRQ+33/40] do_IRQ+0x21/0x28
  [common_interrupt+26/32] common_interrupt+0x1a/0x20
  [default_idle+0/52] default_idle+0x0/0x34
  [default_idle+38/52] default_idle+0x26/0x34
  [cpu_idle+69/88] cpu_idle+0x45/0x58
  [stext+26/28] _stext+0x1a/0x1c
  [start_kernel+326/328] start_kernel+0x146/0x148

-- 
Pete Clements 

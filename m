Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUDPFzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUDPFzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:55:44 -0400
Received: from ind-iport-1-sec.cisco.com ([64.104.129.9]:15229 "EHLO
	ind-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262488AbUDPFzj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:55:39 -0400
X-BrightmailFiltered: true
Content-Type: text/plain;
  charset="us-ascii"
From: "N.C.Krishna Murthy" <krmurthy@cisco.com>
To: saw@saw.sw.com.sg
Subject: N/W Card ceases to function after page allocation failure
Date: Fri, 16 Apr 2004 11:24:26 +0530
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, "Manish Kumar Bhojasia" <mbhojasi@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200404161124.26930.krmurthy@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I was testing our iSCSI initiator driver on linux-2.6.4. The host 
machine had Ethernet Pro 100 ethernet cards using which iSCSI sessions were 
established. Few minutes after starting I/O on iSCSI disks the following 
messages started appearing on the console:

Apr 12 12:04:10 linux-2 kernel: iscsi-tx: page allocation failure. order:0, 
mode:0x20
Apr 12 12:04:10 linux-2 kernel: Call Trace:
Apr 12 12:04:10 linux-2 kernel:  [<c014b25b>] __alloc_pages+0x33b/0x3d0
Apr 12 12:04:11 linux-2 kernel:  [<c01212b5>] scheduler_tick+0x105/0x680
Apr 12 12:04:11 linux-2 kernel:  [<c014b317>] __get_free_pages+0x27/0x40
Apr 12 12:04:11 linux-2 kernel:  [<c014f46c>] inet_sendmsg+0x4b/0x60
Apr 12 12:04:11 linux-2 kernel:  [<c032710b>] cache_grow+0xdc/0x3b0
Apr 12 12:04:11 linux-2 kernel:  [<c014f85d>] cache_alloc_refill+0x11d/0x530
Apr 12 12:04:11 linux-2 kernel:  [<c010bff2>] apic_timer_interrupt+0x1a/0x20
Apr 12 12:04:11 linux-2 kernel:  [<c0150415>] kmem_cache_alloc+0x205/0x230
Apr 12 12:04:11 linux-2 kernel:  [<c032b343>] sock_sendmsg+0xcb/0xd0
Apr 12 12:04:11 linux-2 kernel:  [<c011b6dd>] 
smp_apic_timer_interrupt+0xcd/0x140
Apr 12 12:04:11 linux-2 kernel:  [<c010bff2>] apic_timer_interrupt+0x1a/0x20
Apr 12 12:04:11 linux-2 kernel:  [<e0900430>] iscsi_sendmsg+0x60/0x70 
[iscsi_sfnet]
Apr 12 12:04:11 linux-2 kernel:  [<e08fd825>] iscsi_xmit_task+0x1f5/0xa10 
[iscsi_sfnet]
Apr 12 12:04:11 linux-2 kernel:  [<c011b6dd>] 
smp_apic_timer_interrupt+0xcd/0x140
Apr 12 12:04:11 linux-2 kernel:  [<c010bff2>] apic_timer_interrupt+0x1a/0x20
Apr 12 12:04:11 linux-2 kernel:  [<e0900430>] iscsi_sendmsg+0x60/0x70 
[iscsi_sfnet]
Apr 12 12:04:11 linux-2 kernel:  [<e08e59fb>] kunmap_sg+0x1b/0x20 
[iscsi_sfnet]
Apr 12 12:04:11 linux-2 kernel:  [<e09054a0>] iscsi_xmit_data+0x520/0x940 
[iscsi_sfnet]
Apr 12 12:04:11 linux-2 kernel:  [<c010df30>] do_IRQ+0x120/0x230
Apr 12 12:04:11 linux-2 kernel:  [<e08fabfa>] alloc_task+0x5a/0x100 
[iscsi_sfnet]
Apr 12 12:04:11 linux-2 kernel:  [<e08fabfa>] alloc_task+0x5a/0x100 
[iscsi_sfnet]
Apr 12 12:04:11 linux-2 kernel:  [<e08faea9>] add_session_task+0x39/0x60 
[iscsi_sfnet]
Apr 12 12:04:11 linux-2 kernel:  [<e0904b61>] 
iscsi_xmit_queued_cmnds+0x2d1/0x6f0 [iscsi_sfnet]
Apr 12 12:04:11 linux-2 kernel:  [<e08e6400>] iscsi_tx_thread+0x850/0xbc0 
[iscsi_sfnet]
Apr 12 12:04:12 linux-2 kernel:  [<c010913d>] kernel_thread_helper+0x5/0x18
Apr 12 12:04:12 linux-2 kernel:
Apr 12 12:04:12 linux-2 kernel: speedo_rx+0x265/0x380
Apr 12 12:04:12 linux-2 kernel:  [<c026466e>] speedo_interrupt+0x2ee/0x310
Apr 12 12:04:12 linux-2 kernel:  [<c014f262>] cache_init_objs+0xe2/0x1e0
Apr 12 12:04:12 linux-2 kernel:  [<c010da9b>] handle_IRQ_event+0x3b/0x70
Apr 12 12:04:12 linux-2 kernel:  [<c010def2>] do_IRQ+0xe2/0x230
Apr 12 12:04:12 linux-2 kernel:  [<c010bf70>] common_interrupt+0x18/0x20
Apr 12 12:04:12 linux-2 kernel:  [<c011007b>] handle_vm86_fault+0x6ab/0xa70
Apr 12 12:04:12 linux-2 kernel:  [<c015026b>] kmem_cache_alloc+0x5b/0x230
Apr 12 12:04:12 linux-2 kernel:  [<c032b343>] alloc_skb+0x23/0xf0
Apr 12 12:04:12 linux-2 kernel:  [<c0356a49>] tcp_sendmsg+0x1149/0x13f0
Apr 12 12:04:12 linux-2 kernel:  [<c034bca6>] ip_rcv+0x3b6/0x550
Apr 12 12:04:12 linux-2 kernel:  [<c037ab9b>] inet_sendmsg+0x4b/0x60
Apr 12 12:04:12 linux-2 kernel:  [<c032710b>] sock_sendmsg+0xcb/0xd0
Apr 12 12:04:12 linux-2 kernel:  [<c011b6dd>] 
smp_apic_timer_interrupt+0xcd/0x140
Apr 12 12:04:12 linux-2 kernel:  [<c010bf70>] common_interrupt+0x18/0x20
Apr 12 12:04:12 linux-2 kernel:  [<e0900430>] iscsi_sendmsg+0x60/0x70 
[iscsi_sfnet]
Apr 12 12:04:12 linux-2 kernel:  [<e0905419>] iscsi_xmit_data+0x499/0x940 
[iscsi_sfnet]
Apr 12 12:04:12 linux-2 kernel:  [<c0330e80>] net_rx_action+0x80/0x120
Apr 12 12:04:13 linux-2 kernel:  [<c010df85>] do_IRQ+0x175/0x230
Apr 12 12:04:13 linux-2 kernel:  [<e09059ff>] iscsi_xmit_r2t_data+0x13f/0x310 
[iscsi_sfnet]
Apr 12 12:04:13 linux-2 kernel:  [<e08e63f6>] iscsi_tx_thread+0x846/0xbc0 
[iscsi_sfnet]
Apr 12 12:04:13 linux-2 kernel:  [<c0121fc0>] default_wake_function+0x0/0x20
Apr 12 12:04:13 linux-2 kernel:  [<c0121fc0>] default_wake_function+0x0/0x20
Apr 12 12:04:13 linux-2 kernel:  [<e08e5bb0>] iscsi_tx_thread+0x0/0xbc0 
[iscsi_sfnet]
Apr 12 12:04:13 linux-2 kernel:  [<c010913d>] kernel_thread_helper+0x5/0x18
Apr 12 12:04:13 linux-2 kernel:
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 1)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 1)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 1)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 1)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 1)!
Apr 12 12:04:13 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 1)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 1)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 1)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 1)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 1)!
Apr 12 12:04:14 linux-2 kernel: eth1: can't fill rx buffer (force 0)!
Apr 12 12:04:17 linux-2 kernel: eth1: RxAbort command stalled


--------------------------------------------------------------------------------
After this eth1  ceased to function until the system was rebooted.
Even ping failed. 

I tried the same test on another machine which had a different n/w card.
Though I saw messages about page allocation failure, the card continued to 
function normally.

I was wondering if this is a bug in ethernet pro 100 driver. Please let 
me know in case I am wrong.
Thanx
N.C.Krishna Murthy

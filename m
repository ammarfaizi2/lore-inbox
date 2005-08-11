Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVHKLsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVHKLsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVHKLsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:48:38 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:65507 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S932278AbVHKLsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:48:37 -0400
Date: Thu, 11 Aug 2005 15:48:36 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.6.13-rc5 panic with tg3, e1000, vlan, tso
Message-ID: <20050811114835.GB3543@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.11-ac7
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Today my gateway crashed.
I wrote down crash info on a paper.
It's not complete since only last 25 lines were shown,
but complete stackdump is here (I omitted hexadecimal values).

Call Trace: <IRQ>
    tcp_write_xmit+318
    __tcp_push_pending_frames+45
    tcp_rcv_established+1948
    tcp_v4_do_rcv+35
    tcp_v4_rcv+1444
    nf_hook_slow+125
    ip_local_deliver_finish+0
    ip_local_deliver+389
    ip_rcv+1187
    packet_rcv_spkt+608
    netif_receive_skb+478
    e1000_clean_rx_irq+1165
    tg3_vlan_rx+364
    tg3_tx+328
    e1000_clean+74
    net_rx_action+171
    __do_softirq+53
    do_IRQ+79
    ret_from_intr+0
    <EOI>
    thread_return+0
    thread_return+86
    default_idle+36
    cpu_idle+79
RIP: {tcp_tso_should_defer+73}
Code: 0f 0b a3 7c 9d 42 80 ff ff ff ff c2 96 03 8b be 2c 03 00 00
Aiee, killing interrupt handler!

Before the call trace there was some 64-bit values.

The box is dual Opteron with 2G RAM, with 64-bit kernel and mixed userland.
There are 2 tg3 interfaces (on-board), 3 e1000 ones, and 2 e100's in it.

After reboot, I disabled TSO (on e1000 NICs)  via ethtool.

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 


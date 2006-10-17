Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWJQNuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWJQNuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWJQNuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:50:15 -0400
Received: from web57810.mail.re3.yahoo.com ([68.142.236.88]:18861 "HELO
	web57810.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1750958AbWJQNuO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:50:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=k444AKpFMsa1D/RVpMdQjNusOivZ8dTxP1Xvs+OBe72a0WaBx1S/egGilrD8kZb1NkUJ2vFUNFi+XcTq13IOLWNut7AaF7gBhS2NN20Sn+jPHY/2NK6TVO99pEpcQs83KdI7yE/zDZvku85rWgdC2c72RpUbF1CdCRa45AN3xA0=  ;
Message-ID: <20061017135013.19302.qmail@web57810.mail.re3.yahoo.com>
Date: Tue, 17 Oct 2006 06:50:12 -0700 (PDT)
From: John Philips <johnphilips42@yahoo.com>
Subject: BUG: warning at kernel/softirq.c:141/local_bh_enable()
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently upgraded some router/NAT devices from 2.4.25 to 2.6.17.8.  They're using VIA C3 processors and NatSemi DP83815 NICs.

Right after the upgrade I started noticing these error messages on one of the heavier-loaded boxes.  This particular box routes and does NAT for around 400 users, peaking at 6Mb/sec of throughput.

The errors were happening about every 3-5 minutes.  I statically set eth6 to 100baseTX-FD with mii-tool, and now the errors appear every few hours for 10-20 minute stretches.

I searched Google and couldn't find any insight (FYI, I'm NOT using the CIPE patches).

Any ideas?

Oct 16 16:51:32 localhost kernel: NETDEV WATCHDOG: eth6: transmit timed out
Oct 16 16:51:32 localhost kernel: eth6: Transmit timed out, status 0x000000, resetting...
Oct 16 16:51:32 localhost kernel: eth6: DSPCFG accepted after 0 usec.
Oct 16 16:51:32 localhost kernel: eth6: Setting full-duplex based on negotiated link capability.
Oct 16 16:51:36 localhost kernel: NETDEV WATCHDOG: eth6: transmit timed out
Oct 16 16:51:36 localhost kernel: eth6: Transmit timed out, status 0x000000, resetting...
Oct 16 16:51:36 localhost kernel: eth6: DSPCFG accepted after 0 usec.
Oct 16 16:51:36 localhost kernel: eth6: Setting full-duplex based on negotiated link capability.
Oct 16 16:51:43 localhost kernel: eth6: Transmit timed out, status 0x000000, resetting...
Oct 16 16:51:43 localhost kernel: NETDEV WATCHDOG: eth6: transmit timed out
Oct 16 16:51:43 localhost kernel: BUG: warning at kernel/softirq.c:141/local_bh_enable()
Oct 16 16:51:43 localhost kernel: <c029a975> __kfree_skb+0xa5/0x120  <c0236790> drain_tx+0x20/0x40
Oct 16 16:51:43 localhost kernel: <c011c0fb> local_bh_enable+0x6b/0x70  <c0310bd1> destroy_conntrack+0x31/0xe0
Oct 16 16:51:43 localhost kernel: <c02367bf> reinit_ring+0xf/0x50  <c0237fdf> tx_timeout+0x4f/0xe0
Oct 16 16:51:43 localhost kernel: <c0105d67> timer_interrupt+0x67/0x70  <c02aa500> dev_watchdog+0x0/0xb0
Oct 16 16:51:43 localhost kernel: <c011bf52> __do_softirq+0x42/0x90  <c011bfc6> do_softirq+0x26/0x30
Oct 16 16:51:43 localhost kernel: <c02aa5a0> dev_watchdog+0xa0/0xb0  <c011f3f9> run_timer_softirq+0x129/0x170
Oct 16 16:51:43 localhost kernel: <c0101cab> default_idle+0x2b/0x60  <c0101d1a> cpu_idle+0x3a/0x50
Oct 16 16:51:43 localhost kernel: <c0104a1e> do_IRQ+0x1e/0x30  <c0102d8a> common_interrupt+0x1a/0x20
Oct 16 16:51:43 localhost kernel: <c0408676> start_kernel+0x1e6/0x2b0  <c0408220> unknown_bootoption+0x0/0x270
Oct 16 16:51:43 localhost kernel: BUG: warning at kernel/softirq.c:141/local_bh_enable()
Oct 16 16:51:43 localhost kernel: <c029a975> __kfree_skb+0xa5/0x120  <c0236790> drain_tx+0x20/0x40
Oct 16 16:51:43 localhost kernel: <c011c0fb> local_bh_enable+0x6b/0x70  <c0310c16> destroy_conntrack+0x76/0xe0
Oct 16 16:51:43 localhost kernel: <c02367bf> reinit_ring+0xf/0x50  <c0237fdf> tx_timeout+0x4f/0xe0
Oct 16 16:51:43 localhost kernel: <c02aa5a0> dev_watchdog+0xa0/0xb0  <c011f3f9> run_timer_softirq+0x129/0x170
Oct 16 16:51:43 localhost kernel: <c0105d67> timer_interrupt+0x67/0x70  <c02aa500> dev_watchdog+0x0/0xb0
Oct 16 16:51:43 localhost kernel: <c011bf52> __do_softirq+0x42/0x90  <c011bfc6> do_softirq+0x26/0x30
Oct 16 16:51:43 localhost kernel: <c0104a1e> do_IRQ+0x1e/0x30  <c0102d8a> common_interrupt+0x1a/0x20
Oct 16 16:51:43 localhost kernel: <c0101cab> default_idle+0x2b/0x60  <c0101d1a> cpu_idle+0x3a/0x50
Oct 16 16:51:43 localhost kernel: <c0408676> start_kernel+0x1e6/0x2b0  <c0408220> unknown_bootoption+0x0/0x270
Oct 16 16:51:43 localhost kernel: BUG: warning at kernel/softirq.c:141/local_bh_enable()
Oct 16 16:51:43 localhost kernel: <c011c0fb> local_bh_enable+0x6b/0x70  <c0310bd1> destroy_conntrack+0x31/0xe0
Oct 16 16:51:43 localhost kernel: <c029a975> __kfree_skb+0xa5/0x120  <c0236790> drain_tx+0x20/0x40
Oct 16 16:51:43 localhost kernel: <c02aa5a0> dev_watchdog+0xa0/0xb0  <c011f3f9> run_timer_softirq+0x129/0x170
Oct 16 16:51:43 localhost kernel: <c02367bf> reinit_ring+0xf/0x50  <c0237fdf> tx_timeout+0x4f/0xe0
Oct 16 16:51:43 localhost kernel: <c0105d67> timer_interrupt+0x67/0x70  <c02aa500> dev_watchdog+0x0/0xb0
Oct 16 16:51:43 localhost kernel: <c011bf52> __do_softirq+0x42/0x90  <c011bfc6> do_softirq+0x26/0x30
Oct 16 16:51:43 localhost kernel: <c0104a1e> do_IRQ+0x1e/0x30  <c0102d8a> common_interrupt+0x1a/0x20
Oct 16 16:51:43 localhost kernel: <c0101cab> default_idle+0x2b/0x60  <c0101d1a> cpu_idle+0x3a/0x50
Oct 16 16:51:43 localhost kernel: <c0408676> start_kernel+0x1e6/0x2b0  <c0408220> unknown_bootoption+0x0/0x270
Oct 16 16:51:43 localhost kernel: BUG: warning at kernel/softirq.c:141/local_bh_enable()
Oct 16 16:51:43 localhost kernel: <c011c0fb> local_bh_enable+0x6b/0x70  <c0310c16> destroy_conntrack+0x76/0xe0
Oct 16 16:51:43 localhost kernel: <c029a975> __kfree_skb+0xa5/0x120  <c0236790> drain_tx+0x20/0x40
Oct 16 16:51:43 localhost kernel: <c0105d67> timer_interrupt+0x67/0x70  <c02aa500> dev_watchdog+0x0/0xb0
Oct 16 16:51:43 localhost kernel: <c02aa5a0> dev_watchdog+0xa0/0xb0  <c011f3f9> run_timer_softirq+0x129/0x170
Oct 16 16:51:43 localhost kernel: <c02367bf> reinit_ring+0xf/0x50  <c0237fdf> tx_timeout+0x4f/0xe0
Oct 16 16:51:43 localhost kernel: <c0104a1e> do_IRQ+0x1e/0x30  <c0102d8a> common_interrupt+0x1a/0x20
Oct 16 16:51:43 localhost kernel: <c011bf52> __do_softirq+0x42/0x90  <c011bfc6> do_softirq+0x26/0x30
Oct 16 16:51:43 localhost kernel: <c0101cab> default_idle+0x2b/0x60  <c0101d1a> cpu_idle+0x3a/0x50
Oct 16 16:51:43 localhost kernel: <c0408676> start_kernel+0x1e6/0x2b0  <c0408220> unknown_bootoption+0x0/0x270
Oct 16 16:51:43 localhost kernel: eth6: DSPCFG accepted after 0 usec.
Oct 16 16:51:43 localhost kernel: eth6: Setting full-duplex based on negotiated link capability.
Oct 16 16:51:47 localhost kernel: NETDEV WATCHDOG: eth6: transmit timed out
Oct 16 16:51:47 localhost kernel: eth6: Transmit timed out, status 0x000000, resetting...
Oct 16 16:51:47 localhost kernel: eth6: DSPCFG accepted after 0 usec.
Oct 16 16:51:47 localhost kernel: eth6: Setting full-duplex based on negotiated link capability.





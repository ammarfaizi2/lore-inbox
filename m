Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTJTWXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 18:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTJTWXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 18:23:16 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:54666 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S262536AbTJTWXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 18:23:06 -0400
Date: Tue, 21 Oct 2003 00:23:06 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-net@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: 2.6.0-test6, connntrack/sis900/net (?)  Badness in local_bh_enable at kernel/softirq.c:119
Message-ID: <20031020222306.GB32167@finwe.eu.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, netfilter-devel@lists.netfilter.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found it in logs (2.6.0-test6). It happened little while after 
I had reloaded dhcpd configuration.

I'm not sure if it's related to NIC or ip-conntrack, but as both
are mentioned... 

System information below.

eth0: Media Link Off
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000004 00000000 
Badness in local_bh_enable at kernel/softirq.c:119
Call Trace:
 [local_bh_enable+137/144] local_bh_enable+0x89/0x90
 [_end+130859013/1069963240] ip_ct_find_proto+0x3d/0x60 [ip_conntrack]
 [_end+130860013/1069963240] destroy_conntrack+0x15/0x110 [ip_conntrack]
 [sock_wfree+73/80] sock_wfree+0x49/0x50
 [__kfree_skb+143/272] __kfree_skb+0x8f/0x110
 [_end+130608961/1069963240] sis900_tx_timeout+0x99/0x150 [sis900]
 [dev_watchdog+0/208] dev_watchdog+0x0/0xd0
 [dev_watchdog+191/208] dev_watchdog+0xbf/0xd0
 [run_timer_softirq+203/448] run_timer_softirq+0xcb/0x1c0
 [do_timer+224/240] do_timer+0xe0/0xf0
 [do_softirq+149/160] do_softirq+0x95/0xa0
 [do_IRQ+267/352] do_IRQ+0x10b/0x160
 [_stext+0/96] rest_init+0x0/0x60
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [_stext+0/96] rest_init+0x0/0x60
 [default_idle+35/64] default_idle+0x23/0x40
 [cpu_idle+52/64] cpu_idle+0x34/0x40
 [start_kernel+342/368] start_kernel+0x156/0x170
 [unknown_bootoption+0/288] unknown_bootoption+0x0/0x120

Badness in local_bh_enable at kernel/softirq.c:119
Call Trace:
 [local_bh_enable+137/144] local_bh_enable+0x89/0x90
 [_end+130860237/1069963240] destroy_conntrack+0xf5/0x110 [ip_conntrack]
 [sock_wfree+73/80] sock_wfree+0x49/0x50
 [__kfree_skb+143/272] __kfree_skb+0x8f/0x110
 [_end+130608961/1069963240] sis900_tx_timeout+0x99/0x150 [sis900]
 [dev_watchdog+0/208] dev_watchdog+0x0/0xd0
 [dev_watchdog+191/208] dev_watchdog+0xbf/0xd0
 [run_timer_softirq+203/448] run_timer_softirq+0xcb/0x1c0
 [do_timer+224/240] do_timer+0xe0/0xf0
 [do_softirq+149/160] do_softirq+0x95/0xa0
 [do_IRQ+267/352] do_IRQ+0x10b/0x160
 [_stext+0/96] rest_init+0x0/0x60
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [_stext+0/96] rest_init+0x0/0x60
 [default_idle+35/64] default_idle+0x23/0x40
 [cpu_idle+52/64] cpu_idle+0x34/0x40
 [start_kernel+342/368] start_kernel+0x156/0x170
 [unknown_bootoption+0/288] unknown_bootoption+0x0/0x120

Badness in local_bh_enable at kernel/softirq.c:119
Call Trace:
 [local_bh_enable+137/144] local_bh_enable+0x89/0x90
 [_end+130860184/1069963240] destroy_conntrack+0xc0/0x110 [ip_conntrack]
 [sock_wfree+73/80] sock_wfree+0x49/0x50
 [__kfree_skb+143/272] __kfree_skb+0x8f/0x110
 [_end+130608961/1069963240] sis900_tx_timeout+0x99/0x150 [sis900]
 [dev_watchdog+0/208] dev_watchdog+0x0/0xd0
 [dev_watchdog+191/208] dev_watchdog+0xbf/0xd0
 [run_timer_softirq+203/448] run_timer_softirq+0xcb/0x1c0
 [do_timer+224/240] do_timer+0xe0/0xf0
 [do_softirq+149/160] do_softirq+0x95/0xa0
 [do_IRQ+267/352] do_IRQ+0x10b/0x160
 [_stext+0/96] rest_init+0x0/0x60
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [_stext+0/96] rest_init+0x0/0x60
 [default_idle+35/64] default_idle+0x23/0x40
 [cpu_idle+52/64] cpu_idle+0x34/0x40
 [start_kernel+342/368] start_kernel+0x156/0x170
 [unknown_bootoption+0/288] unknown_bootoption+0x0/0x120

eth0: Media Link On 100mbps full-duplex 

config: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/config

System information (please note, that it's running 2.6.0-test8 now):

cpuinfo: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/cpuinfo
dmesg: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/dmesg
  (boot options as in 2.6.0-test6)
lsmod: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/lsmod
lspci: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/lspci
lspci -v: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/lspci-v
lspci -v -v: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/lspci-v-v
modules: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/modules

module-init-tools: module-init-tools 0.9.15-pre2

If I can help somehow, please let me know :)

bye

-- 
Jacek Kawa   **Trying to avoid complications often creates them. [F.Herbert]**

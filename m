Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUDHQjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUDHQjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:39:09 -0400
Received: from open.nlnetlabs.nl ([213.154.224.1]:59917 "EHLO
	open.nlnetlabs.nl") by vger.kernel.org with ESMTP id S261998AbUDHQjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:39:02 -0400
Date: Thu, 8 Apr 2004 18:38:44 +0200
From: Miek Gieben <miekg@atoom.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 network related crash
Message-ID: <20040408163844.GA21251@atoom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Vim/Mutt/Linux
X-Home: www.miek.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've experienced a 2.6.5 crash today, I believe it is network related.
I don't have a oops it just locked solid. Below is information I do
have. What can I do to narrow this down?

regards, Miek

In the logs:

Apr  8 10:46:17 kasteel kernel: eth0: Transmit timed out, status 00000000, resetting... 
Apr  8 10:46:17 kasteel kernel: eth0: Transmit timed out, status 00000000, resetting... 
Apr  8 10:46:17 kasteel kernel:   Rx ring cba1d000:  80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000  80000000 0000 80000000 80000000 80000000   8 10:46:33 kasteel kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Apr  8 10:46:33 kasteel kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Apr  8 10:46:33 kasteel kernel: eth0: Transmit timed out, status 00000000, resetting... 
Apr  8 10:46:33 kasteel kernel: eth0: Transmit timed out, status 00000000, resetting... 
Apr  8 10:46:33 kasteel kernel:   Rx ring cba1d000:  80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000  80000000 80000000 80000000 80000000 0000   8 10:47:13 kasteel kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Apr  8 10:47:13 kasteel kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Apr  8 10:47:13 kasteel kernel: eth0: Transmit timed out, status 00000000, resetting... 
Apr  8 10:47:13 kasteel kernel: eth0: Transmit timed out, status 00000000, resetting... 
Apr  8 10:47:13 kasteel kernel:   Rx ring cba1d000:  80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 
Apr  8 10:47:13 kasteel kernel:   Tx ring cba1e000:  80000000 80000000 80000000 0000 80000000 80000000 
Apr  8 10:47:19 kasteel kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Apr  8 10:47:19 kasteel kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Apr  8 10:47:19 kasteel kernel: eth0: Transmit timed out, status 00000000, resetting... 
Apr  8 10:47:19 kasteel kernel: eth0: Transmit timed out, status 00000000, resetting... 
Apr  8 10:47:19 kasteel kernel:   Rx ring cba1d000:  80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 
Apr  8 10:47:19 kasteel kernel:   Tx ring cba1e000:  80000000 80000000 80000000 80000000 0000 80000000 
Apr  8 10:47:25 kasteel kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Apr  8 10:47:25 kasteel kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Apr  8 10:47:25 kasteel kernel: eth0: Transmit timed out, status 00000000, resetting... 
Apr  8 10:47:25 kasteel kernel: eth0: Transmit timed out, status 00000000, resetting... 
Apr  8 10:47:25 kasteel kernel:   Rx ring cba1d000:  80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 80000000 
Apr  8 10:47:25 kasteel kernel:   Tx ring cba1e000:  80000000 80000000 80000000 0000 80000000 8000


Information about eth0:

eth0      Link encap:Ethernet  HWaddr 00:02:44:52:09:30  
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::202:44ff:fe52:930/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4735 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5215 errors:0 dropped:0 overruns:0 carrier:0
          collisions:3 txqueuelen:1000 
          RX bytes:793790 (775.1 KiB)  TX bytes:3111062 (2.9 MiB)
          Interrupt:10 Base address:0xec00 

The card in question is a:
00:0a.0 Ethernet controller: MYSON Technology Inc SURECOM EP-320X-S 100/10M Ethernet PCI Adapter

using irq 10 and the fealnx module

Modules loaded:
# lsmod
Module                  Size  Used by
ipt_LOG                 5024  2 
ipt_limit               1824  2 
ipt_state               1376  4 
ipt_MARK                1600  12 
ipt_REJECT              5312  38 
ip_nat_ftp              3984  0 
ip_conntrack_ftp       71092  1 ip_nat_ftp
ipt_mark                1248  0 
iptable_mangle          2048  1 
iptable_nat            20044  2 ip_nat_ftp
iptable_filter          2112  1 
ipv6                  227552  8 
3c509                  11924  0 
8139too                19328  0 
fealnx                 13352  0 
mii                     3968  2 8139too,fealnx

-- 
today's fortune:
BOFH excuse #162:

bugs in the RAID

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVHEP4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVHEP4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVHEPxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:53:47 -0400
Received: from smtp.bredband2.net ([82.209.166.4]:44585 "EHLO
	smtp.bredband2.net") by vger.kernel.org with ESMTP id S262911AbVHEPxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:53:14 -0400
Message-ID: <42F38B67.5040308@home.se>
Date: Fri, 05 Aug 2005 17:53:11 +0200
From: =?ISO-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: netdev@vger.kernel.org
Subject: assertion (cnt <= tp->packets_out) failed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get

KERNEL: assertion (cnt <= tp->packets_out) failed at 
net/ipv4/tcp_input.c (1476)

with 2.6.13-rc5, also with a small netpoll patch that shouldnt affect 
these things. (Topic: "lockups with netconsole on e1000 on media 
insertion").

I have a decent amount of dropped/overruns:

eth2      Link encap:Ethernet  HWaddr 00:50:DA:E0:BB:36
           inet addr:83.233.27.60  Bcast:83.233.27.255  Mask:255.255.255.0
           inet6 addr: fe80::250:daff:fee0:bb36/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:9141685 errors:0 dropped:0 overruns:794 frame:0
           TX packets:10596040 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:950232746 (906.2 MiB)  TX bytes:804721505 (767.4 MiB)
           Interrupt:10 Base address:0x8800

eth3      Link encap:Ethernet  HWaddr 00:0E:0C:75:F1:2A
           inet addr:10.32.0.1  Bcast:10.255.255.255  Mask:255.255.0.0
           inet6 addr: fe80::20e:cff:fe75:f12a/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:16000  Metric:1
           RX packets:16090188 errors:2329 dropped:4658 overruns:2329 
frame:0
           TX packets:34370559 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:1148661167 (1.0 GiB)  TX bytes:4000412315 (3.7 GiB)
           Base address:0x8400 Memory:e2000000-e2020000



ethtool -S eth3
NIC statistics:
      rx_packets: 16195970
      tx_packets: 34563822
      rx_bytes: 1258213074
      tx_bytes: 4205874656
      rx_errors: 2332
      tx_errors: 0
      rx_dropped: 2332
      tx_dropped: 0
      multicast: 0
      collisions: 0
      rx_length_errors: 0
      rx_over_errors: 0
      rx_crc_errors: 0
      rx_frame_errors: 0
      rx_fifo_errors: 2332
      rx_no_buffer_count: 0
      rx_missed_errors: 2332
      tx_aborted_errors: 0
      tx_carrier_errors: 0
      tx_fifo_errors: 0
      tx_heartbeat_errors: 0
      tx_window_errors: 0
      tx_abort_late_coll: 0
      tx_deferred_ok: 0
      tx_single_coll_ok: 0
      tx_multi_coll_ok: 0
      rx_long_length_errors: 0
      rx_short_length_errors: 0
      rx_align_errors: 0
      tx_tcp_seg_good: 2981894
      tx_tcp_seg_failed: 0
      rx_flow_control_xon: 0
      rx_flow_control_xoff: 0
      tx_flow_control_xon: 0
      tx_flow_control_xoff: 0
      rx_long_byte_count: 14143114962
      rx_csum_offload_good: 16195740
      rx_csum_offload_errors: 0


ethtool -S eth2
NIC statistics:
      tx_deferred: 0
      tx_multiple_collisions: 0
      rx_bad_ssd: 0

---
John Bäckstrand

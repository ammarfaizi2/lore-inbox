Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272301AbTG3WaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272300AbTG3WaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:30:08 -0400
Received: from aneto.able.es ([212.97.163.22]:61689 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S272290AbTG3W2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:28:37 -0400
Date: Thu, 31 Jul 2003 00:28:35 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: e1000 performance
Message-ID: <20030730222835.GC2858@werewolf.able.es>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229232@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102229232@orsmsx402.jf.intel.com>; from scott.feldman@intel.com on Wed, Jul 30, 2003 at 08:52:07 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.30, "Feldman, Scott" wrote:
> > I think I am getting weird performace with e1000 in 2.4.22-pre.
> 
> Is this behavior new to 2.4.22-pre?
> 
> > Hardware:
> > 03:01.0 Ethernet controller: Intel Corp. 82543GC Gigabit 
> > Ethernet Controller (Copper) (rev 02)
> 
> 82543 = PCI, not PCI-X.  Are you in a 64-bit slot?  Get ethtool 1.8 and
> run ethtool -d eth<x> to see PCI type/width/speed.
>  

Here are the results:
annwn:~# ethtool -d eth2
MAC Registers
-------------
0x00000: CTRL (Device control register)  0x0A501A49
      Duplex:                            full
      Endian mode (buffers):             little
      Link reset:                        reset
      Set link up:                       1
      Invert Loss-Of-Signal:             no
      Receive flow control:              enabled
      Transmit flow control:             disabled
      VLAN mode:                         disabled
      Auto speed detect:                 disabled
      Speed select:                      1000Mb/s
      Force speed:                       yes
      Force duplex:                      yes
0x00008: STATUS (Device status register) 0x00001B8F
      Duplex:                            full
      Link up:                           link config
      TBI mode:                          disabled
      Link speed:                        1000Mb/s
0x00100: RCTL (Receive control register) 0x00008002
      Receiver:                          enabled
      Store bad packets:                 disabled
      Unicast promiscuous:               disabled
      Multicast promiscuous:             disabled
      Long packet:                       disabled
      Descriptor minimum threshold size: 1/2
      Broadcast accept mode:             accept
      VLAN filter:                       disabled
      Cononical form indicator:          disabled
      Discard pause frames:              filtered
      Pass MAC control frames:           don't pass
      Receive buffer size:               2048
0x02808: RDLEN (Receive desc length)     0x00001000
0x02810: RDH   (Receive desc head)       0x0000009B
0x02818: RDT   (Receive desc tail)       0x00000090
0x02820: RDTR  (Receive delay timer)     0x00000000
0x00400: TCTL (Transmit ctrl register)   0x0004010A
      Transmitter:                       enabled
      Pad short packets:                 enabled
      Software XOFF Transmission:        disabled
      Re-transmit on late collision:     disabled
0x03808: TDLEN (Transmit desc length)    0x00001000
0x03810: TDH   (Transmit desc head)      0x00000076
0x03818: TDT   (Transmit desc tail)      0x00000076
0x03820: TIDV  (Transmit delay timer)    0x00000040

More info:

annwn:~# ethtool -i eth2
driver: e1000
version: 5.1.13-k1
firmware-version: N/A
bus-info: 03:01.0
annwn:~# ethtool -S eth2
NIC statistics:
     rx_packets: 12523
     tx_packets: 6559
     rx_bytes: 1828772
     tx_bytes: 1434954
     rx_errors: 0
     tx_errors: 0
     rx_dropped: 0
     tx_dropped: 0
     multicast: 0
     collisions: 0
     rx_length_errors: 0
     rx_over_errors: 0
     rx_crc_errors: 0
     rx_frame_errors: 0
     rx_fifo_errors: 0
     rx_missed_errors: 0
     tx_aborted_errors: 0
     tx_carrier_errors: 6559
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
     tx_tcp_seg_good: 0
     tx_tcp_seg_failed: 0
     rx_flow_control_xon: 0
     rx_flow_control_xoff: 0
     tx_flow_control_xon: 0
     tx_flow_control_xoff: 0
     rx_csum_offload_good: 12506
     rx_csum_offload_errors: 0


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like
sex:
werewolf.able.es                         \           It's better when it's
free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre9-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.7mdk))

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVCLPzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVCLPzR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVCLPzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:55:16 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:26462 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261941AbVCLPxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:53:31 -0500
From: Kimmo Sundqvist <kimmo.sundqvist@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: Badness in local_bh_enable at kernel/softirq.c:140
Date: Sat, 12 Mar 2005 17:53:03 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503121753.03974.kimmo.sundqvist@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

A bug I've been with for a while.  Any thoughts on this?  Just ask if you want  
more details.  This is a little firewall machine at home, with a HFC PCI ISDN 
card.  These appear in /var/log/messages about once an hour to once a day.

Linux shadowgate 2.6.10-gentoo-r6 #3 Thu Mar 10 20:40:32 EET 2005 i586 Pentium 
75 - 200 GenuineIntel GNU/Linux
shadowgate log # lsmod
Module                  Size  Used by
cls_u32                 7236  5 
sch_sfq                 4640  3 
sch_cbq                14432  1 
ipt_LOG                 5888  1 
ipt_MASQUERADE          2432  1 
ipt_state               1408  2 
iptable_filter          2784  1 
ip_nat_ftp              3888  0 
iptable_nat            20904  3 ipt_MASQUERADE,ip_nat_ftp
ip_conntrack_ftp       70992  1 ip_nat_ftp
ip_conntrack           38260  5 
ipt_MASQUERADE,ipt_state,ip_nat_ftp,iptable_nat,ip_conntrack_ftp
ip_tables              15008  5 
ipt_LOG,ipt_MASQUERADE,ipt_state,iptable_filter,iptable_nat
psmouse                18024  0 
3c509                  10708  0 
hisax                 144672  3 
isdn                  104704  5 hisax
slhc                    6304  1 isdn

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 1).
      Master Capable.  Latency=64.  
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 0).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] (rev 0).
      Master Capable.  Latency=64.  
      I/O at 0xf000 [0xf00f].
  Bus  0, device  11, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II] 
(rev 0).
      IRQ 10.
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe0ffffff].
      Non-prefetchable 32 bit memory at 0xe1000000 [0xe1003fff].
      Non-prefetchable 32 bit memory at 0xe2000000 [0xe27fffff].
  Bus  0, device  13, function  0:
    Network controller: Asustek Computer, Inc. ISDNLink P-IN100-ST-D (rev 2).
      IRQ 12.
      Master Capable.  Latency=16.  Max Lat=16.
      I/O at 0x6400 [0x6407].
      Non-prefetchable 32 bit memory at 0xe3000000 [0xe30000ff].
  Bus  0, device  15, function  0:
    Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 36).
      IRQ 7.
      Master Capable.  Latency=64.  Min Gnt=10.Max Lat=10.
      I/O at 0x6800 [0x687f].
      Non-prefetchable 32 bit memory at 0xe3001000 [0xe300107f].

Mar 12 10:39:45 shadowgate Badness in local_bh_enable at kernel/softirq.c:140
Mar 12 10:39:45 shadowgate [<c0114ca4>] local_bh_enable+0x64/0x70
Mar 12 10:39:45 shadowgate [<c486afd7>] isdn_ppp_xmit+0xf7/0x7e0 [isdn]
Mar 12 10:39:45 shadowgate [<c485d646>] isdn_net_xmit+0x186/0x1d0 [isdn]
Mar 12 10:39:45 shadowgate [<c485d9e7>] isdn_net_start_xmit+0x277/0x290 [isdn]
Mar 12 10:39:45 shadowgate [<c02467c2>] qdisc_restart+0x52/0x140
Mar 12 10:39:45 shadowgate [<c023c78d>] dev_queue_xmit+0x17d/0x200
Mar 12 10:39:45 shadowgate [<c0241789>] neigh_connected_output+0x89/0xd0
Mar 12 10:39:45 shadowgate [<c02566ad>] ip_finish_output2+0xbd/0x190
Mar 12 10:39:45 shadowgate [<c02565f0>] ip_finish_output2+0x0/0x190
Mar 12 10:39:45 shadowgate [<c0245a27>] nf_hook_slow+0x97/0xd0
Mar 12 10:39:45 shadowgate [<c0252cf0>] ip_forward_finish+0x0/0x40
Mar 12 10:39:45 shadowgate [<c0254308>] ip_finish_output+0x1b8/0x1c0
Mar 12 10:39:45 shadowgate [<c02565f0>] ip_finish_output2+0x0/0x190
Mar 12 10:39:45 shadowgate [<c0252cf0>] ip_forward_finish+0x0/0x40
Mar 12 10:39:45 shadowgate [<c0252d0e>] ip_forward_finish+0x1e/0x40
Mar 12 10:39:45 shadowgate [<c0245a27>] nf_hook_slow+0x97/0xd0
Mar 12 10:39:45 shadowgate [<c0252c75>] ip_forward+0x165/0x1e0
Mar 12 10:39:45 shadowgate [<c0252cf0>] ip_forward_finish+0x0/0x40
Mar 12 10:39:45 shadowgate [<c0251d67>] ip_rcv_finish+0x1c7/0x230
Mar 12 10:39:45 shadowgate [<c0251ba0>] ip_rcv_finish+0x0/0x230
Mar 12 10:39:45 shadowgate [<c0245a27>] nf_hook_slow+0x97/0xd0
Mar 12 10:39:45 shadowgate [<c02519bb>] ip_rcv+0x39b/0x450
Mar 12 10:39:45 shadowgate [<c0251ba0>] ip_rcv_finish+0x0/0x230
Mar 12 10:39:45 shadowgate [<c023cd07>] netif_receive_skb+0x177/0x220
Mar 12 10:39:45 shadowgate [<c0117a68>] __mod_timer+0x58/0x80
Mar 12 10:39:45 shadowgate [<c023ce1f>] process_backlog+0x6f/0x120
Mar 12 10:39:45 shadowgate [<c023cf2f>] net_rx_action+0x5f/0xf0
Mar 12 10:39:45 shadowgate [<c0114c23>] __do_softirq+0x83/0xa0
Mar 12 10:39:45 shadowgate [<c0104759>] do_softirq+0x39/0x40
Mar 12 10:39:45 shadowgate =======================
Mar 12 10:39:45 shadowgate [<c0104678>] do_IRQ+0x48/0x60
Mar 12 10:39:45 shadowgate [<c01030fa>] common_interrupt+0x1a/0x20
Mar 12 10:39:45 shadowgate [<c0100570>] default_idle+0x0/0x30
Mar 12 10:39:45 shadowgate [<c0100594>] default_idle+0x24/0x30
Mar 12 10:39:45 shadowgate [<c0100605>] cpu_idle+0x25/0x40
Mar 12 10:39:45 shadowgate [<c0368708>] start_kernel+0x138/0x160

Please cc all replies.

-Kimmo S.

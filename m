Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbTATAbw>; Sun, 19 Jan 2003 19:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267735AbTATAbw>; Sun, 19 Jan 2003 19:31:52 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:56462 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S267732AbTATAbr>;
	Sun, 19 Jan 2003 19:31:47 -0500
To: <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Generic HDLC and hw drivers update for 2.4
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 20 Jan 2003 01:40:24 +0100
Message-ID: <m3lm1gbqmf.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've put the generic HDLC update at:
ftp://ftp.pm.waw.pl/pub/linux/hdlc/current/hdlc-2.4.21pre3d.patch.gz

Please apply to linux-2.4.21pre and linux-2.4.21-pre-ac.
Thank you.
(A patch for 2.5 kernel is in the works).


Changes summary: 1.12 - January, 2003

* Added Ethernet device emulation for raw HDLC. VLAN and bridging compatible,
  tested with RAD ChipBridge (ChipBridge doesn't work with full size VLAN
  frames, though).

* Added Ethernet device emulation for bridged Ethernet frames on Frame-Relay.

* fixed subtle transmit bug in c101.c which could lead to transmitter hangs
  and duplicated frames with SCA HD64570 working in 8-bit mode.

* no more "protocol 0008 is buggy" while using tcpdump, at last.

* Frame-Relay DCE (network) side now sorts DLCI list in PVC FULL STATUS.
  Some FR DTE had problems with unsorted list.

* Small changes to LMI logic with Frame-Relay.

* tcpdump etc. should see all frames going through physical and logical
  interfaces correctly (exception: internal syncppp.c processing).

* You can now query PVC device using sethdlc.

* You can continue to use older sethdlc.c tool, but for new functionality
  you need sethdlc-1.12.c.

>From a hardware driver point of view:
A hardware driver has to call hdlc_type_trans(skb, dev) instead of
using ETH_P_HDLC to set skb->protocol before netif_rx(skb):

         skb->dev = hdlc_to_dev (&port->hdlc);
-        skb->protocol = htons (ETH_P_HDLC);
+        skb->protocol = hdlc_type_trans(skb, skb->dev);
         netif_rx (skb);

This change corrects problems with tcpdump/etc not seeing all inbound
frames correctly.
-- 
Krzysztof Halasa
Network Administrator

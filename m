Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267407AbTBLPra>; Wed, 12 Feb 2003 10:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTBLPr3>; Wed, 12 Feb 2003 10:47:29 -0500
Received: from copper.ftech.net ([212.32.16.118]:10127 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S267407AbTBLPr1>;
	Wed, 12 Feb 2003 10:47:27 -0500
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0EF6EC@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'Krzysztof Halasa'" <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: Generic HDLC and hw drivers update for 2.4
Date: Wed, 12 Feb 2003 15:57:09 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
	I have tested this today with our FarSync T-Series drivers, and all
seems to be OK.  However, I want to release a new driver that provides
support for some new FarSync cards (T1U, T2U and T4U).  As the driver has
under-gone radical change, I suspect that this would best be done after the
generic hdlc makes it into the Kernel.  Is this likely to be 2.4.21?  When
is 2.4.21 expected to be released.


Thanks

Kevin 

-----Original Message-----
From: Krzysztof Halasa [mailto:khc@pm.waw.pl]
Sent: 20 January 2003 00:40
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti; Alan Cox
Subject: Generic HDLC and hw drivers update for 2.4


Hi,

I've put the generic HDLC update at:
ftp://ftp.pm.waw.pl/pub/linux/hdlc/current/hdlc-2.4.21pre3d.patch.gz

Please apply to linux-2.4.21pre and linux-2.4.21-pre-ac.
Thank you.
(A patch for 2.5 kernel is in the works).


Changes summary: 1.12 - January, 2003

* Added Ethernet device emulation for raw HDLC. VLAN and bridging
compatible,
  tested with RAD ChipBridge (ChipBridge doesn't work with full size VLAN
  frames, though).

* Added Ethernet device emulation for bridged Ethernet frames on
Frame-Relay.

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

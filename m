Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWDIUjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWDIUjo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 16:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWDIUjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 16:39:44 -0400
Received: from v813.rev.tld.pl ([195.149.226.213]:29589 "EHLO
	smtp.host4.kei.pl") by vger.kernel.org with ESMTP id S1750704AbWDIUjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 16:39:44 -0400
From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCMCIA: make Pretec CF Wifi use hostap_cs by default
Date: Sun, 9 Apr 2006 22:39:27 +0200
User-Agent: KMail/1.9.1
Cc: Jouni Malinen <jkmaline@cc.hut.fi>, Pavel Roskin <proski@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604092239.29008.openembedded@hrw.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I use two Zaurus palmtops - one run 2.4.18 kernel (it's sl-5500) and second 
run 2.6.16. Both are running under control of OpenZaurus distribution 
(I'm Release Manager of it).

When I use pcmcia-cs then my Pretec WiFi card is handled by hostap driver
and everything is working fine. Recently I switched to pcmciautils and after
card insert orinoco modules are loaded. I prefer to use hostap modules
because they work the same under 2.4 and 2.6 kernels (with orinoco I have to
use 0.13e ones because never ones does not work under 2.4/arm).

This patch adds definition of my card to hostap_cs cardlist. It was tested on
Sharp Zaurus C760 palmtop running 2.6.16 + pcmciautils 010 + udev 084


PS - I'm not subscribed to that list - so please Cc: me on reply.

Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>

--- drivers/net/wireless/hostap/hostap_cs.c.orig
+++ drivers/net/wireless/hostap/hostap_cs.c
@@ -912,6 +912,9 @@ static struct pcmcia_device_id hostap_cs
        PCMCIA_DEVICE_PROD_ID123(
                "SMC", "SMC2632W", "Version 01.02",
                0xc4f8b18b, 0x474a1f2a, 0x4b74baa0),
+       PCMCIA_DEVICE_PROD_ID123(
+               "Pretec", "CompactWLAN Card 802.11b", "2.5",
+               0x1cadd3e5, 0xe697636c, 0x7a5bfcf1),
        PCMCIA_DEVICE_PROD_ID12("BUFFALO", "WLI-CF-S11G",
                                0x2decece3, 0x82067c18),
        PCMCIA_DEVICE_PROD_ID12("Compaq", "WL200_11Mbps_Wireless_PCI_Card",


-- 
JID: hrw-jabber.org
Palmtop: Sharp Zaurus C760
OpenEmbedded/OpenZaurus developer

Vi has two modes: the one in which it beeps, and the one in which it doesn't.

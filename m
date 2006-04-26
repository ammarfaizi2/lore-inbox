Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWDZVqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWDZVqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWDZVqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:46:30 -0400
Received: from smtp-out3.iol.cz ([194.228.2.91]:38539 "EHLO smtp-out3.iol.cz")
	by vger.kernel.org with ESMTP id S932487AbWDZVq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:46:29 -0400
Date: Wed, 26 Apr 2006 23:46:27 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@silence.gardas.net
To: linux-kernel@vger.kernel.org
Subject: [2.6.16.11] Xircom RealPort RBEM56G-100 link change issue
Message-ID: <Pine.LNX.4.63.0604262337530.3859@silence.gardas.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm trying to get working linux with Xircom RealPort CardBus Ethernet 
10/100+Modem 56 PCMCIA card. I only need ethernet working. The problem 
with this is that I'm losing too many packets while syslog is filled with 
messages like:

Apr 26 23:17:31 thinkpad kernel: pccard: CardBus card inserted into slot 1
Apr 26 23:18:13 thinkpad kernel: PCI: Enabling device 0000:06:00.0 (0000 -> 0003)
Apr 26 23:18:13 thinkpad kernel: PCI: Setting latency timer of device 0000:06:00.0 to 64
Apr 26 23:18:13 thinkpad kernel: eth1: Xircom cardbus revision 3 at irq 11
Apr 26 23:19:31 thinkpad kernel: xircom cardbus adaptor found, registering as eth1, using irq 11
Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link status has changed
Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link is 100 mbit
Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link status has changed
Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link is 0 mbit
Apr 26 23:19:54 thinkpad kernel: xircom_cb: Link status has changed
Apr 26 23:19:54 thinkpad kernel: xircom_cb: Link is 100 mbit
Apr 26 23:19:54 thinkpad kernel: xircom_cb: Link status has changed
Apr 26 23:19:54 thinkpad kernel: xircom_cb: Link is 0 mbit
Apr 26 23:19:56 thinkpad kernel: xircom_cb: Link status has changed
Apr 26 23:19:56 thinkpad kernel: xircom_cb: Link is 100 mbit
Apr 26 23:19:56 thinkpad kernel: xircom_cb: Link status has changed
Apr 26 23:19:56 thinkpad kernel: xircom_cb: Link is 0 mbit


the problem are those messages about link status change. I'm getting 
exactly the same behavior with RHEL4.3 distribution kernel and hence I 
tried to duplicate it with stock 2.6.16.11 and that's still the same.
I've enabled debugging inside the xircom_cb driver and got this from it:


Apr 26 23:35:38 thinkpad kernel: Enter: xircom_interrupt
Apr 26 23:35:38 thinkpad kernel: , drivers/net/tulip/xircom_cb.c line 343
Apr 26 23:35:38 thinkpad kernel: 0110 1000 0110 0110 1000 0000 0000 0000
Apr 26 23:35:38 thinkpad kernel: tx status 0x00000000 0x00000000
Apr 26 23:35:38 thinkpad kernel: rx status 0x80000000 0x80000000
Apr 26 23:35:38 thinkpad kernel: Enter: link_status_changed, drivers/net/tulip/xircom_cb.c line 688
Apr 26 23:35:38 thinkpad kernel: Leave: link_status_changed - changed, drivers/net/tulip/xircom_cb.c line 702
Apr 26 23:35:38 thinkpad kernel: xircom_cb: Link status has changed
Apr 26 23:35:38 thinkpad kernel: Enter: link_status, drivers/net/tulip/xircom_cb.c line 1054
Apr 26 23:35:38 thinkpad kernel: Leave: link_status, drivers/net/tulip/xircom_cb.c line 1065
Apr 26 23:35:38 thinkpad kernel: xircom_cb: Link is 0 mbit
Apr 26 23:35:38 thinkpad kernel: Enter: investigate_write_descriptor, drivers/net/tulip/xircom_cb.c line 1237
Apr 26 23:35:38 thinkpad kernel: Leave: investigate_write_descriptor, drivers/net/tulip/xircom_cb.c line 1261
Apr 26 23:35:38 thinkpad kernel: Enter: investigate_write_descriptor, drivers/net/tulip/xircom_cb.c line 1237
Apr 26 23:35:38 thinkpad kernel: Leave: investigate_write_descriptor, drivers/net/tulip/xircom_cb.c line 1261
Apr 26 23:35:38 thinkpad kernel: Enter: investigate_write_descriptor, drivers/net/tulip/xircom_cb.c line 1237
Apr 26 23:35:38 thinkpad kernel: Leave: investigate_write_descriptor, drivers/net/tulip/xircom_cb.c line 1261
Apr 26 23:35:38 thinkpad kernel: Enter: investigate_write_descriptor, drivers/net/tulip/xircom_cb.c line 1237
Apr 26 23:35:38 thinkpad kernel: Leave: investigate_write_descriptor, drivers/net/tulip/xircom_cb.c line 1261
Apr 26 23:35:38 thinkpad kernel: Enter: investigate_read_descriptor, drivers/net/tulip/xircom_cb.c line 1191
Apr 26 23:35:38 thinkpad kernel: Leave: investigate_read_descriptor, drivers/net/tulip/xircom_cb.c line 1227
Apr 26 23:35:38 thinkpad kernel: Enter: investigate_read_descriptor, drivers/net/tulip/xircom_cb.c line 1191
Apr 26 23:35:38 thinkpad kernel: Leave: investigate_read_descriptor, drivers/net/tulip/xircom_cb.c line 1227
Apr 26 23:35:38 thinkpad kernel: Enter: investigate_read_descriptor, drivers/net/tulip/xircom_cb.c line 1191
Apr 26 23:35:38 thinkpad kernel: Leave: investigate_read_descriptor, drivers/net/tulip/xircom_cb.c line 1227
Apr 26 23:35:38 thinkpad kernel: Enter: investigate_read_descriptor, drivers/net/tulip/xircom_cb.c line 1191
Apr 26 23:35:38 thinkpad kernel: Leave: investigate_read_descriptor, drivers/net/tulip/xircom_cb.c line 1227
Apr 26 23:35:38 thinkpad kernel: Leave: xircom_interrupt, drivers/net/tulip/xircom_cb.c line 384
Apr 26 23:35:40 thinkpad kernel: Enter: xircom_interrupt
Apr 26 23:35:40 thinkpad kernel: , drivers/net/tulip/xircom_cb.c line 343
Apr 26 23:35:40 thinkpad kernel: 0110 1000 0110 0110 1000 0000 0000 0000
Apr 26 23:35:40 thinkpad kernel: tx status 0x00000000 0x00000000
Apr 26 23:35:40 thinkpad kernel: rx status 0x80000000 0x80000000
Apr 26 23:35:40 thinkpad kernel: Enter: link_status_changed, drivers/net/tulip/xircom_cb.c line 688
Apr 26 23:35:40 thinkpad kernel: Leave: link_status_changed - changed, drivers/net/tulip/xircom_cb.c line 702
Apr 26 23:35:40 thinkpad kernel: xircom_cb: Link status has changed
Apr 26 23:35:40 thinkpad kernel: Enter: link_status, drivers/net/tulip/xircom_cb.c line 1054
Apr 26 23:35:40 thinkpad kernel: xircom_cb: Link is 100 mbit
Apr 26 23:35:40 thinkpad kernel: Enter: investigate_write_descriptor, drivers/net/tulip/xircom_cb.c line 1237

[...]

Is there anything I should provide for better debugging of this issue? Is 
there anything I can try to test? Or is this card really "broken"? I've 
thought that tulip produced some decent NIC chipsets...

Thanks for any help,
Karel
--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVGKHKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVGKHKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 03:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVGKHK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 03:10:29 -0400
Received: from main.gmane.org ([80.91.229.2]:63683 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261183AbVGKHK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 03:10:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Haber <mh+usenetspam200516@zugschlus.de>
Subject: 2.6.12.2 tg3 driver doesn't ARP on 8021q 802.1q dot1q VLAN interfaces?
Date: Mon, 11 Jul 2005 08:29:51 +0200
Organization: private site in Mannheim, Germany
Message-ID: <dat3kv$rpq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.151.248.5
User-Agent: KNode/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this morning, I tried upgrading a firewall from Debian woody to Debian
sarge, and in the course upgrading from a locally compiled vanilla 2.4.30
to a locally compiled vanilla 2.6.12.2. The box is a hp DL 140 which has
two tg3-based Interfaces on board, and a dual-Interface E1000 PCI card in
its PCI slot:

$ lspci
0000:00:00.0 Host bridge: ServerWorks GCNB-LE Host Bridge (rev 32)
0000:00:00.1 Host bridge: ServerWorks GCNB-LE Host Bridge
0000:00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
27)
0000:00:0f.0 ISA bridge: ServerWorks CSB6 South Bridge (rev a0)
0000:00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0)
0000:00:0f.2 USB Controller: ServerWorks CSB6 OHCI USB Controller (rev 05)
0000:00:0f.3 Host bridge: ServerWorks GCLE-2 Host Bridge
0000:00:10.0 Host bridge: ServerWorks CIOB-E I/O Bridge with Gigabit
Ethernet (rev 12)
0000:00:10.2 Host bridge: ServerWorks CIOB-E I/O Bridge with Gigabit
Ethernet (rev 12)
0000:01:06.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet
Controller (Copper) (rev 01)
0000:01:06.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet
Controller (Copper) (rev 01)
0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 02)
0000:02:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 02)
$

The box uses dot1q VLANs on all interfaces.

After rebooting, the VLANs on the Intel-based interfaces worked fine, while
the tg3-based interfaces didn't answer to tagged ARP requests. The untagged
VLAN on the tg3-based interfaces was fine as well. When tcpdumping the
subinterfaces, I saw all traffic on the network, and especially the
incoming ARP requests, but no ARP replies went out.

Rebooting back to 2.4 solved the issue immediately, all VLANs were OK as
well.

Conclusion: Since the e1000-based VLANs work fine even with 2.6, the dot1q
code seems to be ok. So, the issue most probably lies with the tg3 driver.

I am pretty well aware that there are issues with tg3 on _Debian_ kernels,
which is one of the reasons why I use locally compiled kernels built from
vanilla kernel.org sources.

Any hints?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVFQRmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVFQRmS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVFQRmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:42:18 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:59076 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262029AbVFQRmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:42:10 -0400
Message-ID: <42B30B53.2060204@g-house.de>
Date: Fri, 17 Jun 2005 19:41:39 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: manfreds@colorfullife.com
Subject: forcedeth as a module only?
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

are there any known issues with the forcedeth driver when statically
compiled in? i have an onboard GbE ethernet controller (see below) and
forcedeth seems to work pretty fine for this controller. it's 100Mbps
only, but i don't care because my switch is 100Mbps too.

i've noticed that the driver just does not work, when it's compiled with
CONFIG_FORCEDETH=y

eth0: forcedeth.c: subsystem: 01462:0250 bound to 0000:00:05.0
eth0: no link during initialization

recompiling the same kernel (2.6.12-rc6-mm1, x86_64) with
CONFIG_FORCEDETH=m and loading the module without any parameters get the
NIC up. mii-tool does not work in both cases, CONFIG_MII is set to "y".


any hints?

thank you,
Christian.

% lspci -v | grep -A6 0000:00:05.0
0000:00:05.0 Bridge: nVidia Corporation: Unknown device 00df (rev a2)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
        Memory at f8000000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at d800 [size=8]
        Capabilities: [44] Power Management version 2

(the manual says it's a Marvell 88E111 10/100/1000 onboard NIC)

% mii-tool
SIOCGMIIPHY on 'eth0' failed: Operation not supported
SIOCGMIIPHY on 'eth1' failed: Operation not supported
no MII interfaces found

% ethtool eth0
Settings for eth0:
        Supported ports: [ MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 1
        Transceiver: externel
        Auto-negotiation: on
        Supports Wake-on: g
        Wake-on: d
        Link detected: yes

-- 
BOFH excuse #334:

50% of the manual is in .pdf readme files

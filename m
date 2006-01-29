Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWA2XZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWA2XZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWA2XZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:25:59 -0500
Received: from isilmar.linta.de ([213.239.214.66]:13263 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932081AbWA2XZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:25:58 -0500
Date: Mon, 30 Jan 2006 00:25:37 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com,
       john.ronciak@intel.com, jgarzik@pobox.com
Cc: linux-netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: patch "e100: Fix TX hang and RMCP Ping issue" (post-2.6.16-rc1) causes suspend-to-ram breakage
Message-ID: <20060129232537.GA8343@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com,
	john.ronciak@intel.com, jgarzik@pobox.com,
	linux-netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

git bisect revealed that 24180333206519e6b0c4633eab81e773b4527cac is 
the first bad commit, which is 

"e100: Fix TX hang and RMCP Ping issue (due to a microcode loading issue)"

With it applied, suspend-to-ram fails to resume to userspace, which is
required on my system to get video back (vbetool). 

02:08.0 Ethernet controller: Intel Corporation 82801DB PRO/100 VE (MOB) Ethernet Controller (rev 81)
	Subsystem: Samsung Electronics Co Ltd Unknown device c009
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e0201000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

eth0      Link encap:Ethernet  HWaddr ...................
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

Settings for eth0:
	Supported ports: [ TP MII ]
	Supported link modes:   10baseT/Half 10baseT/Full 
	                        100baseT/Half 100baseT/Full 
	Supports auto-negotiation: Yes
	Advertised link modes:  10baseT/Half 10baseT/Full 
	                        100baseT/Half 100baseT/Full 
	Advertised auto-negotiation: Yes
	Speed: 10Mb/s
	Duplex: Half
	Port: MII
	PHYAD: 1
	Transceiver: internal
	Auto-negotiation: on
	Supports Wake-on: g
	Wake-on: g
	Current message level: 0x00000007 (7)
	Link detected: no


No cable inserted, therefore the link is down...

	Dominik

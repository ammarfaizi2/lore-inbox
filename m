Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWIHPof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWIHPof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWIHPof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:44:35 -0400
Received: from mga03.intel.com ([143.182.124.21]:44609 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1750908AbWIHPod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:44:33 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,232,1154934000"; 
   d="scan'208"; a="113752230:sNHT18892643"
Message-ID: <45018F76.5080403@intel.com>
Date: Fri, 08 Sep 2006 08:42:46 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Jan Kiszka <jan.kiszka@web.de>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: e100 fails, eepro100 works
References: <450172F2.50308@web.de>
In-Reply-To: <450172F2.50308@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2006 15:44:32.0480 (UTC) FILETIME=[AD9CEE00:01C6D35D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kiszka wrote:
> Hi,
> 
> we have a couple of industrial PCs here with Intel PRO/100 controllers
> on board. Most of them work fine with the e100, but today I stumbled
> over one box that doesn't: Reception works (RX counter increases, ARP
> cache gets filled up), but transmission fails (TX counter is also zero).

please include `ifconfig ethX` and `ethtool -S ethX` after attempting to 
transmit using the device.

> In contrast, the eepro100 is fine, also Etherboot's driver.
> 
> I'm currently on 2.6.17.8, but I don't see any changes up to latest git
> that may have positive influence. This is what lspci -v tells about this
> piece of hardware:
> 
> 00:12.0 Ethernet controller: Intel Corporation 8255xER/82551IT Fast
> Ethernet Controller (rev 08)
>         Subsystem: Intel Corporation: Unknown device 1229
>         Flags: bus master, medium devsel, latency 66, IRQ 10
>         Memory at fc020000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at 1080 [size=64]
>         Memory at fc000000 (32-bit, non-prefetchable) [size=128K]
>         Capabilities: [dc] Power Management version 2
> 
> And here is the kernel log of e100 with highest debug level when sending
> out a few pings while other packets arrive on the network:
> 
> e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
> e100: Copyright(c) 1999-2005 Intel Corporation
> PCI: Found IRQ 10 for device 0000:00:12.0
> e100: eth0: e100_probe: addr 0xfc020000, irq 10, MAC addr 00:30:59:01:07:A7
> e100: eth0: e100_watchdog: right now = 35470
> e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
> e100: eth0: e100_intr: stat_ack = 0x04
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_watchdog: right now = 35970
> e100: eth0: e100_intr: stat_ack = 0x04
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_watchdog: right now = 36470
> e100: eth0: e100_intr: stat_ack = 0x04
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_watchdog: right now = 36970
> e100: eth0: e100_intr: stat_ack = 0x04
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_watchdog: right now = 37470
> e100: eth0: e100_intr: stat_ack = 0x04
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_watchdog: right now = 37970
> e100: eth0: e100_intr: stat_ack = 0x04
> e100: eth0: e100_watchdog: right now = 38470
> e100: eth0: e100_intr: stat_ack = 0x04
> e100: eth0: e100_intr: stat_ack = 0x40
> e100: eth0: e100_watchdog: right now = 38970
> e100: eth0: e100_intr: stat_ack = 0x04
> 
> I may find the time one day to debug this at lower levels, but you could
> accelerate this process with any pointer where to dig deeper precisely.

Can you include a full `dmesg` and `lcpci -vv -s 00:12.0` ?

Also you're using 3.5.10-k2, can you try the current git tree version instead? 
I can send you the e100.c if wanted.

Auke

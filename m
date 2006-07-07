Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWGGPYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWGGPYz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWGGPYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:24:55 -0400
Received: from tornado.reub.net ([202.89.145.182]:3307 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751049AbWGGPYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:24:54 -0400
Message-ID: <44AE7CC6.6090202@reub.net>
Date: Sat, 08 Jul 2006 03:24:54 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060707)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/07/2006 10:03 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> 
> 
> - A major update to the e1000 driver.
> 
> - 1394 updates

Some minor breakage in the e1000...

Fedora Core release 5.90 (Test)
Kernel 2.6.17-mm6 on an x86_64

tornado.reub.net login: e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <a>
   TDT                  <1c>
   next_to_use          <1c>
   next_to_clean        <8>
buffer_info[next_to_clean]
   time_stamp           <100027f1a>
   next_to_watch        <a>
   jiffies              <1000281d4>
   next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <a>
   TDT                  <1c>
   next_to_use          <1c>
   next_to_clean        <8>
buffer_info[next_to_clean]
   time_stamp           <100027f1a>
   next_to_watch        <a>
   jiffies              <1000283c8>
   next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <a>
   TDT                  <1c>
   next_to_use          <1c>
   next_to_clean        <8>
buffer_info[next_to_clean]
   time_stamp           <100027f1a>
   next_to_watch        <a>
   jiffies              <1000285bc>
   next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <a>
   TDT                  <1c>
   next_to_use          <1c>
   next_to_clean        <8>
buffer_info[next_to_clean]
   time_stamp           <100027f1a>
   next_to_watch        <a>
   jiffies              <1000287b0>
   next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <a>
   TDT                  <1c>
   next_to_use          <1c>
   next_to_clean        <8>
buffer_info[next_to_clean]
   time_stamp           <100027f1a>
   next_to_watch        <a>
   jiffies              <1000289a4>
   next_to_watch.status <0>


A look through my switch logs and kernel logs over the last few days shows these 
messages and layer 2/link down disconnections every few hours or so, but of very 
short duration (I hadn't noticed until now).

This output above was under virtually no load.

Both the e1000 and switch port on the other end are doing RX and TX flow control.

The controller is a built in chip on an Intel D945GNT board.

01:00.0 Ethernet controller: Intel Corporation 82573V Gigabit Ethernet 
Controller (Copper) (rev 03)
         Subsystem: Intel Corporation Unknown device 3094
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 313
         Region 0: Memory at 48000000 (32-bit, non-prefetchable) [size=128K]
         Region 2: I/O ports at 2000 [size=32]
         Capabilities: [c8] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable+
                 Address: 00000000fee0100c  Data: 4142
         Capabilities: [e0] Express Endpoint IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <512ns, L1 <64us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                 Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM unknown, Port 0
                 Link: Latency L0s <128ns, L1 <64us
                 Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                 Link: Speed 2.5Gb/s, Width x1

[root@tornado log]# ethtool -i eth0
driver: e1000
version: 7.1.9-k2-NAPI
firmware-version: 1.0-5
bus-info: 0000:01:00.0
[root@tornado log]#

Where can I go from here to help debug this further?

reuben

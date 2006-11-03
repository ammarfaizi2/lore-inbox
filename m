Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753401AbWKCRcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbWKCRcF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbWKCRcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:32:05 -0500
Received: from SMT02001.global-sp.net ([193.168.50.54]:40075 "EHLO
	SMT02001.global-sp.net") by vger.kernel.org with ESMTP
	id S1753401AbWKCRcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:32:02 -0500
Message-ID: <454B7C3A.3000308@privacy.net>
Date: Fri, 03 Nov 2006 18:28:26 +0100
From: John <me@privacy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux.nics@intel.com
Subject: Intel 82559 NIC corrupted EEPROM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2006 17:34:02.0210 (UTC) FILETIME=[409C2C20:01C6FF6E]
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck: 
X-MailScanner-From: me@privacy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an EBC-2000T motherboard with 3 on-board Intel 82559 NICs.

http://www.intel.com/design/network/products/lan/controllers/82559.htm
http://www.adlinktech.com/PD/web/PD_detail.php?pid=213
http://www.intel.com/support/network/adapter/1000/linux/e100.htm

Running a 2.6.14 kernel, the e100 driver refuses to load because
it detects a corrupted EEPROM.

cf. e100_eeprom_load()

   /* The checksum, stored in the last word, is calculated such that
    * the sum of words should be 0xBABA */
   checksum = le16_to_cpu(0xBABA - checksum);
   if(checksum != nic->eeprom[nic->eeprom_wc - 1]) {
         DPRINTK(PROBE, ERR, "EEPROM corrupted\n");
         if (!eeprom_bad_csum_allow)
                 return -EAGAIN;
   }

Several people have reported the same error. Intel's Auke Kok has
stated that ignoring the error is a BAD idea.

http://lkml.org/lkml/2006/7/10/215

What tool is used to reprogram the EEPROM? ethtool?
I suppose I'll have to ask the manufacturer for an updated EEPROM?


# ethtool -e eth0
Cannot get EEPROM data: Operation not supported

I'm not sure why I can't dump the contents of the EEPROM.
Does the driver need to be loaded?

On a totally unrelated note, does the 82559 support VLAN tagging?
(I believe the driver supports it.)

Thanks for reading this far.

Please note, email address is a bit-bucket.
I do monitor the mailing list.

Regards.

John

# lspci -vv
[...]
00:08.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 
100] (rev 08)
         Subsystem: Intel Corporation EtherExpress PRO/100B (TX)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min, 14000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at e5402000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at d800 [size=64]
         Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at 20000000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:09.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 
100] (rev 08)
         Subsystem: Intel Corporation EtherExpress PRO/100B (TX)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min, 14000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 12
         Region 0: Memory at e5401000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at dc00 [size=64]
         Region 2: Memory at e5100000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at 20100000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 
100] (rev 08)
         Subsystem: Intel Corporation EtherExpress PRO/100B (TX)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min, 14000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at e5400000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at e000 [size=64]
         Region 2: Memory at e5200000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at 20200000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-


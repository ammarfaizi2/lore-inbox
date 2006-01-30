Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWA3T7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWA3T7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWA3T7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:59:46 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:48613 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964933AbWA3T7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:59:45 -0500
Message-ID: <43DE7035.1040806@t-online.de>
Date: Mon, 30 Jan 2006 20:59:49 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: netdev@vger.kernel.org, jgarzik@pobox.com
Subject: [BUG] 8139too fails for ip autoconfig and nfsroot
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: ZqH3WYZTQeEaG+Q8r-ukLbBkoAEZyw3JIf9fqAXdo6YNWS3UqlDn64@t-dialin.net
X-TOI-MSGID: fd1ecd92-9015-4727-95b3-68ef132ac63d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a number of systems equipped with:

0000:05:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at d000 [size=1027M]
        Region 1: Memory at d0320000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Those cards have PXE boot roms.

There are no problems in normal operation, but something is totaly wrong 
when I
try to use those cards for network booting:

I compiled a kernel for nfsroot and dhcp ip autoconfiguration, 
configured the server and tried
to boot. Well, booting memtest and booting msdos works perfectly fine. 
Loading the kernel
is also no problem, but at the point of ip autoconfiguration (ip=dhcp) 
the kernel loops sending
DHCPDISCOVER packets. Those packets arrive at the server, and the server 
responds appropiately.
ic_bootp_recv() never gets called (checked by a printk). I suspected a 
server malconfiguration,
but found none. Skipping ip autoconfig is no solution, the kernel then 
fails trying rpc lookup.

Then I tried to netboot another system with the same kernel + via rhine 
driver, same server
config. Voila, dhcp ip autoconfig and rpc port lookup is not a problem 
on this system.

During my search for a solution I tried some recent kernels, the oldest 
2.6.14. All fail with 8139too.

Any ideas?

cu,
 Knut

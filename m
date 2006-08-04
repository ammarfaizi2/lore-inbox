Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWHDHY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWHDHY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWHDHY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:24:58 -0400
Received: from host2.marvell.com ([65.219.4.2]:1217 "EHLO maili.marvell.com")
	by vger.kernel.org with ESMTP id S1161086AbWHDHY5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:24:57 -0400
Content-class: urn:content-classes:message
Subject: RE: sk98lin extremely slow transfer rate ASUS P5P800(2.6.17.7)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 4 Aug 2006 09:24:54 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <4D634BCFD1A2144ABECC75FF512D7A9001095D41@SKGExch01.marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sk98lin extremely slow transfer rate ASUS P5P800(2.6.17.7)
Thread-Index: Aca3lQsga4VGOy0TSFqoVGyQsZebGQAAcBEQ
From: "SysKonnect Support" <support@syskonnect.de>
To: "Willy Tarreau" <w@1wt.eu>
Cc: "Sean Bruno" <sean.bruno@dsl-only.net>, <linux-kernel@vger.kernel.org>,
       <linux@syskonnect.de>
X-OriginalArrivalTime: 04 Aug 2006 07:24:57.0536 (UTC) FILETIME=[16B23400:01C6B797]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

the current driver version 8.34 includes a new common module, so please
give it a try and let me know.

Best regards,
Karim

Marvell(r) Semiconductor Germany GmbH 
------------------------------------- 
Karim Jamal 
Technical Support Engineer 
-------------------------------------- 
Phone: +49 (0) 7243502-330 
Fax: +49 (0) 7243502-364 
Mail: support@syskonnect.de 
Web: http:\\www.syskonnect.de 



-----Original Message-----
From: Willy Tarreau [mailto:w@1wt.eu] 
Sent: Friday, August 04, 2006 9:00 AM
To: SysKonnect Support
Cc: Sean Bruno; linux-kernel@vger.kernel.org; linux@syskonnect.de
Subject: Re: sk98lin extremely slow transfer rate ASUS P5P800(2.6.17.7)


Hi,

On Fri, Aug 04, 2006 at 08:50:33AM +0200, SysKonnect Support wrote:
> Hi Sean,
> 
> Did you test with the current driver version 8.34, which is vailable 
> on our website?

I've already observed the same behaviour (8.31 though). The problem was
that after sending a few thousands UDP packets, then next UDP packets
would not go out without some TCP traffic to "push" them outside. This
is a real problem on NFS (where I first noticed it). But for me, it
happened only on Yukon cards and not on Yukon2.

Hoping this helps,
Willy


> Best regards,
> Karim
>
> Marvell(r) Semiconductor Germany GmbH
> ------------------------------------- 
> Karim Jamal 
> Technical Support Engineer 
> -------------------------------------- 
> Phone: +49 (0) 7243502-330 
> Fax: +49 (0) 7243502-364 
> Mail: support@syskonnect.de 
> Web: http:\\www.syskonnect.de 
> 
> 
> 
> -----Original Message-----
> From: Sean Bruno [mailto:sean.bruno@dsl-only.net]
> Sent: Thursday, August 03, 2006 5:40 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux@syskonnect.de
> Subject: sk98lin extremely slow transfer rate ASUS P5P800(2.6.17.7)
> 
> 
> I am experiencing a very slow(32Kbytes per second) transfer rate on an

> ASUS P5P800 mobo.  This occurs on a special case where I am sending 
> individual 32Kbyte messages from a second server.
> 
> I suspect the hardware, but am not sure how to come up with a 'good' 
> regression test for this issue.
> 
> Configurations I have tried:
> 
> 1. If I swap out the ethernet adapter(tried a intel 10/100 and intel
> 10/100/1000) the transfer rate jumps up into the MBytes / second.
> 
> 2. If I do 'other' network activity on the box, like scp'ing' files 
> around, the transfer rate for my 32Kbyte packets goes up into the 
> Mbytes / second.  So I am a little baffled with the behavior.
> 
> 3. If I just 'scp' files around of various sizes the transfer rate 
> goes up into the Mbytes / second.
> 
> 
> 
> some of the relevant dmesg information:
> 
> eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
>       PrefPort:A  RlmtMode:Check Link State
> ...
> eth0: network connection up using port A
>     speed:           1000
>     autonegotiation: yes
>     duplex mode:     full
>     flowctrl:        symmetric
>     role:            slave
>     irq moderation:  disabled
>     scatter-gather:  disabled
>     tx-checksum:     disabled
>     rx-checksum:     disabled
> 
> 
> lspci -vvv output for the ethernet adapter:
> 02:05.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 
> Gigabit Ethernet Controller (rev 13)
>         Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit 
> Ethernet Controller (Asus)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (5750ns min, 7750ns max), Cache Line Size 04
>         Interrupt: pin A routed to IRQ 7
>         Region 0: Memory at fbffc000 (32-bit, non-prefetchable)
> [size=16K]
>         Region 1: I/O ports at e800 [size=256]
>         Expansion ROM at f0000000 [disabled] [size=128K]
>         Capabilities: [48] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1
> +,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [50] Vital Product Data
> 
> The Marvel ethernet adapter is connected to a Linksys SD2005 
> 10/100/1000 switch.
> 
> Any ideas why it would be doing this or a 'good' test for me to try?
> 
> Sean
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


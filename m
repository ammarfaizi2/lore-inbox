Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbUCIW12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUCIW11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:27:27 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:30216 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262246AbUCIW0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:26:48 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: PCI 2.2 card hangs the system. Need driver writer's advice
Date: Wed, 10 Mar 2004 00:18:49 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403100018.49602.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm going to tap on the collective experience of lkml
wrt dealing with hardware bugs and quirks.

I have a pair of SMC 2802w PCI 2.2 wireless NICs built
around Prism GT chipset (with ARM processor lurking inside).
There is a Linux driver for it at prism54.org.

I was going to deploy several 11g routers with these cards but
wanted to stress test them first. I fixed one easy bug but now
I've hit another one. Under bidirectional UDP flood + heavy
IDE write activity system freeze instantly and needs powercycling.
It turned out that card does something nasty to PCI bus
when driver does a readl() from PCI mapped space.
Even reset button does not return the card to sanity,
modprobe prism54 and you're toast.

All the details are at
http://prism54.org/cgi-bin/bugzilla/show_bug.cgi?id=67

I need to prevent this freeze by reprogramming card
and/or mainboard chipset.

Does anybody seen similar quirks before? Any ideas? Hints?
Does anybody have PDFs about my chipset? Here's the lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
00:0a.0 Network controller: Harris Semiconductor: Unknown device 3890 (rev 01)
00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)

Thanks.
--
vda


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUCPVZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUCPVZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:25:10 -0500
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:39869 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S261684AbUCPVYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:24:48 -0500
Message-ID: <4057709A.8080808@cogweb.net>
Date: Tue, 16 Mar 2004 13:24:42 -0800
From: Francis F Steen <steen@cogweb.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.3 ifdown race
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.6.3, if I take down the network connection, within a second 
or so top shows 99.9% CPU utilization for [events/0].
When I restablish a network connection, it calms down at once.

I had the same behavior in 2.6.0.

Details below -- what can I do to get more information on what is happening?

Cheers,
David

(Please cc: me)


#lspci
00:00.0 Host bridge: ALi Corporation M1671 Super P4 Northbridge 
[AGP4X,PCI and SDR/DDR] (rev 02)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem]
00:09.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan 
chipset (rev 01)
00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus 
Controller (rev 02)
00:0b.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:0b.1 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 
(MacPhyter) Ethernet Controller
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 
Go 32M] (rev a3)

#dmesg

natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
eth0: NatSemi DP8381[56] at 0xe089d000, 00:c0:9f:15:0f:59, IRQ 5.
eth0: link up.
eth0: Setting full-duplex based on negotiated link capability.
eth0: remaining active for wake-on-lan
eth0: link up.
eth0: Setting full-duplex based on negotiated link capability.

# ifdown eth0
# top

    3 root      15 -10     0    0    0 R 99.9  0.0   4:06.09 events/0

# ps aux | grep events

root         3  0.0  0.0     0    0 ?        RW<  Mar14   1:00 [events/0]




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132234AbRCYWwj>; Sun, 25 Mar 2001 17:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132243AbRCYWw3>; Sun, 25 Mar 2001 17:52:29 -0500
Received: from hercules.telenet-ops.be ([195.130.132.33]:25510 "HELO
	smtp1.pandora.be") by vger.kernel.org with SMTP id <S132234AbRCYWwM>;
	Sun, 25 Mar 2001 17:52:12 -0500
Date: Mon, 26 Mar 2001 01:12:22 +0200
From: wing tung Leung <tg@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: via-rhine driver: wicked 2005 problem
Message-ID: <20010326011222.A17042@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[Kernel 2.4.2, gcc-2.9.3 (same problem with egcs-2.91.66),
binutils-2.9.5.0.22-6]

[AMD Thunderbird, ABIT KT7A, no overclocking, D-Link DFE-530TX, 3Com
10Mbit hub, ATI Radeon AGP video, Matrox Mystique PCI video.]

When I download a big sized a few MB from the LAN using FTP, the hub
collision LED burns a lot, and after a few downloads the connection suddenly
hangs and syslog dumps:

Mar 25 16:44:03 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Mar 25 16:44:03 localhost kernel: eth0: Transmit timed out, status 0000, PHY
status 782d, resetting... 

I just need the restart the device using "/etc/rc.d/init.d/network restart"
and the connection is back. I just need to start a heavy download to initiate
the problem, uploading seems to work fine.

If I increase the debug level to 7, the logs contains:

Mar 25 16:44:01 localhost kernel: eth0: Transmit error, Tx status 00008100. 
Mar 25 16:44:01 localhost kernel: eth0: Something Wicked happened! 2009. 
Mar 25 16:44:01 localhost kernel: eth0: exiting interrupt, status=0x0000. 
Mar 25 16:44:01 localhost kernel: eth0: Interrupt, status 0001. 
Mar 25 16:44:01 localhost kernel:  In via_rhine_rx(), entry 5 status 05ee8f00. 
Mar 25 16:44:01 localhost kernel:   via_rhine_rx() status is 05ee8f00. 
Mar 25 16:44:01 localhost kernel: eth0: exiting interrupt, status=0x0000. 

I tried the diagnostic utilities from Donald Becker at Scyld.com, but I don't
know what I should be looking for. The text output seems ok to me.

I also tried to move the network card into other PCI slots, even tried to
throw out the AGP and PCI video card, but with no succes. This is an extract
from /proc/pci, and I don't think see any IRQ conflict there.

  Bus  0, device  11, function  0:
    Ethernet controller: VIA Technologies, Inc. Ethernet Controller (rev 67).
      IRQ 15.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xde000000 [0xde0000ff].

Last fact: when using M$ Windows, I get comparable FTP speeds, without the
locking. The subjective collision rate is about the same. I also have the
problem to need a cold boot after having used Windows, the network card
completely refuses to send or/and receive before pulling the power cord. The
via-rhine module *does* recognize the card correctly, but just is not able
to use it.

I know this kind of issues have come up in the past, but I haven't found any
real solution in the archives. Please redirect me to it if it does exist.

Regards,

Tung


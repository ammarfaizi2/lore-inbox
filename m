Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbRFTXcD>; Wed, 20 Jun 2001 19:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbRFTXbx>; Wed, 20 Jun 2001 19:31:53 -0400
Received: from w115.z208177135.sjc-ca.dsl.cnc.net ([208.177.135.115]:28551
	"EHLO technolunatic.com") by vger.kernel.org with ESMTP
	id <S264688AbRFTXbg>; Wed, 20 Jun 2001 19:31:36 -0400
Date: Wed, 20 Jun 2001 16:31:34 -0700
From: Dionysius Wilson Almeida <dwilson@technolunatic.com>
To: linux-kernel@vger.kernel.org
Subject: eepro100: wait_for_cmd_done timeout
Message-ID: <20010620163134.A22173@technolunatic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running Linux 2.4.5 from kernel.org on my Sony VAIO PCG-FX140 notebook.
I'm runing it on Debian Sid.  The problem i'm facing is that the ethernet card
hangs after every 2 minutes or so and this is consistent.  I've to bring down
the interface and bring it back up and then it works for another 2 minutes 
before freezing.

When i run Redhat 7.1 using redhat supplied intel's e100 driver, everything
works fine.  I tried compiling and loading this driver under Debian, but it
does not work (i.e. does not recognize any adapter).

I tried downloading the e100 driver from Intel site and loading that too..
but that too loads but does not find my adapter.  Further the sources which
came with redhat 7.1 does not compile under Debian Sid.

I tried looking for specific info but i've not been sucessful so far.

Here's what lspci outputs :
00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 11)
00:02.0 VGA compatible controller: Intel Corporation: Unknown device 1132 (rev 11)
00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448 (rev 03)
00:1f.0 ISA bridge: Intel Corporation: Unknown device 244c (rev 03)
00:1f.1 IDE interface: Intel Corporation: Unknown device 244a (rev 03)
00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A) (rev 03)
00:1f.3 SMBus: Intel Corporation 82820 820 (Camino 2) Chipset SMBus (rev 03)
00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub B) (rev 03)
00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev 03)
00:1f.6 Modem: Intel Corporation: Unknown device 2446 (rev 03)
01:00.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8021 (rev 02)
01:02.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
01:02.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
01:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2) Chipset Ethernet (rev 03)


And this is the log when the card hangs :
=========================================
Jun 20 16:10:18 debianlap kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun 20 16:10:18 debianlap kernel: eth0: Transmit timed out: status 0050  0c80 at 314/342 command 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0: Tx ring dump,  Tx queue 342 / 314:
Jun 20 16:10:18 debianlap kernel: eth0:     0 200c0000.
Jun 20 16:10:18 debianlap kernel: eth0:     1 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:     2 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:     3 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:     4 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:     5 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:     6 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:     7 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:     8 200c0000.
Jun 20 16:10:18 debianlap kernel: eth0:     9 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    10 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    11 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    12 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    13 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    14 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    15 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    16 200c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    17 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    18 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    19 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    20 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    21 400c0000.
Jun 20 16:10:18 debianlap kernel: eth0:   =22 000ca000.
Jun 20 16:10:18 debianlap kernel: eth0:    23 000ca000.
Jun 20 16:10:18 debianlap kernel: eth0:    24 200ca000.
Jun 20 16:10:18 debianlap kernel: eth0:    25 000ca000.
Jun 20 16:10:18 debianlap kernel: eth0:  * 26 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    27 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    28 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    29 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    30 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0:    31 000c0000.
Jun 20 16:10:18 debianlap kernel: eth0: Printing Rx ring (next to receive into 977, dirty index 977).
Jun 20 16:10:18 debianlap kernel: eth0:     0 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:     1 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:     2 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:     3 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:     4 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:     5 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:     6 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:     7 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:     8 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:     9 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    10 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    11 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    12 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    13 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    14 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    15 00000001.
Jun 20 16:10:18 debianlap kernel: eth0: l  16 c0000001.
Jun 20 16:10:18 debianlap kernel: eth0:  *=17 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    18 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    19 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    20 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    21 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    22 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    23 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    24 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    25 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    26 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    27 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    28 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    29 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    30 00000001.
Jun 20 16:10:18 debianlap kernel: eth0:    31 00000001.
Jun 20 16:14:07 debianlap kernel: eepro100: wait_for_cmd_done timeout!
Jun 20 16:14:38 debianlap last message repeated 5 times

-Wilson

-- 
We'll try to cooperate fully with the IRS, because, as citizens, we feel
a strong patriotic duty not to go to jail.
		-- Dave Barry

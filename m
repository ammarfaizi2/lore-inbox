Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTDNJqs (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTDNJqs (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:46:48 -0400
Received: from [195.95.38.160] ([195.95.38.160]:25335 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262930AbTDNJqn convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 05:46:43 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org, devilkin-lkml@blindguardian.org
Subject: [2.5.66] network device does not survive laptop suspend
Date: Mon, 14 Apr 2003 11:58:30 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304141158.43797.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello List,

I suspended my laptop this morning to move it from home to work without having 
to shhutdown everything. The laptop came nicely out of the suspend, except 
for my Cardbus ethernet device.

Since i resumed the laptop it hangs around every 10 seconds for around 2 
seconds. Everything hangs, from mouse movement, to audio playback, to 
pinging. This is seen in syslog, in great numbers:

eth0: Transmitter encountered 16 collisions -- network cable problem?
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 0(0) current 16(0)
  Transmit list ffffffff vs. ce6da200.
eth0: command 0x3002 did not complete! Status=0xffff
  0: @ce6da200  length 80000123 status 00000123
  1: @ce6da2a0  length 800000f9 status 000000f9
  2: @ce6da340  length 8000002a status 0000002a
  3: @ce6da3e0  length 8000002a status 0000002a
  4: @ce6da480  length 8000002a status 0000002a
  5: @ce6da520  length 8000002a status 0000002a
  6: @ce6da5c0  length 8000002a status 0000002a
  7: @ce6da660  length 8000002a status 0000002a
  8: @ce6da700  length 8000002a status 0000002a
  9: @ce6da7a0  length 8000002a status 0000002a
  10: @ce6da840  length 8000002a status 0000002a
  11: @ce6da8e0  length 8000002a status 0000002a
  12: @ce6da980  length 8000002a status 0000002a
  13: @ce6daa20  length 8000002a status 0000002a
  14: @ce6daac0  length 8000002a status 8000002a
  15: @ce6dab60  length 8000002a status 8000002a
eth0: command 0x5800 did not complete! Status=0xffff
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status ff status ffff.
  diagnostics: net ffff media ffff dma ffffffff fifo ffff
eth0: Transmitter encountered 16 collisions -- network cable problem?
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 0(0) current 16(0)
  Transmit list ffffffff vs. ce6da200.
eth0: command 0x3002 did not complete! Status=0xffff
  0: @ce6da200  length 80000123 status 00000123
  1: @ce6da2a0  length 800000f9 status 000000f9
  2: @ce6da340  length 8000002a status 0000002a
  3: @ce6da3e0  length 8000002a status 0000002a
  4: @ce6da480  length 8000002a status 0000002a
  5: @ce6da520  length 8000002a status 0000002a
  6: @ce6da5c0  length 8000002a status 0000002a
  7: @ce6da660  length 8000002a status 0000002a
  8: @ce6da700  length 8000002a status 0000002a
  9: @ce6da7a0  length 8000002a status 0000002a
  10: @ce6da840  length 8000002a status 0000002a
  11: @ce6da8e0  length 8000002a status 0000002a
  12: @ce6da980  length 8000002a status 0000002a
  13: @ce6daa20  length 8000002a status 0000002a
  14: @ce6daac0  length 8000002a status 8000002a
  15: @ce6dab60  length 8000002a status 8000002a
eth0: command 0x5800 did not complete! Status=0xffff
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out

The module in question is loaded directly, 3c59x, and was not unloaded prior 
to the suspend.

Hardware:

Dell Latitude CPj 650Mhz

00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00bb
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	16-bit legacy interface ports at 0001

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00bb
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	16-bit legacy interface ports at 0001

02:00.0 Ethernet controller: 3Com Corporation 3c575 [Megahertz] 10/100 LAN 
CardBus (rev 01)
	Subsystem: 3Com Corporation 3C575 Megahertz 10/100 LAN Cardbus PC Card
	Flags: medium devsel, IRQ 11
	I/O ports at 1000 [disabled] [size=128]
	[virtual] Memory at 10800000 (32-bit, non-prefetchable) [disabled] [size=128]
	[virtual] Memory at 10800080 (32-bit, non-prefetchable) [disabled] [size=128]
	Expansion ROM at 10400000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 1


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+moZQpuyeqyCEh60RAl/yAJ9BcjPFuxj7BuBjteohfn7hEHD55gCeKPyx
5hKlYvdT+h6MTGcfs/wDEuE=
=bOt0
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311443AbSCTDPX>; Tue, 19 Mar 2002 22:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311459AbSCTDPO>; Tue, 19 Mar 2002 22:15:14 -0500
Received: from pool-151-197-241-89.phil.east.verizon.net ([151.197.241.89]:22935
	"EHLO porsche.genebrew.com") by vger.kernel.org with ESMTP
	id <S311443AbSCTDO7>; Tue, 19 Mar 2002 22:14:59 -0500
Message-ID: <33032.192.168.1.1.1016594386.squirrel@porsche.genebrew.com>
Date: Tue, 19 Mar 2002 22:19:46 -0500 (EST)
Subject: 3Com 556B Tornado not working
From: "Rahul Karnik" <rahul@genebrew.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a HP Omnibook 500 with a 3Com 556B miniPCI ethernet/modem combo. Try
as I might, I can't seem to get the card to connect to the network. My
question is, how do I figure out what is the problem here? At this point, I
do not know if the card or the kernel is at fault. Please CC me as I am not
subscribed to the list.

Thanks for your help,
Rahul

P.S. This is on RedHat 7.2 with kernel 2.4.9-31. Please let me know if I
should upgrade to the stock kernel.

Here is the output from "modprobe 3c59x debug=7":

Mar 19 22:24:30 quicksilver kernel:   Enabling bus-master transmits and
whole-frame receives.
Mar 19 22:24:30 quicksilver kernel: 00:0b.0: scatter/gather enabled. h/w
checksums enabled
Mar 19 22:24:30 quicksilver kernel: eth0: Media override to transceiver 8
(Autonegotiate).
Mar 19 22:24:30 quicksilver kernel: eth0: MII #0 status 7849, link partner
capability 0001, info1 0010, setting half-duplex.
Mar 19 22:25:58 quicksilver kernel: eth0: vortex_error(), status=0xe081
Mar 19 22:26:30 quicksilver dhcpcd[1634]: timed out waiting for a valid DHCP
server response

The following is the output from vortex-diag:

[root@quicksilver root]# ./vortex-diag -af
vortex-diag.c:v2.05 5/15/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3c566 Laptop Tornado adapter at 0x1400.
Initial window 7, registers values by window:
  Window 0: 0000 0000 e720 0000 0000 01f5 00aa 0000.
  Window 1: 0000 0028 0700 0000 0000 007f 0000 2000.
  Window 2: 0400 4d76 3fda 0000 0000 0000 0000 4000.
  Window 3: 0040 0080 05ea 0000 0040 1000 0800 6000.
  Window 4: 0000 0000 0000 0050 0003 8000 0000 8000.
  Window 5: 1ffc 0000 0000 0600 0805 0000 06c6 a000.
  Window 6: 0000 0000 0000 0000 0000 0000 0000 c000.
  Window 7: 0000 0000 0000 0000 0000 0000 0000 e000.
Vortex chip registers at 0x1400
  0x1410: 00000000 00000000 00000093 00000000
  0x1420: 00000020 00000000 00080000 00000004
  0x1430: 00000000 3ef5c10b 00000000 00080004
 Indication enable is 06c6, interrupt enable is 0000.
 No interrupt sources are pending.
 Transceiver/media interfaces available:  MII.
Transceiver type in use:  Autonegotiate.
 MAC settings: half-duplex.
 Station address set to 00:04:76:4d:da:3f.
 Configuration options 0000.

Finally, mii-diag:

[root@quicksilver root]# ./mii-diag -v
mii-diag.c:v2.03 11/5/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Using the default interface 'eth0'.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 Basic mode status register 0x7849 ... 7849.
   Link status: not established.
   This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation not complete.
   End of basic transceiver information.

 MII PHY #0 transceiver registers:
   3000 7849 0022 561b 01e1 0001 0004 2001
   ffff ffff ffff ffff ffff ffff ffff ffff
   01c0 0000 0000 8020 4f02 0304 0026 0000
   0000 bfbf 0000 ffff ffff ffff ffff ffff.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 Basic mode status register 0x7849 ... 7849.
   Link status: not established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation not complete.
 Vendor ID is 00:08:95:--:--:--, model 33 rev. 11.
   Vendor/Part: AdHoc Technology AH101LF.
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 0001:.
   Negotiation did not complete.
  TDK format vendor-specific registers 16..18 are 0x01c0 0x0000 0x0000
      Link polarity is detected as normal.
      Auto-negotiation complete, 10Mbps half duplex.
      Rx link in fail state, PLL locked.
      No new link status events.



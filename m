Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274174AbRISUkZ>; Wed, 19 Sep 2001 16:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274180AbRISUkR>; Wed, 19 Sep 2001 16:40:17 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:61840 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S274174AbRISUkE>;
	Wed, 19 Sep 2001 16:40:04 -0400
Message-ID: <3BA902B6.923D7ACA@candelatech.com>
Date: Wed, 19 Sep 2001 13:40:22 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard. [EEPRO-100 bugs]
In-Reply-To: <E15jnal-0003kR-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Damn..someone has to make good stable motherboards...anyone got any
> > suggestions for one that will fit into a 1U server, with built-in
> > Video and preferably a NIC?  I had ok luck with an Intel board based
> > on the 815 chipset, so long as I used the e100 driver...maybe I'll
> > have to go back to it...
> 
> The 815 + e100 thing is _not_ a hardware issue. Its some subtle driver
> related things, and of course Intel are keen to push e100 rather than
> help people fix the kernel driver so not much help.
> 

If they'd only implement the mii-diags I would just use theirs...

> I've fixed some of the problems in recent -ac (the power management timeout)
> which is now in Linus tree. Arjan van de Ven also fixed some other bits.

Do you think you've fixed this?  If so, I'll give your version a try...


I get all kinds of crap on the pre11 build with the eepro100, but only
on one of my 4 Intel NICs.  The driver messages call it an 82557, but the
chip says 82559.  I'm not sure if that is significant or not...


/var/log/messages snippet:

Sep 19 13:27:42 lanf1 last message repeated 24 times
Sep 19 13:27:46 lanf1 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Sep 19 13:27:46 lanf1 kernel: eth1: Transmit timed out: status 0090  0c80 at 194636/194664 command 000c0000.
Sep 19 13:27:51 lanf1 kernel: eepro100: wait_for_cmd_done timeout!
Sep 19 13:27:51 lanf1 last message repeated 24 times
Sep 19 13:27:54 lanf1 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Sep 19 13:27:54 lanf1 kernel: eth1: Transmit timed out: status 0090  0c80 at 210712/210740 command 200c0000.
Sep 19 13:28:11 lanf1 kernel: eepro100: wait_for_cmd_done timeout!
Sep 19 13:28:11 lanf1 last message repeated 24 times
Sep 19 13:28:14 lanf1 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Sep 19 13:28:14 lanf1 kernel: eth1: Transmit timed out: status 0090  0c80 at 251298/251326 command 000c0000.
Sep 19 13:28:16 lanf1 kernel: eepro100: wait_for_cmd_done timeout!
Sep 19 13:28:16 lanf1 last message repeated 24 times
Sep 19 13:28:20 lanf1 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Sep 19 13:28:20 lanf1 kernel: eth1: Transmit timed out: status 0090  0c80 at 260668/260696 command 000c0000.
Sep 19 13:28:23 lanf1 kernel: eepro100: wait_for_cmd_done timeout!
Sep 19 13:28:23 lanf1 last message repeated 24 times
Sep 19 13:28:26 lanf1 sshd(pam_unix)[1977]: session opened for user root by (uid=0)
Sep 19 13:28:26 lanf1 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Sep 19 13:28:26 lanf1 kernel: eth1: Transmit timed out: status 0090  0c80 at 273076/273104 command 000c0000.
Sep 19 13:28:54 lanf1 kernel: eepro100: wait_for_cmd_done timeout!
Sep 19 13:28:54 lanf1 last message repeated 24 times
Sep 19 13:28:58 lanf1 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Sep 19 13:28:58 lanf1 kernel: eth1: Transmit timed out: status 0090  0c80 at 334769/334797 command 000c0000.



dmesg shows this:
.....
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
VFS: Disk change detected on device ide1(22,0)
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out: status 0090  0c80 at 401389/401417 command 000c0000.
eth1: Tx ring dump,  Tx queue 401417 / 401389:
eth1:     0 200c0000.
eth1:     1 000c0000.
eth1:     2 000c0000.
eth1:     3 000c0000.
eth1:     4 000c0000.
eth1:     5 000c0000.
eth1:     6 000c0000.
eth1:     7 000c0000.
eth1:     8 600c0000.
eth1:   = 9 000ca000.
eth1:    10 000ca000.
eth1:    11 000ca000.
eth1:    12 000ca000.
eth1:  * 13 000c0000.
eth1:    14 000c0000.
eth1:    15 000c0000.
eth1:    16 200c0000.
eth1:    17 000c0000.
eth1:    18 000c0000.
eth1:    19 000c0000.
eth1:    20 000c0000.
eth1:    21 000c0000.
eth1:    22 000c0000.
eth1:    23 000c0000.
eth1:    24 200c0000.
eth1:    25 000c0000.
eth1:    26 000c0000.
eth1:    27 000c0000.
eth1:    28 000c0000.
eth1:    29 000c0000.
eth1:    30 000c0000.
eth1:    31 000c0000.
eth1: Printing Rx ring (next to receive into 43202, dirty index 43202).
eth1:     0 00000001.
eth1: l   1 c0000001.
eth1:  *= 2 00000001.
eth1:     3 00000001.
eth1:     4 00000001.
eth1:     5 00000001.
eth1:     6 00000001.
eth1:     7 00000001.
eth1:     8 00000001.
eth1:     9 00000001.
eth1:    10 00000001.
eth1:    11 00000001.
eth1:    12 00000001.
eth1:    13 00000001.
eth1:    14 00000001.
eth1:    15 00000001.
eth1:    16 00000001.
eth1:    17 00000001.
eth1:    18 00000001.
eth1:    19 00000001.
eth1:    20 00000001.
eth1:    21 00000001.
eth1:    22 00000001.
eth1:    23 00000001.
eth1:    24 00000001.
eth1:    25 00000001.
eth1:    26 00000001.
eth1:    27 00000001.
eth1:    28 00000001.
eth1:    29 00000001.
eth1:    30 00000001.
eth1:    31 00000001.
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
.....


Here's the boot messages:

Sep 19 13:20:49 lanf1 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Sep 19 13:20:49 lanf1 kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and o
thers
Sep 19 13:20:49 lanf1 kernel: PCI: Found IRQ 10 for device 01:0b.0
Sep 19 13:20:49 lanf1 kernel: eth0: Intel Corporation 82557 [Ethernet Pro 100] (#3), 00:E0:81:03:B9:77, IRQ 10.
Sep 19 13:20:49 lanf1 kernel:   Board assembly 567812-052, Physical connectors present: RJ45
Sep 19 13:20:49 lanf1 kernel:   Primary interface chip i82555 PHY #1.
Sep 19 13:20:49 lanf1 kernel:   General self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   Serial sub-system self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   Internal registers self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   ROM checksum self-test: passed (0x04f4518b).
Sep 19 13:20:49 lanf1 kernel: PCI: Found IRQ 4 for device 01:09.0
Sep 19 13:20:49 lanf1 kernel: eth1: Intel Corporation 82557 [Ethernet Pro 100] (#2), 00:90:27:65:39:18, IRQ 4.
Sep 19 13:20:49 lanf1 kernel:   Board assembly 721383-006, Physical connectors present: RJ45
Sep 19 13:20:49 lanf1 kernel:   Primary interface chip i82555 PHY #1.
Sep 19 13:20:49 lanf1 kernel:   General self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   Serial sub-system self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   Internal registers self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   ROM checksum self-test: passed (0x04f4518b).
Sep 19 13:20:49 lanf1 kernel: PCI: Found IRQ 5 for device 01:04.0
Sep 19 13:20:49 lanf1 kernel: PCI: Sharing IRQ 5 with 00:1f.3
Sep 19 13:20:49 lanf1 kernel: eth2: Intel Corporation 82557 [Ethernet Pro 100], 00:90:27:35:45:AB, IRQ 5.
Sep 19 13:20:49 lanf1 kernel:   Receiver lock-up bug exists -- enabling work-around.
Sep 19 13:20:49 lanf1 kernel:   Board assembly 689661-004, Physical connectors present: RJ45
Sep 19 13:20:49 lanf1 kernel:   Primary interface chip i82555 PHY #1.
Sep 19 13:20:49 lanf1 kernel:   General self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   Serial sub-system self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   Internal registers self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   ROM checksum self-test: passed (0x24c9f043).
Sep 19 13:20:49 lanf1 kernel:   Receiver lock-up workaround activated.
Sep 19 13:20:49 lanf1 kernel: PCI: Found IRQ 11 for device 01:08.0
Sep 19 13:20:49 lanf1 kernel: eth3: Invalid EEPROM checksum 0xff00, check settings before activating this device!
Sep 19 13:20:49 lanf1 kernel: eth3: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 11.
Sep 19 13:20:49 lanf1 kernel:   Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
Sep 19 13:20:49 lanf1 kernel:   Primary interface chip unknown-15 PHY #31.
Sep 19 13:20:49 lanf1 kernel:     Secondary interface chip i82555.
Sep 19 13:20:49 lanf1 kernel:   General self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   Serial sub-system self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   Internal registers self-test: passed.
Sep 19 13:20:49 lanf1 kernel:   ROM checksum self-test: passed (0x04f4518b).

> 
> I'd be interested to know if that helps (to keep the test simple and single
> variable you can use the -ac eepro100.c file in Linus 2.4.9)
> 
> Alan

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

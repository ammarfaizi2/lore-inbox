Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274002AbRISFFF>; Wed, 19 Sep 2001 01:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274003AbRISFE4>; Wed, 19 Sep 2001 01:04:56 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:54922 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S274002AbRISFEo>;
	Wed, 19 Sep 2001 01:04:44 -0400
Message-ID: <3BA82777.13872CFD@candelatech.com>
Date: Tue, 18 Sep 2001 22:04:55 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: eepro list <eepro100@scyld.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [eepro100] eepro100 driver (2.4 kernel) fails with S2080 Tomcati815t 
 motherboard.
In-Reply-To: <Pine.LNX.4.10.10109190016140.19173-100000@vaio.greennet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interestingly enough, when I manually set a MAC it seems to pass traffic,
at least at low speeds.  I'm about to crank it up a bit to see what
falls out :)

(Working fine at 10Mbps (about 4200 packets-per-second..)


Donald Becker wrote:
> 
> On Tue, 18 Sep 2001, Ben Greear wrote:
> 
> > I have a Tyan motherboard (S2080 Tomcat i815t) with 2 built-in NICs.
> >
> > The manual claims this:
> >
> > "One Intel 82559 LAN controller
> >  One ICH2 LAN controller"
> >
> > Seems that the eepro driver tries to bring up both of
> > them, and fails to read the eeprom on the second one it
> > scans.  One visible result is that the MAC is all FF's.
> 
> Does the diagnostic program correctly read the EEPROM on both cards?
> If so, my driver release should work with the cards.
>

It doesn't seem to...


[root@lanf1 /root]# eepro100-diag -aaeemmf -#1
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82562 EEPro100 adapter at 0xdd80.
i82557 chip registers at 0xdd80:
  0c000050 0f162000 00000000 00080002 1be7ffff 00000600
  No interrupt sources are pending.
   The transmit unit state is 'Suspended'.
   The receive unit state is 'Ready'.
  This status is normal for an activated but idle interface.
 The Command register has an unprocessed command 0c00(?!).
EEPROM contents, size 256x16:
    00: ffff ffff ffff ffff ffff ffff ffff ffff
  0x08: ffff ffff ffff ffff ffff ffff ffff ffff
  0x10: ffff ffff ffff ffff ffff ffff ffff ffff
  0x18: ffff ffff ffff ffff ffff ffff ffff ffff
  0x20: ffff ffff ffff ffff ffff ffff ffff ffff
  0x28: ffff ffff ffff ffff ffff ffff ffff ffff
  0x30: ffff ffff ffff ffff ffff ffff ffff ffff
  0x38: ffff ffff ffff ffff ffff ffff ffff ffff
  0x40: ffff ffff ffff ffff ffff ffff ffff ffff
  0x48: ffff ffff ffff ffff ffff ffff ffff ffff
  0x50: ffff ffff ffff ffff ffff ffff ffff ffff
  0x58: ffff ffff ffff ffff ffff ffff ffff ffff
  0x60: ffff ffff ffff ffff ffff ffff ffff ffff
  0x68: ffff ffff ffff ffff ffff ffff ffff ffff
  0x70: ffff ffff ffff ffff ffff ffff ffff ffff
  0x78: ffff ffff ffff ffff ffff ffff ffff ffff
  0x80: ffff ffff ffff ffff ffff ffff ffff ffff
  0x88: ffff ffff ffff ffff ffff ffff ffff ffff
  0x90: ffff ffff ffff ffff ffff ffff ffff ffff
  0x98: ffff ffff ffff ffff ffff ffff ffff ffff
  0xa0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xa8: ffff ffff ffff ffff ffff ffff ffff ffff
  0xb0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xb8: ffff ffff ffff ffff ffff ffff ffff ffff
  0xc0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xc8: ffff ffff ffff ffff ffff ffff ffff ffff
  0xd0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xd8: ffff ffff ffff ffff ffff ffff ffff ffff
  0xe0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xe8: ffff ffff ffff ffff ffff ffff ffff ffff
  0xf0: ffff ffff ffff ffff ffff ffff ffff ffff
  0xf8: ffff ffff ffff ffff ffff ffff ffff ffff
 *****  The EEPROM checksum is INCORRECT!  *****
  The checksum is 0xFF00, it should be 0xBABA!
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address FF:FF:FF:FF:FF:FF.
  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
  Primary interface chip i82555 PHY #-1.
    Secondary interface chip i82555, PHY -1.
  Baseline value of MII status register is 0000.

[root@lanf1 /root]# 

> > eth0: Intel Corporation 82557 [Ethernet Pro 100] (#3), 00:E0:81:03:B9:7B, IRQ 10.
> > eth1: Intel Corporation 82557 [Ethernet Pro 100] (#2), 00:90:27:65:39:1B, IRQ 3.
> > eth2: Intel Corporation 82557 [Ethernet Pro 100], 00:90:27:65:37:8A, IRQ 9.
> > eth3: Invalid EEPROM checksum 0xff00, check settings before activating this device!
> > eth3: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 11.
> 
> > [root@lanf2 /root]# eepro100-diag -aaeemmf eth3
> 
> The diagnostic does not (and cannot) know which card is "eth3".
> (Consider the case where no driver is loaded.)

I wish it would have complained about me sending it eth3 then, so
I would have known!

> 
> You must specify the interface to examine with e.g. "-#3"

Thanks,
Ben


> 
> Donald Becker                           becker@scyld.com
> Scyld Computing Corporation             http://www.scyld.com
> 410 Severn Ave. Suite 210               Second Generation Beowulf Clusters
> Annapolis MD 21403                      410-990-9993
> 
> _______________________________________________
> eepro100 mailing list
> eepro100@scyld.com
> http://www.scyld.com/mailman/listinfo/eepro100

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

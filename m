Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273985AbRISCU2>; Tue, 18 Sep 2001 22:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273986AbRISCUT>; Tue, 18 Sep 2001 22:20:19 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:26761 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S273985AbRISCUF>;
	Tue, 18 Sep 2001 22:20:05 -0400
Message-ID: <3BA800DD.8C72F065@candelatech.com>
Date: Tue, 18 Sep 2001 19:20:13 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: eepro list <eepro100@scyld.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: eepro100 driver (2.4 kernel) fails with S2080 Tomcat i815t motherboard.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Tyan motherboard (S2080 Tomcat i815t) with 2 built-in NICs.

The manual claims this:

"One Intel 82559 LAN controller
 One ICH2 LAN controller"

Seems that the eepro driver tries to bring up both of
them, and fails to read the eeprom on the second one it
scans.  One visible result is that the MAC is all FF's.

I have two other EEPRO NICs in the system, and they seem to be
detected first.

The kernel is 2.4.10-pre11:
[root@lanf2 /root]# dmesg | more
Linux version 2.4.10-pre11 (root@lanf2) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #3 Tue Sep 18
 10:07:01 MST 2001
The same problem is appearant with RH's 7.1 kernels (the upgrade 2.4.3* too).


Here is a pertinent part of the dmesg.  eepro100-diag messages
follow below, along with an 'ifconfig -a'.

The kernel is 2.4.10-pre11:
[root@lanf2 /root]# dmesg | more
Linux version 2.4.10-pre11 (root@lanf2) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #3 Tue Sep 18
 10:07:01 MST 2001



eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 10 for device 01:0b.0
eth0: Intel Corporation 82557 [Ethernet Pro 100] (#3), 00:E0:81:03:B9:7B, IRQ 10.
  Board assembly 567812-052, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PCI: Found IRQ 3 for device 01:09.0
eth1: Intel Corporation 82557 [Ethernet Pro 100] (#2), 00:90:27:65:39:1B, IRQ 3.
  Board assembly 721383-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PCI: Found IRQ 9 for device 01:04.0
PCI: Sharing IRQ 9 with 00:1f.3
eth2: Intel Corporation 82557 [Ethernet Pro 100], 00:90:27:65:37:8A, IRQ 9.
  Board assembly 721383-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PCI: Found IRQ 11 for device 01:08.0
eth3: Invalid EEPROM checksum 0xff00, check settings before activating this device!
eth3: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 11.
  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
  Primary interface chip unknown-15 PHY #31.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).





[root@lanf2 /root]# eepro100-diag         
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xdf00.
A potential i82557 chip has been found, but it appears to be active.
Either shutdown the network, or use the '-f' flag.
Index #2: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xde80.
Index #3: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xdd00.
Index #4: Found a Intel i82562 EEPro100 adapter at 0xdd80.
 Use '-a' or '-aa' to show device registers,
     '-e' to show EEPROM contents, -ee for parsed contents,
  or '-m' or '-mm' to show MII management registers.


[root@lanf2 /root]# eepro100-diag -aaeemmf eth3
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xdf00.
i82557 chip registers at 0xdf00:
  0c000090 0f22c000 00000000 00080002 18250021 00000600
  No interrupt sources are pending.
   The transmit unit state is 'Active'.
   The receive unit state is 'Ready'.
  This status is unusual for an activated interface.
 The Command register has an unprocessed command 0c00(?!).
EEPROM contents, size 64x16:
    00: e000 0381 7bb9 0403 0000 0201 4701 0000
  0x08: 5678 1234 4082 100c 8086 0000 0000 0000
      ...
  0x30: 0128 0000 0000 0000 0000 0000 0000 0000
  0x38: 0000 0000 0000 0000 0000 0000 0000 d393
 The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address 00:E0:81:03:B9:7B.
  Board assembly 567812-052, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
 MII PHY #1 transceiver registers:
  3000 782d 02a8 0154 05e1 0021 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0400 0000 0001 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000.
  Baseline value of MII status register is 782d.



[root@lanf2 /root]# eepro100-diag -aaeemmf eth2
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xdf00.
i82557 chip registers at 0xdf00:
  0c000090 0f22c000 00000000 00080002 18250021 00000600
  No interrupt sources are pending.
   The transmit unit state is 'Active'.
   The receive unit state is 'Ready'.
  This status is unusual for an activated interface.
 The Command register has an unprocessed command 0c00(?!).
EEPROM contents, size 64x16:
    00: e000 0381 7bb9 0403 0000 0201 4701 0000
  0x08: 5678 1234 4082 100c 8086 0000 0000 0000
      ...
  0x30: 0128 0000 0000 0000 0000 0000 0000 0000
  0x38: 0000 0000 0000 0000 0000 0000 0000 d393
 The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address 00:E0:81:03:B9:7B.
  Board assembly 567812-052, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
 MII PHY #1 transceiver registers:
  3000 782d 02a8 0154 05e1 0021 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0400 0000 0001 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000.
  Baseline value of MII status register is 782d.

[root@lanf2 /root]# eepro100-diag -aaeemmf eth1
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xdf00.
i82557 chip registers at 0xdf00:
  0c000090 0f22c000 00000000 00080002 18250021 00000600
  No interrupt sources are pending.
   The transmit unit state is 'Active'.
   The receive unit state is 'Ready'.
  This status is unusual for an activated interface.
 The Command register has an unprocessed command 0c00(?!).
EEPROM contents, size 64x16:
    00: e000 0381 7bb9 0403 0000 0201 4701 0000
  0x08: 5678 1234 4082 100c 8086 0000 0000 0000
      ...
  0x30: 0128 0000 0000 0000 0000 0000 0000 0000
  0x38: 0000 0000 0000 0000 0000 0000 0000 d393
 The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address 00:E0:81:03:B9:7B.
  Board assembly 567812-052, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
 MII PHY #1 transceiver registers:
  3000 782d 02a8 0154 05e1 0021 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0400 0000 0001 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000.
  Baseline value of MII status register is 782d.

[root@lanf2 /root]# eepro100-diag -aaeemmf eth0
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xdf00.
i82557 chip registers at 0xdf00:
  0c000090 0f22c000 00000000 00080002 18250021 00000600
  No interrupt sources are pending.
   The transmit unit state is 'Active'.
   The receive unit state is 'Ready'.
  This status is unusual for an activated interface.
 The Command register has an unprocessed command 0c00(?!).
EEPROM contents, size 64x16:
    00: e000 0381 7bb9 0403 0000 0201 4701 0000
  0x08: 5678 1234 4082 100c 8086 0000 0000 0000
      ...
  0x30: 0128 0000 0000 0000 0000 0000 0000 0000
  0x38: 0000 0000 0000 0000 0000 0000 0000 d393
 The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address 00:E0:81:03:B9:7B.
  Board assembly 567812-052, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
 MII PHY #1 transceiver registers:
  3000 782d 02a8 0154 05e1 0021 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0400 0000 0001 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000.
  Baseline value of MII status register is 782d.

[root@lanf2 /root]# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:E0:81:03:B9:7B  
          inet addr:192.168.1.56  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:412 errors:0 dropped:0 overruns:0 frame:0
          TX packets:278 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:10 Base address:0xe000 

eth1      Link encap:Ethernet  HWaddr 00:90:27:65:39:1B  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:3 

eth2      Link encap:Ethernet  HWaddr 00:90:27:65:37:8A  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:9 Base address:0x2000 

eth3      Link encap:Ethernet  HWaddr FF:FF:FF:FF:FF:FF  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:11 Base address:0x4000 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:18 errors:0 dropped:0 overruns:0 frame:0
          TX packets:18 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 





-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

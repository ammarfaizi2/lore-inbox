Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132652AbRC2DBF>; Wed, 28 Mar 2001 22:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132653AbRC2DA4>; Wed, 28 Mar 2001 22:00:56 -0500
Received: from hercules.telenet-ops.be ([195.130.132.33]:61366 "HELO
	smtp1.pandora.be") by vger.kernel.org with SMTP id <S132652AbRC2DAt>;
	Wed, 28 Mar 2001 22:00:49 -0500
Date: Thu, 29 Mar 2001 04:20:48 +0200
From: wing tung Leung <tg@skynet.be>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
   urban@svenskatest.se
Subject: Re: via-rhine driver: wicked 2005 problem
Message-ID: <20010329042048.A1589@skynet.be>
In-Reply-To: <3ABEEAFE.81CA76A3@colorfullife.com> <20010326185641.A19619@skynet.be> <3ABF7376.D6F79A4B@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3ABF7376.D6F79A4B@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii

On Mon, Mar 26, 2001 at 11:51:02AM -0500, Jeff Garzik wrote:
> 
> If the problem is still not solved, could you download via-diag.c and
> libmii.c from ftp://www.scyld.com/pub/diag/   Compile instructions are
> at the bottom of via-diag.c.  I'm interested in seeing two via-diag
> register snapshots, one from a cold boot (where it is working), and one
> from a warm boot.
> 
>   ./via-diag -maaavvveef > via-diag-cold.txt
> 	and
>   ./via-diag -maaavvveef > via-diag-warm.txt
> 	then
>    diff -u v*cold.txt v*warm.txt | send mail...
> 
> And to see if the PCI configuration registers change between warm boot
> and cold boot, run lspci from pciutils:
> 
>   lspci -vvvxxx > lspci-cold.txt
> 	and
>   lspci -vvvxxx > lspci-warm.txt
> 	then
>   diff -u l*cold.txt l*warm.txt | send mail...

I still have the boot problem, these are the diffs you asked for. I hope
they are useful. (using 2.4.3-pre8)

I had to include the driver in the kernel, and could not load it as module,
I don't know why.

==
[root@twisted /root]# modprobe via-rhine
/lib/modules/2.4.3-pre8/kernel/drivers/net/via-rhine.o: unresolved symbol alloc_etherdev
/lib/modules/2.4.3-pre8/kernel/drivers/net/via-rhine.o: unresolved symbol unregister_netdev
/lib/modules/2.4.3-pre8/kernel/drivers/net/via-rhine.o: unresolved symbol register_netdev
/lib/modules/2.4.3-pre8/kernel/drivers/net/via-rhine.o: insmod /lib/modules/2.4.3-pre8/kernel/drivers/net/via-rhine.o failed
/lib/modules/2.4.3-pre8/kernel/drivers/net/via-rhine.o: insmod via-rhine failed
==





--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.diff"

--- lspci-cold.txt	Thu Mar 29 04:10:49 2001
+++ lspci-warm.txt	Thu Mar 29 04:08:04 2001
@@ -65,7 +65,7 @@
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
 30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
-40: 08 01 00 00 00 80 60 e6 05 01 84 00 00 00 f0 f3
+40: 08 01 00 00 00 80 60 ee 05 01 84 00 00 00 f0 f3
 50: 00 00 04 00 00 a0 0b f0 00 06 ff 08 50 00 00 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 70: 00 00 00 00 05 1e 00 02 00 00 f0 40 00 00 00 00
@@ -115,7 +115,7 @@
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00
 40: 20 84 5c 00 ba 70 00 00 01 40 00 00 d8 10 00 00
-50: 00 fe ff 88 50 04 00 00 00 ff ff 00 00 00 00 00
+50: 00 ff ff 88 50 04 00 00 00 ff ff 00 00 00 00 00
 60: 00 00 00 00 00 00 00 00 01 00 02 00 00 00 00 00
 70: 01 60 00 00 01 00 00 00 00 00 00 00 00 00 00 00
 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-diag.diff"

--- via-diag-cold.txt	Thu Mar 29 04:10:31 2001
+++ via-diag-warm.txt	Thu Mar 29 04:07:26 2001
@@ -1,24 +1,19 @@
 via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
  http://www.scyld.com/diag/index.html
 Index #1: Found a VIA VT3065 Rhine-II adapter at 0xec00.
- Station address 00:50:ba:1e:91:1b.
+ Station address 00:00:00:00:00:00.
  Tx disabled, Rx disabled, half-duplex (0x0804).
   Receive  mode is 0x00: Unknown/invalid.
   Transmit mode is 0x00: Normal transmit, 128 byte threshold.
 VIA VT3065 Rhine-II chip registers at 0xec00
- 0x000: 1eba5000 00001b91 00000804 00000000 00000000 00000000 00000000 00000000
+ 0x000: 00000000 00000000 00000804 00000000 00000000 00000000 00000000 00000000
  0x020: 00000400 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  0x040: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 ffd7dffa
- 0x060: 00000000 00000000 00000000 0e091108 ffff9f00 08000080 02470000 00000000
+ 0x060: 00000000 00000000 00000000 0e09131f 00008100 08000080 02470000 00000000
  No interrupt sources are pending (0000).
   Access to the EEPROM has been disabled (0x80).
     Direct reading or writing is not possible.
 EEPROM contents (Assumed from chip registers):
-0x100:  00 50 ba 1e 91 1b 00 00 00 00 00 00 00 00 00 00
+0x100:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 0x110:  00 00 00 00 00 00 00 00 09 0e 00 00 47 02 73 73
- mdio_read(0xec00, 0, 1).. mdio_read(0xec00, 1, 1).. mdio_read(0xec00, 2, 1).. mdio_read(0xec00, 3, 1).. mdio_read(0xec00, 4, 1).. mdio_read(0xec00, 5, 1).. mdio_read(0xec00, 6, 1).. mdio_read(0xec00, 7, 1).. mdio_read(0xec00, 8, 1).. MII PHY found at address 8, status 0x782d.
- mdio_read(0xec00, 9, 1).. mdio_read(0xec00, 10, 1).. mdio_read(0xec00, 11, 1).. mdio_read(0xec00, 12, 1).. mdio_read(0xec00, 13, 1).. mdio_read(0xec00, 14, 1).. mdio_read(0xec00, 15, 1).. mdio_read(0xec00, 16, 1).. mdio_read(0xec00, 17, 1).. mdio_read(0xec00, 18, 1).. mdio_read(0xec00, 19, 1).. mdio_read(0xec00, 20, 1).. mdio_read(0xec00, 21, 1).. mdio_read(0xec00, 22, 1).. mdio_read(0xec00, 23, 1).. mdio_read(0xec00, 24, 1).. mdio_read(0xec00, 25, 1).. mdio_read(0xec00, 26, 1).. mdio_read(0xec00, 27, 1).. mdio_read(0xec00, 28, 1).. mdio_read(0xec00, 29, 1).. mdio_read(0xec00, 30, 1).. mdio_read(0xec00, 31, 1).. MII PHY #8 transceiver registers: mdio_read(0xec00, 8, 0)..
-   3000 mdio_read(0xec00, 8, 1).. 782d mdio_read(0xec00, 8, 2).. 0016 mdio_read(0xec00, 8, 3).. f880 mdio_read(0xec00, 8, 4).. 01e1 mdio_read(0xec00, 8, 5).. 0021 mdio_read(0xec00, 8, 6).. ffff mdio_read(0xec00, 8, 7).. ffff mdio_read(0xec00, 8, 8)..
-   ffff mdio_read(0xec00, 8, 9).. ffff mdio_read(0xec00, 8, 10).. ffff mdio_read(0xec00, 8, 11).. ffff mdio_read(0xec00, 8, 12).. ffff mdio_read(0xec00, 8, 13).. ffff mdio_read(0xec00, 8, 14).. ffff mdio_read(0xec00, 8, 15).. ffff mdio_read(0xec00, 8, 16)..
-   0022 mdio_read(0xec00, 8, 17).. ff40 mdio_read(0xec00, 8, 18).. 0000 mdio_read(0xec00, 8, 19).. ffc0 mdio_read(0xec00, 8, 20).. 00a0 mdio_read(0xec00, 8, 21).. ffff mdio_read(0xec00, 8, 22).. ffff mdio_read(0xec00, 8, 23).. ffff mdio_read(0xec00, 8, 24)..
-   ffff mdio_read(0xec00, 8, 25).. ffff mdio_read(0xec00, 8, 26).. ffff mdio_read(0xec00, 8, 27).. ffff mdio_read(0xec00, 8, 28).. ffff mdio_read(0xec00, 8, 29).. ffff mdio_read(0xec00, 8, 30).. ffff mdio_read(0xec00, 8, 31).. ffff.
+ mdio_read(0xec00, 0, 1).. mdio_read(0xec00, 1, 1).. mdio_read(0xec00, 2, 1).. mdio_read(0xec00, 3, 1).. mdio_read(0xec00, 4, 1).. mdio_read(0xec00, 5, 1).. mdio_read(0xec00, 6, 1).. mdio_read(0xec00, 7, 1).. mdio_read(0xec00, 8, 1).. mdio_read(0xec00, 9, 1).. mdio_read(0xec00, 10, 1).. mdio_read(0xec00, 11, 1).. mdio_read(0xec00, 12, 1).. mdio_read(0xec00, 13, 1).. mdio_read(0xec00, 14, 1).. mdio_read(0xec00, 15, 1).. mdio_read(0xec00, 16, 1).. mdio_read(0xec00, 17, 1).. mdio_read(0xec00, 18, 1).. mdio_read(0xec00, 19, 1).. mdio_read(0xec00, 20, 1).. mdio_read(0xec00, 21, 1).. mdio_read(0xec00, 22, 1).. mdio_read(0xec00, 23, 1).. mdio_read(0xec00, 24, 1).. mdio_read(0xec00, 25, 1).. mdio_read(0xec00, 26, 1).. mdio_read(0xec00, 27, 1).. mdio_read(0xec00, 28, 1).. mdio_read(0xec00, 29, 1).. mdio_read(0xec00, 30, 1).. mdio_read(0xec00, 31, 1).. ***WARNING***: No MII transceivers found!

--ikeVEW9yuYc//A+q--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSKGOkT>; Thu, 7 Nov 2002 09:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266569AbSKGOkT>; Thu, 7 Nov 2002 09:40:19 -0500
Received: from smtp.laposte.net ([213.30.181.11]:34776 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S261205AbSKGOkQ>;
	Thu, 7 Nov 2002 09:40:16 -0500
Subject: [Resend]2.5 usb + rt8139too + io-apic + acpi UP problem
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net, jgarzik@pobox.com, mingo@elte.hu,
       andrew.grover@intel.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rjJV3bD7Hrc0pWy+JMYp"
Organization: 
Message-Id: <1036680407.3504.2.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.90 (Preview Release)
Date: 07 Nov 2002 15:46:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rjJV3bD7Hrc0pWy+JMYp
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[ Resend since the first one seems to have been lost somewhere ; apologies =
if it did get through ]

[ Please CC me any reply as I'm not on the list ]

Hi

	I'm trying to move from an pure usb hid + acpi + io-apic UP 2.4 system
to a 2.5 one. Hardware is via kt400 based. The problem is :
      * 2.5 io-apic kills usb input=20

device not accepting address", see
http://linux-usb.sourceforge.net/FAQ.html#ts6

      * without io-apic build-in  rt8139too do not work with acpi :

nov  5 20:50:30 rousalka ifup:
nov  5 20:50:30 rousalka ifup: D=E9finition des informations IP pour eth0.
Nov  5 20:50:30 rousalka kernel: eth0: Setting 100mbps full-duplex based
on auto-negotiated partner ability 41e1.
Nov  5 20:50:36 rousalka dhclient: DHCPREQUEST on eth0 to
255.255.255.255 port 67
Nov  5 20:50:45 rousalka last message repeated 3 times
Nov  5 20:50:53 rousalka dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 8
Nov  5 20:50:54 rousalka kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Nov  5 20:50:54 rousalka kernel: eth0: Setting 100mbps full-duplex based
on auto-negotiated partner ability 41e1.
Nov  5 20:51:01 rousalka dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 12
Nov  5 20:51:13 rousalka dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 7
Nov  5 20:51:20 rousalka dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 15
Nov  5 20:51:30 rousalka kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Nov  5 20:51:30 rousalka kernel: eth0: Setting 100mbps full-duplex based
on auto-negotiated partner ability 41e1.
Nov  5 20:51:35 rousalka dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 10
Nov  5 20:51:45 rousalka dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 9
Nov  5 20:51:54 rousalka dhclient: No DHCPOFFERS received.
Nov  5 20:51:54 rousalka dhclient: Trying recorded lease 81.65.232.223
nov  5 20:51:57 rousalka ifup: PING 81.65.232.1 (81.65.232.1) from
81.65.232.223 : 56(84) bytes of data.
nov  5 20:51:57 rousalka ifup:
nov  5 20:51:57 rousalka ifup: --- 81.65.232.1 ping statistics ---
nov  5 20:51:57 rousalka ifup: 3 packets transmitted, 0 received, +3
errors, 100% loss, time 1999ms
nov  5 20:51:57 rousalka ifup: , pipe 3
nov  5 20:51:57 rousalka ifup:  =E9chou=E9.
nov  5 20:51:57 rousalka network: Montage de l'interface eth0 : failed

      * without acpi and io-apic network and usb works, but obviously
        not acpi:(

So right now on 2.5 i have to choose between broken input, broken
network or broken acpi:((.

Here are /proc/interrupts contents for various configurations on this
system, I don't find them all that enlightening but maybe someone here
can interpret them.

2.4.20-pre10-ac1 uhci, io-apic, acpi

           CPU0
  0:       4024    IO-APIC-edge  timer
  1:          4    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0    IO-APIC-edge  acpi
 14:         37    IO-APIC-edge  ide0
 15:       2782    IO-APIC-edge  ide1
 18:         62   IO-APIC-level  cs46xx, eth0
 21:        233   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
NMI:          0
LOC:       3974
ERR:          0
MIS:          0

2.5.46-bk2 uhci, io-apic, acpi

           CPU0
  0:      68555    IO-APIC-edge  timer
  2:          0          XT-PIC  cascade
  7:          0    IO-APIC-edge  uhci-hcd
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 10:          0    IO-APIC-edge  uhci-hcd
 11:          0    IO-APIC-edge  uhci-hcd
 14:         42    IO-APIC-edge  ide0
 15:       2992    IO-APIC-edge  ide1
 18:        105   IO-APIC-level  CS46XX, eth0
NMI:          0
LOC:      68478
ERR:          0
MIS:          0

2.5.46-bk2 ehci, io-apic, acpi

           CPU0
  0:      67659    IO-APIC-edge  timer
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:          0    IO-APIC-edge  ehci-hcd
 14:         42    IO-APIC-edge  ide0
 15:       2880    IO-APIC-edge  ide1
 18:         44   IO-APIC-level  CS46XX, eth0
NMI:          0
LOC:      67575
ERR:          0
MIS:          0

2.5.46-bk2 uhci, no io-apic, no acpi

           CPU0
  0:      39606          XT-PIC  timer
  2:          0          XT-PIC  cascade
  7:          0          XT-PIC  uhci-hcd
  8:          1          XT-PIC  rtc
 10:        262          XT-PIC  uhci-hcd
 11:         48          XT-PIC  uhci-hcd, CS46XX, eth0
 14:         41          XT-PIC  ide0
 15:       2615          XT-PIC  ide1
NMI:          0
ERR:          0

2.5.46-bk2 uhci, no io-apic, no acpi

           CPU0
  0:      38133          XT-PIC  timer
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 11:        112          XT-PIC  CS46XX, eth0
 12:        149          XT-PIC  ehci-hcd
 14:         41          XT-PIC  ide0
 15:       2679          XT-PIC  ide1
NMI:          0
ERR:          0

2.5.46-bk2 uhci, no io-apic, no acpi

           CPU0
  0:      47925          XT-PIC  timer
  2:          0          XT-PIC  cascade
  7:          0          XT-PIC  uhci-hcd
  8:          1          XT-PIC  rtc
 10:          0          XT-PIC  uhci-hcd
 11:        102          XT-PIC  uhci-hcd, CS46XX, eth0
 12:        278          XT-PIC  ehci-hcd
 14:         41          XT-PIC  ide0
 15:       2479          XT-PIC  ide1
NMI:          0
ERR:          0

Regards,

--=20
Nicolas Mailhot

--=-rjJV3bD7Hrc0pWy+JMYp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQA9ynzXI2bVKDsp8g0RAgOcAKD5XMNbb4wTwIaT9IZxL7zzmLlUnwCcD/PX
HkQpP7kMPJnG1OHqI+BDtqQ=
=CoJT
-----END PGP SIGNATURE-----

--=-rjJV3bD7Hrc0pWy+JMYp--


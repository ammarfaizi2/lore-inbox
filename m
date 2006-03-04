Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751939AbWCDT0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWCDT0W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 14:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWCDT0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 14:26:22 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:61535 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751939AbWCDT0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 14:26:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer;
        b=Ug5RAVZXF05tcsSuKXAqn62yJKH+9lemQtsKJLSq/iRgTTGKnOKJiEAVW41UUEYvuMsmDBaBIm5/g6jXKldBQoHEVyx3Cl5+A2tfvvmNspsIb8Gg8aBzq2NqMcPUbfA1VgrYgCzO9/cWPLNO4AH5JqXu+61xA9ZieKStyFFbqSU=
Subject: BUG Report: Network Communication between "eth0" and "dhcp", only
	last for 1 minute. On NIC Vendor: Davicom Semiconductor, Inc. Device: 21x4x
	DEC-Tulip compatible 10/100 Ethernet. NIC Bus Type: PCI
From: "Joel Bryan T. Juliano" <joelbryan.juliano@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-L8jhi+3VNQprr0JTv4Pv"
Date: Sun, 05 Mar 2006 03:26:09 +0800
Message-Id: <1141500369.5874.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-L8jhi+3VNQprr0JTv4Pv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

My DHCP is up and running, I have no problems acquiring IP address
during boot. I can connect to the internet, but for just under 1 minute.

I had experimented with the commands for reloading the network (ifdown
eth0, ifup eth0, /etc/init.d/networking restart, dhclient), reacquiring
DHCP and manually bringing it up, or use static IP to connect to my DSL
modem.
My DSL modem is ZyXel Prestige 600 Series DSL Router. I even kill
running dhclient, dhcbdb (NetworkManager), and NetworkManager. And route
the gateway manually, but even without DHCP, my connection disconnects
after 1 minute.

For the first few seconds, I can ping my Gateway/Router/DHCP server,
until 1 minute elapse, then it disconnects. Then after 1 minute elapse I
try to run dhclient and it does not work anymore this point.

To bring up the network again, I manually unplugging and re-plugging the
network cable. Then it works again, for just 1 minute.

I fixed it using mii-diag, with -r option to resets autonegotiation,

This are the --help options

[help]
Usage: mii-diag [-aDfrRvVw] [-AF <speed+duplex>] [--watch] <interface>.

  This program configures and monitors the transceiver management
registers
  for network interfaces. It uses the Media Independent Interface (MII)
  standard with additional Linux-specific controls to communicate with
the
  underlying device driver. The MII registers control and report network
  link settings and errors. Examples are link speed, duplex,
capabilities
  advertised to the link partner, status LED indications and link error
  counters.

   The common usage is
      mii-diag eth0

   The default interface is "eth0".
 Frequently used options are
   -A --advertise <speed|setting>
   -F --fixed-speed <speed>
 Speed is one of: 100baseT4, 100baseTx, 100baseTx-FD, 100baseTx-HD,
                  10baseT, 10baseT-FD, 10baseT-HD
   -s --status Return exit status 2 if there is no link beat.

 Less frequently used options are
   -a --all-interfaces Show the status all interfaces
              (Not recommended with options that change settings.)
   -D --debug
   -g --read-parameters Get driver-specific parameters.
   -G --set-parameters PARMS Set driver-specific parameters.
       Parameters are comma separated, missing elements retain existing
value.
   -M --msg-level LEVEL Set the driver message bit map.
   -p --phy ADDR Set the PHY (MII address) to report.
   -r --restart Restart the link autonegotiation.
   -R --reset Reset the transceiver.
   -v --verbose Report each action taken.
   -V --version Emit version information.
   -w --watch Continuously monitor the transceiver and report changes.

   This command returns success (zero) if the interface information can
be
   read. If the --status option is passed, a zero return means that the
   interface has link beat.
[/help]

This is my diagnostic when I am connected, without any parameters

[connected]
Basic registers of MII PHY #1: 3100 782d 0181 b840 01e1 41e1 0001 0000.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.
[/connected]

Connected with -a (all interfaces) option.

[connected-a]
Basic registers of MII PHY #1: 3100 782d 0181 b840 01e1 41e1 0003 0000.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.
[/connected-a]

connected with -a -D (for debug)

[connected-a-D]
Basic registers of MII PHY #1: 3100 782d 0181 b840 01e1 41e1 0001 0000.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.
[/connected-a-D]

connected with -a -v (for verbose)

[connected-a-v]
mii-diag.c:v2.11 3/21/2005 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
  Using the new SIOCGMIIPHY value on PHY 1 (BMCR 0x3100).
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.

libmii.c:v2.11 2/28/2005 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 MII PHY #1 transceiver registers:
   3100 782d 0181 b840 01e1 41e1 0001 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 8018 7800 1000 0001 0002 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 Basic mode status register 0x782d ... 782d.
   Link status: established.
   Capable of 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Vendor ID is 00:60:6e:--:--:--, model 4 rev. 0.
   Vendor/Part: Davicom (unknown type).
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   Negotiation completed.
  Davicom vendor specific registers: 0x0000 0x8018 0x7800.
[/connected-a-v]

connected with -a -v -D

[connected-a-v-D]
mii-diag.c:v2.11 3/21/2005 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
  Using the new SIOCGMIIPHY value on PHY 1 (BMCR 0x3100).
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.

libmii.c:v2.11 2/28/2005 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 MII PHY #1 transceiver registers:
   3100 782d 0181 b840 01e1 41e1 0001 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 8018 7800 1000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 Basic mode status register 0x782d ... 782d.
   Link status: established.
   Capable of 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Vendor ID is 00:60:6e:--:--:--, model 4 rev. 0.
   Vendor/Part: Davicom (unknown type).
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   Negotiation completed.
  Davicom vendor specific registers: 0x0000 0x8018 0x7800.
[/connected-a-v-D]

Connected with -s (status)

[connected-s]
Basic registers of MII PHY #1: 3100 782d 0181 b840 01e1 41e1 0003 0000.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.
[/connected-s]

here is my diagnostic when I get disconnected

without any parameters.

[disconnected]
Basic registers of MII PHY #1: 3100 782d 0181 b840 01e1 41e1 0001 0000.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.
[/disconnected]

with -a

[disconnected-a]
Basic registers of MII PHY #1: 3100 782d 0181 b840 01e1 41e1 0001 0000.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.
[/disconnected-a]

with -a -D

[disconnected-a-D]
Basic registers of MII PHY #1: 3100 782d 0181 b840 01e1 41e1 0001 0000.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.
[/disconnected-a-D]

with -a -v

[disconnected-a-v]
mii-diag.c:v2.11 3/21/2005 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
  Using the new SIOCGMIIPHY value on PHY 1 (BMCR 0x3100).
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.

libmii.c:v2.11 2/28/2005 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 MII PHY #1 transceiver registers:
   3100 782d 0181 b840 01e1 41e1 0001 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 8018 7800 1000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 Basic mode status register 0x782d ... 782d.
   Link status: established.
   Capable of 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Vendor ID is 00:60:6e:--:--:--, model 4 rev. 0.
   Vendor/Part: Davicom (unknown type).
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   Negotiation completed.
  Davicom vendor specific registers: 0x0000 0x8018 0x7800.
[/disconnected-a-v]

disconnected with -a-v-D

[disconnected-a-v-D]
mii-diag.c:v2.11 3/21/2005 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
  Using the new SIOCGMIIPHY value on PHY 1 (BMCR 0x3100).
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.

libmii.c:v2.11 2/28/2005 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 MII PHY #1 transceiver registers:
   3100 782d 0181 b840 01e1 41e1 0001 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 8018 7800 1000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 Basic mode status register 0x782d ... 782d.
   Link status: established.
   Capable of 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Vendor ID is 00:60:6e:--:--:--, model 4 rev. 0.
   Vendor/Part: Davicom (unknown type).
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   Negotiation completed.
  Davicom vendor specific registers: 0x0000 0x8018 0x7800.
[/disconnected-a-v-D]

disconnected with -s

[disconnected-s]
Basic registers of MII PHY #1: 3100 782d 0181 b840 01e1 41e1 0001 0000.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.
[/disconnected-s]

And now the watch interface

[watch-interfce]
Using the default interface 'eth0'.
Basic registers of MII PHY #1: 3100 782d 0181 b840 01e1 41e1 0001 0000.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   End of basic transceiver information.

Monitoring the MII transceiver status.
02:24:10.140 Baseline value of MII BMSR (basic mode status register) is
782d. --comment --10 seconds -- joelbryan
02:24:28.500 MII BMSR now 7809: no link, NWay busy, No Jabber (0000).
--comment --unplugged cat45-- joelbryan
02:24:43.212 MII BMSR now 782d: Good link, NWay done, No Jabber (41e1).
   New link partner capability is 41e1 0003: 10/100 HD+FD switch.
--comment --replugged cat45-- joelbryan
--comment --still no link because interface being watched-- joelbryan
--comment --still no link after several seconds-- joelbryan
--comment --quitting watch session -- joelbryan
[/watch-interface]

As a solution, I use -r (Restart the link autonegotiation.) or -R (Reset
the transceiver.)

here's the difference

[reset-and-restart]
joelbryan@dhcppc0:~/devs/ethdebug$ sudo mii-diag -r
Using the default interface 'eth0'.
Restarting negotiation...
Basic registers of MII PHY #1: 1000 7809 0181 b840 01e1 0000 0000 0000.
 Basic mode control register 0x1000: Auto-negotiation enabled.
 Basic mode status register 0x7809 ... 7809.
   Link status: not established.
   End of basic transceiver information.

joelbryan@dhcppc0:~/devs/ethdebug$ ping -c 5 www.google.com
PING www.l.google.com (66.102.7.104) 56(84) bytes of data.
64 bytes from 66.102.7.104: icmp_seq=3D1 ttl=3D243 time=3D226 ms
64 bytes from 66.102.7.104: icmp_seq=3D2 ttl=3D243 time=3D227 ms
64 bytes from 66.102.7.104: icmp_seq=3D3 ttl=3D243 time=3D226 ms
64 bytes from 66.102.7.104: icmp_seq=3D4 ttl=3D243 time=3D226 ms
64 bytes from 66.102.7.104: icmp_seq=3D5 ttl=3D243 time=3D226 ms

--- www.l.google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4005ms rtt
min/avg/max/mdev =3D 226.681/226.865/227.254/0.365 ms
joelbryan@dhcppc0:~/devs/ethdebug$ sudo mii-diag -R
Using the default interface 'eth0'.
Resetting the transceiver...
Basic registers of MII PHY #1: 3100 7809 0181 b840 01e1 0000 0000 0000.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 Basic mode status register 0x7809 ... 7809.
   Link status: not established.
   End of basic transceiver information.

--comment-- wait for 1 minute to elapse -joelbryan
--comment-- disconnected -joelbryan

joelbryan@dhcppc0:~/devs/ethdebug$ ping -c 5 www.google.com
PING www.l.google.com (66.102.7.147) 56(84) bytes of data.
64 bytes from 66.102.7.147: icmp_seq=3D1 ttl=3D243 time=3D226 ms
64 bytes from 66.102.7.147: icmp_seq=3D2 ttl=3D243 time=3D227 ms
64 bytes from 66.102.7.147: icmp_seq=3D3 ttl=3D243 time=3D226 ms
64 bytes from 66.102.7.147: icmp_seq=3D4 ttl=3D243 time=3D226 ms
64 bytes from 66.102.7.147: icmp_seq=3D5 ttl=3D243 time=3D226 ms

--- www.l.google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4000ms rtt
min/avg/max/mdev =3D 226.395/226.819/227.141/0.402 ms
joelbryan@dhcppc0:~/devs/ethdebug$

[/reset-and-restart]

I create a cron job to invoke "/usr/sbin/mii-diag -r" command
recurrently every 1 minute.

* * * * * /usr/sbin/mii-diag -r >/dev/null 2> &1>

I hope I provide the details for reporting this bug. I believe that it's
the tulip driver's bug, not my hardware.

And I really want to get this fixed, because my university uses this
particular NIC card (over 1 thousand computers) And I'm assigned to
deploy Ubuntu Linux, and waiting for Dapper Drake to finalize. :-D

Good Day sir!

--=20
Joel Bryan T. Juliano <joelbryan.juliano@gmail.com>

--=-L8jhi+3VNQprr0JTv4Pv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBECenR5tf3ds5t46cRAh5VAJ9Z0Rzwj05Vn+EUrWsfGrSe/RXPBwCfbgBq
J0hi/ooX0cvzanzY8I4BtCA=
=4YL4
-----END PGP SIGNATURE-----

--=-L8jhi+3VNQprr0JTv4Pv--


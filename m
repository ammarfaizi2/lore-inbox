Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZAvB>; Thu, 25 Jan 2001 19:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRAZAuv>; Thu, 25 Jan 2001 19:50:51 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:31111 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129169AbRAZAum>;
	Thu, 25 Jan 2001 19:50:42 -0500
Message-ID: <20010126085037.B467@saw.sw.com.sg>
Date: Fri, 26 Jan 2001 08:50:37 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, Scott Robinson <scott@tranzoa.com>
Subject: Re: eepro100 problems in 2.4.0
In-Reply-To: <006601c08711$4bdfb600$9b2f4189@angelw2k> <3A709504.5599E0F7@mandrakesoft.com> <3A70985F.E5A0AB7F@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=UlVJffcvxoiEqYs2
X-Mailer: Mutt 0.93.2i
In-Reply-To: <3A70985F.E5A0AB7F@mandrakesoft.com>; from "Jeff Garzik" on Thu, Jan 25, 2001 at 04:19:27PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii

Hi,

On Thu, Jan 25, 2001 at 04:19:27PM -0500, Jeff Garzik wrote:
> Oops, sorry guys.  Thanks to DaveM for correcting me -- my patch has
> nothing to do with the "card reports no resources" problem.  My
> apologies.

No problems.

However, there is a real problem with eepro100 when the system resumes
operations after a sleep.
May be, you could guess what's wrong in this case?

Best regards
		Andrey

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=l1

Return-Path: <scott@robhome.dyndns.org>
Delivered-To: saw-main@saw.sw.com.sg
Received: (qmail 5459 invoked by uid 577); 18 Jan 2001 01:39:41 -0000
Received: (qmail 5453 invoked from network); 18 Jan 2001 01:39:38 -0000
Received: from sea-pm3-10-p213.wolfenet.com (HELO mail.robhome.dyndns.org) (206.159.18.213)
  by saw.sw.com.sg with SMTP; 18 Jan 2001 01:39:38 -0000
Received: from tara.robhome.dyndns.org (tara.mvdomain [10.1.1.66])
	by mail.robhome.dyndns.org (Postfix) with ESMTP id 16645BBE9
	for <saw@saw.sw.com.sg>; Wed, 17 Jan 2001 17:39:18 -0800 (PST)
Received: by tara.robhome.dyndns.org (Postfix, from userid 1000)
	id 5D43A17183E; Wed, 17 Jan 2001 17:39:10 -0800 (PST)
Date: Wed, 17 Jan 2001 17:39:08 -0800
From: Scott Robinson <scott@tranzoa.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: EEPRO100 Power Management problem?
Message-ID: <20010117173908.A7129@robhome.dyndns.org>
In-Reply-To: <20010105151822.A14053@robhome.dyndns.org> <20010116171916.C29594@saw.sw.com.sg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
User-Agent: Mutt/1.0.1i
In-Reply-To: <20010116171916.C29594@saw.sw.com.sg>; from saw@saw.sw.com.sg on Tue, Jan 16, 2001 at 05:19:16PM +0800
X-Disclaimer: The contents of this e-mail, unless otherwise stated, are the property of David Ryland Scott Robinson. Copyright (C)2001, All Rights Reserved.
X-Operating-System: Linux tara 2.4.0-test10 
Sender: scott@robhome.dyndns.org


--4SFOXa2GPu3tIq4H
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Well, it appears *something* like that is happening. However, I can't think
of how to fix it. Everything goes "disabled".

Attached are the two 'lspci -v' executed pre and post-suspend. Also attached
is a diff file between them. If you have any further ideas, please e-mail me
back?

Scott.

* Andrey Savochkin translated into ASCII [Tue, Jan 16, 2001 at 05:19:16PM +=
0800][<20010116171916.C29594@saw.sw.com.sg>]
> Hello,
>=20
> On Fri, Jan 05, 2001 at 03:18:23PM -0800, Scott Robinson wrote:
> > The following occurs when I suspend my Dell Inspiron 8000 with an inter=
nal
> > MiniPCI Actiontec MP100IM. I'm using 2.4.0-final with power-management
> > turned on and off. The logs below are with power-management turned on.
> >=20
> > I checked with a eepro100 diagnostic tool, and according to it, the ent=
ire
> > EEPROM has been FF'ed out. (and it's larger than before)
> >=20
> > I have tried unloading the driver before suspend. No dice. Is there a
> > hard-reset command for a card?
> >=20
> > I was looking at the source code and maybe if I suspend the pci card in
> > _suspend()? I'm not certain what power state I need to tell it, though.=
 D3?
> >=20
> > When I power-cycle the machine, I end up having to hard-reset otherwise=
 I
> > freeze in the bios startup. Something seriously harsh is happening.
>=20
> The first idea that comes to mind is an old issue of cleared PCI
> configuration on sleep.
> Run `lspci -v' after wakeup and compare how the output look with how it d=
id
> before the sleep.
>=20
> Best regards
> 					Andrey V.
> 					Savochkin
>=20

--=20
jabber:quad@jabber.org         - Universal ID (www.jabber.org)
http://dsn.itgo.com/           - Personal webpage
robhome.dyndns.org             - Home firewall

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GAT dpu s+: a--- C++ UL++++ P+ L+++ E- W+ N+ o+ K++ w++
O M V PS+ PE Y+ PGP++ t++ 5++ X+ R tv b++++ DI++++ D++
G+ e+ h! r-- y-
------END GEEK CODE BLOCK------

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.presuspend"

00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [f104]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e8000000-ebffffff

00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=32
	I/O behind bridge: 0000d000-0000ffff
	Memory behind bridge: f2000000-fbffffff

00:1f.0 ISA bridge: Intel Corporation: Unknown device 244c (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 244a (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0
	I/O ports at bfa0 [size=16]

00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at bce0 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4d46 (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: VGA palette snoop, stepping, 66Mhz, medium devsel, IRQ 11
	Memory at e8000000 (32-bit, prefetchable) [size=64M]
	I/O ports at cc00 [size=256]
	Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2

02:03.0 Multimedia audio controller: ESS Technology: Unknown device 1998 (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at dc00 [size=256]
	Memory at f6ffe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2

02:06.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=02, secondary=08, subordinate=08, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: f8000000-f9ffffff
	Capabilities: [80] Power Management version 2
	Capabilities: [90] #06 [0000]

02:0f.0 CardBus bridge: Texas Instruments: Unknown device ac42
	Subsystem: Texas Instruments: Unknown device ac42
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f2000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=09, subordinate=0c, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0007

02:0f.1 CardBus bridge: Texas Instruments: Unknown device ac42
	Subsystem: Texas Instruments: Unknown device ac42
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f2001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=0d, subordinate=10, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0007

02:0f.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8027 (prog-if 10 [OHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f6ffd800 (32-bit, non-prefetchable) [size=2K]
	Memory at f6ff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

08:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Action Tec Electronics Inc: Unknown device 1100
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f8fff000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at ecc0 [size=64]
	Memory at f8e00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2

08:08.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
	Subsystem: Action Tec Electronics Inc: Unknown device 2400
	Flags: bus master, medium devsel, latency 0, IRQ 11
	Memory at f8ffec00 (32-bit, non-prefetchable) [size=256]
	I/O ports at ecb8 [size=8]
	I/O ports at e800 [size=256]
	Capabilities: [f8] Power Management version 2


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.postsuspend"

00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [f104]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e8000000-ebffffff

00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=32
	I/O behind bridge: 0000d000-0000ffff
	Memory behind bridge: f2000000-fbffffff

00:1f.0 ISA bridge: Intel Corporation: Unknown device 244c (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 244a (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0
	I/O ports at bfa0 [size=16]

00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at bce0 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4d46 (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: VGA palette snoop, stepping, 66Mhz, medium devsel, IRQ 11
	Memory at e8000000 (32-bit, prefetchable) [size=64M]
	I/O ports at cc00 [size=256]
	Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2

02:03.0 Multimedia audio controller: ESS Technology: Unknown device 1998 (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at dc00 [size=256]
	Memory at f6ffe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2

02:06.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=02, secondary=08, subordinate=08, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Capabilities: [80] Power Management version 2
	Capabilities: [90] #06 [0000]

02:0f.0 CardBus bridge: Texas Instruments: Unknown device ac42
	Subsystem: Texas Instruments: Unknown device ac42
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f2000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=09, subordinate=0c, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0007

02:0f.1 CardBus bridge: Texas Instruments: Unknown device ac42
	Subsystem: Texas Instruments: Unknown device ac42
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f2001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=0d, subordinate=10, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0007

02:0f.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8027 (prog-if 10 [OHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f6ffd800 (32-bit, non-prefetchable) [size=2K]
	Memory at f6ff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

08:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Action Tec Electronics Inc: Unknown device 1100
	Flags: medium devsel, IRQ 11
	[virtual] Memory at f8fff000 (32-bit, non-prefetchable) [disabled] [size=4K]
	I/O ports at ecc0 [disabled] [size=64]
	[virtual] Memory at f8e00000 (32-bit, non-prefetchable) [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2

08:08.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
	Subsystem: Action Tec Electronics Inc: Unknown device 2400
	Flags: medium devsel, IRQ 11
	[virtual] Memory at f8ffec00 (32-bit, non-prefetchable) [disabled] [size=256]
	I/O ports at ecb8 [disabled] [size=8]
	I/O ports at e800 [disabled] [size=256]
	Capabilities: [f8] Power Management version 2


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.suspend.diff"

54d53
< 	Memory behind bridge: f8000000-f9ffffff
85,88c84,87
< 	Flags: bus master, medium devsel, latency 32, IRQ 11
< 	Memory at f8fff000 (32-bit, non-prefetchable) [size=4K]
< 	I/O ports at ecc0 [size=64]
< 	Memory at f8e00000 (32-bit, non-prefetchable) [size=1M]
---
> 	Flags: medium devsel, IRQ 11
> 	[virtual] Memory at f8fff000 (32-bit, non-prefetchable) [disabled] [size=4K]
> 	I/O ports at ecc0 [disabled] [size=64]
> 	[virtual] Memory at f8e00000 (32-bit, non-prefetchable) [disabled] [size=1M]
93,96c92,95
< 	Flags: bus master, medium devsel, latency 0, IRQ 11
< 	Memory at f8ffec00 (32-bit, non-prefetchable) [size=256]
< 	I/O ports at ecb8 [size=8]
< 	I/O ports at e800 [size=256]
---
> 	Flags: medium devsel, IRQ 11
> 	[virtual] Memory at f8ffec00 (32-bit, non-prefetchable) [disabled] [size=256]
> 	I/O ports at ecb8 [disabled] [size=8]
> 	I/O ports at e800 [disabled] [size=256]

--jRHKVT23PllUwdXP--

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpmSTwACgkQQzP9mY3zNDZv9gCgw9mRkLAUoFbl55kGiflEGKw1
t+AAn2xczYVf3Qfdalqcm9VuVmsX7M/g
=joc4
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--


--UlVJffcvxoiEqYs2--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

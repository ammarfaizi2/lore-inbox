Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTFKNDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 09:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTFKNDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 09:03:13 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:34035 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261168AbTFKNDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 09:03:10 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [2.5.70-mm8] NETDEV WATCHDOG: eth0: transmit timed out
Date: Wed, 11 Jun 2003 15:16:44 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030611013325.355a6184.akpm@digeo.com> <200306111356.52950.schlicht@uni-mannheim.de>
In-Reply-To: <200306111356.52950.schlicht@uni-mannheim.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_8uy5+TqG1JMLsfl";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306111516.46648.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_8uy5+TqG1JMLsfl
Content-Type: multipart/mixed;
  boundary="Boundary-01=_8uy5+DmF7ZyXWey"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_8uy5+DmF7ZyXWey
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

it seems that whether the netdevice nor the 8139too parts of the kernel cau=
se=20
my problems but there must have been some bad changes to the interrupt=20
routing or the IO-APIC parts.

I don't have -mm7 handy currently (but at the moment it compiles again) but=
 I=20
attached the contents of /proc/interrupts of 2.4.10 (the system I currently=
=20
run) and 2.5.70-mm8 again.

As you can see there, the -mm8 code does not assign more than 16 interrupt=
=20
sinks but the 2.4.10 (and if I remember correctly -mm7, too) has 22. Perhap=
s=20
even more problematic is that -mm8 seems not to use level-triggered=20
interrupts...!

I could try to revert some IRQ or APIC changes if someone could tell me whi=
ch=20
Changeset may have caused that...

Best reagrds
  Thomas Schlichter

--Boundary-01=_8uy5+DmF7ZyXWey
Content-Type: text/plain;
  charset="iso-8859-1";
  name="interrupts-2.4.10.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="interrupts-2.4.10.txt"

           CPU0      =20
  0:     184641    IO-APIC-edge  timer
  1:       2037    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  4:          2    IO-APIC-edge  serial
  8:          2    IO-APIC-edge  rtc
 12:      78366    IO-APIC-edge  PS/2 Mouse
 14:     188581    IO-APIC-edge  ide0
 15:          6    IO-APIC-edge  ide1
 16:     180617   IO-APIC-level  nvidia
 17:      14155   IO-APIC-level  eth0
 18:      82091   IO-APIC-level  EMU10K1
 19:     457792   IO-APIC-level  fcpci
 21:          0   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
NMI:          0=20
LOC:     184592=20
ERR:          0
MIS:          0

--Boundary-01=_8uy5+DmF7ZyXWey
Content-Type: text/plain;
  charset="iso-8859-1";
  name="interrupts-2.5.70-mm8.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="interrupts-2.5.70-mm8.txt"

           CPU0      =20
  0:      52599    IO-APIC-edge  timer
  1:       1075    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:         11    IO-APIC-edge  serial
  5:          0    IO-APIC-edge  uhci-hcd
  8:          2    IO-APIC-edge  rtc
  9:          0    IO-APIC-edge  acpi
 10:          0    IO-APIC-edge  ehci-hcd
 11:          0    IO-APIC-edge  eth0, EMU10K1, bttv0, uhci-hcd, uhci-hcd
 12:         79    IO-APIC-edge  i8042
 14:       6217    IO-APIC-edge  ide0
 15:         10    IO-APIC-edge  ide1
NMI:          0=20
LOC:      52557=20
ERR:          0
MIS:          0

--Boundary-01=_8uy5+DmF7ZyXWey--

--Boundary-03=_8uy5+TqG1JMLsfl
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+5yu8YAiN+WRIZzQRAoMMAKCoBQMTZcRn1D1Z3jEDlgJ1sk2KxACeP/pS
2f7lj3nWHNPBzQdyMOoOnxw=
=IkTu
-----END PGP SIGNATURE-----

--Boundary-03=_8uy5+TqG1JMLsfl--

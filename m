Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQLTThK>; Wed, 20 Dec 2000 14:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbQLTThA>; Wed, 20 Dec 2000 14:37:00 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:37765 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S129669AbQLTTgn>; Wed, 20 Dec 2000 14:36:43 -0500
Date: Wed, 20 Dec 2000 14:06:12 -0500
From: Pete Toscano <pete@research.netsol.com>
To: linux-kernel@vger.kernel.org
Subject: usb + smp + 2.4.0test = pci irq routing problem?
Message-ID: <20001220140612.A11162@tesla.admin.cto.netsol.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 1:48pm  up 19:25,  6 users,  load average: 0.21, 0.25, 0.24
X-Married: 402 days, 18 hours, 3 minutes, and 17 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello,

i've been working with johannes erdfelt in fixing a problem with usb on
my machine.  it's a dual pentium 3 system on a tyan tiger 133 mobo (via
apollo pro 133a chipset).  basically, usb works when i don't enable smp
or when i disable apic on smp-enabled kernels.  he believes that we're
seeing a pci irq routing problem and that i should contact martin mares
about this problem.  (i've written him a couple times, but have heard
nothing, so i figure he's either away, busy, or whatnot and i thought
i'd try lkml for help.)

i have an ethernet card on my system and it shares an irq with usb-uhci.
in this state, i see interrupts for the irq eth0 and usb-uhci
share.  when i remove the ethernet card, i get this in /proc/interrupts:

            CPU0       CPU1
   0:      37124      19379    IO-APIC-edge  timer
   1:        146         84    IO-APIC-edge  keyboard
   2:          0          0          XT-PIC  cascade
   8:          1          0    IO-APIC-edge  rtc
  14:       1640       1910    IO-APIC-edge  ide0
  15:          1          1    IO-APIC-edge  ide1
  16:         29         28   IO-APIC-level  ide2
  18:         26         27   IO-APIC-level  aic7xxx
  19:          0          0   IO-APIC-level  usb-uhci
 NMI:      56419      56419
 LOC:      56392      56403
 ERR:          0

from this, je thought that this was a pci irq routing problem and not a
usb problem.

because of this, running an smp-enabled kernel with apic enabled yields
the "device not accepting new address" error on startup (usb is compiled
into my kernel, so i'm not sure what part is actually triggering the
error) and none of the usb devices work.  (yes, i've checked the mps and
tried both 1.1 and 1.4.)  if i disable apic or don't use an smp-enabled
kernel, everything works fine.  this has been happening for quite a
while, at least since 2.4.0test9, right up to test13-pre3.

i really don't know what kind of information would be useful for
debugging this problem.  i don't know much about kernel programming, but
i am more than willing to try any kind of patch or give any information
about my system that could help squash this bug.  it's a problem that
quite a few people on the linux-usb list are complaining about (all, it
seems, have this via chipset).  please let me know if there's any more
info i can provide, i'm more than happy to help.

thanks,
pete

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6QQMkH/Abp5AIJzYRAnMZAJ9hee0dxNKFFW55tRxn7GnQ6kF+SgCgmYfO
HXi4vzoXQYIVoHZkBnB1GNs=
=cHlg
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

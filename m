Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUARMb2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 07:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUARMb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 07:31:28 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:61585 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S261152AbUARMbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 07:31:21 -0500
Subject: Re: Serial ATA (SATA) for Linux status report
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, andersen@codepoet.org,
       Greg Stark <gsstark@mit.edu>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       mplayer@jburgess.uklinux.net
In-Reply-To: <4005E1D4.6040807@pobox.com>
References: <20031203204445.GA26987@gtf.org>
	 <87hdyyxjgl.fsf@stark.xeocode.com> <20040114225653.GA32704@codepoet.org>
	 <4005D141.7050408@superbug.demon.co.uk>  <4005E1D4.6040807@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-K0wrVZ31Jh9v0g1lH5y8"
Message-Id: <1074429276.8472.194.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 18 Jan 2004 14:34:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-K0wrVZ31Jh9v0g1lH5y8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-15 at 02:41, Jeff Garzik wrote:
> I'm pretty sure the "excessive interrupts" issue was successfully=20
> tracked down by Jon Burgess (thanks!).  He found this post describing an=20
> ICH5 hardware issue,
> http://www.mail-archive.com/freebsd-stable@freebsd.org/msg58421.html
>=20
> and he also submitted the attached patch.
>=20
> I've been meaning to rewrite his patch to isolate it more to ata_piix,=20
> but in the meantime maybe folks could test this?
>=20

I have an Asus P4C800-E Deluxe, with two drivers on the ICH5 sata
controllers.  It is a 3Ghz cpu using HT.

I use the normal PIIX ide drivers for the pata channels, and libata for
the sata ones.  I also use the vector based interrupts.  Kernel is
2.6.1-bk4.

Anyhow, I do not think  the interrupt count is _that_ high, as it shares
with usb and network and I cannot complain of problems with cdrom, etc,
but I decided to try the patch anyhow.  It have some interesting results
though.  First, network stops responding after a few minutes of uptime
(especially easy to reproduce if you have heavy network traffic), then
for some reason you cannot start a new program/login/etc, but those
running seems Ok, and lastly X becomes totally unresponsive (although
alt-sysrq-b still do work).

--
 # cat /proc/interrupts
           CPU0       CPU1
  0:   29703539   29690292    IO-APIC-edge  timer
  2:          0          0          XT-PIC  cascade
  8:          2          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:        564        210    IO-APIC-edge  ide0
 15:          1          0    IO-APIC-edge  ide1
169:    1049180    1055746   IO-APIC-level  libata, uhci_hcd, eth0
177:      39519      37904   IO-APIC-level  Intel ICH5
185:    2521873    2494269   IO-APIC-level  uhci_hcd, uhci_hcd, nvidia
193:          0          0   IO-APIC-level  uhci_hcd
201:          0          0   IO-APIC-level  ehci_hcd
NMI:          0          0
LOC:   59387583   59387287
ERR:          0
MIS:          0
--

--=20
Martin Schlemmer

--=-K0wrVZ31Jh9v0g1lH5y8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBACn1cqburzKaJYLYRAgXGAJ9BE2nsY07vQZkzEpm9ZsmXQ7+CTACeJNr4
yWweMDTcwdEf07QakUZhiEs=
=eT1p
-----END PGP SIGNATURE-----

--=-K0wrVZ31Jh9v0g1lH5y8--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUHGSOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUHGSOW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 14:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUHGSOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 14:14:22 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:57524 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262605AbUHGSOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 14:14:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: architectures with their own "config PCMCIA"
Date: Sat, 7 Aug 2004 20:12:56 +0200
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com,
       davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org> <20040807172518.GA25169@fs.tum.de>
In-Reply-To: <20040807172518.GA25169@fs.tum.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_suRFB4KiDJLgURv";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408072013.01168.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_suRFB4KiDJLgURv
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> On Sat, Aug 07, 2004 at 06:10:51PM +0100, Christoph Hellwig wrote:
> > What about switching them to use drivers/Kconfig instead?

I'd prefer not to switch s390 to use drivers/Kconfig unless someone
volunteers to clean up all included Kconfig files by adding proper
'depends on PCI' etc. flags. Otherwise too many broken options are
offered.

On Samstag, 7. August 2004 19:25, Adrian Bunk wrote:
> Is there eny reason for such options that are never visible nor enabled, =
=20
> or could they be removed?

Yes, the reason is that some other options depend on them. We added the
PCMCIA option to arch/s390/Kconfig to stop kbuild from asking about
some drivers that won't work anyway.

E.g. drivers/scsi/pcmcia starts with

menu "PCMCIA SCSI adapter support"
	depends on SCSI!=3Dn && PCMCIA!=3Dn && MODULES

which evaluate to true if the PCMCIA option is not known. Changing
that to

menu "PCMCIA SCSI adapter support"
	depends on SCSI && PCMCIA && MODULES

solves this in a different way, but I'm not 100% sure if it still has
the same meaning.

	Arnd <><

--Boundary-02=_suRFB4KiDJLgURv
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBFRus5t5GS2LDRf4RAgYxAJ9C9wsxWgp8j939QEdqZdW1BWLtIQCeP5Sx
o/OFG73rGq3bI4Jw7AEm5xY=
=LmTS
-----END PGP SIGNATURE-----

--Boundary-02=_suRFB4KiDJLgURv--

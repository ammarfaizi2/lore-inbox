Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293288AbSB1NVr>; Thu, 28 Feb 2002 08:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293334AbSB1NTZ>; Thu, 28 Feb 2002 08:19:25 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:58643 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S293289AbSB1NQ2>; Thu, 28 Feb 2002 08:16:28 -0500
Date: Thu, 28 Feb 2002 14:16:26 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Tekram DC3x5 SCSI driver 1.37
Message-ID: <20020228141626.L31674@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pP0ycGQONqsnqIMP"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pP0ycGQONqsnqIMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I finally ported the Tekram DC395 SCSI driver to use pci_map functions.
This means that it potentially work on highmem and 64bit archs.
(Most probably it won't work on big-endian archs, though.)

A few more changes (locking and strtok) have been done to make it work with
2.5 as well. The driver still works under 2.4 kernels as well.

I also found a strangeness (which I suspect to be a chip bug) when DMAing to
disk, when the adapter occasionally fails to count one byte or word (wide)
before a page boundary when the device disconnects.
This is worked around now; though the real fix may be to review
the switching on/off of the SCSI FIFO at the right moments to prevent
counting bytes on the SCSI bus which are not part of the information
transfer.

The code contains lots of ifdefs, part of which are for debugging and part
of which for compatibility with older kernels. Please don't flame me for the
non-aestethic coding, if you dare to look at the code.

The driver still uses old error handling, so expect the driver to break,
when this is thrown out of 2.5.

Get the driver at
 http://www.garloff.de/kurt/linux/dc395/
or
 ftp://ftp.suse.com/pub/people/garloff/linux/dc395/

The driver is not meant for inclusion into official kernels at this moment,
as a number of users reported problems with the driver; in the worst case
they face data corruption, so be warned. That said, it works for most users.

Please report back success and failures to me.
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--pP0ycGQONqsnqIMP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fi2qxmLh6hyYd04RAnUVAJ4xMZ7EwM4pKLuU8YysqzGD2Md6QwCeJKpW
iOdtzjNn4/TFZY7CAiK7t4Y=
=PTo5
-----END PGP SIGNATURE-----

--pP0ycGQONqsnqIMP--

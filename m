Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265720AbRF1NNX>; Thu, 28 Jun 2001 09:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265716AbRF1NNN>; Thu, 28 Jun 2001 09:13:13 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:2318 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S265714AbRF1NND>;
	Thu, 28 Jun 2001 09:13:03 -0400
Date: Thu, 28 Jun 2001 17:12:58 +0400
To: linux-kernel@vger.kernel.org
Subject: [uPATCH] i810-tco watchdog, 
Message-ID: <20010628171258.A2214@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
User-Agent: Mutt/1.0.1i
X-Uptime: 4:54pm  up 29 days, 38 min,  2 users,  load average: 0.66, 0.48, 0.19
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

Intel ICHx have one(?) ugly feature: reboot by TCO timer can be
disabled by the hardware. Current message isn't very informative and
can cause false bugreports, so the attached micropatch.

BTW this hardware braindamage already reported on Sony Vaio pCG-FX140.

Best regards.

P.S. What's wrong with my previous patches including Intel ICH and SCL90E66
PCI quirks ?

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-i810-msg

diff -ur -X dontdiff linux.vanilla/drivers/char/i810-tco.c linux/drivers/char/i810-tco.c
--- linux.vanilla/drivers/char/i810-tco.c	Tue Jun 26 10:37:47 2001
+++ linux/drivers/char/i810-tco.c	Thu Jun 28 16:51:17 2001
@@ -289,7 +289,7 @@
 			pci_write_config_byte (i810tco_pci, 0xd4, val1);
 			pci_read_config_byte (i810tco_pci, 0xd4, &val1);
 			if (val1 & 0x02) {
-				printk (KERN_ERR "i810tco init: failed to reset NO_REBOOT flag\n");
+				printk (KERN_ERR "i810tco init: failed to reset NO_REBOOT flag, reboot disabled by hardware\n");
 				return 0;	/* Cannot reset NO_REBOOT bit */
 			}
 		}

--huq684BweRXVnRxX--

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Oy1aBm4rlNOo3YgRAiTwAJ4t5EvV6TgW/v+GpC8eXSPERFAYSwCdHxZD
gRCFk8urxfD3IqgaLLHxyPw=
=No4M
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

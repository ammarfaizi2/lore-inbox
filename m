Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266883AbUGLQ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUGLQ05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUGLQ04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:26:56 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:38651 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S266883AbUGLQ0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:26:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Peter Osterlund <petero2@telia.com>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Date: Mon, 12 Jul 2004 18:25:47 +0200
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
References: <m2lli36ec9.fsf@telia.com> <20040710232714.GA21633@infradead.org> <m2r7rjpd24.fsf@telia.com>
In-Reply-To: <m2r7rjpd24.fsf@telia.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Lur8AUYsgPYW6cT";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407121825.47889.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Lur8AUYsgPYW6cT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sonntag, 11. Juli 2004 03:06, Peter Osterlund wrote:
> OK, I'll create a patch that gets rid of the ioctl interface and uses
> an auxiliary character device instead to control device bindings.

I don't think that's a good idea either. It will solve the udev problem,
but it essentially means you're sneaking in system calls through the
back door here.

Maybe we can decide on one of the following approaches (or yet another
one):

- Do the ioctl call on the cdrom device through cdrom_ioctl() instead of
  the pktcdvd driver. You need to hook into the cdrom driver subsystem,
  but leave everything else as it is today.
- Register all cdrom devices with pktcdvd as soon as they are detected.
  This needs some more changes to the cdrom subsystem, but gets rid of
  the need for the pktsetup interface because you can do the setup stuff
  at open time.
- Merge pktcdvd completely into the cdrom subsystem so the existing cdrom
  device node passes everything down to pktcdvd if an RW medium is mounted
  writable.

	Arnd <><

--Boundary-02=_Lur8AUYsgPYW6cT
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8ruL5t5GS2LDRf4RAgFqAKCdulXfB+7j9JWhYFdE10jlMv9uGwCfeHvW
jOztZuQ7laGQ+kZleLG7dn4=
=+dQx
-----END PGP SIGNATURE-----

--Boundary-02=_Lur8AUYsgPYW6cT--

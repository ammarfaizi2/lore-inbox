Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbRDMNs3>; Fri, 13 Apr 2001 09:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRDMNsT>; Fri, 13 Apr 2001 09:48:19 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:64516 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S131324AbRDMNsQ>; Fri, 13 Apr 2001 09:48:16 -0400
Date: Fri, 13 Apr 2001 08:48:05 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Alpha "process table hang"
Message-ID: <20010413084805.B3118@draal.physics.wisc.edu>
In-Reply-To: <20010411125731.B6472@draal.physics.wisc.edu> <E14nOzo-0007Ew-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14nOzo-0007Ew-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 11, 2001 at 07:05:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alan Cox [alan@lxorguk.ukuu.org.uk] wrote:
> > (But since the X server shouldn't have the ability to corrupt the
> > kernel's process list, there has to be a problem in the kernel
> > somewhere)
>=20
> The X server has enough priviledge to corrupt anything. Its unlikely to a=
nd
> I do agree they two are likely to be unrelated.

Well, nix that idea.  I just fell back to 2.2.19, and I see neither the
X crash nor the process-table-hang crash (which rules out hardware
problems, thankfully).  The X crash is also kernel related, it seems.

I'm using XFree86 4.0.3 with the mga driver.  It hangs in mga_storm.c on
a line that looks like:
    while (MGAISBUSY()) {}
where:
    #define MGAISBUSY() (INREG8(MGAREG_Status + 2) & 0x01)

Killing and restarting X causes it to immediately hang in the same
place.  (I have to reboot to recover the console)

This would seem to be PCI related.  Have any significant PCI code
changes been made to the alpha architecture, especially pyxis or
cabriolet code?  I see that arch/alpha/kernel has been totally
rearranged, but since this doesn't crash in kernel code, I have no idea
how to debug it.

Thanks,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrXA5UACgkQjwioWRGe9K0tCQCeK6MCEm/xXDImzzPSh6rIOgK6
1f0AoL4ATebOPiHRi8QvHpZLpOlSBBDs
=hfMu
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

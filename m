Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131439AbQLRJRX>; Mon, 18 Dec 2000 04:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbQLRJRO>; Mon, 18 Dec 2000 04:17:14 -0500
Received: from air.lug-owl.de ([62.52.24.190]:44041 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S131428AbQLRJRB>;
	Mon, 18 Dec 2000 04:17:01 -0500
Date: Mon, 18 Dec 2000 09:46:32 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Monitoring filesystems / blockdevice for errors
Message-ID: <20001218094631.A17087@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001217153453.O5323@marowsky-bree.de> <Pine.LNX.4.10.10012171314050.16143-100000@coffee.psychology.mcmaster.ca> <20001217194334.V5323@marowsky-bree.de> <20001217232846.W3199@cadcamlab.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001217232846.W3199@cadcamlab.org>; from peter@cadcamlab.org on Sun, Dec 17, 2000 at 11:28:46PM -0600
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2000 at 11:28:46PM -0600, Peter Samuelson wrote:
>   [Mark Hahn]
> > > reinventing /proc/kmsg and klogd would be tre gross.
>=20
> [Lars Marowsky-Bree]
> > Well, only one process can read kmsg and get notified about new
> > messages at any time, so that makes the monitoring depend on
> > klogd/syslogd working, which given a write error by syslog might not
> > be the case...
>=20
> So rewrite klogd to do something much simpler for serious errors (yes
> they will be tagged as such) before trying to pass them on to syslogd.
> Or does it already do this?  It's a userspace problem.

Hmmm... Even if LMB and I are often of quite different oppinions, I
think only modifying klogd is not enough. LMB stated that a userspace
tool would need to know any possibly error messages that could
possibly generated. Cleaning up all messages would be the first
step to prepare for failure reports to userspace. Ie, what errors do
re have?

	- Sense errors (recoverable)            \
	-    "    "    (unrecoverable)           > for all kinds of devices
	- Complete device failure (HDD is gone) /
	- Data failure (wrong ext2 bitmaps) for all FS
	- RAM's ECC/parity errors
	- possibly some more;)

Cleaning up all error messages (maybe using exctly two lines: one for kind
of failure, one for device/RAM/fs specific messages) could help a lot
and doesn't hurt badly (code doesn't get really slower as these paths
are more-or-less never taken; but there is a little bit more bloat...).

With such an infrastructure, klogd could pass those lines to an external
helper (and additionally to syslog).

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjo9zucACgkQHb1edYOZ4bu0IQCeMNK3N+Gv0y2ArQLggDRZRXqC
PQ4AnjR5TUhJLN8VjLC1jKT+wM7SSm9o
=buiG
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131775AbQK0Oy7>; Mon, 27 Nov 2000 09:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131677AbQK0Oyu>; Mon, 27 Nov 2000 09:54:50 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:16905 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S131648AbQK0Oym>; Mon, 27 Nov 2000 09:54:42 -0500
Date: Mon, 27 Nov 2000 15:22:50 +0100
From: Kurt Garloff <garloff@suse.de>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.2.17] oops in /proc/scsi/scsi
Message-ID: <20001127152250.J18517@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux SCSI list <linux-scsi@vger.kernel.org>,
        Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001122020618.A1411@emma1.emma.line.org> <20001123010712.C32555@garloff.etpnet.phys.tue.nl> <20001127085703.A535@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="3MHXEHrrXKLGx71o"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001127085703.A535@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Mon, Nov 27, 2000 at 08:57:03AM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2000 at 08:57:03AM +0100, Matthias Andree wrote:
> Good thing first: I can't trigger the oopses with 2.0e6. I tried hard, di=
dn't
> manage to.

Nice to learn.

> However, trying to trigger a race condition, I found that your script suf=
fers
> from too small a kernel API in this place, since it uses the
> remove-single-device and all-single-devices in a non-locked manner, so if=
 you
> run several instances of your script in parallel (simple rescan-scsi-bus.=
sh -r
> & will do) it will give a mess and may leave you with missing devices.
>=20
> I don't currently recall if your web site states that your script may onl=
y be
> run once at the same time; lock files would be nice :-]

Well, it's one of these root-only admin tools.
I assume, root knows about what (s)he's doing.
So, I'll add some line to the documentation that tells you not to run the
scripts in parallel. Locking is really overkill, IMHO.

> A subsequent rescan-scsi-bus.sh will find the PX-32TS and add it, this ti=
me,
> without bus resets and aborts.
>=20
> Should the reset->inquiry delay be applied after ANY reset? Is it actually
> applied but too short for my Plextor?

Well, the default for tmscsim is 1.5s time after a reset before it start
command processing again. This can be changed by echoing DelayReset values =
tp
the proc file. If your Plextor requires 5s, just do=20
echo "delayreset 5" >/proc/scsi/tmscsim/? and the driver will wait for 5.5s
=2E..

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Im45xmLh6hyYd04RAjfCAJ48y6ENsbOkN6mfd3AifCLJmLVGtwCeKoxm
h3XgGO1LbIIuvnPuRXGZ72A=
=fH80
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

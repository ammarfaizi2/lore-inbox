Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTKOKOk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 05:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTKOKOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 05:14:40 -0500
Received: from coruscant.franken.de ([193.174.159.226]:49853 "EHLO
	dagobah.gnumonks.org") by vger.kernel.org with ESMTP
	id S261613AbTKOKOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 05:14:38 -0500
Date: Sat, 15 Nov 2003 10:38:33 +0100
From: Harald Welte <laforge@netfilter.org>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031115093833.GB656@obroa-skai.de.gnumonks.org>
References: <20031114204212.GK6937@obroa-skai.de.gnumonks.org> <Pine.LNX.4.44.0311142059560.849-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311142059560.849-100000@einstein.homenet>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.4.23-pre7-ben0
X-Date: Today is Prickle-Prickle, the 27th day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2003 at 09:01:58PM +0000, Tigran Aivazian wrote:
> On Fri, 14 Nov 2003, Harald Welte wrote:
> > The problem is, that seq_file is already using the file.private_data
> > member...
>=20
> there is a seq_file->private pointer where you can store private (per fil=
e=20
> structure) data. That is what I do and it works very nice, BUT the proble=
m=20
> is that the ->private pointer was only added to seq_file recently=20
> (2.4.20 if I remember correctly) although seq_file API was present since=
=20
> 2.4.15.

that doesn't help.  As I am aware, the seq_file structure is only
allocated in the seq_open() call.  How does seq_open() know which
private data (i.e. hash table) to associate with struct file?

The only moment I know which htable corresponds to a proc entry is at
the time where I call proc_net_create() [or a similar function].  So the
information would need to be associated with the dentry or whatever...
seq_file() is allocated way too late.

> Kind regards
> Tigran

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tfQYXaXGVTD0i/8RAlMgAJsFOCkmy2CV+S0zRdCLWUrRAot4OACgpesb
Sd0XN5JCddNLd9zy4EVcdt0=
=BBZU
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--

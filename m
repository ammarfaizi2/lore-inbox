Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTKPUts (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 15:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTKPUts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 15:49:48 -0500
Received: from coruscant.franken.de ([193.174.159.226]:12739 "EHLO
	dagobah.gnumonks.org") by vger.kernel.org with ESMTP
	id S263172AbTKPUtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 15:49:43 -0500
Date: Sun, 16 Nov 2003 21:45:01 +0100
From: Harald Welte <laforge@netfilter.org>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031116204501.GB15732@obroa-skai.de.gnumonks.org>
References: <20031115201444.GO24159@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0311152045310.743-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311152045310.743-100000@einstein.homenet>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.4.23-pre7-ben0
X-Date: Today is Setting Orange, the 28th day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2003 at 08:50:55PM +0000, Tigran Aivazian wrote:
> But I was referring to the complication on the kernel side, whereby if th=
e=20
> data (collectively, all the entries) is more than 1 page then ->stop()=20
> must be called and a page returned to user and then the kernel must build=
=20
> another page but all it knows is the integer 'offset'. Anything could hav=
e=20
> happened to the list (task list in this case) since ->stop() routine=20
> dropped the spinlock. So, it is not obvious from which position to=20
> start building the data for the new page.=20

Yes, I am well aware of that issue.  As for the connection tracking
table or the dstlimit htables I was referring to, I am actually relating
'pos' to the bucket number, not to the logical entry in the table.

The number of hash buckets is constant, so that's at least something the
user can count on.

However, there will be a problem when there are too many entries within
a single bucket - since all of them would have to be returned within a
single read() call.

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

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/t+HMXaXGVTD0i/8RAhZmAJwNfw+EF5x3Kjx41rdYnsucoNSJFQCgpW15
TFOeDuBobi9K41CGCejPAlw=
=Qr3W
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbTFUQbn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 12:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTFUQbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 12:31:43 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:22400
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S264955AbTFUQbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 12:31:41 -0400
Date: Sat, 21 Jun 2003 18:45:43 +0200
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, axboe@suse.de, clemens@endorphin.org,
       torvalds@transmeta.com, jari.ruusu@pp.inet.fi,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] loop.c
Message-ID: <20030621164543.GA1641@ghanima.endorphin.org>
References: <UTC200306211507.h5LF7lM23701.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <UTC200306211507.h5LF7lM23701.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2003 at 05:07:47PM +0200, Andries.Brouwer@cwi.nl wrote:
> For a long time we have had a somewhat unfortunate situation
> where people wanting to use cryptoloop had to collect some
> kernel patches and util-linux patches elsewhere.
> Now that we have crypto in the kernel this can be rectified.
>=20
> As far as I can see this requires two things:
> - crypto transfer functions must be registered with loop.c,
> that is, loop_register_transfer() must be called
> - loop.c must be fixed
>=20
> The first point is handled by cryptoloop-0.2-2.5.58.diff.
> Concerning the second point, several patches are floating around.
> Below a patch that Jari Ruusu sent me.
>=20
> This is a RFC.
> Clemens - any comments on the crypto side?
> Jens - any comments on the block I/O side?

I haven't looked at it in detail but Jari's patches have done the right
things at all times. If they do things right is another issue. I prefer Adam
Richter's patches better but if the decision is in favour for Jari's I have
no technical objections.

But you have to make yourself clear:

This patch will change the IV metric to 512 byte and the loop transfer
function has to be allowed to increase the IV for itself after any 512byte
chunk. (Otherwise the transfer function would have to return after a single
chunk, let loop.c compute the next IV and be called by loop.c again.)

I've always wanted it this way. Nothing which has ever been merged
officially has used loop.c's IV calculation and the unofficial stuff fixed
the calculation years ago (one and a half actually). So I can't see a
reason to maintain backward compatiblity, because I hardly suspect that
there is even a user base. I come to this conclusion because loop.c's old IV
calculation isn't even done properly. This patch breaks the old IV calculat=
ion:
http://lwn.net/Articles/2677/ . It has been merged a year ago and nobody
ever recognized the breakage. So let's face it: There is no user base. We
are talking about backward compatiblity for nobody here.=20

If you, Andries, are really volunteering to split the patch up, you're my
hero :)

Regards, Clemens

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+9Iu3W7sr9DEJLk4RAjPoAJ9NhERnE6lmsyLExeIOdbI6f5suIACdHsiu
z2Qtp4Tdx9QAfo+1sm1dN7M=
=ZrNz
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

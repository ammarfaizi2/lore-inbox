Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSAPURh>; Wed, 16 Jan 2002 15:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSAPUR1>; Wed, 16 Jan 2002 15:17:27 -0500
Received: from UX3.SP.CS.CMU.EDU ([128.2.198.103]:21105 "HELO
	ux3.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S287425AbSAPURY>;
	Wed, 16 Jan 2002 15:17:24 -0500
Subject: Re: multithreading  on a multiprocessor system ( a bit OT )
From: Justin Carlson <justincarlson@cmu.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3C45D95C.7000402@student.uni-kl.de>
In-Reply-To: <3C45D95C.7000402@student.uni-kl.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-71eFP1xpZ+3cUOAXxsuU"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 16 Jan 2002 15:16:44 -0500
Message-Id: <1011212204.314.3.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-71eFP1xpZ+3cUOAXxsuU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-01-16 at 14:49, R. Sinoradzki wrote:
> O.K my question:
> Consider two modern processors that share some data and a lock.
> The lock may be implemented with something like an atomic test-and-set
> instruction. Now processor 'A' acquires the lock and works with the data.
> Processor 'B' also wants to access the data, but internally reorders it's
> instructions because the instructions seem independent from each other.
> So 'B' might access the data without having the lock.
> If it's a single processor system, reordering instructions in a way that
> ensures that it looks 'as if' everything has been executed in the right o=
rder
> might be easy, but in a multiprocessor system 'A' doesn't know 'B's state=
.

Then you've got a bug.  Modern implementations that do SMP provide some
way of placing barriers around speculative execution structures to make
sure you don't, say, go out and read some memory location that changes
state in a device because that's an OK speculative action to take.

Can't really comment on x86, as I'm not very good with it, but taking
for example MIPS and Alpha, in addition to the ll-sc ops, there are a
sync and mb instructions, respectively, which provide a method for
assuring that previous operations have become visible in terms of
general machine state before going on.

-Justin

--=-71eFP1xpZ+3cUOAXxsuU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8Rd+s47Lg4cGgb74RAnxeAJ42+wPvabJmfNf4wOHD/fPNra8XRgCcD4TC
cRNyj0fjHwjkUn23Vkl1fQQ=
=BWIY
-----END PGP SIGNATURE-----

--=-71eFP1xpZ+3cUOAXxsuU--


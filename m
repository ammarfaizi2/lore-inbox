Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271278AbRHOQaH>; Wed, 15 Aug 2001 12:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271279AbRHOQ35>; Wed, 15 Aug 2001 12:29:57 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:47886 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271278AbRHOQ3s>; Wed, 15 Aug 2001 12:29:48 -0400
Date: Wed, 15 Aug 2001 11:29:47 -0500
From: Tim Walberg <twalberg@mindspring.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Steve Hill <steve@navaho.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
Message-ID: <20010815112947.B6067@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Steve Hill <steve@navaho.co.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108151622570.2107-100000@sorbus.navaho> <Pine.LNX.3.95.1010815113613.28526A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010815113613.28526A-100000@chaos.analogic.com> from Richard B. Johnson on 08/15/2001 10:42
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I may be wrong here - haven't looked at the source lately -
and I'm sure someone will correct me if I am, but I don't
think that network interrupts in general contribute to
the random driver, the theory being that an attacker
could carefully time the packets sent and thus possibly
influence the entropy pool in some way that would gain
some advantage. I don't think this has been proven, just
that network interrupts are not used because of general
paranoia to that effect. The sources I know of that contribute
to the entropy pool are keyboard and mouse interrupts (and
scancodes and pointer positions), some block device timing
information and some other interrupts. Actually, a quick
perusal of 2.4.8-ac3 shows that the sk_mca, 3c523, and ibmlana
network drivers seem to be the only other drivers that
include the SA_SAMPLE_RANDOM bit in their interrupt processing.

So, my guess is that on a system without mouse and keyboard,
you may need to do something (low priority-ish to minimize
performance impact) that generates a fair amount of disk activity
in order to keep the entropy pool full (unless you happen to have
one of the above network drivers).



			tw



--=20
twalberg@mindspring.com

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO3qjecPlnI9tqyVmEQLIMQCg2vOXtctWHoGimigNUixJXALQEr8AoK3D
RheTjgk2Z3vXTmee40LAWlt4
=gqXn
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

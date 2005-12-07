Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVLGIZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVLGIZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 03:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVLGIZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 03:25:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:10194 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750729AbVLGIZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 03:25:21 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Patrick Boettcher <patrick.boettcher@desy.de>
Subject: Re: [linux-dvb-maintainer] Re: [PATCH] b2c2: make front-ends    selectable and include noob option
Date: Wed, 7 Dec 2005 09:25:32 +0100
User-Agent: KMail/1.9
Cc: Johannes Stezenbach <js@linuxtv.org>, Michael Krufky <mkrufky@gmail.com>,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
References: <200512062053.00711.prakash@punnoor.de> <20051207002919.GA18629@linuxtv.org> <Pine.LNX.4.64.0512070849300.18120@pub5.ifh.de>
In-Reply-To: <Pine.LNX.4.64.0512070849300.18120@pub5.ifh.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2399805.QoKPS1ypnZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512070925.32884.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2399805.QoKPS1ypnZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch Dezember 7 2005 08:56 schrieb Patrick Boettcher:
> Hi,
>
> On Wed, 7 Dec 2005, Johannes Stezenbach wrote:
> > I think b2c2-flexcop-pci uses a 240K dma buffer, whether you
> > save a few K in demodulator code doesn't mean much.
> > The saved memory will be similarly unnoticable to the user as
> > if you would go and scatter #ifdefs all over tuner-simple.c.
> >
> > But I'm neither the author nor the maintainer of the b2c2-flexcop
> > driver, you better ask Patrick if he likes it.
>
> There will be at least two new devices in the future, which again will
> need (at least) two new demod(and maybe tuner)-modules.
>
> Prakash, if it is just the i2c_xfer failed, that could be easily turned
> into a debug-message, but I rather have these as errors, because they are.

Well aren't these expected errors? You want to attach an non-existent=20
front-end and the driver finds out it isn't there? IMHO it doesn't look ver=
y=20
professional if some strange errors are scattered in the log. I think if yo=
u=20
don't find *any* front-end there should be perhaps an error or note to the=
=20
user, but not because half a dozen of front-ends drivers can't find the hw.=
=20
At least please make the errors verbose and not cryptical, if you really wa=
nt=20
them.

If these errors are not expected, they have been here since months and=20
probably should have been fixed. But I think I remember someone saying that=
=20
they are expected once I reported them...

> I don't see the need for the ifdef - on the contrary: the number of people
> asking for which demod they shall load dropped significantly after
> FE_REFACTORING starting one year ago - now reintroducing that again is not
> a good idea, IMO.

Well, I got twice annoyed by missing reverse dependecies introduced by new=
=20
front-ends. Once the fw loader and once the new lgt330x(?) front-end. If ne=
w=20
front-ends wouldn't go in automatically as rev dependency this wouldn't bre=
ak=20
for me (and everyone alse using b2c2 in general and not only the new=20
frontends), which is another reason, if you don't care about the bit of cod=
e=20
saving.

I really don't see the big problem of the ifdefs as the are in the *header*=
=20
files as it is just checking whether something is in or not - as the user=20
selected thus emulating that a probe for a front-end failed... If the .c fi=
le=20
is coded properly there is no chance of breaking - otherwise you'd have the=
=20
same problem with the unpatched source (leaving the module problem out for=
=20
now). (Yes, I know ifdefs in the code as such are bad, but I noted that in=
=20
conjunction with the fw loader, which was the only "dirty" ifdef.)

And as I said I added an *option* for unsure users to include all supported=
=20
front-ends, which is another one of your arguments. Selecting it by default=
=20
(I don't know how to do this) would be what you want then. Wouldn't this ma=
ke=20
all happy (if Michael additionally fixes the module stuff)?

bye,

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2399805.QoKPS1ypnZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDlpx8xU2n/+9+t5gRAvg1AKCVq0TasTLSa5VD8za4URs4HIaWtgCg47t6
Ji8EydZRfFefOZGstrOt/ls=
=z86k
-----END PGP SIGNATURE-----

--nextPart2399805.QoKPS1ypnZ--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129667AbQK3ULY>; Thu, 30 Nov 2000 15:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129555AbQK3ULS>; Thu, 30 Nov 2000 15:11:18 -0500
Received: from schiele.swm.uni-mannheim.de ([134.155.20.124]:3845 "EHLO
        schiele.swm.uni-mannheim.de") by vger.kernel.org with ESMTP
        id <S130468AbQK3R4v>; Thu, 30 Nov 2000 12:56:51 -0500
Date: Thu, 30 Nov 2000 18:24:28 +0100
From: Robert Schiele <rschiele@uni-mannheim.de>
To: Dick Streefland <dick.streefland@tasking.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: es1371 mixer problems
Message-ID: <20001130182428.A2127@schiele.priv>
In-Reply-To: <20001124135956.A5842@kemi.tasking.nl> <20001130134725.A12437@kemi.tasking.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001130134725.A12437@kemi.tasking.nl>; from dick.streefland@tasking.com on Thu, Nov 30, 2000 at 01:47:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2000 at 01:47:25PM +0100, Dick Streefland wrote:
> Dick Streefland <dick.streefland@tasking.com> wrote:
> | 2.4.0-test11 introduced a problem with the mixer device of my SB128
> | soundcard (es1371 driver). When I start a mixer application like
> | xmixer or aumix, only a small subset of the mixer devices are available.
> | With 2.4.0-test10, using the same .config, all devices are available.
>=20
> This is a followup to my own message to report that the mixer is
> working again after I disabled the CONFIG_SOUND_TVMIXER option. I
> don't know what exactly this option does (no help text), but since I
> have a Hauppauge (BT878) TV-card, I did enable this option. In
> test11, drivers/media/video/tvmixer.c was modified so that it now
> looks for tvmixer devices, and it actually finds one:
>=20
>   tvmixer: debug: MSP3415D-A2=20
>   tvmixer: MSP3415D-A2 (bt848 #0) registered with minor 0=20
>   tvmixer: debug: (unset)=20
>=20
> This mixer probably replaces the normal AC97 mixer device. So, in
> what situations do you need CONFIG_SOUND_TVMIXER? It would be nice if
> someone could come up with an entry for Documentation/Configure.help.

In fact it does not 'replace' the other mixer device, but it adds
another one. The problem on your system is, that you load the new
module before your sound card module.
This means with only your sound card module, the mixer for your sound
card is major 14/minor 0. With tvmixer module loaded before your sound
card module, major 14/minor 0 is assigned to tvmixer and your sound
card mixer gets major 14/minor 16. This is a problem for some mixer
applications, because they always control the first mixer device.
So you should just make sure, your sound card module is loaded
_before_ the tvmixer module.

Robert

--=20
Robert Schiele			mailto:rschiele@uni-mannheim.de
Tel./Fax: +49-621-10059		http://webrum.uni-mannheim.de/math/rschiele/

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEVAwUBOiaNSsQAnns5HcHpAQFZjwf/Tnp864vRE/bZ+pp7E+pC58EfWRxXybh7
4Jf+MDPEZ9yz7y+gK3oSJK9ocPxOk3/n4mOg51NjFW2jHff43nGtRGfFWmYTib0w
D518j2tf6bu2C6qCyE+2KPPa7wZsd68tfyvDQvSQ3f2YMU7a6p10X/O0a2bSYp9s
LTkWd9pIc6PSmb5tjtR//QQjyrDZveZzQ5YQKpxXVoJ5ny3qXMLXcKd2UmZw4xRL
ujUd8aLpcttq/7j1ZmPk4yT1SR3kAbI5qks3n+Srd6RPyt8f875ncQmy97Cl32aM
qjXV9eC37rKJd3XS1mK9QmDWSS855m3ee+UFYO2PFrUnt94JcQVw4g==
=JyiN
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUJRIi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUJRIi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 04:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUJRIi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 04:38:56 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:56504 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S264639AbUJRIiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 04:38:52 -0400
Date: Mon, 18 Oct 2004 09:39:05 +0100
From: Alexander Clouter <alex-kernel@digriz.org.uk>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Con Kolivas <kernel@kolivas.org>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq_ondemand
Message-ID: <20041018083905.GC3311@inskipp.digriz.org.uk>
References: <88056F38E9E48644A0F562A38C64FB60031DA073@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60031DA073@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 17, Pallipadi, Venkatesh wrote:
>=20
> [snipped]
>=20
> We can never accurately predict freq for some future load.=20
> Say a CPU capable of 600, 800, 1000, 1200 and 1400 KHz, is=20
> running at 600 and we have sudden 100% CPU utilization, then=20
> we cannot precisely say which should be the next freq. It=20
> can be any of the higher possible freqs. And we felt performance=20
> should get a higher priority whenever there is some=20
> tradeoffs like this.
>=20
it took me a while to work out why speed decreasing was 'working' whilst=20
speed increasing was not with my method; a good hour finding out that the=
=20
cpufreq (correctly) goes to the lowest match.

My approach was not to try and avoid predicting the desired freq, it was ju=
st=20
to increase it...well on demand at a steady rate towards 100% and then once=
=20
the load disappears to reduce it.  Having used powernowd and found it do th=
at=20
rather nicely, then seeing the inclusion of cpufreq_ondemand, I tweaked=20
cpufreq_ondemand to replace powernowd.

I'm all for "this really should be done in userspace", but for something li=
ke=20
this I have a nagging feeling that its neater in kernel-space.  Of course t=
he=20
userspace one has the advantage (I think cpufreqd does it) that you can=20
decide if you want to increase the freq depending on what applications are=
=20
running.

Of course you are using CPU cycles, though bearly any, to have this floatin=
g=20
requested_freq variable.  Of course I would love this to be in the kernel,=
=20
mainly though I wanted people to improve upon it and such.

Meanwhile I am thinking of moving that freq_step variable bits to the /sys=
=20
show/store functions to remove a avoidable divide.

Cheers

Alex

--=20
 ____________________________________=20
/ Let your conscience be your guide. \
|                                    |
\ -- Pope                            /
 ------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBc4EpNv5Ugh/sRBYRAsAKAKCbKE4vAfsENeIGAllcBdHond6aeACbBXIx
/AWB9q6WjcMdY2iJ1307JZ4=
=06fw
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

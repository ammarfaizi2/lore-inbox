Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVI1FBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVI1FBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 01:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVI1FBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 01:01:47 -0400
Received: from pool-151-202-105-53.ny325.east.verizon.net ([151.202.105.53]:44751
	"EHLO blaze.homeip.net") by vger.kernel.org with ESMTP
	id S1030189AbVI1FBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 01:01:47 -0400
Date: Wed, 28 Sep 2005 01:01:48 -0400
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Carlo Calica <ccalica@gmail.com>,
       xorg@lists.freedesktop.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <20050928050148.GB9960@blazebox.homeip.net>
References: <20050925220037.GA8776@blazebox.homeip.net> <Pine.LNX.4.53.0509260911540.29885@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0509260911540.29885@gockel.physik3.uni-rostock.de>
X-Mailer: Mutt http://www.mutt.org
X-Operating-System: Slackware 10.2.0
X-Kernel-Version: Linux blaze 2.6.13.2 i686
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2005 at 09:14:02AM +0200, Tim Schmielau wrote:
> On Sun, 25 Sep 2005, Paul Blazejowski wrote:
>=20
> > Upon quick testing the latest mm kernel it appears there's some kind of
> > race condition when using dual core cpu esp when using XORG and USB
> > (although PS2 has same issue) kebyboard rate being too fast.
>=20
> Does the following patch by John Stultz fix the problem?
>=20
> Tim

Tim,

No it does not, from my understanding it only pertains to x86_64 but
currently i run i386 SMP enabled kernel on the dualcore X2 processor.

Also worth noting is that i do not see any failures or errors in dmesg
related to lost timers. Perhaps this is something new? I even run  a
script from the bugzilla and the output matched both cpu's.

Thanks,

	Paul

>=20
>=20
> From johnstul@us.ibm.com Mon Sep 26 09:04:08 2005
> Date: Mon, 19 Sep 2005 12:16:43 -0700
> From: john stultz <johnstul@us.ibm.com>
> To: Andrew Morton <akpm@osdl.org>
> Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
> Subject: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced
>     TSCs
>=20
> Andrew,
> 	This patch should resolve the issue seen in bugme bug #5105, where it
> is assumed that dualcore x86_64 systems have synced TSCs. This is not
> the case, and alternate timesources should be used instead.
>=20
> For more details, see:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D5105
>=20
>=20
> Please consider for inclusion in your tree.
>=20
> thanks
> -john
>=20
> diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> --- a/arch/x86_64/kernel/time.c
> +++ b/arch/x86_64/kernel/time.c
> @@ -959,9 +959,6 @@ static __init int unsynchronized_tsc(voi
>   	   are handled in the OEM check above. */
>   	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
>   		return 0;
> - 	/* All in a single socket - should be synchronized */
> - 	if (cpus_weight(cpu_core_map[0]) =3D=3D num_online_cpus())
> - 		return 0;
>  #endif
>   	/* Assume multi socket systems are not synchronized */
>   	return num_online_cpus() > 1;
>=20
>=20
>=20

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDOiO8wu5Nmh3PsiMRAmqmAJ47gy0obnib4SEL6iE8uPwuSKBwfwCfbEbf
yTgJZqxiIlxj1qHhcYW2LFw=
=vh8R
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--

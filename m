Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWCSReg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWCSReg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 12:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWCSReg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 12:34:36 -0500
Received: from woodchuck.digriz.org.uk ([217.147.82.209]:34216 "EHLO
	woodchuck.digriz.org.uk") by vger.kernel.org with ESMTP
	id S1751515AbWCSRef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 12:34:35 -0500
Date: Sun, 19 Mar 2006 17:34:33 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-ID: <20060319173433.GB28207@inskipp.digriz.org.uk>
References: <200603181525.14127.kernel-stuff@comcast.net> <200603190134.01833.kernel-stuff@comcast.net> <20060319120047.GA26018@inskipp.digriz.org.uk> <200603190906.25174.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <200603190906.25174.kernel-stuff@comcast.net>
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Parag Warudkar <kernel-stuff@comcast.net> [20060319 09:06:25 -0500]:
>
> The codebase already seems identical to ondemand - Are your patches in=20
> 2.6.16-rc6 or -mm? If they are - let me know which. If you posted them bu=
t=20
> they haven't yet made it into either -mm or mainline can you please post=
=20
> links to all your patches please? I can test them.
>=20
Well I submitted them back on 2006-02-24:

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D114079151404567&w=3D2
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D114079151425558&w=3D2
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D114079151417220&w=3D2

It has been pointed out I did forget to CC the cpufreq folk, so thats=20
completely my fault; I thought I had. :-/

> Why do we even have conservative and ondemand as two separate modules giv=
en=20
> they share huge amount of code - perhaps make conservative an optional=20
> behaviour of ondemand or alteast make a common lib which both use?
>
Originally the 'conservative' feature was just a sysfs flag that could be s=
et=20
however it was rejected for a number of reasons; one of them quite rightly,=
=20
we have a modular system that can take stacks of cpufreq governors so lets=
=20
use that :)

Also, more importantly, bugs in my bits do not affect the original author.=
=20
It makes more sense to keep things this way as the internal code then does
not need a bunch of if{}'s scattered around and also I have a number of ext=
ra
sysfs files to tweak which would either do nothing in 'ondemand' mode or ha=
ve
to be magically created and destroyed.

Either way, its probably neater this way and its *my* duty to make sure
anything changing for ondemand is considered for conservative.  If you look
at a lot of the userland tools that have come out, it would be a pain to ha=
ve
them consider the exception class of handling the combined
ondemand/conservative.

Breaking out the thing into a library probably would be awkward as all the
similar code is actually inline in functions, putting that in a seperate fi=
le
would be pointless.  Hopefully when you apply my patches and then do a diff
between the ondemand and conservative governors you will see what I mean.

Cheers

Alex

--=20
 ________________________________________=20
/ Fortune finishes the great quotations, \
| #3                                     |
|                                        |
| Birds of a feather flock to a newly    |
\ washed car.                            /
 ----------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEHZYoNv5Ugh/sRBYRAuztAKCEQorQFZv7oXlhIRbrR5Kov6n8bwCeOO9+
NjnENpKn8pTERqHLx0VhIio=
=hgwO
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--

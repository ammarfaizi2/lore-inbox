Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbTFAXjC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 19:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264764AbTFAXjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 19:39:02 -0400
Received: from ik-dynamic-66-102-74-246.kingston.net ([66.102.74.246]:60429
	"EHLO linux.interlinx.bc.ca") by vger.kernel.org with ESMTP
	id S264763AbTFAXjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 19:39:00 -0400
Subject: Re: [PATCH][2.5] Honour dont_enable_local_apic flag
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: mikpe@csd.uu.se
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
In-Reply-To: <200306012308.h51N8K6j001404@harpo.it.uu.se>
References: <200306012308.h51N8K6j001404@harpo.it.uu.se>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d+fIrSpwVa9T4wM0U76+"
Message-Id: <1054511535.6676.85.camel@pc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3-1mdk (Preview Release)
Date: 01 Jun 2003 19:52:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d+fIrSpwVa9T4wM0U76+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-06-01 at 19:08, mikpe@csd.uu.se wrote:
>=20
> Details, please. What does `cat /proc/cpuinfo` say?

Oops.  Sorry.  Problem is that VMware just reports the underlying (host)
system's CPU, so it will vary from (real) machine to machine.  So for
instance, both my host system and my VMware virtual machine running on
it report:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 796.626
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1589.24

With the exception of the "apic" flag (and cpu MHz values and bogomips
values differ).  The above is from the host system.  The VMware virtual
system has the same flags minus the apic flag because the only way to
boot it such that I can get the /proc/cpuinfo is by using the nolapic
command arg in the patch I sent earlier.

> My intention here is that we should be able to detect
> this apparently broken "CPU" by its vendor/model and
> clear cpu_has_apic for it.

Not doable by CPU identification I don't think.

> Alternatively the no_apic label in detect_init_APIC()
> could clear cpu_has_apic.

Fair enough, but what would cause the code at the no_apic label to be
executed without any of the command line arg patches proposed?  We could
use Zwane's __setup() for nolapic and instead of doing:

if (dont_enable_local_apic)
	return -1;

in detect_init_APIC() we can do:

if (dont_enable_local_apic)
	goto no_apic;

> Hmm, obviously a 2.4 kernel.

Yes indeed.  This is for testing production systems, so I need stable
kernels.

b.

--=20
Brian J. Murrell <brian@interlinx.bc.ca>

--=-d+fIrSpwVa9T4wM0U76+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+2pGvl3EQlGLyuXARAqXNAKDZhUZvPipq1yGWVwD+XfdV3ivNRwCg3mDE
MVbLFaBcG1g5HizC8weWlDw=
=biEi
-----END PGP SIGNATURE-----

--=-d+fIrSpwVa9T4wM0U76+--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUA1QU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 11:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUA1QU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 11:20:26 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:8082 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S265823AbUA1QUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 11:20:16 -0500
Date: Wed, 28 Jan 2004 17:14:27 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Alessandro Suardi <alessandro.suardi@oracle.com>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-acpi <linux-acpi@intel.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
Message-ID: <20040128161427.GB5583@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Alessandro Suardi <alessandro.suardi@oracle.com>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-acpi <linux-acpi@intel.com>, Andrew Morton <akpm@osdl.org>,
	Dave Jones <davej@redhat.com>
References: <40171B5B.4020601@oracle.com> <Pine.LNX.4.58.0401271859140.10794@home.osdl.org> <40171B5B.4020601@oracle.com> <Pine.LNX.4.58.0401271859140.10794@home.osdl.org> <40172F30.8050602@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401271859140.10794@home.osdl.org> <40172F30.8050602@oracle.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2004 at 04:40:32AM +0100, Alessandro Suardi wrote:
> printk("CPUFREQ DEBUG: [%lu] [%u] [%u]\n", l_p_j_ref, l_p_j_ref_freq,=20
> ci->new);
>=20
>  as both first and last instruction in adjust_jiffies() turns
>  up the same values, which are 1773568, 1, 0.

The ACPI tables report totally bogus CPU frequencies -- 1 and 0 MHz. I'm
surprised this differs between 2.6.0 and 2.6.x-mm... Len, any idea?


On Tue, Jan 27, 2004 at 07:06:41PM -0800, Linus Torvalds wrote:
>=20
>=20
> On Wed, 28 Jan 2004, Alessandro Suardi wrote:
> >
> > Already reported, but I'll do so once again, since it looks like
> >   in a short while I won't be able to boot official kernels in my
> >   current config...
> >
> >	http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/0442.html
>=20
> Can you make adjust_jiffies() print out its arguments (it's in=20
> drivers/cpufreq/cpufreq.c).
>=20
> It looks like cpufreq_scale() gets a divide-by-zero or an overflow on one=
=20
> of
>=20
> 	l_p_j_ref, l_p_j_ref_freq, ci->new
>=20
> and just printing out those values would be interesting.
>=20
> That said, the code is crap anyway.

> It does various divides without=20
> actually testing for any sanity at all,

CPUfreq and the CPUfreq timing code _need_ to rely on the CPU frequencies
being reported by the drivers. If they're wrong all timing will be wrong[1]=
=2E..
Nonetheless, a fix for the acpi driver which aborts on such "zero" MHz
reports has already been sent to Len for reviewal [2].

> and tries to "avoid overflow" by=20
> totally bogus methods, instead of just using the 64-bit do_div64().

Agreed, will fix it.

	Dominik

[1] Especially as the pmtmr also uses tsc for the delay() routines...
[2] http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D107421039607335&w=3D2

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAF9/jZ8MDCHJbN8YRAiQVAJ96DH4bXk96dyugY5A7RxUoO1nR6QCdGhac
wfUuh8+QF4+L5NN47Ta81eQ=
=6mD4
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--

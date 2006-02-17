Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWBQCLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWBQCLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 21:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBQCLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 21:11:04 -0500
Received: from threatwall.zlynx.org ([199.45.143.218]:63697 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S1750862AbWBQCLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 21:11:01 -0500
Subject: Re: Wrong number of core_siblings in sysfs for Athlon64 X2
From: Zan Lynx <zlynx@acm.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <9a8748490602161408i736a7ab3vef09f3e1c95916fe@mail.gmail.com>
References: <9a8748490602161346x6e2802e8r4edf7dcbdafa5e17@mail.gmail.com>
	 <200602162259.32433.ak@suse.de>
	 <9a8748490602161408i736a7ab3vef09f3e1c95916fe@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RJ8yDex+/1SYvSBIFE17"
Date: Thu, 16 Feb 2006 19:10:56 -0700
Message-Id: <1140142257.29021.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RJ8yDex+/1SYvSBIFE17
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-02-16 at 23:08 +0100, Jesper Juhl wrote:
> On 2/16/06, Andi Kleen <ak@suse.de> wrote:
> > On Thursday 16 February 2006 22:46, Jesper Juhl wrote:
> >
> > > Obviously something is wrong, but I just can't seem to spot it.  Any =
clues?
> >
> > It's a bitmap. 3 =3D 0b11
> >
>=20
> When I was reading the smpboot code my brain *was* actually in the
> "this is a bitmap" mode, but when I then looked at the sysfs code it
> for some reason switched to "this wants to just print the number of
> siblings as an integer" mode - which was obviously where I went wrong.
> If it's being treated as a bitmap when it's created why would that
> change when it gets printed - D'OH!
>=20
> Thank you very much for that hit with the clue stick Andi.

While looking around for other examples, I ran across
cpufreq/affected_cpus.  Shouldn't cpufreq.c:show_affected_cpus() be
using cpumask_scnprintf instead of "%u"?

But anyway...

It seems to me that this could be confusing for a lot of people who are
casually browsing through sysfs.  Why not name core_siblings something
like core_sibling_bitmap?  Using _units isn't unprecedented, we have
read_ahead_kb.  I think it's nice not having to look it up to know
read_ahead is in kb and not bytes or sectors.  Likewise, it'd be nice to
know it's a bitmap and not a count just by looking at the name.

More alternatively, bitmaps seem ugly.  Why not one of these options
instead?
- a space separated list of bitmap offsets: "0 1" instead of 3
- a directory of symlinks to devices/system/cpu/cpu[N]:
   devices/system/cpu/cpu1/topology/core_siblings/0 -> ../../../cpu0
   devices/system/cpu/cpu1/topology/core_siblings/1 -> ../../../cpu1
--=20
Zan Lynx <zlynx@acm.org>

--=-RJ8yDex+/1SYvSBIFE17
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD9TCwG8fHaOLTWwgRAs5HAJ97aR18p+qhUdozVtnpSUSLNVilnwCfSQ64
HVImMcUKso9T6iHEGwP1PyM=
=lwQL
-----END PGP SIGNATURE-----

--=-RJ8yDex+/1SYvSBIFE17--


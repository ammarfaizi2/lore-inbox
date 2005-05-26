Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVEZS7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVEZS7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVEZS7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:59:34 -0400
Received: from the-penguin.otak.com ([65.37.126.18]:47568 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S261692AbVEZS7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:59:24 -0400
Date: Thu, 26 May 2005 11:59:21 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: Wolfgang Wander <wwc@rentec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1 alsa oops
Message-ID: <20050526185921.GA3519@the-penguin.otak.com>
References: <1117092768.26173.4.camel@localhost> <200505261944.50942.petkov@uni-muenster.de> <1117130470.5477.5.camel@mindpipe> <200505262012.45833.petkov@uni-muenster.de> <1117132339.5477.20.camel@mindpipe> <42961700.5090005@rentec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <42961700.5090005@rentec.com>
X-Operating-System: Linux 2.6.12-rc5-mm1 on an i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Wolfgang Wander [wwc@rentec.com] wrote:
> Lee Revell wrote:
> >On Thu, 2005-05-26 at 20:12 +0200, Borislav Petkov wrote:
> >
> >>On Thursday 26 May 2005 20:01, Lee Revell wrote:
> >>
> >>>On Thu, 2005-05-26 at 19:44 +0200, Borislav Petkov wrote:
> >>>
> >>>><snip>
> >>>>
> >>>>Andrew,
> >>>>
> >>>>similar oopses as the one I'm replying to all over the place. At it
> >>>>happens m in snd_pcm_mmap_data_close(). Here's a stack trace:
> >>>
> >>>No one using ALSA CVS or any of the 1.0.9 release candidates ever
> >>>reported this, but lots of -mm users are... does that help at all?  I
> >>>suspect some upstream bug that ALSA just happens to trigger.
> >>
> >>yeah,
> >>
> >>this has to do with alsa indirectly. snd_pcm_mmap_data_close() accesses=
=20
> >>some vm_area_struct->vm_private_data and apparently there have been som=
e=20
> >>optimizations to mmap code to avoid fragmentation of vma's so i think=
=20
> >>there's the problem. However, we'll need the smarter ones here :))
> >
> >
> >Any idea which patches to back out?
>=20
>=20
> avoiding-mmap-fragmentation-fix-2.patch
>=20
> seems to do the trick. Ken will likely have a fix-3 shortly ;-)
>=20
Reverting this patch makes it work for me. <tm>
--=20
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - -=20



--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFClhyJsgPkFxgrWYkRAoOPAJ9AYNSu7gr3Y37AgC6k/FePV8+xWgCgoDEz
bZVR3ECiCrf9nDBmipCj0mc=
=bS/G
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

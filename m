Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWDJJBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWDJJBs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWDJJBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:01:48 -0400
Received: from 169.248.adsl.brightview.com ([80.189.248.169]:11282 "EHLO
	getafix.willow.local") by vger.kernel.org with ESMTP
	id S1751008AbWDJJBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:01:47 -0400
Date: Mon, 10 Apr 2006 09:01:45 +0000
From: John Mylchreest <johnm@gentoo.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060410090145.GB16413@getafix.willow.local>
References: <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de> <20060402112002.GA3443@getafix.willow.local> <20060402114215.GA30491@suse.de> <20060404085729.GH3443@getafix.willow.local> <20060404094124.GA22332@suse.de> <20060404100115.GI3443@getafix.willow.local> <20060404105826.GA22820@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20060404105826.GA22820@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2006 at 12:58:26PM +0200, Olaf Hering <olh@suse.de> wrote:
>  On Tue, Apr 04, John Mylchreest wrote:
>=20
> > On Tue, Apr 04, 2006 at 11:41:24AM +0200, Olaf Hering <olh@suse.de> wro=
te:
> > > I think this should go into the main makefile, HOSTCFLAGS or similar.=
 If
> > > you look around quickly in the gentoo bugzilla, all non-userland
> > > packages (grub, xen, kernel etc.) require the -fno-feature.
> >=20
> > I'm not completely sure I understand where you are coming from here?
> > I assume you mean adding -fno-stack-protector to the host userlands
> > CFLAGS variable (or similar) to make it a global change, but if so
> > you're missing my point.
>=20
> I mean the whole kernel should be compiled with it, if you put it into
> global cflags, the boot parts will pick it up from there.

Sorry, for the belated reply. I thought that might be what you refered to,
however I think this is going to cause additional problems. The powerpc
code which is effected uses the CROSS32CC which may, or may not be the
same compiler as used by the host cc. This means that it could also have
different capabilities, and the worst scenario in this specific
situation would be where the hostcc didn't support ssp, but the
cross32cc did, and had it enforced.

I don't think this is the right approach, and keeping it isolated to the
boot code makes more sense to me.

--=20
Role:            Gentoo Linux Kernel Lead
Gentoo Linux:    http://www.gentoo.org
Public Key:      gpg --recv-keys 9C745515
Key fingerprint: A0AF F3C8 D699 A05A EC5C  24F7 95AA 241D 9C74 5515


--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEOh74NzVYcyGvtWURAgCWAKCZB707dEL10UMpC93v9C9XR1CV9QCgnX82
+M/0f9kWGK8R0YDKuECb5B4=
=Uw4O
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--

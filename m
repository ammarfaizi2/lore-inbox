Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422733AbWJNSPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWJNSPm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbWJNSPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:15:42 -0400
Received: from home.keithp.com ([63.227.221.253]:41221 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1422733AbWJNSPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:15:41 -0400
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
From: Keith Packard <keithp@keithp.com>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: keithp@keithp.com, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061013194516.GB19283@tau.solarneutrino.net>
References: <20061013194516.GB19283@tau.solarneutrino.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E1lV9gR4G9TTEY1Sxs33"
Date: Sat, 14 Oct 2006 11:15:23 -0700
Message-Id: <1160849723.3943.41.camel@neko.keithp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E1lV9gR4G9TTEY1Sxs33
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-10-13 at 15:45 -0400, Ryan Richter wrote:
> I have a new Intel 965G board, and I'm trying to get DRI working.
> Direct rendering is enabled, but all GL programs crash immediately.
> The message 'DRM_I830_CMDBUFFER: -22' is printed on the tty, and the
> kernel says:
>=20
> [drm:i915_cmdbuffer] *ERROR* i915_dispatch_cmdbuffer failed

The 915 DRM validates commands sent to the card from the application to
ensure they aren't directing the card to access memory outside of the
graphics area. At present the module validates only 915/945 commands
correctly and the 965 uses slightly different commands. I haven't walked
over the entire GL library, but it seems possible that this error is
being caused by the mis-validation of the command stream. We need to
update the DRM driver to reflect the new commands, but in the meanwhile,
you might try disabling the validation in the kernel (which will expose
your system to a local root compromise) and seeing if that doesn't
eliminate this message.

--=20
keith.packard@intel.com

--=-E1lV9gR4G9TTEY1Sxs33
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFMSk7Qp8BWwlsTdMRAqDFAKDNLbvsuXyWJdAcrfVYRqXj7dphaQCeNjhY
RNsF1KkCmM7EV6RkgV/a0g4=
=W3FO
-----END PGP SIGNATURE-----

--=-E1lV9gR4G9TTEY1Sxs33--

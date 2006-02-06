Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWBFVeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWBFVeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWBFVeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:34:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7611 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932185AbWBFVeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:34:06 -0500
Message-ID: <43E7C08A.7090700@redhat.com>
Date: Mon, 06 Feb 2006 13:32:58 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Tony Luck <tony.luck@intel.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH 1/3] NEW VERSION: *at syscalls: Implementation
References: <200512171742.jBHHgAKh018491@devserv.devel.redhat.com>	 <12c511ca0602061226pf3bf095jcc570754656c5437@mail.gmail.com> <12c511ca0602061322s7e97c488r78f14cd4897621f0@mail.gmail.com>
In-Reply-To: <12c511ca0602061322s7e97c488r78f14cd4897621f0@mail.gmail.com>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAC97D165F80B1D31D85A9527"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC97D165F80B1D31D85A9527
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tony Luck wrote:
> But I still can't get sys_mkdirat()
> to make a directory ... I just get a regular file.

Does normal mkdir() work?  If yes, it a problem in the way you wire the
syscalls up.  sys_mkdir is just calling sys_mkdirat.

Anyway, hold off on submitting code for the *at syscalls for a bit
longer.  I just found another problem.  Not a bug, but we must expose
the stat64 data instead of stat on 32bit platforms.  I completely missed
this in my patch.  The kernel's stat-related code is in almost a bad of
a shape as glibc's.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigAC97D165F80B1D31D85A9527
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFD58CK2ijCOnn/RHQRAvpYAKCUz1jsY/Q4eajc5qT4p05X0aCiAgCfe85f
FzEBHCuUozWWLDcEAttuOQE=
=wPOf
-----END PGP SIGNATURE-----

--------------enigAC97D165F80B1D31D85A9527--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWAGIDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWAGIDA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 03:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWAGIDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 03:03:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44780 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964862AbWAGIC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 03:02:59 -0500
Message-ID: <43BF7598.1070702@redhat.com>
Date: Sat, 07 Jan 2006 00:02:32 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] updated *at function patch
References: <200601061904.k06J4T3r027891@devserv.devel.redhat.com> <20060106234738.2445520e.akpm@osdl.org>
In-Reply-To: <20060106234738.2445520e.akpm@osdl.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig93017B58023423B08C8AA537"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig93017B58023423B08C8AA537
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Andrew Morton wrote:
> We don't have changelogs for these patches.  Apart from the usual
> what-it-does and how-it-does it I'd really like to be reminded of the
> "why".  Adding a bunch of stuff to the core kernel codepaths needs to h=
ave
> a good reason and I've forgotten your rationale.

This is the intro from the first set of patches I sent (I adjusted it
for the additional syscalls):

=3D=3D=3D=3D
Here is a series of patches which introduce in total 13 new system calls
which take a file descriptor/filename pair instead of a single file
name.  These functions, openat etc, have been discussed on numerous
occasions.  They are needed to implement race-free filesystem traversal,
they are necessary to implement a virtual per-thread current working
directory (think multi-threaded backup software), etc.

We have in glibc today implementations of the interfaces which use the
/proc/self/fd magic.  But this code is rather expensive.  Here are some
results (similar to what Jim Meyering posted before).

The test creates a deep directory hierarchy on a tmpfs filesystem.  Then
rm -fr is used to remove all directories.  Without syscall support I get
this:

real    0m31.921s
user    0m0.688s
sys     0m31.234s

With syscall support the results are much better:

real    0m20.699s
user    0m0.536s
sys     0m20.149s
=3D=3D=3D=3D=3D



> We'll need Signed-off_by:'s for all these patches.

I'm not sure how you want to handle this.  I don't particularly want to
resent all of them just for this purpose.

[PATCH 1/3] updated *at function patch

Signed-off-by: Ulrich Drepper <drepper@redhat.com>

[PATCH 2/3] updated *at function patch

Signed-off-by: Ulrich Drepper <drepper@redhat.com>

[PATCH 3/3] updated *at function patch

Signed-off-by: Ulrich Drepper <drepper@redhat.com>


--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig93017B58023423B08C8AA537
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDv3WY2ijCOnn/RHQRAi1iAJ0UtCK4HCYRGjRc7Xb59CDZbze8pQCbBsnc
/4U/4VYM3dPEuZQM71xdjAc=
=IJyK
-----END PGP SIGNATURE-----

--------------enig93017B58023423B08C8AA537--

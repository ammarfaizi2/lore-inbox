Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWFNQa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWFNQa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWFNQa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:30:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965027AbWFNQaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:30:25 -0400
Message-ID: <4490399F.1090104@redhat.com>
Date: Wed, 14 Jun 2006 09:30:23 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
References: <200606140942.31150.ak@suse.de> <449029DB.7030505@redhat.com> <200606141752.02361.ak@suse.de>
In-Reply-To: <200606141752.02361.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6D96805DBAAF578354FD086B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D96805DBAAF578354FD086B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Andi Kleen wrote:

> Eventually we'll need a dynamic format but I'll only add it=20
> for new calls that actually require it for security.
> vgetcpu doesn't need it.

Just introduce the vdso now, add all new vdso calls there.  There is no
reason except laziness to continue with these moronic fixed addresses.
They only get in the way of address space layout change/optimizations.
And nobody said anything about breaking apps which use the fixed
addresses.  That code can still be available.  One should be able to
turn it off with setarch.


>>> long vgetcpu(int *cpu, int *node, unsigned long *tcache)
>> Do you expect the value returned in *cpu and*node to require an error
>> value?  If not, then why this fascination with signed types?
>=20
> Shouldn't make a difference.

If there is no reason for a signed type none should be used.  It can
only lead to problems.

This reminds me: what are the values for the CPU number?  Are they
continuous?  Are they the same as those used in the affinity syscalls
(they better be)?  With hotplug CPUs, are CPU numbers "recycled"?


>> And as for the cache: you definitely should use a length parameter.
>> We've seen in the past over and over again that implicit length
>> requirements sooner or later fail.
>=20
> No, the cache should be completely opaque to user space. It's just
> temporary space for the vsyscall which it cannot store for itself.
> I'll probably change it to a struct to make that clearer.
>=20
> length doesn't make sense for that use.

You didn't even try to understand what I said.  Yes, in this one case
you might at this point in time only need two words.  But

- this might change
- there might be other future functions in the vdso which need memory.
  It is a huge pain to provide more and more of these individual
  variables.  Better allocate one chunk.


> If some other function needs a cache too it can define its own.
> I don't see any advantage of using a shared buffer.

I believe it that _you_ don't see it.  Because the pain is in the libc.
 The code to set up stack frames has to be adjusted for each new TLS
variable.  It is better to do it once in a general way which is what I
suggested.


> I think you're misunderstanding the concept.

No, I understand perfectly.  You don't get it because you don't want to
understand the userlevel side.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig6D96805DBAAF578354FD086B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEkDmf2ijCOnn/RHQRArjbAJ0fBfWYU1Yy3apa9rYz4voVmji0QwCfYQYq
pbwRQZxBIED4b4/eKYAO5r0=
=nWvA
-----END PGP SIGNATURE-----

--------------enig6D96805DBAAF578354FD086B--

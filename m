Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWGMFRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWGMFRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 01:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWGMFRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 01:17:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34988 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751216AbWGMFRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 01:17:09 -0400
Message-ID: <44B5D77F.60200@redhat.com>
Date: Wed, 12 Jul 2006 22:17:51 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Jakub Jelinek <jakub@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>	<44B54EA4.5060506@redhat.com>	<20060712195349.GW3823@sunsite.mff.cuni.cz>	<44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig65754842FC6A6178E796322E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig65754842FC6A6178E796322E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Eric W. Biederman wrote:
> Ulrich what would be interesting besides the possibility of having
> multiple cpus?

What is needed for various things like memory handling etc is all
topology information.  Somebody might remember the numa library proposal
I had in April 2004 which was cast aside because people were only
looking for a "quick fix".  Well, the problem still isn't solved.

IMO the vdso should export information about:

- processors and their relationship (hyperthreads, cores)

- the CPU caches and how they relate to the cores (e.g., dual core
  with shared L2)

- local main memory for each processor

- relative costs of the memory access of the various memory regions
  (for numa local memory to a node, intra-node costs)

- ideally, relative costs main memory and CPU caches


All this information can be steadily updated by the kernel as new
CPUs/memory get added/removed.  The vdso should have functions to access
this information.  It's easy enough to make this access race free.

I guess I should try to come up with a representation for this
knowledge.  Collecting the information (except the costs) should be
easy.  Determining the costs also shouldn't be that hard but it can be
very useful.  Some of this information could be determined at userlevel
but you really don't want every process to compute all this from
scratch.  And stored data in a file is stale if the system changes.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig65754842FC6A6178E796322E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEtdd/2ijCOnn/RHQRAlL1AJsGcTPsVLfxooYJit05pdSTh6PfaACfYfM7
vjvqY+n6ixMaAmsRlGoR9/k=
=BRMH
-----END PGP SIGNATURE-----

--------------enig65754842FC6A6178E796322E--

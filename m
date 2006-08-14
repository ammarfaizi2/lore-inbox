Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWHNQj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWHNQj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHNQj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:39:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62681 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932175AbWHNQj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:39:56 -0400
Message-ID: <44E0A6F6.509@redhat.com>
Date: Mon, 14 Aug 2006 09:38:14 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: sebastien.dugue@bull.net, Badari Pulavarty <pbadari@us.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, linux-aio@kvack.org, mingo@elte.hu
Subject: Re: Kernel patches enabling better POSIX AIO (Was Re: [3/4] kevent:
 AIO, aio_sendfile)
References: <1153982954.3887.9.camel@frecb000686> <44C8DB80.6030007@us.ibm.com> <44C9029A.4090705@oracle.com> <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com> <44C90987.1040200@redhat.com> <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com> <1154091500.13577.14.camel@frecb000686> <44DCDE73.9030901@redhat.com> <20060812182928.GA1989@in.ibm.com> <44DE27AB.7040507@redhat.com> <20060814070210.GA27005@in.ibm.com>
In-Reply-To: <20060814070210.GA27005@in.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF2E112A8FEC654D437EACF10"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2E112A8FEC654D437EACF10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Suparna Bhattacharya wrote:
> Is there a (remote) possibility that the thread could have died and its=

> pid got reused by a new thread in another process ? Or is there a mecha=
nism
> that prevents such a possibility from arising (not just in NPTL library=
,
> but at the kernel level) ?

The UID/GID won't help you with dying processes.  What if the same user
creates a process with the same PID?  That process will not expect the
notification and mustn't receive it.  If you cannot detect whether the
issuing process died you have problems which cannot be solved with a
uid/gid pair.


> AIO for pipes should not be a problem - Chris Mason had a patch, so we =
can
> just bring it up to the current levels, possibly with some additional
> improvements.

Good.


> I'm not sure what would be the right thing to do for the sockets case. =
While
> we could put together a patch for basic aio_read/write (based on the sa=
me
> model used for files), given the whole ongoing kevent effort, its not y=
et
> clear to me what would make the most sense ... =20
>=20
> Ben had a patch to do a fallback to kernel threads for AIO operations t=
hat
> are not yet supported natively. I had some concerns about the approach,=
 but
> I guess he had intended it as an interim path for cases like this.

A fallback solution would be sufficient.  Nobody _should_ use POSIX AIO
for networking but people do and just giving them something that works
is good enough.  It cannot really be worse than the userlevel emulation
we have know.

The alternative, separately and sequentially handling network sockets at
userlevel is horrible.  We'd have to go over every file descriptor and
check whether it's a socket and then take if out of the request list for
the kernel.  Then they need to be handled separately before or after the
kernel AIO code.  This would punish unduly all the 99.9% of the programs
which don't use POSIX  AIO for network I/O.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigF2E112A8FEC654D437EACF10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFE4Kb22ijCOnn/RHQRAsaKAJ0TSt0BHFPDGSYfNaZD7ur828PtNwCfRNzw
k5l0SDBsX3xUiU1ytcjj1XE=
=m9Zf
-----END PGP SIGNATURE-----

--------------enigF2E112A8FEC654D437EACF10--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWG0Sny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWG0Sny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWG0Sny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:43:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1518 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750986AbWG0Snx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:43:53 -0400
Message-ID: <44C90987.1040200@redhat.com>
Date: Thu, 27 Jul 2006 11:44:23 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Zach Brown <zach.brown@oracle.com>,
       =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru>	 <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru>	 <20060726103001.GA10139@infradead.org> <44C77C23.7000803@redhat.com>	 <44C796C3.9030404@us.ibm.com> <1153982954.3887.9.camel@frecb000686>	 <44C8DB80.6030007@us.ibm.com>  <44C9029A.4090705@oracle.com> <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E49989A3EA87F7AD4A2FE39"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E49989A3EA87F7AD4A2FE39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Badari Pulavarty wrote:
> Before we spend too much time cleaning up and merging into mainline -
> I would like an agreement that what we add is good enough for glibc
> POSIX AIO.

I haven't seen a description of the interface so far.  Would be good if
it existed.  But I briefly mentioned one quirk in the interface about
which Suparna wasn't sure whether it's implemented/implementable in the
current interface.

If a lio_listio call is made the individual requests are handle just as
if they'd be issue separately.  I.e., the notification specified in the
individual aiocb is performed when the specific request is done.  Then,
once all requests are done, another notification is made, this time
controlled by the sigevent parameter if lio_listio.


Another feature which I always wanted: the current lio_listio call
returns in blocking mode only if all requests are done.  In non-blocking
mode it returns immediately and the program needs to poll the aiocbs.
What is needed is something in the middle.  For instance, if multiple
read requests are issued the program might be able to start working as
soon as one request is satisfied.  I.e., a call similar to lio_listio
would be nice which also takes another parameter specifying how many of
the NENT aiocbs have to finish before the call returns.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig8E49989A3EA87F7AD4A2FE39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEyQmH2ijCOnn/RHQRAntFAJ4w4+X+w+1gPLRVx3c6DpgZPbgb8QCfUvhg
CDoJIfLS93rnpf1q/ZIqn2Y=
=+qLg
-----END PGP SIGNATURE-----

--------------enig8E49989A3EA87F7AD4A2FE39--

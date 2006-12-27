Return-Path: <linux-kernel-owner+w=401wt.eu-S1754771AbWL0UsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbWL0UsF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 15:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754777AbWL0UsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 15:48:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754771AbWL0UsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 15:48:04 -0500
Message-ID: <4592DB7E.4090100@redhat.com>
Date: Wed, 27 Dec 2006 12:45:50 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
References: <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122120933.GA32681@2ka.mipt.ru> <20061122121516.GA7229@2ka.mipt.ru> <4564CE00.9030904@redhat.com> <20061123122225.GD20294@2ka.mipt.ru> <456605EA.5060601@redhat.com> <20061124105856.GE13600@2ka.mipt.ru> <456B2D2B.9080502@redhat.com> <20061128101327.GE15083@2ka.mipt.ru>
In-Reply-To: <20061128101327.GE15083@2ka.mipt.ru>
X-Enigmail-Version: 0.94.1.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBE7C558334F8510731A0E4AA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE7C558334F8510731A0E4AA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Evgeniy Polyakov wrote:
> Why do we want to inject _ready_ event, when it is possible to mark
> event as ready and wakeup thread parked in syscall?

Going back to this old one:

How do you want to mark an event ready if you don't want to introduce
yet another layer of data structures?  The event notification happens
through entries in the ring buffer.  Userlevel code should never add
anything to the ring buffer directly, this would mean huge
synchronization problems.  Yes, one could add additional data structures
accompanying the ring buffer which can specify userlevel-generated
events.  But this is a) clumsy and b) a pain to use when the same ring
buffer is used in multiple threads (you'd have to have another shared
memory segment).

It's much cleaner if the userlevel code can get the kernel to inject a
userlevel-generated event.  This is the equivalent of userlevel code
generating a signal with kill().

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigBE7C558334F8510731A0E4AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFktuC2ijCOnn/RHQRAjSfAJwJmugiHdUzbJJz9VusJKmnQa6GOwCfQM5g
hH6mMw12XZTvxTzJigN7Z2k=
=4XJb
-----END PGP SIGNATURE-----

--------------enigBE7C558334F8510731A0E4AA--

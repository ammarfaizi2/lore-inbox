Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWJEOog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWJEOog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWJEOof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:44:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30171 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932092AbWJEOoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:44:34 -0400
Message-ID: <45251A83.9060901@redhat.com>
Date: Thu, 05 Oct 2006 07:45:23 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru> <20060927150957.GA18116@2ka.mipt.ru> <a36005b50610032150x8233feqe556fd93bcb5dc73@mail.gmail.com> <20061004045527.GB32267@2ka.mipt.ru> <452363C5.1020505@redhat.com> <20061004074821.GA22688@2ka.mipt.ru> <4523ED6C.9080902@redhat.com> <20061005090214.GB1015@2ka.mipt.ru>
In-Reply-To: <20061005090214.GB1015@2ka.mipt.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDE7C2B78544235EF8F24D775"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE7C2B78544235EF8F24D775
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Evgeniy Polyakov wrote:
> And you can add/remove signal events using existing kevent api between
> calls.

That's far more expensive than using a mask under control of the program.=



> And creating special cases for usual events is bad.
> There is unified way to deal with events in kevent -
> add/remove/modify/wait on them, signals are just usual events.

How can this be unified?  The installment of the temporary signal mask
is unlike the handling of signal for the purpose of reporting them
through the signal queue.  It's equally completely new functionality.
Don't kid yourself in thinking that because this is signal stuff, too,
you're "unifying" something.  The way this signal mask is used has
nothing whatsoever to do with the delivering signals via the event
queue.  For the latter the signals always must be blocked (similar to
sigwait's requirement).

As a result it means you want to introduce a new mechanism for the event
queue instead of using the well known and often used method of
optionally passing a signal mask to the syscall.  That's just insane.


> I think you wanted to say, that 'all event mechanism except the most
> commonly used poll/select/epoll use timespec'.

Get your facts straight.  select uses timeval which is just the
predecessor of of timespec.  And epoll is just (badly) designed after
poll.  Fact is therefore that poll plus its spawn is the only interface
using such a timeout method.


> I designed it to be similar to poll(), it is really good interface.

Not many people agree.  All the interfaces designed (not derived) in the
last years take a timespec parameter.

Plus, you chose to ignore all the nice things using a timespec allow you
like absolute timeout modes etc.  See the clock_nanosleep()  interface
for a way this can be useful.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigDE7C2B78544235EF8F24D775
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFJRqD2ijCOnn/RHQRAuYfAKCBqCeIKicnFwvVUOufPet+/PDwNgCcDnS7
QwG3um7cgsPZrH/E2DoNzBs=
=gZ4H
-----END PGP SIGNATURE-----

--------------enigDE7C2B78544235EF8F24D775--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWBOByY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWBOByY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 20:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWBOByY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 20:54:24 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:30889 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932447AbWBOByX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 20:54:23 -0500
X-Sasl-enc: Nchp4kwqoCBBRGG4sz9NcRqC+jW7F7k5/tDns6YEi1CI 1139968459
Message-ID: <43F289F5.2080102@imap.cc>
Date: Wed, 15 Feb 2006 02:55:01 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hansjoerg Lipp <hjlipp@web.de>, kkeil@suse.de,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH 6/9] isdn4linux: Siemens Gigaset drivers - procfs interface
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de>	<gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de>	<gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de>	<gigaset307x.2006.02.11.001.3@hjlipp.my-fqdn.de>	<gigaset307x.2006.02.11.001.4@hjlipp.my-fqdn.de>	<gigaset307x.2006.02.11.001.5@hjlipp.my-fqdn.de>	<gigaset307x.2006.02.11.001.6@hjlipp.my-fqdn.de> <20060212022742.16df78a2.akpm@osdl.org>
In-Reply-To: <20060212022742.16df78a2.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A821E5D1B642E511626089C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A821E5D1B642E511626089C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andrew,

thank you very much for your comments.

On 12.02.2006 11:27, Andrew Morton wrote:
>=20
>>This patch adds the procfs interface to the gigaset module.
>=20
> sysfs, actually.

Yes, sorry, the comment didn't get updated when we did the move from
procfs to sysfs.

> - The ringbuffer head and tail indexes are atomic_t's, but always seem =
to
>   be manipulated inside the lock.  Perhaps they can become integers.

We use ringbuffers in two places. I suppose you are talking about the
one implementing our event queue through the ev_head and ev_tail members
of the cardstate structure. You have a point there, although I'm not
sure if it wouldn't be better to take advantage of the atomic_t and do a
little less locking instead.

The other one, within the inbuf_t structure, used for capturing
characters received from the device, is accessed without locking from
the gigaset_handle_event() tasklet and therefore needs atomic_t indexes,
IMHO.

> - You did the ringbuffer the wrong way.  Don't constrain the head and
>   tail to be within 0..MAX_EVENTS.  Instead, just let them wrap right u=
p to
>   0xffffffff.   Apply the masking when you actually _use_ them.
>=20
>   That way, empty is (head =3D=3D tail) and full is (tail - head =3D=3D=
 MAX_EVENTS).

Interesting idea. I have to admit it's rather new to me. I have always
done ringbuffers the way they are done in the Gigaset driver now. Can
you point me to some example code done the way you propose, so I can
familiarize myself with its advantages?

> - Could use kstrdup() in a few places.

Thanks for the hint. Will watch out for these.

> - A few unneeded casts of void*'s, but everyone does that.

:-)

> - There are a lot of global symbols in there.  Perhaps they don't all
>   need to be global.

Well, I *hope* there aren't any unnecessary ones, but we'll re-check.

Regards
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig3A821E5D1B642E511626089C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8ooBMdB4Whm86/kRAu4qAJ0YCmlg8JIJ2zmCohR6gNzUp3qMZACfVH1m
EaJh1RXbLxXCRW07m3yglBM=
=4yR6
-----END PGP SIGNATURE-----

--------------enig3A821E5D1B642E511626089C--

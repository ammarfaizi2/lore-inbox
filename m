Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWJVToq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWJVToq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 15:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWJVToq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 15:44:46 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:31366 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751123AbWJVTop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 15:44:45 -0400
X-Sasl-enc: gxCnmGDiSGSvQ7dPRkcNrIwXaZRW79Dv259n5QwtuQxm 1161546283
Message-ID: <453BCABB.6000204@imap.cc>
Date: Sun, 22 Oct 2006 21:47:07 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: driver's tasklets stop being executed - how to debug?
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigED3FB83479335916BEDF2489"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED3FB83479335916BEDF2489
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I would like some advice on how to debug a strange problem with
the Gigaset ISDN driver (drivers/isdn/gigaset). All of a sudden,
both data streams as well as the input control stream experience
over/underruns:

bas_gigaset: isochronous write buffer underrun
bas_gigaset: isochronous read overrun, dropped URB with status: success, =
64 bytes lost
bas_gigaset: receive AT data overrun, 12 bytes lost

It looks as if my driver's tasklets aren't being executed anymore,
and it doesn't receive URB callbacks anymore, either.

As the tasklets have separate spinlocks for synchronization, I
think it somewhat unlikely (though of course not impossible) that
this is a locking issue.

Unfortunately, I can't reproduce the problem on any of my own
machines, and the reporter only observes it irregularly. So my
only chance is to add debugging output which would tell me, once
the problem happens again, enough about the system state in order
to figure out what's going on.

Therefore my questions:
- What could prevent a scheduled tasklet from executing?
- What could prevent an URB callback from being delivered?
- Is there a way to query the state of my tasklets and pending
  URB callbacks in order to printk something that might provide
  a clue when the problem strikes next time?

Thanks in advance for any hints.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enigED3FB83479335916BEDF2489
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFO8q7MdB4Whm86/kRAqCQAJ40YE7Da/ZFMK6cGVrAF2PYorBWTACfclGT
gHC9/wSkvEedD3c3Ue0voCI=
=YfKG
-----END PGP SIGNATURE-----

--------------enigED3FB83479335916BEDF2489--

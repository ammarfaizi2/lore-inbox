Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWEWS3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWEWS3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWEWS3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:29:33 -0400
Received: from 193.red-82-159-197.user.auna.net ([82.159.197.193]:65417 "EHLO
	indy.cmartin.tk") by vger.kernel.org with ESMTP id S1751201AbWEWS3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:29:33 -0400
Subject: A couple of oops.
From: Carlos =?ISO-8859-1?Q?Mart=EDn?= <carlos@cmartin.tk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pyKEBD231fw/xxV1ugpc"
Date: Tue, 23 May 2006 20:28:50 +0200
Message-Id: <1148408930.7726.11.camel@kiopa>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pyKEBD231fw/xxV1ugpc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've nailed this down to something that happened in 2.6.17-rc4. The
system locks up with either a NULL dereference or an unhandable paging
request. The stack trace shows this:

paging request            NULL dereference

_raw_spin_trylock+12    _raw_spin_trylock+20
__spin_lock+22
main_timer_handler+22
timer_interrupt+18
handle_IRQ_event+41
__do_IRQ+156
do_IRQ+51
default_idle+0
_spin_unlock_irq+43
thread_return+187
generic_unplug_device+0
default_idle+45
dev_idle+95 (I can't read the func clearly in this handwriting)
start_secondary+1129

I'm guessing this is the same problem only that it once manifests itself
as one and another time as the other. The problem is in the call to
write_seqlock(&xtime_lock) from main_timer_handler().

I've not been able to determine what patch has caused this to happen,
but it is between 2.6.17-rc3 and -rc4. I'm bisecting, but if anybody has
a good candidate, it'd probably be faster than doing a complete bisect.

   cmn
--=20
Carlos Mart=C3=ADn Nieto    |   http://www.cmartin.tk
Hobbyist programmer    |

--=-pyKEBD231fw/xxV1ugpc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEc1RiEVXxXOiy6a4RAo15AKCDN9SG+eCo3vAeYZlbtSq5dMtuZQCgmqzQ
qidt2ZgzMvGDdgswmACVrSg=
=GkOM
-----END PGP SIGNATURE-----

--=-pyKEBD231fw/xxV1ugpc--


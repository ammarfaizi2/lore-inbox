Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263032AbSJGMyu>; Mon, 7 Oct 2002 08:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263033AbSJGMyu>; Mon, 7 Oct 2002 08:54:50 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:28398 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263032AbSJGMyt>; Mon, 7 Oct 2002 08:54:49 -0400
Subject: Re: wake_up from interrupt handler
From: Arjan van de Ven <arjanv@redhat.com>
To: Amol Lad <dal_loma@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021007124121.37417.qmail@web12407.mail.yahoo.com>
References: <20021007124121.37417.qmail@web12407.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Lt3Md7du0AWNfD4+pde3"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 15:04:17 +0200
Message-Id: <1033995858.2798.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Lt3Md7du0AWNfD4+pde3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-10-07 at 14:41, Amol Lad wrote:
> Hi,
>  I have a kernel thread which did add_to_wait_queue()
> to wait for an event.=20
> The event for which above thread is waiting occurs in
> an interrupt handler that calls wake_up() to wake the
> above thread.=20
> Now I am faced with a 'lost wakeup' problem, in which
> the   =20
> kernel thread checks whether event occured, he finds
> it to be 'not-occured' but before calling
> add_to_wait_queue(), interrupt handler detects that
> the event has occured and calls wake_up().
> My thread sleeps forever.

set_current_state(TASK_INTERRUPTIBLE);
add_to_wait_queue(...);
if (even_occured) { ...}=20
  else
     schedule();
=20
remove_from_wait_queue(..);
set_current_state(TASK_RUNNABLE);


>=20


--=-Lt3Md7du0AWNfD4+pde3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9oYZRxULwo51rQBIRAqdlAJ9k8yOdTx+fjqQqQosdgdWoGDG5DACffrbP
Gzwmt6Eh4rEjrdiwQ1sIfP4=
=Y02o
-----END PGP SIGNATURE-----

--=-Lt3Md7du0AWNfD4+pde3--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265818AbUAKJsY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 04:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUAKJsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 04:48:24 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:35200 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265818AbUAKJsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 04:48:22 -0500
Subject: Re: lowlatency patch question
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: shai@ftcon.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200401110331.BBB99015@ms6.verisignmail.com>
References: <200401110331.BBB99015@ms6.verisignmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kEvGEFaSG8W4y3faalZ1"
Organization: Red Hat, Inc.
Message-Id: <1073814493.4431.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 11 Jan 2004 10:48:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kEvGEFaSG8W4y3faalZ1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> lowlatency patch added conditional_schedule() to be called from
> close_files() at kernel/exit.c, which seems to raise a problem if the
> process had LDT entries.
> If it had LDT, at the stage of close_files() the tsk->mm already zeroed
> (__exit_mm(), which comes before __exit_files() in do_exit()).  If
> conditional_schedule() at close_files() will succeed, switching back into
> this process (that now have zeroed tsk->mm) will fail since the kernel wi=
ll
> not use the right LDT (since tsk->mm was zeroed, so switch_mm() will not =
be
> called to load the LDT at schedule()).

since closing of files can sleep anyway I don't see how this schedule
point could introduce a bug.


> Switching back to a process that had a register that used the LDT will fa=
il
> since the register probably points to non-valid LDT entry (since we are
> using the wrong LDT), which will lead to a segmentation fault.

Do you have an oops? Could you file that in RH bugzilla
(bugzilla.redhat.com) ? RH bugzilla is a far more appropriate place to
report bugs in the RH vendor kernels than lkml is.

Greetings,
   Arjan van de Ven

--=-kEvGEFaSG8W4y3faalZ1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAARvdxULwo51rQBIRAn2NAKCikfPwvAOPKJNZ//5JRSrByrbtuwCfXdAj
WjbfjX4xkZLNK3UkloVnzMs=
=vjRU
-----END PGP SIGNATURE-----

--=-kEvGEFaSG8W4y3faalZ1--

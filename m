Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267963AbUHEU6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267963AbUHEU6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267970AbUHEU5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:57:11 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:43469 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S267963AbUHEUzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:55:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Amici <alexamici@fastwebnet.it>
Subject: Re: [PATCH] cputime (1/6): move call to update_process_times.
Date: Thu, 5 Aug 2004 22:54:20 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-390@vm.marist.edu, arjanv@redhat.com,
       tim.bird@am.sony.com, mulix@mulix.org, alan@redhat.com,
       jan.glauber@de.ibm.com
References: <20040805180335.GB9240@mschwid3.boeblingen.de.ibm.com> <200408052157.47603.alexamici@fastwebnet.it>
In-Reply-To: <200408052157.47603.alexamici@fastwebnet.it>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_85pEBTlgYJjCZ1s";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408052254.20715.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_85pEBTlgYJjCZ1s
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Donnerstag, 5. August 2004 21:57, Alessandro Amici wrote:
> I don't have enough knowledge to comment on the merit of the move to=20
> architecture files, but the proliferation of #ifndef CONFIG_SMP looks rea=
lly=20
> ugly.

Yes, it does.

> Wouldn't it be possible to move the #ifndef into sched.h?

You can't simply define it to a nop in case of SMP, because
there it is called from a different place, but we could
have a separate version for UP and SMP in sched.h:

void update_process_times(int user_tick);
static inline void update_process_times_nonsmp(int user_tick)
{
#ifndef CONFIG_SMP
	update_process_times(user_tick);
#endif
}

	Arnd <><

--Boundary-02=_85pEBTlgYJjCZ1s
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBEp585t5GS2LDRf4RApy3AJ4wzVIcxYD3SjXpWc+vAQp7jJnJvwCfeu4o
UAXDp2g9mWOWJwNnyj6oFVY=
=I+IM
-----END PGP SIGNATURE-----

--Boundary-02=_85pEBTlgYJjCZ1s--

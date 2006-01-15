Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751889AbWAOJ7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbWAOJ7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 04:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWAOJ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 04:59:04 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:8638 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751889AbWAOJ7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 04:59:02 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: state terminology
Date: Sun, 15 Jan 2006 10:58:48 +0100
User-Agent: KMail/1.7.2
References: <Pine.LNX.4.61.0601142234280.23423@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601142234280.23423@yvahk01.tjqt.qr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1449938.F2I192dcBr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601151058.55369.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1449938.F2I192dcBr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jan,

On Saturday 14 January 2006 22:34, you wrote:
> Is there a specific term (other than "hang") associated with this=20
> situation? It's not a "dead-lock", because there is no other process=20
> (anymore) which could potentially up the semaphore.

This is a simple "resource leak" (or "semaphore leak" in this case).

Explanation follows:

The resource semaphore is not usable by anyone anymore=20
and is still around.

Its pretty much the same as a memory leak. There is no one, who
could free the memory anymore.

The reasons for the resource not being usable anymore is
not significant for a resource leak.

Also insignificant is the fact that the amount of semaphores
are just limited by available memory. If you repeat starting threads=20
doing the semaphore leak game from your example, you'll run out
of memory and thus out of semaphores. This is another sign of leakage.

Do the above explanations sound ok?


Regards

Ingo Oeser


--nextPart1449938.F2I192dcBr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyhzfU56oYWuOrkARAituAJ9r25fViQpCatKWLF7OHe3LPm3OSACeMBbw
OBzJfpcoTCDNBgVaqy3D2Gg=
=hSGo
-----END PGP SIGNATURE-----

--nextPart1449938.F2I192dcBr--
